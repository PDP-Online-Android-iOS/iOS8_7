//
//  EditScreen.swift
//  SwiftUIMVVM
//
//  Created by Ogabek Matyakubov on 12/01/23.
//

import SwiftUI

struct EditScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var contact: Contact
    @ObservedObject var viewModel = EditViewModel()
    
    @State var name = ""
    @State var number = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                
                VStack {
                    
                    TextField("Name", text: $name)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.8), lineWidth: 1))
                    
                    TextField("Number", text: $number)
                        .frame(height: 40)
                        .padding(.leading, 10)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.8), lineWidth: 1))
                    
                    Spacer()
                    
                }.padding()
            }
            .navigationTitle("Edit Contact")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Text("Save").foregroundColor(.accentColor).onTapGesture {
                viewModel.apiContactEdit(contact: Contact(id: contact.id, name: name, number: number), handler: { response in
                    if response {
                        dismiss()
                    }
                })
            })
        }.onAppear {
            name = contact.name
            number = contact.number
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(contact: Contact(id: "", name: "", number: ""))
    }
}
