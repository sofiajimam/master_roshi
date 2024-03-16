//
//  ContentView.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                SidebarMenuView()
            }.padding(10)
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading)
    }
}

#Preview {
    ContentView()
}
