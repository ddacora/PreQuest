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
        let resultsArray = Array(results)
        return resultsArray.shuffled()
    }
    
    func saveImageData(for id: String, imageData: Data) -> ApiData? {
        if let apiData = realm.object(ofType: ApiData.self, forPrimaryKey: id) {
            try? realm.write {
                apiData.imageData = imageData
            }
            return apiData
        }
        return nil
    }
    
    func getApiData(for id: String) -> ApiData? {
        realm.object(ofType: ApiData.self, forPrimaryKey: id)
    }
    
    func getImageData(for id: String) -> Data? {
        realm.object(ofType: ApiData.self, forPrimaryKey: id)?.imageData
    }
    
    func deleteAllApiDatas() {
        DispatchQueue.main.async {
            try? self.realm.write {
                self.realm.deleteAll()
            }
        }
    }
}
