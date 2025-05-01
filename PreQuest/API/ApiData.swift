//
//  CatImage.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import RealmSwift

class ApiData: Object, Codable {
    @objc dynamic var id: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
