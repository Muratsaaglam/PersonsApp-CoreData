//
//  KisiDetayViewController.swift
//  PersonsApp
//
//  Created by Murat Sağlam on 23.02.2022.
//

import UIKit

class KisiDetayViewController: UIViewController {

    @IBOutlet weak var kisiAdLabel: UILabel!
    
    @IBOutlet weak var kisiTelLabel: UILabel!
    
    
    //.Core Data'dan bir değer oluşturduk.
    var kisi:Kisiler?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //.Core data'dan çektiğimiz verileri Label'lara yazdık
        if let k = kisi {
            kisiAdLabel.text = k.kisi_ad
            kisiTelLabel.text = k.kisi_tel
        }


    }
    


}
