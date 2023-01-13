//
//  HomeScreen.swift
//  SwiftUIMVVM
//
//  Created by Ogabek Matyakubov on 11/01/23.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    @State private var showingEdit = false
    
    func delete(indexSet: IndexSet) {
        let contact = viewModel.contacts[indexSet.first!]
        viewModel.apiContactDelete(contact: contact, handler: { response in
            if response {
                viewModel.apiContactList()
            }
        })
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.contacts, id:\.id) { contact in
                        ContactCell(contact: contact).onLongPressGesture {
                            self.viewModel.tempContact = contact
                            showingEdit.toggle()
                        }.sheet(isPresented: $showingEdit) {
                            EditScreen(contact: viewModel.tempContact)
                        }
                    }
                    .onDelete(perform: delete)
                }.listStyle(PlainListStyle())
                
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle("SwiftUI MVVM")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Image(systemName: "arrow.triangle.2.circlepath").onTapGesture {
                viewModel.apiContactList()
            }, trailing: NavigationLink(destination: CreateScreen(), label: {
                Image(systemName: "person.badge.plus")
                    .foregroundColor(.black)
            }))
        }.onAppear {
            viewModel.apiContactList()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
