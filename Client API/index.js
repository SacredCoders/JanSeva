//Modules
const express =require('express');
const mysql = require('mysql');
const uuid = require('uuid/v4');
const session = require('express-session')
const FileStore = require('session-file-store')(session);
const bodyParser = require('body-parser');

//DATABASE CONSTANTS
const citizens = "citizens";
const super_admin = "super";
const water = "water";

//DATABASE SELECT
function query(database,sql,res){
const con = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "",
  database:database
});

con.connect(function(err) {
  if (err) throw err;
  console.log("connected");

con.query(sql,function (err, result, fields){
  if (err) throw err;
  res.status(200).json(result);
 });
});	
}

//DATABASE INSERT
function insert(database,sql,values,res,info){
info = info || null;
const con = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "",
  database:database
});

con.connect(function(err) {
  if (err) throw err;
  console.log("connected");

con.query(sql,[values],function (err, result, fields){
  if (err) throw err;
  res.status(201).send(info);
 });
});	
}

//DATABASE LOGIN
function login(req,res){
const con = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "",
  database:"citizens"
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select *from citizen_details where contactNo = '"+req.body.contactNo+"' and password = '"+req.body.password+"'", function (err, result, fields){
    if (err) throw err;
    console.log(result);
    if(result.length==1){
    req.session.contactNo=req.body.contactNo; 
    return res.status(200).send("LOGIN");
  }
  	else{
  	return res.status(401).send("FAILED");
  	}
 });
 });
}

function isLogin(req){
if(req.session.contactNo){
	return true;
}
else{
return false;
}
}

function logout(req){
	req.session.contactNo = null;
}

//Server
const app = express();

//Middleware
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(session({
  genid: (req) => {
    console.log('Inside the session middleware')
    console.log(req.sessionID)
    return uuid() 
  },
  store: new FileStore(),
  secret: 'sacred coders',
  resave: false,
  saveUninitialized: true
}))

//Routes

//DEVELOPMENT USE[SKIP]
app.get('/',(req,res)=>{
if(isLogin(req)){
	res.send('LOGGED IN');
}
else{
	res.redirect('/login');
}
});

//LOGIN
app.post('/login',(req, res)=>{
login(req,res); 
})

//LOGOUT
app.get('/logout',(req,res)=>{
logout(req);
res.status(200).send("LOGGED OUT");	
})

//LIST DEPARTMENTS
app.get('/departments',(req,res)=>{
if(isLogin(req)){
	const sql = "select *from department";
	query(super_admin,sql,res);
}
else{
	res.redirect('/login');}	
});

//VIEW SCHEMES
app.get('/:department/all_schemes',(req,res)=>{
if(isLogin(req)){
	const sql = "select *from schemes";
	query(req.params.department,sql,res);;
}
else{
	res.redirect('/login');
}
});

//APPLIED SCHEMES
app.get('/applied_schemes/',(req,res)=>{
if(isLogin(req)){
	const sql = "select *from applied_schemes where contactNo="+req.session.contactNo;
	query(citizens,sql,res);
}
else{
	res.redirect('/login');
}
});

//APPLY SCHEME [DB need update department,scheme_id]
app.post('/:department/apply_scheme/:scmid',(req,res)=>{
if(isLogin(req)){
	const sql = "insert into applied_schemes values ?";
	var d = new Date();
	var month = d.getUTCMonth()+1;
	var day = d.getUTCDate();
	var year = d.getUTCFullYear();
	date = year + "/" + month + "/" + day;
	const values=[[8,req.session.contactNo,date,req.params.scmid,'placed']];
	insert(citizens,sql,values,res);
}
else{
	res.redirect('/login');
}
});

//NOTIFICATIONS
app.get('/notifications',(req,res)=>{
if(isLogin(req)){
	const sql = "select *from citizen_details where contactNo="+req.session.contactNo;
	query(citizens,sql,res);
}
else{
	res.redirect('/login');
}
});

//ELIGIBLE SCHEMES
app.get('/:department/eligible_schemes',(req,res)=>{
/*
Return:
select *from $departments.schemes where eligible like citizen.additional_details;
*/

});

//SIGNIN
app.post('/signin',(req,res)=>{
const contactNo = req.body.contactNo;
const firstname = req.body.firstname;
const secondname = req.body.secondname;
const dob = req.body.dob;
const sex = req.body.sex;
const address = req.body.address;
const city = req.body.city;
const caste = req.body.caste;
const religion = req.body.religion;
const pincode = req.body.pincode;
const occupation = req.body.occupation;
const membersPerFamily = parseInt(req.body.membersPerFamily);
const numberOfEarnings = parseInt(req.body.numberOfEarnings);
const salary = parseFloat(req.body.salary);
const password = req.body.password;
const time = new Date().toLocaleTimeString();
const otp_num = Math.floor(Math.random() * Math.floor(99999));;
const values = [[contactNo,firstname,secondname,dob,sex,address,city,caste,religion,pincode,occupation,membersPerFamily,numberOfEarnings,salary,password,time,otp_num]];
console.log(values);
const sql = "insert into citizen_details_temp values ?";
req.session.contactNo=contactNo; 
const otp = {'OTP':otp_num};
insert(citizens,sql,values,res,otp); 
});

//OTP[NEEDS WORK]
app.post('/otp',(req,res)=>{

const otp = req.body.otp;
const time = new Date().toLocaleTimeString();

const con = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "",
  database:"citizens",
  acquireTimeout: 1000000
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select otp,time from citizen_details_temp where contactNo="+req.session.contactNo, function (err, result, fields){
    if (err) throw err;
    console.log(time+5);
    if(result[0].otp==parseInt(otp) && time>result[0].time+5){
    console.log("True");
   con.query("SELECT `contactNo`, `firstname`, `secondname`, `dob`, `sex`, `address`, `city`, `caste`, `religion`, `pincode`, `occupation`, `membersPerFamily`, `noOfEarnings`, `salary`, `password` from citizen_details_temp where contactNo="+req.session.contactNo,function(err,result,fields){
   			 if (err) throw err;
   			 console.log(result);
   			 const values = [[result[0].contactNo,result[0].firstname,result[0].secondname,result[0].dob,result[0].sex,result[0].address,result[0].city,result[0].caste,result[0].religion,result[0].pincode,result[0].occupation,result[0].membersPerFamily,result[0].noOfEarnings,result[0].salary,result[0].password]];	 
   			 console.log(values);
   			 con.query("insert into citizen_details values ?",[values], function (err, result, fields){
   			 	if (err) throw err;
    			con.query("delete from citizen_details_temp where contactNo="+req.session.contactNo);
    			return res.status(201).send();  
   			 });
 	});
    }
});
});
});


// ChatBot [In progress]
app.get('/chatbot',(req, res)=>{
	const args1 = req.query.q;
    const {spawn} = require('child_process');
    const chatbot = spawn('python3', ['./hello.py',args1]);
    chatbot.stdout.on('data', function(data) {
    console.log(data.toString());
    res.send(data);
    });
})	


app.listen(7000);