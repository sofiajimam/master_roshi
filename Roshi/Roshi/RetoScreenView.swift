//
//  RetoScreenView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI

struct RetoScreenView: View {
    var body: some View {
        VStack{
            MarkdownView()
            Spacer()
        }.frame(width: 520, height: .infinity)
    }
}

#Preview {
    RetoScreenView()
}
