//
//  ViewController.swift
//  DiceDiceApp
//
//  Created by Batu on 13.03.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    @IBOutlet weak var lbl2OyuncuPuan: UILabel!
    @IBOutlet weak var lbl1OyuncuPuan: UILabel!
    @IBOutlet weak var lbl2OyuncuSkor: UILabel!
    @IBOutlet weak var imgZar1: UIImageView!
    @IBOutlet weak var imgZar2: UIImageView!
    @IBOutlet weak var lbl1OyuncuSkor: UILabel!
    @IBOutlet weak var imgOyuncuDurum2: UIImageView!
    @IBOutlet weak var imgOyuncuDurum1: UIImageView!
   
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0 , ikinciOyuncuPuani : 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru : 0 , ikinciOyuncuSkorlari : 0)
    var oyuncuSira : Int = 1
    
    var maxSetSayisi : Int = 5
    var suankiSet : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let arkaPlan = UIImage(named: "arkaPlan") {
            
            
        self.view.backgroundColor = UIColor(patternImage: arkaPlan)
            
            
            
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
       
        
        if suankiSet > maxSetSayisi {
            return
        }
        
        
        
        
        zarDegerleriniUret()
    }
    func setSonucu(zar1 : Int, zar2 : Int) {
        if oyuncuSira == 1 { //1.set daha yeni başladı ve 1. oyuncu zar atar.
            
            oyuncuPuanlari.birinciOyuncuPuani = zar1 + zar2  //Bu şekilde yapıldığında 1. oyuncunun puanı kaydediliyor.
            lbl1OyuncuPuan.text = String(oyuncuPuanlari.birinciOyuncuPuani) //Bu şekilde yeşil olan skor ifadesi değişecektir.
            imgOyuncuDurum1.image = UIImage(named: "bekle")
            imgOyuncuDurum2.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2.Oyuncuda"
            oyuncuSira = 2 // oyuncu sira değişmezse sürekli soldaki oyuncu oynanacaktır.
            lbl2OyuncuPuan.text = "0"
            
        } else {
            
            oyuncuPuanlari.ikinciOyuncuPuani = zar1 + zar2
            lbl2OyuncuPuan.text = String(oyuncuPuanlari.ikinciOyuncuPuani)
            imgOyuncuDurum1.image = UIImage(named: "onay")
            imgOyuncuDurum2.image = UIImage(named: "bekle")
            oyuncuSira = 1
            //Seti bitirme işlemleri
            
            
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuani {
                //birinci oyuncu oyunu kazandı.
                
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(suankiSet). Seti 1. Oyuncu Kazandı"
                suankiSet += 1
                lbl1OyuncuSkor.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
                
            } else if oyuncuPuanlari.ikinciOyuncuPuani > oyuncuPuanlari.birinciOyuncuPuani {
                oyuncuSkorlari.ikinciOyuncuSkorlari += 1
                lblSetSonucu.text = "\(suankiSet). Seti 2. Oyuncu Kazandı"
                suankiSet += 1
                lbl2OyuncuSkor.text = String(oyuncuSkorlari.ikinciOyuncuSkorlari)
                
            } else {
                // oyun berabere kaldı
                //set sayısı değiştirilmemeli
                lblSetSonucu.text = "\(suankiSet). Set Berabere Sona Erdi"
            }
            
            
        }
        
    }
    func zarDegerleriniUret() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3 ) {
            let zar1 = arc4random_uniform(6) + 1
            let zar2 = arc4random_uniform(6) + 1
            
            
            self.imgZar1.image = UIImage(named: String(zar1))
            self.imgZar2.image = UIImage(named: String(zar2))

            self.setSonucu(zar1: Int(zar1), zar2: Int(zar2))
            if self.suankiSet > self.maxSetSayisi {
                if self.oyuncuSkorlari.birinciOyuncuSkoru > self.oyuncuSkorlari.ikinciOyuncuSkorlari {
                    self.lblSetSonucu.text = "Oyunun Galibi 1. Oyuncu"
                } else {
                    self.lblSetSonucu.text = "Oyunun Galibi 2. Oyuncu"
                }
            }
        }
        
        lblSetSonucu.text = "\(oyuncuSira). Oyuncu Zar Atıyor"
        imgZar1.image = UIImage(named: "bilinmeyenZar")
        imgZar2.image = UIImage(named: "bilinmeyenZar")

        
        
        
    }
    
}
