//
//  CharacterResponse.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 6/2/23.
//

import Foundation

struct APIResponse<Response: Decodable>: Decodable {
    let info: Info
    let results: Response
}


struct CharacterResponse: Codable {
    let info: Info
    let results: [RMCharacter]
}
