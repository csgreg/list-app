//
//  ListModel.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 18..
//

import Foundation

struct Listy: Identifiable {
    var id: String
    var name: String
    var items: [Item]
    var users: [String]
}
