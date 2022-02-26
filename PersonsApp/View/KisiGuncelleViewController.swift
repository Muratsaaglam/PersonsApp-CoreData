//
//  KisiGuncelleViewController.swift
//  PersonsApp
//
//  Created by Murat Sağlam on 23.02.2022.
//

import UIKit

class KisiGuncelleViewController: UIViewController {

    //Bu kod ile  her yerden .core data işlem yapabiliyorum.
    let context = appDelegate.persistentContainer.viewContext

    
    
    
    @IBOutlet weak var kisiAdTextField2: UITextField!
    @IBOutlet weak var kisiTelTextFields2: UITextField!
    
    
    //.Core Data'daki verileri çekmek için değer oluşturduk.
    var kisi:Kisiler?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //.Core'daki verileri arayüze yansıttık
        
        if let k = kisi {
            kisiAdTextField2.text = k.kisi_ad
            kisiTelTextFields2.text = k.kisi_tel
        }
        
    }
    

    @IBAction func guncelle(_ sender: Any) {
        
        
        //Güncelle dediğinde kayıt işlemlerini yapıyoruz.
        
        if let k = kisi, let ad = kisiAdTextField2.text, let tel = kisiTelTextFields2.text
        {
            k.kisi_ad = ad
            k.kisi_tel = tel
            
            appDelegate.saveContext()
        }
        
    }
    
    
    
    
    
}
