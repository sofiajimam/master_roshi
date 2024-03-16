//
//  SidebarMenuView.swift
//  Roshi
//
//  Created by Pablo Salas on 15/03/24.
//

import SwiftUI

// View que representa la barra lateral y modificarla sin alterar lo demas

struct SidebarMenuView: View {
    var body: some View {
        VStack(content: {
            HStack(content: {
                VStack {
                    Image("Home2")
                }.padding(10)
                    .frame(width: 78, height: 56)
                    .background(Color(red: 0, green: 0.48, blue: 1))
                    .cornerRadius(10)
                VStack {
                    Image("Books")
                }.padding(10)
                    .frame(width: 78, height: 56)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).inset(by: 0.50).stroke(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20), lineWidth: 0.50))
                VStack {
                    Image("Idea2")
                }.padding(10)
                    .frame(width: 78, height: 56)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).inset(by: 0.50).stroke(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20), lineWidth: 0.50))
            }).padding()
            Spacer()
        }).frame(width: 300, height:.infinity).background(.white)
            .cornerRadius(14);
      }
    }

    struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView()
      }
    }
