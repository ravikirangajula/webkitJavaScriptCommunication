//
//  ViewController.swift
//  WebkitJSCommunication
//
//  Created by Gajula RaviKiran on 09/12/2020.
//

import UIKit
import WebKit


class ViewController: UIViewController ,WKScriptMessageHandler, WKNavigationDelegate,WKUIDelegate {
    
    
    
    @IBOutlet var containerView : UIView! = nil
    var webView: WKWebView?

    override func loadView() {
        super.loadView()
        let contentController = WKUserContentController();
        let userScript = WKUserScript(
            source: "redHeader()",
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        
        contentController.addUserScript(userScript)
        contentController.add(
            self,
            name: "callbackHandler"
        )

        let config = WKWebViewConfiguration()
        
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.frame, configuration: config)
        
        self.webView?.uiDelegate = self
        
        self.view = self.webView!
        
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let htmlFile = Bundle.main.path(forResource: "MudahCheck", ofType: "html")
        
        let html = try? String(contentsOfFile: htmlFile!, encoding: String.Encoding.utf8)
        self.webView?.loadHTMLString(html!, baseURL: nil)
    }
    
    
    
    func userContentController(_ userContentController: WKUserContentController,didReceive message: WKScriptMessage) {
        
        if(message.name == "callbackHandler") {
            
            print("JavaScript is sending a message \(message.body)")
            
            let alert = UIAlertController(title: "Alert", message: "\(message.body)", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            
        } }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            completionHandler()
            
        }))
        
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
}





