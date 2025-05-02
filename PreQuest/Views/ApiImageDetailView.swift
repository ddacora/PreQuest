//
//  ApiImageDtailView.swift
//  PreQuest
//
//  Created by LeeJunghun on 5/2/25.
//

import SwiftUI

struct ApiImageDetailView: View {
    let image: UIImage
    let userId: String
    @Environment(\.dismiss) private var dismiss
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                Spacer()
                Text("ID: \(userId)")
                Spacer()
            }
            .padding()
            .frame(height: 44)
            .background(Color(UIColor.systemBackground))
            GeometryReader { geo in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                scale = min(max(value, 1.0), 3.0)
                            }
                    )
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
} 
