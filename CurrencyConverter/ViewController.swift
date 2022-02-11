//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Caner Ağkaya on 11.02.2022.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func getData(_ sender: Any) {
        // 1
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=b86fbe62bfe7c47f3e687562ab07d29c&format=1")
        let session = URLSession.shared
        // Closure
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton  = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                // 2
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        
                        // ASYNC
                        
                        DispatchQueue.main.async {
//                            print(jsonResponse)
//                            print(jsonResponse["rates"])
                            if let rates = jsonResponse["rates"] as? [String:Any]{
//                                print(rates)
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(String(gbp))"
                                }
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(String(cad))"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(String(usd))"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(String(tr))"
                                }
                                
                            }
                        }
                        
                        
                    }catch{
                        print("Error!")
                    }
                    
                    
                }
            }
        }
        task.resume()
    }
    

}

