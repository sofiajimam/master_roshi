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
            HStack(alignment:.top){
                Text("Tus Retos").font(Font.custom("SF Pro Display", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                Spacer()
                Image("PlusIcon")
            }.padding([.horizontal], 27)
            HStack{
                Text("Creémos una lista de pendiente...")
                        .font(Font.custom("SF Pro Display", size: 16))
                        .foregroundColor(.black)
            }.padding(EdgeInsets(top: 12, leading: 15, bottom: 11, trailing: 25))
                .frame(width: 260, height: 42)
                .background(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20))
                .cornerRadius(5)
            HStack{
                Text("Aprende a hacer elementos inte...")
                        .font(Font.custom("SF Pro Display", size: 16))
                        .foregroundColor(.black)
            }.padding(EdgeInsets(top: 12, leading: 15, bottom: 11, trailing: 25))
                .frame(width: 260, height: 42)
            Spacer()
        }).frame(width: 300, height:.infinity).background(.white)
            .cornerRadius(10)
      }
    }

    struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView()
      }
    }
