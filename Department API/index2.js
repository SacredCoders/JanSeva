////Modules
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
function insert(database,sql,values,res){
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
  res.status(201).send();
 });
});	
}

//DATABASE LOGIN
function login(database,req,res){
const con = mysql.createConnection({
  host:"localhost",
  user: "root",
  password: "",
  database:database
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  console.log(req.body.contactNo+"\n"+req.body.password);
  con.query("select *from employee where empId = '"+req.body.empId+"' and password = '"+req.body.password+"'", function (err, result, fields){
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


//LOGIN[Database password require]
app.post('/:department/login',(req,res)=>{
login(req.params.department,req,res);
});

//ADD EMPLOYESS
app.post('/:department/add_employee',(req,res)=>{
const empId = req.body.empId;
const firstName = req.body.firstName;
const LastName = req.body.LastName;
const pincode = req.body.pincode;
const designationID = req.body.designationID;
const dateOfCreation = new Date();
const dateOfDeletion = "0/0/0";
const lastModified = new Date();
const isDelete = "0";
const isBlocked = "0";
const email = req.body.email;
const password = req.body.password;
const values = [[empId,firstName,LastName,pincode,designationID,dateOfCreation,dateOfDeletion,lastModified,isDelete,isBlocked,email,password]];
console.log(values);
const sql = "insert into employee values ?"; 
insert(req.params.department,sql,values,res);
});

//VIEW EMPLOYESS
app.get('/:department/view_employees',(req,res)=>{
const sql = "select *from employee";
query(req.params.department,sql,res);
});

//ADD designation[Change roles to designation]
app.post('/:department/add_designation',(req,res)=>{
const designationId = req.body.designationId;
const designationName = req.body.designationName;
const sql = "insert into designation values ?";
const values = [[designationId,designationName]];
insert(res.params.department,sql,values,res);
});

//ADD SCHEMES
app.post('/:department/add_schemes',(req,res)=>{
const scId = req.body.scId;
const name = req.body.name;
const startDate = req.body.startDate;
const endDate = req.body.endDate;
const eligibleCaste = req.body.eligibleCaste;
const eligibleAge = req.body.eligibleAge;
const eligibleOccupation = req.body.eligibleOccupation;
const eligibleIncome = req.body.eligibleIncome;
const eligibleSex = req.body.eligibleSex;
const eligibleReligion = req.body.eligibleReligion;
const eligibleOthers = req.body.eligibleOthers;
const dateOfCreation = new Date();
const dateOfDeletion = "0/0/0";
const lastModified = new Date();
const isDelete = "0";
const isBlocked = "0";
const values = [[scId,name,startDate,endDate,eligibleCaste,eligibleAge,eligibleOccupation,eligibleIncome,eligibleSex,eligibleReligion,eligibleOthers,dateOfCreation,dateOfDeletion,lastModified,isDelete,isBlocked]];
const sql = "insert into schemes values ?";
insert(req.params.department,sql,values,res);
});

//VIEW SCHEMES
app.get('/:department/view_schemes',(req,res)=>{
const sql = "select *from schemes";
query(req.params.department,sql,res);
});

//ACCESS CONTROL[VIEW]
app.get('/:department/access_control/view',(req,res)=>{
const sql = "select *from access_control";
query(req.params.department,sql,res);
});

//ACCESS CONTROL[UPDATE]
app.put('/:department/access_control/:designationId/update',(req,res)=>{
const sql = "update access_control set .. where designationId="+designationId;
query(req.params.department,sql,res);
});

//VIEW ASSIGNED APPLICATIONS
app.get('/:department/inbox',(req,res)=>{
const sql="select *from application_assigned where empId= "+req.session.empId;
query(req.params.department,sql,res);
});

//VERIFY APPLICATIONS
app.put('/:department/inbox/update/:appId',(req,res)=>{
const status = req.body.status;	
const sql="update applied_schemes set applicationStatus = "+status+" where appId ="+appId;
query(citizens,sql,res);
});

//VIEW FINISHED APLLICATIONS
app.get('/:department/inbox/completed',(req,res)=>{
const status = req.body.status;	
const sql="select *from application_assigned where where empId = "+req.session.empId+"and exists(select *from citizens.applied_schemes where applicationStatus=completed)";
query(citizens,sql,res);
});

//ASSIGN APPLICATIONS
app.post('/:department/assign_applications',(req,res)=>{
const sql = "select *from application_assigned";
query(req.params.department,sql,res)

});

//FILE

app.listen(7000);