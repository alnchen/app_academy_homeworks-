function madLib(verb, adjective, noun) {
  return `We shall ${verb.toUpperCase()} the ${adjective.toUpperCase()} ${noun.toUpperCase()}.`
}
//console.log(madLib('make', 'best', 'guac'));




function isSubstring(string1, string2) {
  return string1.includes(string2)
}
//console.log(isSubstring("time to program", "time"))
//console.log(isSubstring("Jump for joy", "joys"))




function fizzBuzz(array) {
  arr = [];
  array.forEach( el =>{
    if ((el % 3 === 0) ^ (el % 5 === 0)) {
      arr.push(el)
    }
  })
  return arr
}
//console.log(fizzBuzz([2,3,5,10,12]))



function isPrime(number) {
  if (number < 2) { return false };

  for (let i = 2; i < number; i++) {
    if ( number % i === 0) { return false};
  }
  return true
}

/*
console.log(isPrime(2))
console.log(isPrime(14))
console.log(isPrime(15485863))
console.log(isPrime(3548563))
*/


function sumOfNPrimes(n) {
  let sum = 0;
  let count = 0;
  let num = 1;

  while ( count < n ) {
    if (isPrime(num)) {
      sum += num;
      count ++;
    }
    num++
  }
  return sum
}

//console.log(sumOfNPrimes(4))
