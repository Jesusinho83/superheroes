//
//  WebView.swift
//  Superhéroes
//
//  Created by Jesus Grimaldo on 03/10/22.
//

import Foundation
import WebKit
import SwiftUI

struct WebView:  UIViewRepresentable{
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    
    var url : URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        
        return view
    }
}
