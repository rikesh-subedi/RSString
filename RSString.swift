//
//  RSString.swift
//  RSString
//
//

import Foundation

public enum PasswordStrength {
    case none
    case weak
    case strong
    case veryStrong
}

public protocol StringInitable {
    init?(value: String)
}

public extension String {
    var color: UIColor? {
        if self.hasPrefix("#") {
            let hexNumber = self.getSubstring(startIndex: 1)
            let _red = hexNumber.getSubstring(startIndex: 0, length: 2)
            let _green = hexNumber.getSubstring(startIndex: 2, length: 2)
            let _blue = hexNumber.getSubstring(startIndex: 4, length:2)
            let r = CGFloat(strtoul(_red, nil, 16))/255.0
            let g = CGFloat(strtoul(_green, nil, 16))/255.0
            let b = CGFloat(strtoul(_blue, nil, 16))/255.0
            return UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        }
        if self.hasPrefix("rgb") {
            guard let closeParenthesisIndex = self.index(of: ")") else {
                return nil
            }
            let rgb = self.getSubstring(startIndex: 4, endIndex: closeParenthesisIndex.encodedOffset - 1)
            let rgbArray = rgb.split(separator: ",")
            if rgbArray.count < 3 {
                return nil
            }
            let r = CGFloat(strtoul(String(rgbArray[0]), nil, 10))/255.0
            let g = CGFloat(strtoul(String(rgbArray[1]), nil, 10))/255.0
            let b = CGFloat(strtoul(String(rgbArray[2]), nil, 10))/255.0
            let a = rgbArray.count == 4 ? strtof("0.9", nil) : 1.0
            return UIColor.init(red: r, green: g, blue: b, alpha: CGFloat(a))
            
            
        }
        
        return nil
        
    }
    func getSubstring(startIndex: Int, endIndex:Int) -> String {
        if startIndex > endIndex {
            return ""
        }
        let startIndex = self.index(self.startIndex, offsetBy: startIndex)
        let endIndex = self.index(self.startIndex, offsetBy: endIndex)
        let str = self[startIndex...endIndex]
        return String(str)
    }
    
    func getSubstring(startIndex:Int, length: Int) -> String {
        let endIndex = startIndex + length - 1
        return self.getSubstring(startIndex:startIndex, endIndex:endIndex)
    }
    
    func getSubstring(startIndex: Int) -> String {
        let endIndex = self.count - 1
        return self.getSubstring(startIndex: startIndex, endIndex: endIndex)
    }
    
    var url: URL? {
        return URL(string: self, relativeTo: nil)!
    }
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var passwordStrength: PasswordStrength {
        var strength = 0
        
        //check for length
        switch self.count {
        case 0:
            return .none
        case 1...4:
            strength += 1
        case 5...8:
            strength += 2
        default:
            strength += 3
        }
        
        //check for patterns
        let patterns = ["^(?=.*[A-Z]).*$", "^(?=.*[a-z]).*$", "^(?=.*[0-9]).*$", "^(?=.*[!@#%&-_=:;\"'<>,`~\\*\\?\\+\\[\\]\\(\\)\\{\\}\\^\\$\\|\\\\\\.\\/]).*$"]
        for pattern in patterns {
            if self.range(of: pattern, options: .regularExpression) != nil {
                strength += 1
            }
        }
        
        switch strength {
        case 0:
            return .none
        case 1...3:
            return .weak
        case 4...6:
            return .strong
        default:
            return .veryStrong
        }
    }
    var data: Data? {
        return self.data(using: String.Encoding.utf8)
    }
    
    var toFloat: Float? {
        return Float(self)
    }
    var toInt: Int? {
        return Int(self)
    }
    var hexToInt: Int? {
        return strtol(self, nil, 16)
    }
    
    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: self.count))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    var base64: String {
        return self.data!.base64EncodedString()
    }
    
    var base64Decoded: String {
        let data = Data.init(base64Encoded: self)!
        return String.init(data: data, encoding: String.Encoding.utf8)!
    }
    
    func getModel<T:Decodable>()->T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: self.data!)
    }
    func getHeight(in frame: CGRect, font: UIFont)->CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height
    }
    func getDate(format:String)->Date {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.date(from: self)!
    }
    func getDisplayDate(inputFormat:String , outputformat: String) -> String {
        let date = self.getDate(format: inputFormat)
        let formatter = DateFormatter.init()
        formatter.dateFormat = outputformat
        return formatter.string(from: date)
    }
    func split(separator:String) -> [String] {
       return self.components(separatedBy: separator)
    }
    func split<T:StringInitable>(separator:String, type: StringInitable.Type) -> [T] {
        let strings = self.split(separator: separator)
        return strings.compactMap { (str) -> T? in
            return T(value: str)
        }
    }
    
    var camelcasedUpper: String {
        let words = self.split(separator: " ").map { (word) in
            return word.lowercased().capitalized
        }
        return words.joined()
    }
    var camelcaseLower: String {
        let words = self.split(separator: " ").enumerated().map { (args) -> String in
            let (index, word) = args
            if index == 0 {
                return word.lowercased()
            }
            return word.lowercased().capitalized
        }
        return words.joined()
    }
    
    var shuffled: String {
        var arr = Array(self)
        var shuffled = ""
        for _ in 0..<arr.count {
            let index = Int(arc4random()) % arr.count
            shuffled.append(arr[index])
            arr.remove(at: index)
        }
        return shuffled
    }
    
    
    
    
}
