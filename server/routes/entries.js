const express = require('express');
const mysql = require('mysql');
const mySqlConfig = require('../mySqlConfig');
var connection = mysql.createConnection(mySqlConfig);
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();
const router = express.Router();


router.get('/', (req, res) => {
  connection.query(`SELECT * FROM Odbicia
                    INNER JOIN Pracownicy
                    ON Odbicia.pracownik_id = Pracownicy.pracownik_id
                    INNER JOIN Stanowiska
                    ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                    INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                    `, (err, result) => {
    if(err){
      console.log("[MySql] " + err);
      res.sendStatus(404);
    }else {
      res.status(200);
      res.json(result);
    }
  });
});

router.get('/:id', (req, res) => {
  connection.query(`SELECT * FROM Odbicia
                      INNER JOIN Pracownicy
                    ON Odbicia.pracownik_id = Pracownicy.pracownik_id
                      INNER JOIN Stanowiska
                    ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                      INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                      WHERE odbicie_id = ?
                    `, req.params.id , (err, result) => {
    if(err){
      console.log("[MySql] " + err);
      res.sendStatus(404);
    }else {
      res.status(200);
      res.json(result);
    }
  });
});

// Gives list of entries of specific worker
router.get('/workers/:id', (req, res) => {
  connection.query(`SELECT * FROM Odbicia
                      INNER JOIN Pracownicy
                        ON Odbicia.pracownik_id = Pracownicy.pracownik_id
                      INNER JOIN Stanowiska
                        ON Pracownicy.stanowisko_id = Stanowiska.stanowisko_id
                      INNER JOIN Dzialy
                        ON Stanowiska.dzial_id = Dzialy.dzial_id
                    WHERE Odbicia.pracownik_id = ?
                    `,req.params.id , (err, result) => {
    if(err){
      console.log("[MySql] " + err);
      res.sendStatus(404);
    }else {
      res.status(200);
      res.json(result);
    }
  });
});

/*
* POST status:
* 201 - Created
* 400 - Empty JSON - bad request
* 409 - Conflict - SQL Error - Wrong json
*
**406 - if worker tries to get in or out 2 times in a row
*/

router.post('/', jsonParser,(req, res) => {
  var badEntry= false;
  if (!req.body){
      res.sendStatus(400);
      return;
   }
  connection.query("SELECT * FROM Odbicia WHERE pracownik_id = ? ORDER BY odbicie_id DESC LIMIT 1", req.body.pracownik_id, (err, result) =>{
    if(err){
      console.log("[MySql] error: ", err );
      res.sendStatus(409);
      return;
    }
    if(result.length){
      if(result[0].We_Wy == req.body.We_Wy)
        badEntry = true;
    }
     else if(req.body.We_Wy == "Wy")
            badEntry == true;
  });
  var datetime = new Date();
  datetime.setHours(datetime.getHours()+2);
  Object.assign( req.body, {godzina : datetime});
  connection.query('insert into Odbicia set ?', req.body, (err, result) => {
    if(err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Entry record added");
    if(badEntry)
      res.sendStatus(406);
    else
      res.sendStatus(201);
  });
});



router.delete('/:id', (req, res) =>{
  connection.query('DELETE FROM Odbicia WHERE odbicie_id = ?',req.params.id , (err, result) => {
    if(err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Deleted");
    res.sendStatus(200);
  });
});

router.put('/:id',jsonParser , (req, res) =>{
  if(!req.body){
    res.sendStatus(400);
    return;
  }
  connection.query('UPDATE Odbicia SET ? WHERE odbicie_id = ?', [req.body, req.params.id] , (err, result) => {
    if(err){
      console.log("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Entry edited");
    res.sendStatus(200);
 });
});

module.exports = router;
