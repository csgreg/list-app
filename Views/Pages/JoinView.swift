//
//  CreateView.swift
//  lify
//
//  Created by Gergo Csizmadia on 2023. 03. 20..
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

struct JoinView: View {
    @State var listName: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    @AppStorage("uid") var userID: String = ""
    
    
    private let db = Firestore.firestore()
    
    @EnvironmentObject var listManager: ListManager

    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Enter a code to join existing lists. Collaborate on tasks, events, or shopping effortlessly with friends and family.")
                        .font(.subheadline)
                        .padding(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color("dark-gray"))
                    Spacer()
                    HStack {
                        Image(systemName: "list.bullet.clipboard.fill")
                        TextField("Code", text: $listName).preferredColorScheme(.light)
                        
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
                    Button(action: {
                        listManager.joinToList(listId: self.listName, userId: userID){ (message) in
                            self.alertMessage = message
                            self.showAlert = true
                        }
                    }){
                        Text("Join")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.linearGradient(colors: [Color("purple").opacity(1), Color("purple").opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .padding(.horizontal)
                    }
                    .alert(isPresented: $showAlert){
                        Alert(title: Text(alertMessage)
                        )
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }.navigationTitle("Join the Collaboration")
        }
    }
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView()
            .environmentObject(ListManager(userId: "asd"))
    }
}

