//
//  RMEpisode.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 7/2/23.
//

import Foundation


struct RMEpisode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
