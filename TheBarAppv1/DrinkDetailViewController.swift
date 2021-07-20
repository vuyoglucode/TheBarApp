//
//  DrinkDetailViewController.swift
//  TheBarAppv1
//
//  Created by Vuyo Matiti on 2021/07/19.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
  // var drinkData = [DrinkProperties]()
    var drink: DrinkProperties?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
override func viewWillAppear(_ animated: Bool)
  {
     super.viewWillAppear(animated)
   // print(drink)
        
        
        // let characterNickname: String = (character?.nickname)!
       //  charNickname.text = "A.K.A ' \(characterNickname.uppercased())'"
         
   drinkName.text = drink?.strDrink.uppercased()
       // charNickname.text = character?.nickname.uppercased()
      //"Name is "\(character)
      
       // charDob.text = character?.dob
//   drinkImage.downloaded(from: (drink?.strDrinkThumb)!)
      
       
    }
}
