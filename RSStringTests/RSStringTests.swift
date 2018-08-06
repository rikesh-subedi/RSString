//
//  RSStringTests.swift
//  RSStringTests
//
//

import XCTest
import RSString
extension Int: StringInitable {
    public init?(value: String) {
        self.init(value)
    }
}

extension Float: StringInitable {
    public init?(value: String) {
        self.init(value)
    }
}
class RSStringTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRGBColor() {
        let rgb = "rgb(255,0,0)"
        let redColor = rgb.color
        assert(redColor != nil)
        assert(redColor! == UIColor.red)
    }
    
    func testRGBAColor() {
        let rgb = "rgb(255,0,0, 0.9)"
        let redColor = rgb.color
        assert(redColor != nil)
        assert(redColor! == UIColor.red.withAlphaComponent(0.9))
    }
    
    func testHexColor() {
        let hex = "#ff0000"
        let redColor = hex.color
        assert(redColor != nil)
        assert(redColor! == UIColor.red)
    }
    
    func testBase64Encoding() {
        let str = "hello"
        assert(str.base64 == "aGVsbG8=")
    }
    
    func testBase64Decoding() {
        let base64 = "aGVsbG8="
        assert(base64.base64Decoded == "hello")
    }
    
    func testStrToFloat() {
        let floatStr = "0.1"
        assert(floatStr.toFloat != nil)
        assert(floatStr.toFloat! == 0.1)
    }
    
    func testStrToInt(){
        let intStr = "1"
        assert(intStr.toInt != nil)
        assert(intStr.toInt! == 1)
    }
    
    func testHexToDec() {
        let hexStr = "FF"
        assert(hexStr.hexToInt != nil)
        assert(hexStr.hexToInt! == 255)
    }
    
    func testEmail() {
        let email = "abc@c.com"
        assert(email.isEmail)
    }
    func testNotEmail() {
        let email = "abcc.com"
        assert(!email.isEmail)
    }
    
    func testURL() {
        let urlString = "http://www.google.com"
        let url = urlString.url
        assert(url != nil)
        assert(url!.absoluteString == urlString)
    }
    func testDateYYYY_MM_dd() {
        let dateStr = "2012-08-18"
        let date = dateStr.getDate(format: "yyyy-MM-dd")
        let comp = Calendar.current.dateComponents([.year, .month, .day], from: date)
        assert(comp.year == 2012)
        assert(comp.month == 8)
        assert(comp.day == 18)
        
        
    }
    func testPasswordNoPassword(){
        let password = ""
        let strength = password.passwordStrength
        assert(strength == .none)
    }
    
    func testPasswordStrengthWeak() {
        let password = "hello"
        let strength = password.passwordStrength
        assert(strength == .weak)
    }
    
    func testPasswordStrong(){
        let password = "hello12"
        let strength = password.passwordStrength
        assert(strength == .strong)
    }
    func testPasswordVeryStrong(){
        let password = "Helloeveryone12$"
        let strength = password.passwordStrength
        assert(strength == .veryStrong)
    }
    
    func testDisplayDate() {
        let dateStr = "2012-08-18"
        let displayDate = dateStr.getDisplayDate(inputFormat: "yyyy-MM-dd", outputformat: "MMM dd, yyyy")
        assert(displayDate == "Aug 18, 2012")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSimpleSplit() {
        let string = "hello,hi,namaste"
        let splitted = string.split(separator: ",")
        assert(splitted.count == 3)
        assert(splitted[0] == "hello")
        assert(splitted[1] == "hi")
        assert(splitted[2] == "namaste")
    }
    
    func testIntSplit() {
        let string = "1,2,3"
        let intArray:[Int] = string.split(separator: ",", type: Int.self)
        assert(intArray.count == 3)
        assert(intArray[0] == 1)
        assert(intArray[1] == 2)
        assert(intArray[2] == 3)
        
        
        
    }
    
    func testFloatSplit() {
        let string = "1.0,2.0,3.0"
        let intArray:[Float] = string.split(separator: ",", type: Float.self)
        assert(intArray.count == 3)
        assert(intArray[0] == 1.0)
        assert(intArray[1] == 2.0)
        assert(intArray[2] == 3.0)
    }
    
    func testCamelCasedUpper() {
        let string = "hello there"
        assert(string.camelcasedUpper == "HelloThere")
    }
    
    func testCamelCasedLower() {
        let string = "hello there"
        assert(string.camelcaseLower == "helloThere")
    }
    func testWordShuffling() {
        let string = "ELEPHANT"
        assert(string.shuffled.count == string.count)
    }
    
}
