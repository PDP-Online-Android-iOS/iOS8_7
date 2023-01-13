//
//  EditViewModel.swift
//  SwiftUIMVVM
//
//  Created by Ogabek Matyakubov on 12/01/23.
//

import Foundation

class EditViewModel: ObservableObject {
    
    @Published var isLoading = false
    
    func apiContactEdit(contact: Contact, handler: @escaping (Bool) -> Void) {
        isLoading = true
        Network.put(url: Network.API_CONTACT_UPDATE + contact.id, params: Network.paramsPostUpdate(contact: contact), handler: { response in
            self.isLoading = false
            switch response.result {
            case .success(let data):
                print(data)
                handler(true)
            case .failure(let error):
                print(error)
                handler(false)
            }
        })
    }
    
}
