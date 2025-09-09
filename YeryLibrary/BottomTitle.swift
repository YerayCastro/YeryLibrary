//
//  BottomTitle.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI

struct BottomTitle: View {
    let title: String
    let id: Int
    let namespace: Namespace.ID
    
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.5))
            .frame(height: 60)
            .overlay(alignment: .bottom) {
                VStack {
                    Text(title)
                        .font(.caption)
                        .matchedGeometryEffect(id: "title\(id)", in: namespace)
                        .foregroundStyle(.black)
                        .bold()
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                }
            }
    }
}

#Preview {
    BottomTitle(title: "A Princess of Mars", id: 1, namespace: Namespace().wrappedValue)
}
