//
//  ViewController.swift
//  Project4
//
//  Created by Lawrence Dizon on 10/19/20.
//

import UIKit
import WebKit

//
// MARK: - View Controller
//
class WebViewController: UIViewController, WKNavigationDelegate {
    //
    // MARK: - Variables and Properties
    //
    var selectedWebsite: String?
    let websites = WebsiteData()
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    //
    // MARK: - View Controller States
    //
    override func loadView(){
        //loadView gets called before viewDidLoad
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    /* Create the URL and load the URLRequest into the Webview. */
        
        guard let initialWebsite = selectedWebsite else { return }
        let url = URL(string: "https://\(initialWebsite)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        webKitUISetup()
        
        /* Add observer to our Webview (observe estimaedProgress) */
            webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    //
    // MARK: - View Controller Functions
    //
    func webKitUISetup(){
        
        
    /* Right bar button will call objc function */
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
    /* Progress View */
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
    /* UI Buttons */
        
        let backButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [backButton, forwardButton, spacer,progressButton, refresh]
        navigationController?.isToolbarHidden = false
    }
    
    //
    //MARK: AlertController Config
    //
    @objc func openTapped() {
    /* Define objc function for when open button gets tapped */
        
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites.websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "youtube.com", style: .destructive, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func invalidAlert(_ host : String?){
        let ac = UIAlertController(title: "Invalid URL", message: "Sorry, \(host!) is not allowed", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(ac, animated: true)
    }
    
    //
    // MARK: Key-Value Observers
    //
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    /* When we register as observer, we must implement a method called observe value */
        
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites.websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
                
            }
            
        }
        
        decisionHandler(.cancel)
        invalidAlert(url?.host) //shows alert when URL is invalid
    }
    
}

