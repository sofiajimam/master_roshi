//
//  WebViewModel.swift
//  Roshi
//
//  Created by Omar Sánchez on 16/03/24.
//

import Foundation

public class WebViewModel: ObservableObject {
    @Published var link: String
    @Published var didFinishLoading: Bool = false
    @Published var pageTitle: String
    
    init (link: String) {
        self.link = link
        self.pageTitle = ""
    }
}
