//
//  ViewController.swift
//  sample
//
//  Created by こさ on 2020/11/11.
//
import UIKit
import WebKit

class ViewController: UIViewController {
    func makeCookie(key:String, value:String) -> HTTPCookie{
            let cookies = HTTPCookie(properties: [
                .domain: "localhost",
                .path: "/",
                .name: key,
                .value: value,
                .secure: "FALSE",
                .expires: NSDate(timeIntervalSinceNow: 31556926)
                ])!
            return cookies
        }
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cookies = Dictionary<String, String>()

        // webViewの制約設定時、AutoresizingMaskによって自動生成される制約と競合するため、自動生成をやめる
        webView.translatesAutoresizingMaskIntoConstraints = false
        // webViewの制約
        NSLayoutConstraint.activate([webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     webView.topAnchor.constraint(equalTo: view.topAnchor),
                                     webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        if let url = URL(string: "http://localhost:8080") {
            var request = URLRequest(url: url)
            var httpCookies = [HTTPCookie]()
                        for (key, value) in cookies {
                            httpCookies.append(makeCookie(key: key, value: value))
                        }

                        let headers = HTTPCookie.requestHeaderFields(with: httpCookies)
                        for (name, value) in headers {
                            request.addValue(value, forHTTPHeaderField: name)
                        }
            self.webView.load(request)
        }
    }
    
}

