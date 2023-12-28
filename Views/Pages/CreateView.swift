//
//  CreateView.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 20..
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

struct CreateView: View {
    @State var listName: String = ""
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    @AppStorage("uid") var userID: String = ""
    
    private let db = Firestore.firestore()
    
    @EnvironmentObject var listManager: ListManager

    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .leading){
                    Text("Craft customized lists for any purpose, share a unique code for seamless collaboration.")
                        .font(.subheadline)
                        .padding(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color("dark-gray"))
                    Spacer()
                    HStack {
                        Image(systemName: "list.bullet.clipboard.fill")
                        TextField("List name", text: $listName).preferredColorScheme(.light)
                        
                        Spacer()
                        
                        if(listName.count != 0){
                            Image(systemName: listName.count > 2 ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundColor(listName.count > 2 ? .green : .red)
                            
                        }
                    }
                    .foregroundColor(Color("purple"))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color("purple"))
                    )
                    .padding()
                    Spacer()
                    Spacer()
                    Button(action: {
                        listManager.createList(listName: self.listName){ (message) in
                            self.alertMessage = message
                            self.showAlert = true
                        }
                    }){
                        Text("Create")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.linearGradient(colors: [Color("purple").opacity(1), Color("purple").opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .padding(.vertical)
                    }.padding(.horizontal)
                    .alert(isPresented: $showAlert){
                        Alert(title: Text(alertMessage))
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }.navigationTitle("Create new list")
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
            .environmentObject(ListManager(userId: "asd"))
    }
}
