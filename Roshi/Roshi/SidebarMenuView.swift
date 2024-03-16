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
        VStack(spacing: 10) {
          VStack(spacing: 10) {
            HStack(spacing: 10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 27, height: 27)
                .background(Image("Home"))
              Text("Inicio")
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
                .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            .frame(maxWidth: .infinity, minHeight: 38, maxHeight: 38)
            .background(Color.gray)
            .cornerRadius(6)
            HStack(spacing: 10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 27, height: 27)
                .background(Image("Storytelling"))
              Text("Cursos")
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
                .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            .frame(maxWidth: .infinity, minHeight: 38, maxHeight: 38)
            .background(Color.gray)
            .cornerRadius(6)
            HStack(spacing: 10) {
              Rectangle()
                .foregroundColor(.clear)
                .frame(width: 27, height: 27)
                .background(Image("Idea"))
              Text("Novedades")
                .font(Font.custom("Apple SD Gothic Neo", size: 15))
                .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
            .frame(maxWidth: .infinity, minHeight: 38, maxHeight: 38)
            .background(Color.gray)
            .cornerRadius(6)
          }
          .frame(maxWidth: .infinity, minHeight: 134, maxHeight: 134)
          VStack(alignment: .leading, spacing: 6) {
            Text("Retos")
              .font(Font.custom("Apple SD Gothic Neo", size: 10))
              .foregroundColor(Color(red: 1, green: 1, blue: 1).opacity(0.60))
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 201, height: 0)
              .overlay(
                Rectangle()
                  .stroke(
                    Color(red: 1, green: 1, blue: 1).opacity(0.60), lineWidth: 0.50
                  )
              )
          }
          .padding(EdgeInsets(top: 9, leading: 0, bottom: 9, trailing: 0))
          HStack(spacing: 10) {
            Text("Hagamos un TODO list")
              .font(Font.custom("Apple SD Gothic Neo", size: 12))
              .foregroundColor(Color(red: 0.61, green: 0.61, blue: 0.61))
          }
          .padding(EdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7))
          .frame(maxWidth: .infinity, minHeight: 24, maxHeight: 24)
          .background(.white)
          .cornerRadius(6)
          HStack(spacing: 0) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 22, height: 22)
              .background(Image("Plus Math"))
          }
          .padding(EdgeInsets(top: 5, leading: 4.50, bottom: 4, trailing: 4.50))
          .frame(width: 31, height: 31)
          .background(Color(red: 1, green: 1, blue: 1).opacity(0.20))
          .cornerRadius(45)
        }
        .padding(EdgeInsets(top: 18, leading: 16, bottom: 18, trailing: 16))
        .frame(width: 224, height: 809).background(Color.white)
        .cornerRadius(7);
      }
    }

    struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
        ContentView()
      }
    }
