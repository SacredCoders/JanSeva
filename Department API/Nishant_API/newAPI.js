const http = require('http');
const mysql = require('mysql');
const express =require('express');
const Joi = require('joi');
const fs = require('fs');
const app = express();
const bodyParser = require('body-parser');
const port=process.env.PORT || 8080;
app.set('view engine','ejs');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static("css"));
app.get('/login',(req,res)=>{
	res.render("login.ejs",{hello:" "});
});



function query(sql,page,res){
	const con = mysql.createConnection({
	  host: "localhost",
	  user: "root",
	  password: "",
	  database:"waterdept"
	});
	//console.log(req.body.username);
	//console.log(req.body.password)
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
		if(err) throw err;
	console.log(result);
	//for(var i=0;i<2;i++){
		return res.render(page,{scId:result});
	//}
	//res.render("view_schemes.ejs",{scId:result[0].scId});
});
});

}




app.post('/login',(req,res)=>{
	
	const con = mysql.createConnection({
	  host: "localhost",
	  user: "root",
	  password: "",
	  database:"waterdept"
	});
	console.log(req.body.username);
	console.log(req.body.password)
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	var sql="select * from employee where firstName=req.body.username and password=req.body.password";
	con.query(sql,function(err,result,fields){
	if(err) throw err;
	//if(result[])
	console.log("res is "+ result[0]);
	//res.render('data',{name: result[0].scId,id: result[0].contactNo});
	//res.redirect("/home");
	});
	});

	res.render("login",{hello:"error"});

});


app.get('/home',(req,res)=>{
	res.send("Welcome");
});

app.get('/navbar',(req,res)=>{
	res.render("/navbar.ejs");
	res.send("Welcome");
});


app.get('/view_schemes',(req,res)=>{
	const page ="view_schemes.ejs";
	var sql="select * from schemes";
	query(sql,page,res);
	//res.render("view_schemes.ejs",{hello:" "});
});
/*
app.post('/view_schemes',(req,res)=>{
	res.write("sdafa");
	res.render("view_schemes.ejs",{hello:"name"});
});
*/

app.listen(port,function(){console.log(`Listening at port ${port}`);});