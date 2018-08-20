var generator = require('generate-password');
var nodemailer = require('nodemailer');


function pass(){

var password = generator.generate({
    length: 10,
    numbers: true
});

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
  to: 'alokrocks217@gmail.com',
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
}

pass();
pass();