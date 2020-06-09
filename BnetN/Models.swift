//
//  Models.swift
//  BnetN
//
//  Created by Роман on 22.05.2020.
//  Copyright © 2020 Роман. All rights reserved.
//

import Foundation

struct SingleResponse: Codable {
    var status: Int
    var data: [[Entry]]?
    var error: String?
}

struct Entry: Codable {
    var id: String
    var body: String
    var da: String
    var dm: String
}

enum ApiMethod: String {
    case new = "new_session"
    case get = "get_entries"
    case add = "add_entry"
    case edit = "edit_entry"
    case remove = "remove_entry"
}




struct SingleResponseSession: Codable {
    let status: Int
    let data: SessionContainer
}

struct SessionContainer: Codable {
    let session: String
}
