//
//  TableViewController.swift
//  moaApp
//
//  Created by sangheon on 2021/05/07.
//

import UIKit
import MessageUI

class TableViewController:UITableViewController,MFMailComposeViewControllerDelegate {
    
    fileprivate let number = "010-5157-4348"
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            guard let noti = storyboard?.instantiateViewController(withIdentifier: "noti") else {
                return
            }
            self.navigationController?.pushViewController(noti, animated: true)
        case 1:
            mailCompose()
        case 2:
            guard let number = URL(string: "tel://" + self.number) else { return }
            UIApplication.shared.open(number)
        case 3:
            self.dismiss(animated: true, completion: nil)
        default:
            print("something wrong")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailCompose() {
        let mc = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setToRecipients(["gus4348@naver.com"])
        mc.setSubject("모과야 문의")
        mc.setMessageBody("문의하시고자 하는 내용을 보내주세요~", isHTML: false)
        if MFMailComposeViewController.canSendMail() {
            mc.modalPresentationStyle = .fullScreen
            self.present(mc, animated: true, completion: nil)
            
        }
        else { let alertController: UIAlertController = UIAlertController(title:"메일 보내기", message:"\n현재 디바이스에서 이메일을 보낼수가 없습니다. 설정에서 이메일 관련 설정을 확인해주세요", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "확인", style: .default, handler: { (alert: UIAlertAction!) in })
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil) }

    }
}
