//
//  ReviewModel.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import Foundation

struct ReviewResponse: Decodable {
    let status: String
    let num_results: Int
    let results: [ReviewModel]
}

struct ReviewModel: Decodable {
    let display_title: String
    let headline: String
    let summary_short: String
    let publication_date: String
    let link: Link
    let multimedia: Multimedia
}

struct Link: Decodable {
    let url: String
    let suggested_link_text: String
}

struct Multimedia: Decodable {
    let src: String
}
