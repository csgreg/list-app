//
//  String.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 12..
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        
        return regex.firstMatch(in: self, range:NSRange(location: 0, length: count)) != nil
    }
    
    func isValidPassword() -> Bool {
        return count > 6
    }
}
