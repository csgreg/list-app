//
//  lifyApp.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. s12..
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct lifyApp: App {
    
    @AppStorage("uid") private var userID: String = ""
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(userId: userID)
        }
    }
}
