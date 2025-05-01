//
//  ApiRepository.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import RealmSwift

class ApiRepository {
    private let realm = try! Realm()
    
    func saveApiDatas(_ apiDatas: [ApiData]) {
        try? realm.write {
            realm.add(apiDatas, update: .modified)
        }
    }
    
    func fetchAllApiDatas() -> [ApiData] {
        let results = realm.objects(ApiData.self)
        return Array(results)
    }
    
    func getApiData(for id: String) -> ApiData? {
        realm.object(ofType: ApiData.self, forPrimaryKey: id)
    }
}
