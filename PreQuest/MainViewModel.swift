//
//  MainViewModel.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/1/25.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
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
                print(ApiDatas)
            }).store(in: &cancellables)        
    }
    
}
