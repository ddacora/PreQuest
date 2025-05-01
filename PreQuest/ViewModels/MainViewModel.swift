//
//  MainViewModel.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var apiDatas: [ApiData] = []

    private let repository = ApiRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func loadInitialData() {
        fetchData()
    }
    
    func fetchData() {
            ApiService().fetchApiDatas()
                .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finish")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { ApiDatas in
                self.repository.saveApiDatas(ApiDatas)
                self.apiDatas.append(contentsOf: ApiDatas)
            }).store(in: &cancellables)
    }
    
}
