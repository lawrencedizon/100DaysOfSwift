//
//  DetailViewController.swift
//  Project 7
//
//  Created by Lawrence Dizon on 11/7/20.
//

import UIKit
import WebKit

//
//MARK:- DetailViewController
//
class DetailViewController: UIViewController {
    //
    //MARK:- DetailViewController Properties
    //
    var webView: WKWebView!
    var detailItem: Petition?
    
    //
    //MARK:-DetailViewController States
    //
    override func loadView(){
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <b>\(detailItem.title)</b>
        <br>
        <br>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; ) </style>
        </head>
        \(detailItem.body)
        </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
        
    }
}
