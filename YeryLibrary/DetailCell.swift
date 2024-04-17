//
//  DetailCell.swift
//  YeryLibrary
//
//  Created by Yery Castro on 11/3/24.
//

import SwiftUI

struct DetailCell: View {
    let title: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .bold()
            Text(label)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    DetailCell(title: "Author", label: "Jules Verne")
}
