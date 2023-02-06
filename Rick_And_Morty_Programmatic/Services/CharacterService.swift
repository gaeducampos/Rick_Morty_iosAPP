//
//  CharacterService.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 6/2/23.
//

import Foundation
import Combine

/// Primary API service object to get Rick and Morty data
final class CharactersService {
    let networkProvider: NetworkProvider
    
    /// Dependency Injection of the NetworkProvider
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }

    
    func fetchCharacters(page: Int) -> AnyPublisher<APIResponse<[RMCharacter]>, Error>  {
        let request: URLRequest =
            .baseRequest
            .add(path: "/character")
            .addParameters(value: "\(page)", name: "page")
        
        return networkProvider
            .request(for: request)
    }
    
    func fetchCharacter(id: Int) ->
    AnyPublisher<APIResponse<RMCharacter>, Error> {
        let request: URLRequest =
            .baseRequest
            .add(path: "/character")
            .addParameters(value: "\(id)", name: "id")
        
        return networkProvider
            .request(for: request)
    }
    
    
}
