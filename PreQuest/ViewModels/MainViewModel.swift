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
                    print("fetchData finish")
                case .failure(let error):
                    self.apiDatas = self.repository.fetchAllApiDatas()
                    print("fetchData error: \(error)")
                }
            }, receiveValue: { [weak self] apiDatas in
                guard let self = self else { return }
                self.repository.saveApiDatas(apiDatas)
                self.downloadImages(apiDatas: apiDatas)
                self.apiDatas.append(contentsOf: apiDatas)
            }).store(in: &cancellables)
    }
    
    func downloadImages(apiDatas: [ApiData]) {
        for apiData in apiDatas {
            if apiData.imageData == nil {
                guard let imageUrl = URL(string: apiData.url) else {
                    continue
                }
                Task {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        await MainActor.run {
                            self.repository.saveImageData(for: apiData.id, imageData: imageData)
                        }
                    }
                }
            }
        }
    }
    
}
