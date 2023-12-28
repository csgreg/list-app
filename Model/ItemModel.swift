//
//  ItemModel.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 18..
//

import Foundation


struct Item: Identifiable, Encodable {
    var id: String
    var text: String
    var done: Bool = false
}

