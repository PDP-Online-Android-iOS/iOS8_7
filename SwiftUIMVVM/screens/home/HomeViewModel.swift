//
//  HomeViewModel.swift
//  SwiftUIMVVM
//
//  Created by Ogabek Matyakubov on 11/01/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var contacts = [Contact]()
    @Published var isLoading = false
    
    @Published var tempContact: Contact!
    
    func apiContactList() {
        isLoading = true
        Network.get(url: Network.API_CONTACT_LIST, params: Network.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success:
                let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                self.contacts = contacts
                self.tempContact = contacts.last
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func apiContactDelete(contact: Contact, handler: @escaping (Bool) -> Void) {
        isLoading = true
        Network.del(url: Network.API_CONTACT_DELETE + contact.id, params: Network.paramsEmpty(), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success(let data):
                print(data)
                let contacts = try! JSONDecoder().decode(Contact.self, from: response.data!)
                handler(true)
            case .failure(let error):
                print(error)
                handler(false)
            }
        })
    }
    
}
