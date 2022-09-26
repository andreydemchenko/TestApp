//
//  CriticModel.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import Foundation

struct CriticResponse: Decodable {
    let status: String
    let num_results: Int
    let results: [CriticModel]
}

struct CriticModel: Decodable {
    let display_name: String
}
