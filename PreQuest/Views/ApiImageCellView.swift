//
//  ApiImageCell.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/2/25.
//

import SwiftUI

struct ApiImageCellView: View {
    let apiImage: UIImage?
    var body: some View {
        ZStack {
            if let apiImage {
                Image(uiImage: apiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Rectangle()
                    .fill(Color.gray)
                    .overlay(ProgressView())
            }
        }
    }
}
