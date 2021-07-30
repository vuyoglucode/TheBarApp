 //
//  ViewController.swift
//  TheBarAppv1
//
//  Created by Vuyo Matiti on 2021/07/15.
//

import UIKit
import MBProgressHUD

 class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var DrinkTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    var drinkData = [DrinkProperties]()
    var filteredDrinks = [DrinkProperties]()
    override func viewDidLoad() {
        super.viewDidLoad()
         // MARK: Search Bar Initialiation
        
        DrinkTableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        DrinkTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.barTintColor = UIColor.white
       
       // searchController.searchBar.scopeButtonTitles = ["All", "Ordinary", "Alcoholic", "Non-Alcoholic", "Cocktail", "Champagne"]
        // searchBar.delegate = self
       //filteredDrinks = drinkData
    }
    private func filterDrink(for searchText: String) {
      filteredDrinks = drinkData.filter { drink in
        return
          drink.strDrink.lowercased().contains(searchText.lowercased())
       
        /*
         cell.drinkName.text = drink.strDrink
          cell.drinkCategory.text = drinkData[indexPath.row].strCategory
          cell.drinkType.text = drinkData[indexPath.row].strAlcoholic.uppercased()
        cell.drinkImage.downloaded(from: (drinkData[indexPath.row].strDrinkThumb))
         */
      }
      DrinkTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if searchController.isActive && searchController.searchBar.text != "" {
          return filteredDrinks.count
        }
        return drinkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = DrinkTableView.dequeueReusableCell(withIdentifier: "drinkCell") as! DrinkTableViewCell
        
        let drink: DrinkProperties!
        if searchController.isActive && searchController.searchBar.text != "" {
          drink = filteredDrinks[indexPath.row]
            
        } else {
            drink = drinkData[indexPath.row]
        }
        cell.drinkName.text = drink.strDrink
         cell.drinkCategory.text = drink.strCategory
         cell.drinkType.text = drink.strAlcoholic
       cell.drinkImage.downloaded(from: (drink.strDrinkThumb))
       
        return cell
    }
    // MARK: Detail View Config
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if let destination = segue.destination as? DrinkDetailViewController
            {
                destination.drink = drinkData[(DrinkTableView.indexPathForSelectedRow?.row)!]
              //  destination.drinkDetails = returnDrinkDetails(drinkData[(DrinkTableView.indexPathForSelectedRow?.row)!].strDrink)
               
            }
        }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadDrinkJSON {
           // self.downloadDrinkJSON
         //   {
   
            print("Its Basically  Working!!!")
            self.DrinkTableView.reloadData()
      //  }
           // self.searchBar.delegate = self
           // self.searchController.delegate = self
            self.DrinkTableView.delegate = self
            self.DrinkTableView.dataSource = self
    }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }        // MARK: Decoding API URL
        func downloadDrinkJSON(completed: @escaping () -> ())
             {
           
            
           /* let alphabet = "abcdefghijklmnopqrstuvwxyz".compactMap {
                $0
            }*/
          //  for character in alphabet
            let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a")!
           
                 let urlSession = URLSession.shared
                let urlRequest = URLRequest( url: url)
            
            let _: Void = urlSession.dataTask(with: urlRequest)
                 {
                     data, urlResponse, error in
                     
                     if let error = error
                     {
                         
                         print("Error: \(error.localizedDescription)")
                         return
                     }
                     
                     guard let unwrappedData = data else
                     {
                         print("No data")
                         return
                     }
            
                     
                     let jsonDecoder = JSONDecoder()
          
                    do {
                        self.drinkData = try jsonDecoder.decode(Drink.self, from: unwrappedData).drinks
                            DispatchQueue.main.async {
                                completed()
                                print(self.drinkData)
                            }
                        } catch {
                            print(error)
                        }
            
                 }.resume()
             }
       // }
}
}
 // MARK: SearchBar Extention
 extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
     filterDrink(for: searchController.searchBar.text!)
   }
 }
 // MARK: Image Extention
extension UIImageView

{

    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit)

    {

        contentMode = mode

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard

                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,

                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),

                let data = data, error == nil,

                let image = UIImage(data: data)

                else { return }

            DispatchQueue.main.async() { [weak self] in

                self?.image = image

            }

        }.resume()

    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {

        guard let url = URL(string: link) else { return }

        downloaded(from: url, contentMode: mode)

    }
}

