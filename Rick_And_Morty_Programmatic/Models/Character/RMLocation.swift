//
//  RMLocation.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 7/2/23.
//

import Foundation


struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
