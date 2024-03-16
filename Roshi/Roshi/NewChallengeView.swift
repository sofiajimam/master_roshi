//
//  NewChallengeView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//

import SwiftUI

struct NewChallengeView: View {
    var body: some View {
        VStack{
            Spacer()
            VStack(spacing:10){
                Image("Hat")
                Text("Aprendamos haciendo")
                        .font(Font.custom("SF Pro Display", size: 24))
                        .foregroundColor(.black)
                      Text("Haz click en el siguiente botón y Roshi generará un reto personalizado para ti")
                        .font(Font.custom("SF Pro Display", size: 16))
                        .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58)).multilineTextAlignment(.center)
            }.padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                .frame(width: 420, height: 175)
            
            HStack(spacing: 10) {
                  Text("Generar mi reto")
                    .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                .frame(width: 130, height: 38)
                .background(Color(red: 1, green: 0.18, blue: 0.33))
                .cornerRadius(10)
            Spacer()
        }.padding(10)
            .frame(width: 930, height: .infinity)
            .background(.white)
            .cornerRadius(14);
    }
}

#Preview {
    NewChallengeView()
}
