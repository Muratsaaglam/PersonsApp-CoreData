//
//  KisiEkleViewController.swift
//  PersonsApp
//
//  Created by Murat Sağlam on 23.02.2022.
//

import UIKit

class KisiEkleViewController: UIViewController {

    @IBOutlet weak var kisiAdTextField: UITextField!
    @IBOutlet weak var kisiTelTextField: UITextField!
    
    
    let context = appDelegate.persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ekle(_ sender: Any) {
        
        if kisiAdTextField.text == "" && kisiTelTextField.text == ""
        {
            self.makeAlert(title: "Error", message: "Kullanıcı adı ve şifre boş geçilemez" )

            
            
        }
        else
        {
            let kisi = Kisiler(context: context)
            kisi.kisi_ad=kisiAdTextField.text
            kisi.kisi_tel=kisiTelTextField.text
            
            appDelegate.saveContext()
        }
        
        
        
    }
    
    func makeAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
