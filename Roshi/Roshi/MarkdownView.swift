//
//  MarkdownView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//


import SwiftUI
import MarkdownUI

struct MarkdownView: View {
    @State private var markdownContent: String = ""

    var body: some View {
        VStack{
            HStack(spacing: 10) {
                  Text("Guía del reto")
                    .font(Font.custom("SF Pro Display", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.58))
                Spacer()
                }
                .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                .frame(width: 520, height: 43)
                .background(Color(red: 0.56, green: 0.56, blue: 0.58).opacity(0.20))
            
            ScrollView{
                Markdown{
                    markdownContent
                }.markdownTextStyle() {
                    FontFamilyVariant(.monospaced)
                    FontSize(.em(0.85))
                    ForegroundColor(.black)
                    FontFamily(.custom("SF Pro Display"))
                  }
            }.padding([.horizontal], 30)
            Spacer()
        }.frame(width: 520, height: .infinity)
            .background(.white)
            .cornerRadius(14)
        .onAppear {
            Task {
                markdownContent = await Brain().getChallenge()
            }
        }
    }
}

#Preview {
    MarkdownView()
}
