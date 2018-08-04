const express = require('express');
const mysql = require('mysql');
const mySqlConfig = require('../mySqlConfig');
var connection = mysql.createConnection(mySqlConfig);
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();
const router = express.Router();



//Getting list of all records in Stanowiska table
router.get('/', (req, res) => {
  connection.query(`SELECT * FROM Stanowiska
                    INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                    `, (err, result) => {
    if(err){
      console.log("[MySql] " + err);
      res.status(404);
    }else {
      res.json(result);
      res.status(200);
    }
  });
});

router.get('/:id', (req, res) => {
  connection.query(`SELECT * FROM Stanowiska
                    INNER JOIN Dzialy
                    ON Stanowiska.dzial_id = Dzialy.dzial_id
                    WHERE stanowisko_id =?`
                    , req.params.id , (err, result) => {
    if(err){
      console.log("[MySql] " + err);
      res.status(404);
    }else {
      res.json(result);
      res.status(200);
    }
  });
});


router.post('/', jsonParser,(req, res) => {
  if (!req.body){
      res.sendStatus(400);
      return;
   }
  connection.query('insert into Stanowiska set ?', req.body, (err, result) => {
    if(err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Job record added");
    res.sendStatus(201);
  });
});


router.delete('/:id', (req, res) =>{
  connection.query('DELETE FROM Stanowiska WHERE stanowisko_id = ?',req.params.id , (err, result) => {
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
  connection.query('UPDATE Stanowiska SET ? WHERE stanowisko_id = ?', [req.body, req.params.id] , (err, result) => {
    if(err){
      console.log("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Job edited");
    res.sendStatus(200);
 });
});

module.exports = router;
