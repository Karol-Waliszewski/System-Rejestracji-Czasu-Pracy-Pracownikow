const express = require('express');
const mysql = require('mysql');
const mySqlConfig = require('../mySqlConfig');
var connection = mysql.createConnection(mySqlConfig);
var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();
const router = express.Router();


router.get('/', (req, res) => {
  connection.query('SELECT * FROM Dzialy', (err, result) => {
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
  connection.query('SELECT * FROM Dzialy WHERE dzial_id = ?'  , req.params.id , (err, result) => {
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
  connection.query('insert into Dzialy set ?', req.body, (err, result) => {
    if(err) {
      console.error("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Departament record added");
    res.sendStatus(201);
    return;
  });
});


router.delete('/:id', (req, res) =>{
  connection.query('DELETE FROM Dzialy WHERE dzial_id = ?',req.params.id , (err, result) => {
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
  connection.query('UPDATE Dzialy SET ? WHERE dzial_id = ?', [req.body, req.params.id] , (err, result) => {
    if(err){
      console.log("[MySql]" + err);
      res.sendStatus(409);
      return;
    }
    console.log("[MySql] Dept edited");
    res.sendStatus(200);
 });
});


module.exports = router;
