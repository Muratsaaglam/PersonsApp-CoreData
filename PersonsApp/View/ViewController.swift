//
//  ViewController.swift
//  PersonsApp
//
//  Created by Murat Sağlam on 23.02.2022.
//

import UIKit
import CoreData


//her yerden .core data ile ilgili işlem yapmama yarayan kod
let appDelegate = UIApplication.shared.delegate as! AppDelegate





class ViewController: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    
    //.Core Datadaki verileri Dizi haline getirdik.
    var kisilerListe = [Kisiler]()
    
    var aramaYapiliyormu = false
    var aramaKelimesi:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Persons App"
        view.backgroundColor = .systemBackground
        
        //Tabloların self yaptık.
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        searchBar.delegate = self
        tumkisilerAl()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //Geçişleri Kontrol ettiğimiz yer
        
        //Table View'de hangi isme tıklandığını aşaağıdaki kod ile yakalıyoruz.
        
        let indeks = sender as? Int
        
        if segue.identifier == "toDetay" {
            let gidilecekVC = segue.destination as! KisiDetayViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
        }
        
        if segue.identifier == "toGuncelle" {
            let gidilecekVC = segue.destination as! KisiGuncelleViewController
            gidilecekVC.kisi = kisilerListe[indeks!]
            
        }
        
    }
    
    //Kişiler eklendikten sonra tableview dataların basılmasını sağlamak
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Öncelikle listedeki kişileri güncelle ardından table view güncelle

        if aramaYapiliyormu
        {
            aramaYap(kisi_ad: aramaKelimesi!)
        }
        else
        {
            tumkisilerAl()

        }
        
        kisilerTableView.reloadData()
    }
    
    func tumkisilerAl()
    {
        do {
            kisilerListe = try context.fetch(Kisiler.fetchRequest())
        } catch
        {
            print("Error")
        }
                
    }
    
    func aramaYap(kisi_ad:String)
    {
        //öncelikle kisiler listesinde arama yapıyoruz.
        //arama bölümüne yazdığımız harfleri Kisiler listesinde aratıyoruz.
        //sonra fetch ederek listeliyoruz.
        let fetchRequest:NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "kisi_ad CONTAINS %@", kisi_ad)

        do {
            kisilerListe = try context.fetch(fetchRequest)
        } catch
        {
            print("Error")
        }
                
    }
    
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kisi = kisilerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        
        cell.kisiYaziLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        
        return cell
    }
    
    //Table View'de seçmiş olduğumuz verinin detayını öğrenme
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    //Seçmiş olduğumuz veride silme ve güncelleme şlemlerini yapma
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil") {  (contextualAction, view, boolValue) in
            
            
            //Table viewdde seçilini olanı al, ardından onu kisi dizisinden sil ve kayıt et
            let kisi = self.kisilerListe[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
            //Ardından tableviewleri güncelle
            if self.aramaYapiliyormu
            {
                self.aramaYap(kisi_ad: self.aramaKelimesi!)
            }
            else
            {
                self.tumkisilerAl()

            }
            
            
            
        }
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") {  (contextualAction, view, boolValue) in
            
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
    
    
}


//Search Barın Kullanımı
extension ViewController:UISearchBarDelegate
{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonuç : \(searchText)")
        
        aramaKelimesi = searchText
        
        
        //Yukarıdaki fon çağırıyoruz ve searchbardaki yazılanı içine at dedik
        if searchText == ""
        {
            aramaYapiliyormu = false
            tumkisilerAl()
        }
        else
        {
            aramaYapiliyormu = true
            aramaYap(kisi_ad: aramaKelimesi!)

        }
        
        
        //Tabloyu yenile dedik
        kisilerTableView.reloadData()
        
        
        
        
        
    }
    
}

