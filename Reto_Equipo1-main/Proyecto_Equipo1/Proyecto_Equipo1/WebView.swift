//
//  WebView.swift
//  QuizReal
//
//  Created by Alumno on 20/09/23.
//

import SwiftUI
import WebKit

struct WebViewWithGIF: UIViewRepresentable {
    let urlString: String // La ruta del archivo GIF
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = Bundle.main.url(forResource: urlString, withExtension: "gif") {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewWithGIF
        
        init(_ parent: WebViewWithGIF) {
            self.parent = parent
        }
    }
}
