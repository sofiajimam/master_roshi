//
//  ToolBarView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI

struct ToolBarView: View {
    var body: some View {
        HStack{
            Spacer()
            
            HStack{
                Image("Terminal")
                Text("Abrir con VS Code").font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
            }
            
            Spacer()
            
            Divider().background(Color(red: 0.56, green: 0.56, blue: 0.58)).opacity(0.20)
            
            Spacer()
            
            HStack{
                Image("File")
                Text("Abrir en Finder").font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
            }
            
            Spacer()
            
            HStack{
                Image("Check")
                Text("Evaluar").font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color.white)
            }.padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                .frame(width: 104, height: 38)
                .background(Color(red: 0, green: 0.48, blue: 1))
                .cornerRadius(10)
            
            Spacer()
            
        }.padding(16)
            .frame(width: 520, height: 70)
            .background(.white)
            .cornerRadius(14)
    }
}

#Preview {
    ToolBarView()
}
