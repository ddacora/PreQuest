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
    
    func saveImageData(for id: String, imageData: Data) {
        if let apiData = realm.object(ofType: ApiData.self, forPrimaryKey: id) {
            try? realm.write {
                apiData.imageData = imageData
            }
        }
    }
    
    func getApiData(for id: String) -> ApiData? {
        realm.object(ofType: ApiData.self, forPrimaryKey: id)
    }
    
    func getImageData(for id: String) -> Data? {
        realm.object(ofType: ApiData.self, forPrimaryKey: id)?.imageData
    }
    
    func deleteAllApiDatas() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
