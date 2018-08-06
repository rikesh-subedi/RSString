# RSString
Personally, I have wasted huge amount of time writing the same code again and again. In an effort to save time, I came up with a framework which adds most basic utitilities as form of extensions to String.



Here are the few examples one can try:

***Get UIColor from a string value***
```
  let rgb = "rgb(255,0,0)"  
  let redColor = rgb.color
  let hexString = "#00ff00"
  let blueColor = rgb.color
````
***Get UIDate from a string value***
```
  let dateStr = "2012-08-18"
  let date = dateStr.getDate(format: "yyyy-MM-dd")
```
***Check if it's a valid email***
```
  let emailString = "abcc.com"
  if emailString.isEmail {
    //do something
  }
```
***Check the strength of a password***
```
  let password = "Hello123"
  if password.passwordStrength == .veryStrong {
    //do something
  }
```

***Get URL from string***
```
  let urlString = "www.google.com"
  let url = urlString.url
```
***Find password strength*** 
```
  let password = "Helloeveryone12$"
  if password.strength == .veryStrong {
      //do something
  }
```
***Split strings into array of StringInitable***
```
  let string = "1,2,3"
  let intArray:[Int] = string.split(separator: ",", type: Int.self)
  //Int and Float needs to conform to custom protocol StringInitable
  let floatArray:[Float] =  string.split(separator: ",", type: Float.self)
```
***Get camelcased lower string***
```
 let string = "hello world"
 let helloWorld = string.camelcaseLower 
```
***Get camelcased upper string***
```
 let string = "hello world"
 let HelloWorld = string.camelcaseUpper 
```
***Get scrambled***
```
 let string = "ELEPHANT"
 let shuffled = string.shuffled
```
