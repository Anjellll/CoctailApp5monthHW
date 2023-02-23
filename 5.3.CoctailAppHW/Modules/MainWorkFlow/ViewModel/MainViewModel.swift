//
//  MainViewModel.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 22/2/23.
//

import Foundation

protocol MainViewModelType {
    func getDrinks() async throws -> Coctails
}

class MainViewModel: MainViewModelType {
    private let networkLayer: NetworkLayer
    
    init() {
        self.networkLayer = NetworkLayer.shared
    }
    
    func getDrinks() async throws -> Coctails {
        try await networkLayer.fetchCoctails()
    }
}
