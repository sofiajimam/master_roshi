//
//  RetoScreenView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI

struct RetoScreenView: View {
    var body: some View {
        HStack {
            VStack{
                MarkdownView()
                Spacer()
                ToolBarView()
            }.frame(width: 520)
            
            ChatRoshiView()
        }
    }
}

#Preview {
    RetoScreenView()
}
