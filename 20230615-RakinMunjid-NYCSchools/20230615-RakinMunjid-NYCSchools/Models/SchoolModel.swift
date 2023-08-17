//
//  SchoolModel.swift
//  20230615-RakinMunjid-NYCSchools
//
//  Created by Rakin Munjid on 8/16/23.
//

import Foundation

public struct NYCResource: Codable {
    let dbn: String?
    let name: String?
    let borough: String?
    let overview: String?
    let website: String?

    enum CodingKeys: String, CodingKey {
        case dbn
        case name = "school_name"
        case borough
        case overview = "overview_paragraph"
        case website
    }
}
