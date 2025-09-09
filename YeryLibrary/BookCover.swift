//
//  BookCover.swift
//  YeryLibrary
//
//  Created by Yery Castro on 7/3/24.
//

import SwiftUI

struct BookCover: View {
    @State var imageVM = ImageVM()
    let book: Book
    var big: Bool = false
    let namespace: Namespace.ID
    
    var body: some View {
        Group {
            if let cover = imageVM.image {
                Image(uiImage: cover)
                    .resizable()
                    .matchedGeometryEffect(id: "cover\(book.id)", in: namespace)
                    .scaledToFill()
                    .frame(width: big ? 250 : 150, height: big ? 420 : 230)
                    .overlay(alignment: .bottom) {
                        if !big {
                            BottomTitle(title: book.title, id: book.id, namespace: namespace)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            } else {
                BookPlaceholder(book: book, namespace: namespace)
            }
        }
        .onAppear {
            try? imageVM.getImage(url: book.cover)
        }
        .onChange(of: book) {
            try? imageVM.getImage(url: book.cover)
        }
    }
}

#Preview {
    BookCover(imageVM: ImageVM.test, book: .test, namespace: Namespace().wrappedValue)
}
