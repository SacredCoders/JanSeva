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

app.get('/login',(req,res)=>{
	res.render("login.ejs",{hello:" "});
});


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
});


app.get('/employee_view',(req,res)=>{
	const page ="employee_view.ejs";
	var sql="SELECT employee.empId,employee.firstName,employee.lastName,employee.pincode,roles.designationName FROM employee INNER JOIN roles ON employee.designationId=roles.designationId;";
	query(sql,page,res);
});

/*
SELECT employee.empId,employee.firstName,employee.lastName,employee.pincode,roles.designationName
FROM employee
INNER JOIN roles ON employee.designationId=roles.designationId;
*/

function query_post(sql,page,res){
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
	return res.render(page);
	//}
	//res.render("view_schemes.ejs",{scId:result[0].scId});
});
});

}





app.get('/addemployee',(req,res)=>{
	res.render("addemployee.ejs",{hello:" "});
});

app.post('/addemployee',(req,res)=>{
	const page ="navbar.ejs";
	var temp="select designationId from roles where designationName='"+req.body.designation_name+"';" 
	console.log("temp is "+temp);
	//var sql="insert into waterdept.employee values('"+req.body.emp_id+"','"+req.body.first_name+"','"+req.body.last_name+"','"+req.body.pin_code+"','"temp"'');";
	//query_post(sql,page,res);
	//res.render("addemployee.ejs",{hello:"error"});
});
//req.body.emp_id,req.body.first_name,req.body.last_name,req.body.pin_code,req.body.designation_name

app.listen(port,function(){console.log(`Listening at port ${port}`);});