//
//  ChatRoshiView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI

struct ChatRoshiView: View {
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                  Text("Mentor y Evaluador")
                    .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                Spacer()
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .frame(width: 400, height: 43)
                .background(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20));
            ScrollView{
                
            }
            Spacer()
            HStack{
                HStack{
                    //Aqui va un input!!
                }
            }.padding(16)
                .frame(width: 400, height: 74)
                .background(Color(red: 1, green: 1, blue: 1).opacity(0.80))
                .overlay(
                  Rectangle()
                    .inset(by: 0.50)
                    .stroke(
                      Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20), lineWidth: 0.50))
            
        }
        .frame(width: 400, height: .infinity)
        .background(Image("BG2").resizable())
            .cornerRadius(14)
    }
}

#Preview {
    ChatRoshiView()
}
