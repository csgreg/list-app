//
//  MainView.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 17..
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @AppStorage("uid") var userID: String = ""
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView{
            HomeView().preferredColorScheme(.light)
                .tabItem{
                    Image(systemName: "house")
                }
            CreateView().preferredColorScheme(.light)
                .tabItem{
                    Image(systemName: "plus.square.fill.on.square.fill")
                }
            JoinView().preferredColorScheme(.light)
                .tabItem{
                    Image(systemName: "person.badge.plus")
                }
            Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    withAnimation {
                        userID = ""
                    }
                } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
                }
            }){
                Text("Sign out")
            }
                .tabItem{
                    Image(systemName: "person.crop.circle")
                }
        }
        .preferredColorScheme(.light)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
