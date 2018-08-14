const http = require('http');
const mysql = require('mysql');
const express =require('express');
const Joi = require('joi');
const app = express();
const port=process.env.PORT || 8080;

//QUERIES

function query(sql,database,res){

const con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database:database
});

con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	//var sql="select * from record";
	con.query(sql,function(err,result,fields){

		if(err) throw err;
		console.log(result);
		//console.log(fields);
		//res.write("API");
		//res.status(200).json(result);
		//res.send(result).status(200);
		res.send(result);
	
	});
});
  
}

//


app.get('/data',function(req,res){

	var sql="select * from record";
	query(sql,"waterdept",res);
	console.log("inside get");
	//res.end("Terminated");
});

app.listen(port,function(){console.log(`Listening at port ${port}`);});