const http = require('http');
const mysql = require('mysql');
const express =require('express');
const Joi = require('joi');
const fs = require('fs');
const app = express();
const bodyParser = require('body-parser');
const port=process.env.PORT || 8080;
var generator = require('generate-password');
var nodemailer = require('nodemailer');
var crypto = require('crypto');
app.set('view engine','ejs');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static("css"));


function password(email){

var password = generator.generate({
    length: 10,
    numbers: true
});

var hash = crypto.createHash('sha256').update(password).digest('base64');
console.log(hash);
console.log(password);


var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'nishantnimbalkar98@gmail.com',
    pass: 'nishant@123'
  }
});

var mailOptions = {
  from: 'nishantnimbalkar98@gmail.com',
  to: email,
  subject: 'Sending Email using Node.js',
  text: 'Hii, admin here. Your username for water dept is something and the password is '+password
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
});
return hash;
}

function connect(database){
	const con = mysql.createConnection({
	  host: "localhost",
	  user: "root",
	  password: "",
	  database:database
	});
	return con;
 }

 app.get('/home',(req,res)=>{
 	console.log(logged_in);
 	res.render("home.ejs");
 });

app.get('/navbar',(req,res)=>{
	res.render("/navbar.ejs");
	res.send("Welcome");
});


app.get('/view_schemes',(req,res)=>{
	con=connect("waterdept");
	const page ="view_schemes.ejs";
	var sql="select * from schemes";
	//query_get(sql,page,res);
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
	if(err) throw err;
	console.log(result);
	return res.render(page,{response:result});
});
});
});


app.get('/employee_view',(req,res)=>{
	con=connect("waterdept");
	const page ="employee_view.ejs";
	var sql="SELECT employee.empId,employee.firstName,employee.lastName,employee.talukaId,employee.email,employee.isBlocked,designation_name.designationName FROM employee INNER JOIN designation_name ON employee.designationId=designation_name.designationId;";
	//query_get(sql,page,res);
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
	if(err) throw err;
	console.log(result);
	return res.render(page,{response:result});
});
});
});



app.get('/login',(req,res)=>{
	res.render("login.ejs",{response:"0"});
});

global.logged_in=0;

app.post('/login',(req,res)=>{
	con=connect("waterdept");
	const source ="login.ejs";
	const destination ="/home";
	let info="Employee ID or Password is wrong";
	var hash = crypto.createHash('sha256').update(req.body.password).digest('base64');
	var sql="select * from employee where empId='"+req.body.emp_id+"' and password='"+hash+"';";
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
	if(err) throw err;
	if(result.length==1)
	{
		console.log("Connected");
		global.logged_in=1;
		res.redirect(destination);
	}
	else{console.log("invalid");
	res.render(source,{response: info});
}
});
});
});

app.get('/addemployee',(req,res)=>{
	res.render("addemployee.ejs");
});

app.post('/addemployee',(req,res)=>{
	con=connect("waterdept");
	const source ="addemployee.ejs";
	const destination="employee_view";
	let info="site under maintainence break";
	password=password(req.body.email);
	var sql="insert into employee values('"+req.body.emp_id+"','"+req.body.first_name+"','"+req.body.last_name+"','"+req.body.email+"','"+password+"','"+req.body.taluka_id+"','"+req.body.designation_id+"',0);";
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	//if(result.length==1)
	//{
	//	console.log("Connected");
	//	res.redirect(destination);
	//}
	res.redirect(destination);
});
});
});

app.get('/add_scheme',(req,res)=>{
	con=connect("superadmin");
	var data=[6];
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	//1)caste
	var sql="select casteName from caste;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[0]=result;
	//2)religion
	var sql="select religionName from religion;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[1]=result;
	console.log("data is "+data[1]);
	});
	//3)Occupation
	var sql="select occupationName from occupation;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[2]=result;
	console.log("data is "+data[2]);
	});
	//4)Age new connection
	con=connect("waterdept");
	var sql="select min,max from required_eligibility_age;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[3]=result;
	console.log("data is "+data[3]);
	});
	//5)Salary
	var sql="select min,max from required_eligibility_salary;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[4]=result;
	console.log("data is "+data[4]);
	});
	//6)required sex
	var sql="select sex from required_eligibility_sex;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[5]=result;
	console.log("data is "+data[5]);
	});
	//7)required sex
	var sql="select sex from required_eligibility_sex;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[6]=result;
	console.log("data is "+data[6]);
	});
	//8)required documents
	var sql="SELECT required_documents.scId,document.documentName from required_documents INNER JOIN document ON required_documents.documentId=document.documentId;"
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	console.log(result);
	data[7]=result;
	console.log("data is "+data[7]);
	});
	// var row= JSON.stringify(data)
	// console.log(row);
	res.render("add_scheme.ejs",{response:data});
	});
});
});


app.post('/add_scheme',(req,res)=>{
	const source ="add_scheme.ejs";
	const destination ="view_schemes";
	var sql="insert into schemes values('"+req.body.schemeid+"','"+req.body.name_of_scheme+"','"+req.body.startDate+"','"+req.body.endDate+"','"+req.body.district+"','"+req.body.required_documents+"','"+req.body.other+"','"+req.body.religions+"','"+req.body.other+"','"+req.body.castes+"','"+req.body.other+"','"+req.body.ages+"','"+req.body.occupations+"','"+req.body.other+"','"+req.body.incomes+"','"+req.body.sex+"')";	
	con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
	con.query(sql,function(err,result,fields){
	if(err) 
	{
	throw(err);	
	res.render(source);
	}
	//if(result.length==1)
	//{
	//	console.log("Connected");
	//	res.redirect(destination);
	//}
	res.redirect(destination);
});
});
});




app.listen(port,function(){console.log(`Listening at port ${port}`);});