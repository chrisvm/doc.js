var config, main;

require('coffee-script/register');

config = require('./src/config/config');

main = function() {
  var cnf, cwd;
  cwd = process.cwd();
  cnf = config.read(cwd);
  if (cnf == null) {
    throw 'Config not found error';
  }
  return console.log(cnf);
};

main();
