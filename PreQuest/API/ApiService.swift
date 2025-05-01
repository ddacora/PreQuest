//
//  NetworkService.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import Alamofire
import Combine

class ApiService {
    func fetchApiDatas(limit: Int = 10) -> AnyPublisher<[ApiData], AFError> {
        let url = "https://api.thecatapi.com/v1/images/search?limit=\(limit)"
        return AF.request(url)
            .publishDecodable(type: [ApiData].self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func downloadImage(from urlString: String) -> AnyPublisher<Data, AFError> {
        return AF.request(urlString)
            .publishData()
            .value()
            .eraseToAnyPublisher()
    }
    
}
