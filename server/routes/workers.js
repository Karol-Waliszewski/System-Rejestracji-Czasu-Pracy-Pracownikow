const express = require('express');
const mysql = require('mysql');
const mySqlConfig = require('../mySqlConfig');
var connection = mysql.createConnection(mySqlConfig);
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();
const router = express.Router();



router.get('/', (req, res) => {
  connection.query(`SELECT * FROM Pracownicy
                    INNER JOIN Stanowiska
                    ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                    INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                    `, (err, result) => {
    if (err) {
      console.log("[MySql] " + err);
      res.sendStatus(404);
    } else {
      res.status(200);
      res.json(result);
    }
  });
});

router.get('/:id', (req, res) => {
  connection.query(`SELECT * FROM Pracownicy
                    INNER JOIN Stanowiska
                    ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                    INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                    WHERE pracownik_id = ?
                    `, req.params.id, (err, result) => {
    if (err) {
      console.log("[MySql] " + err);
      res.sendStatus(404);
    } else {
      res.status(200);
      res.json(result);
    }
  });
});


router.post('/', jsonParser, (req, res) => {
  if (!req.body) {
    res.status(400);
    return;
  }
  Object.assign(req.body, {
    data_dodania: new Date().getFullYear() + '-' + (new Date().getMonth() + 1) + '-' + (new Date().getDate() + 1)
  });
  connection.query('insert into Pracownicy set ?', req.body, (err, result) => {
    if (err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Worker record added");
    res.sendStatus(201);
  });
});


router.delete('/:id', (req, res) => {
  connection.query('DELETE FROM Odbicia WHERE pracownik_id = ?', req.params.id, (err, result) => {
    if (err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    connection.query('DELETE FROM Pracownicy WHERE pracownik_id = ?', req.params.id, (err, result) => {
      if (err) {
        console.error("[MySql]" + err);
        res.sendStatus(409);
        return;
      }
      console.log("[MySql] Deleted");
      res.sendStatus(200);
    });
  });
});


router.put('/:id', jsonParser, (req, res) => {
  if (!req.body) {
    res.sendStatus(400);
    return;
  }
  if (req.body.data_dodania)
    req.body.data_dodania = req.body.data_dodania.slice(0, 10);
  if (req.body.data_urodzenia)
    req.body.data_urodzenia = req.body.data_urodzenia.slice(0, 10);
  connection.query('UPDATE Pracownicy SET ? WHERE pracownik_id = ?', [req.body, req.params.id], (err, result) => {
    if (err) {
      console.log("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Worker edited");
    res.sendStatus(200);
  });
});


module.exports = router;
