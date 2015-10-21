/**
 * @class Person
 * This class describes a person structure, with common methods. Used as
 * test source for doc creation
 */

/**
 * Creates a new person Object
 * @param name string the name of the person
 * @param age integer the age of the person
 */
function Person (name, age) {
  this.name = name;
  this.age = age;
}

/**
 * Get a string with a hello message
 * @return string the hello message
 */
Person.prototype.hello = function () {
  return 'Hello, my name is ' + this.name;
}

/**
 * Get a string with a detailed description
 * @param inline bool if to create a two line description
 * @return string the description
 */
 Person.prototype.details = function (inline) {
   var ret = 'Name: ' + this.name + ' ';
   if (typeof(inline) != 'undefined') {
     ret += '\n';
   }
   ret += 'Age: ' + this.age;
   return ret;
}
