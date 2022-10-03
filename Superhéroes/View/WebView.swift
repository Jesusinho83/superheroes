//
//  WebView.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 03/10/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
    let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    
    }
  
}


