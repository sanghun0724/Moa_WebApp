//
//  File.swift
//  moaApp
//
//  Created by sangheon on 2021/04/24.
//

import UIKit
import WebKit

class WebView:UIViewController,WKUIDelegate,SendDataDelegate, WKNavigationDelegate{
    
    private var activityIndicatorContainer:UIView!
    private var activityIndicator:UIActivityIndicatorView!
    var urlString:String? //url data
    
    @IBOutlet var webView:WKWebView! {
        didSet {
            webView?.uiDelegate = self
            webView?.navigationDelegate = self
        }
    }//webView obj
    
 
    func sendData(data: String) {
        urlString = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setToolBar()
        webView.navigationDelegate = self
   
        //if controller doesn't receive data... ,return nothing
        guard let str = urlString else {
            return
        }
        guard let url = URL(string: str) else {
            return
        }
        webView?.load(URLRequest(url: url))
       
        print("dqwdasdawdawdaawdawd")
         //webContents loading method  -> load(_:)
    }
    
    //MARK: setting Toolbar
    fileprivate func setToolBar() {
        let screenWidth = self.view.bounds.width
        let homeButton = UIBarButtonItem(image: UIImage(systemName: "house.fill"), style: .plain, target: self, action: #selector(goHome))
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(goReload))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goback))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .plain, target: self, action: #selector(goForward))
        let settingButoon = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(goSetting))
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 80))
        let toolbar = UIToolbar()
        toolbar.isTranslucent = true
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.backgroundColor = .white
        toolbar.tintColor = .systemYellow
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        
        
        toolbar.setItems([homeButton,flexibleSpace,reloadButton,flexibleSpace,backButton,flexibleSpace,forwardButton,flexibleSpace,settingButoon], animated: true)
        webView?.addSubview(toolbar)
        
        //constraint
        toolbar.bottomAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        toolbar.leadingAnchor.constraint(equalTo: webView.leadingAnchor,constant: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: 0).isActive = true
    }
    
    //toolbarItem Action
    @objc private func goHome() {
        let alert = UIAlertController(title: "안내", message: "메인화면으로 돌아가시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancel)
        present(alert,animated: false,completion: nil)
        
    }
    
    @objc private func goReload() {
        self.webView.reload()
    }
    
    @objc private func goback() {
        self.webView.goBack()
    }
    
    @objc private func goForward() {
        self.webView.goForward()
    }
    @objc private func goSetting() {
        guard let setting = storyboard?.instantiateViewController(withIdentifier: "setting") else {
            return
        }
        setting.modalPresentationStyle = .fullScreen
        self.present(setting, animated: true, completion: nil)
    }
    
    //MARK: IndicatorView
    //helper funtion to control activityIndicator's animation
    fileprivate func setActivityIndicator() {
        //Configure thr background containterView for the indicator
        activityIndicatorContainer = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80 ))
        activityIndicatorContainer.center.x = webView.center.x
        activityIndicatorContainer.center.y = webView.center.y - 80
        activityIndicatorContainer.backgroundColor = UIColor.black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
        
        //Configure the activity indicator
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicatorContainer.addSubview(activityIndicator)
        webView.addSubview(activityIndicatorContainer)
        
        //constraint
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
    }
    
    //Helper function to control activityIndicator's animation
    fileprivate func showActivityIndicator(show:Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.removeFromSuperview()
        }
    }
    
    
    //MARK: NKNavigationDelegate
    //끝나도 돌아가는거방지
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
    }
    
    //set the indicator everytime webview started loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
        //에러처리
    }
    
    
    
}

