
	
var jsonexport = require('jsonexport');
var fs = require('fs');

var reader = fs.createReadStream('b.json');
var writer = fs.createWriteStream('o.csv');
console.log(reader);
reader.pipe(jsonexport()).pipe(writer);