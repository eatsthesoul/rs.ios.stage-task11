//
//  WebPageViewController.swift
//  RSSchool_T11
//
//  Created by Evgeniy Petlitskiy on 15.12.21.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, LoaderDisplayable {
    
    var url: String?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    
    lazy var reloadButton = UIBarButtonItem(image: .arrow, style: .plain, target: self, action: #selector(updateWebView))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = reloadButton
        setupUI()
        
        webView.navigationDelegate = self
        loadWebPage()
    }
}

// MARK: - Private functions

private extension WebPageViewController {
    
    func loadWebPage() {
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        
        startLoader()
        reloadButton.isEnabled = false
    }
    
    func setupUI() {
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        backButton.isEnabled = false
        forwardButton.isEnabled = false
    }
}

// MARK: - Action functions
extension WebPageViewController {
    
    @objc func updateWebView() {
        webView.isLoading ? stopLoadingWebView() : reloadWebView()
    }
    
    private func reloadWebView() {
        webView.reload()
        reloadButton.image = .xmark
    }
    
    private func stopLoadingWebView() {
        webView.stopLoading()
        reloadButton.image = .arrow
    }
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func share(_ sender: Any) {
        guard let url = webView.url else { return }
        let objectsToShare = [url]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func openInSafari(_ sender: Any) {
        guard let url = webView.url else { return }
        UIApplication.shared.open(url)
    }
}

extension WebPageViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopLoader()
        reloadButton.isEnabled = true
        reloadButton.image = .arrow
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
