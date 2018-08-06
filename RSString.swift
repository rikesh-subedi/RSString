//
//  RSString.swift
//  RSString
//
//  Created by Subedi, Rikesh on 06/08/18.
//  Copyright © 2018 sap. All rights reserved.
//

import Foundation
public enum PasswordStrength {
    case weak
    case strong
    case veryStrong
}

extension String {
    var color: UIColor? {
        return UIColor()
    }
    var url: URL? {
        return URL(string: self, relativeTo: nil)!
    }
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    var passwordStrength: PasswordStrength {
        return .weak
    }
    var data: Data? {
        return self.data(using: String.Encoding.utf8)
    }
    var isEmail: Bool {
        return false
    }
    
    func getModel<T:Decodable>()->T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: self.data!)
    }
    func getHeight(frame: CGRect)->CGFloat {
        return 0
    }
}
