//Modules
const express =require('express');
const Joi = require('joi');
const mysql = require('mysql');
const uuid = require('uuid/v4');
const session = require('express-session')
const FileStore = require('session-file-store')(session);
const bodyParser = require('body-parser');
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

//DATABASE CONSTANTS
const citizens = "citizens-323782b5";
const super_admin = "super-3237d2b9";
const water = "waterdept-323749a3";

//DUMMY DB [NOT USED]
const users = [
  {id: '2f24vvg', email: 'test@test.com', password: 'password'}
]

/*
QUERY [REFERENCE]
con.connect(function(err) {
  if (err) throw err;
  con.query("SELECT * FROM customers", function (err, result, fields){
    if (err) throw err;
    console.log(result);
  });
});
*/

//DATABASE[FUTURE USE]
function query(database,sql){
const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"51004",
  user: "pritesh",
  password: "sacred123",
  database:database
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query(sql,function (err, result, fields){
    if (err) throw err;
    console.log(result); 
    return(result);
 });
});
}

//Server
const app = express();

//Middleware
app.use(bodyParser.urlencoded({ extended: false }))
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
app.get('/',(req,res)=>{
/*Future use
  Redirect:departments
*/
req.session.views = 1;
res.send('Home');
});

//LOGIN
app.post('/login',(req, res)=>{
/*
Post data:
Phone number
Password 

Return:
select *from citizens.citizens_details where phone_no = inp and dfsf ..;
session.id = phone_no;
Session object(Phone number)

Redirect: 
Departments 
*/
const contactNo = req.body.contactNo;
const password = req.body.password;

const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"51134",
  user: "super-admin-32363121",
  password: "sacred123",
  database:"citizen"
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select *from citizens where contactNo = "+req.body.contactNo+"and password = "+req.body.password, function (err, result, fields){
    if (err) throw err;
    console.log(result);

    if(result!=null){
    req.session.contactNo=contactNo; 
    return res.status(200);
  }

 });
 });
  req.status(401);
})

//SIGNIN
app.post('/signin',(req,res)=>{
/*
Post data:
Falana dighana dhimkhana
Return:
OTP verification
Redirect:  
login page
*/
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
const membersPerFamily = req.body.membersPerFamily;
const numberOfEarnings = req.body.numberOfEarnings;
const salary = req.body.salary;
const password = req.body.password;
const time = new Date().toLocaleTimeString();
const otp = Math.floor(Math.random() * Math.floor(99999));;
const values = [contactNo,firstname,secondname,dob,sex,address,city,caste,religion,pincode,occupation,membersPerFamily,numberOfEarnings,salary,password];

const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"51134",
  user: "citizen",
  password: "sacred123",
  database:"super-admin-32363121"
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("insert into citizens_temp values ?",[values], function (err, result, fields){
    if (err) throw err;
    console.log(result);
    req.session.contactNo=contactNo; 
    otp = {'otp':otp};
    return res.json(otp); 
 });
  
});
res.send("signin");
});

//OTP
app.post('/otp',(req,res)=>{

const otp = req.body.otp;
const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"51134",//host: "shareddb-f.hosting.stackcp.net",
  user: "super-admin-32363121",
  password: "sacred123",
  database:"super-admin-32363121"
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select otp from citizen where contactNo="+req.params.contactNo, function (err, result, fields){
    if (err) throw err;
    console.log(result);
    if(result==otp){
    con.query("delete from citizen where contactNo="+req.params.contactNo);  
    con.query("insert into citizens values ?",[values], function (err, result, fields){
    if (err) throw err;
    console.log(result);
    con.close();
    return res.status(201);
 });
    }
});
});
});



app.post('/update_profile',(req,res)=>{
/*
Put data:
Phone number
Update values 

Return:
Success

Redirect:
departments  
*/
res.send("Update profile");
});

app.get('/departments',(req,res)=>{
/*
Return:
Select *from super_admin.departments;  
*/
//Connection
const sql = "select *from departments";
var results = query(super_admin,sql);
console.log(results);
return res.send(results);
});

//VIEW SCHEMES
app.get('/:department/all_schemes',(req,res)=>{
/*
Return:
select *from $departments.schemes;
*/
const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"50551",
  user: "pritesh",
  password: "sacred123",
  database: department
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select *from citizen", function (err, result, fields){
    if (err) throw err;
    console.log(result);
    return res.send(result);
 });
});
});

//ELIGIBLE SCHEMES
app.get('/:department/eligible_schemes',(req,res)=>{
/*
Return:
select *from $departments.schemes where eligible like citizen.additional_details;
*/

res.send(req.params.department+" Eligible Schemes");
});

//APPLIED SCHEMES
app.get('/applied_schemes/',(req,res)=>{
/*
Return:
select *from citizens.applied_schemes where contact_no = session.id; 
*/
const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"50551",
  user: "pritesh",
  password: "sacred123",
  database: "citizen"
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("select *from applied_schemes", function (err, result, fields){
    if (err) throw err;
    console.log(result);
    return res.send(result);
 });
});
res.send("Applies Schemes"+req.session.views++);
});

//NOTIFICATIONS
app.get('/notifications',(req,res)=>{

res.send("Notifications");
});

//

//APPLY SCHEME
app.post('/:department/apply_scheme/:scmid',(req,res)=>{
/*
Post Data:
Scheme ID
Department ID/Name
Documments(single)
Redirect:
applied_schemes
*/

const con = mysql.createConnection({
  host:"mysql.stackcp.com",
  port:"50551",
  user: "pritesh",
  password: "sacred123",
  database: department
});
con.connect(function(err) {
  if (err) throw err;
  console.log("connected");
  con.query("insert into applied_schemes values ?",[values], function (err, result, fields){
    if (err) throw err;
    console.log(result);
    return res.status(201);
 });
});
res.send("Apply Scheme for "+req.params.department+" scheme:"+req.params.scmid);
});

app.put('/update_scheme/:scmid',(req,res)=>{
/*
Future scope
*/
res.send("Update Scheme " + req.params.scmid);
});

app.listen(7000);
