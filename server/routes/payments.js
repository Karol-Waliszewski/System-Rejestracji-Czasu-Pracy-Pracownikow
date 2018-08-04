const express = require('express');
const mysql = require('promise-mysql');
const mySqlConfig = require('../mySqlConfig');
var connection = null;
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();
const router = express.Router();

async function connect() {
  connection = await mysql.createConnection(mySqlConfig);
};

connect();

async function getWorkedHours(pracownik_id) {
  try {
    var result = await connection.query(`SELECT Odbicia.pracownik_id ,
                        We_Wy ,
                        godzina,
                        godz_rozpoczecia_naliczania_oplaty,
                        godz_zakonczenia_naliczania_oplaty,
                        stawka_godz,
                        Pracownicy.imie,
                        Pracownicy.nazwisko,
                        Stanowiska.nazwa_stanowiska,
                        Dzialy.nazwa
                        FROM Odbicia
                        INNER JOIN Pracownicy
                        ON Odbicia.pracownik_id = Pracownicy.pracownik_id
                        INNER JOIN Stanowiska
                        ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                        INNER JOIN Dzialy
                        ON Stanowiska.dzial_id = Dzialy.dzial_id
                        WHERE Odbicia.pracownik_id = ?
                    `, pracownik_id);

    let returnObject = {
      pracownik_id ,
      imie: result[0].imie || null,
      nazwisko: result[0].nazwisko|| null,
      nazwa_stanowiska: result[0].nazwa_stanowiska|| null,
      stawka_godz: result[0].stawka_godz || null
    };

    // Validation of entries
    if (result.lenght == 0) {
      console.error('Brak Odbić!');
      return Object.assign(returnObject, {
        czyPoprawne: false,
      });
    }

    if (result[0].We_Wy == "Wy") {
      console.error('Pierwsze odbicie nie powinno być wyjsciem');
      return Object.assign(returnObject, {
        czyPoprawne: false,
      });
    }

    for (var i = 1; i < result.length; i++) {
      if (result[i].We_Wy == result[i - 1].We_Wy) {
        console.error('Dwie takie same akcje!');
        return Object.assign(returnObject, {
          czyPoprawne: false,
        });
      }
    }

    //console.log('Sukces dla ID: ' + +result[0].pracownik_id)

    var przepracowaneGodziny = 0;

    // Counting
    const acceptableInHour =
      Number(JSON.stringify(result[0].godz_rozpoczecia_naliczania_oplaty).slice(1, 3)) +
      Number(JSON.stringify(result[0].godz_rozpoczecia_naliczania_oplaty).slice(4, 6)) / 60;

    const acceptableOutHour =
      Number(JSON.stringify(result[0].godz_zakonczenia_naliczania_oplaty).slice(1, 3)) +
      Number(JSON.stringify(result[0].godz_rozpoczecia_naliczania_oplaty).slice(4, 6)) / 60;

    console.log("Start: " + acceptableInHour);
    console.log("Koniec: " + acceptableOutHour);

    for (var i = 0; i < result.length - 1; i += 2) {
      var inHour = Number(JSON.stringify(result[i].godzina).slice(12, 14)) +
        Number(JSON.stringify(result[i].godzina).slice(15, 17)) / 60;
      var outHour = Number(JSON.stringify(result[i + 1].godzina).slice(12, 14)) +
        Number(JSON.stringify(result[i + 1].godzina).slice(15, 17)) / 60;
      //console.log("inHour: " + inHour);
      //console.log("outHour: " + outHour);
      if (inHour > outHour) {
        console.log('Wejscie nie moze byc pozniej od wyjscia!');
        return Object.assign(returnObject, {
          czyPoprawne: false,
        });
      }

      if (inHour < acceptableInHour)
        inHour = acceptableInHour;
      if (outHour > acceptableOutHour)
        outHour = acceptableOutHour;
      if (inHour < outHour)
        przepracowaneGodziny += outHour - inHour;
    }

    przepracowaneGodziny = parseInt(przepracowaneGodziny);
    var naleznosc = parseInt(przepracowaneGodziny * Number(result[0].stawka_godz));

    return Object.assign(returnObject, {
      czyPoprawne: true,
      przepracowaneGodziny,
      naleznosc
    });

  } catch (e) {
    console.error(e);
  }

}

router.get('/', async (req, res) => {
  try {
    var ids = await connection.query(`SELECT DISTINCT pracownik_id FROM Odbicia`);
    let data = [];
    for (let id of ids) {
      data.push(await getWorkedHours(id.pracownik_id));
    };
    data = data.filter(el=>el != null);
    res.status(200).json(data);
  } catch (e) {
    res.sendStatus(409);
  }
});

router.get('/:id', async (req, res) => {
  try {
    let data = await getWorkedHours(req.params.id)
    res.status(200).json(data);
  } catch (e) {
    res.sendStatus(409);
  }
});


module.exports = router;
