//
//  ViewController.swift
//  moaApp
//
//  Created by sangheon on 2021/04/24.
//

import UIKit

protocol SendDataDelegate {
    func sendData(data:String)
}

class MainController: UIViewController {
    var delegate:SendDataDelegate?
    let url1 = "https://m.moga2.com"
    let url2 = "https://m.moga1109.com"
    let url3 = "https://m.town1109.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isToolbarHidden = true
        delegate?.sendData(data: url1)
    }
    
 
    @IBAction func button1Act(_ sender: Any) {
        delegate?.sendData(data: url1)
    }
    
    @IBAction func button2Act(_ sender: Any) {
        delegate?.sendData(data: url2)
    }
    
    @IBAction func button3Act(_ sender: Any) {
        delegate?.sendData(data: url3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
       {
        let vc = segue.destination as? WebView
           // Determine what the segue identifier is
        switch segue.identifier {
        case "show1":
            vc?.urlString = url1
        case "show2":
            vc?.urlString = url2
        case "show3":
            vc?.urlString = url3
        default:
            print("ERROR")
        }
}
}

