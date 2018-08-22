const crypto = require('crypto');
// function to encrypt data ....
const KEY="coders";
var encryptInformation= function(KEY,normalText){
const cipher = crypto.createCipher('aes192', KEY);
console.log('cipher is'+cipher);
var encrypted = cipher.update(normalText,'utf8', 'hex');
encrypted += cipher.final('hex');
return encrypted;
}

//const crypto = require('crypto'); 
// function to decryt data..............
var decryptInformation = function(KEY,encryptedText){ 
    const decipher = crypto.createDecipher('aes192', KEY) 
    var decrypted = decipher.update(encryptedText,'hex','utf8') 
    decrypted += decipher.final('utf8'); 
    return decrypted; 
 }
 var encryptedData = encryptInformation(KEY ,"some text that need to encrypt"); 
var decryptedData = decryptInformation(KEY , encryptedData);
console.log(encryptedData);
console.log(decryptedData);