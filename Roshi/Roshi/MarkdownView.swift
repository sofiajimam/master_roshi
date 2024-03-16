//
//  MarkdownView.swift
//  Roshi
//
//  Created by Pablo Salas on 16/03/24.
//


import SwiftUI
import MarkdownUI

struct MarkdownView: View {
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
                    """
                    This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

                    ## Getting Started

                    First, run the development server:

                    ```bash
                    npm run dev
                    # or
                    yarn dev
                    # or
                    pnpm dev
                    # or
                    bun dev
                    ```

                    Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

                    You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

                    This project uses [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) to automatically optimize and load Inter, a custom Google Font.

                    ## Learn More

                    To learn more about Next.js, take a look at the following resources:

                    - [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
                    - [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

                    You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js/) - your feedback and contributions are welcome!

                    ## Deploy on Vercel

                    The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

                    Check out our [Next.js deployment documentation](https://nextjs.org/docs/deployment) for more details.

                    """
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
    }
}

#Preview {
    MarkdownView()
}