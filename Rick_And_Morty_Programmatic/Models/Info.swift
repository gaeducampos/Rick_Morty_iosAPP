//
//  Info.swift
//  Rick_And_Morty_Programmatic
//
//  Created by Gabriel Campos on 6/2/23.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}
