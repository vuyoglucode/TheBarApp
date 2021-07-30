//
//  DrinkDetailViewController.swift
//  TheBarAppv1
//
//  Created by Vuyo Matiti on 2021/07/19.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var drinkName: UILabel!
    @IBOutlet weak var drinkCategory: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    @IBOutlet weak var drinkType: UILabel!
  
   // @IBOutlet weak var drinkIngredients: UILabel!
    @IBOutlet weak var drinkInstructions: UILabel!
    // var drinkDetails = [DrinkProperties]()
    var drink: DrinkProperties?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
override func viewWillAppear(_ animated: Bool)
  {
     super.viewWillAppear(animated)
   // print(drink)
        
    
         
   drinkName.text = drink?.strDrink.uppercased()
    drinkCategory.text = drink?.strCategory.uppercased()
    drinkType.text = drink?.strAlcoholic.uppercased()
    drinkInstructions.text = drink?.strInstructions
    drinkImage.downloaded(from: (drink?.strDrinkThumb)!)
      
       
    }
    
}
