//
//  ViewController.swift
//  TheBarAppv1
//
//  Created by Vuyo Matiti on 2021/07/15.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var DrinkTableView: UITableView!
    
    var drinkData = [DrinkProperties]()
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return drinkData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = DrinkTableView.dequeueReusableCell(withIdentifier: "drinkCell") as! DrinkTableViewCell
        cell.drinkName.text = drinkData[indexPath.row].strDrink
        //cell.charNickname.text = characterDeats[indexPath.row].nickname
       // cell.charDob.text = characterDeats[indexPath.row].dob.uppercased()
       cell.drinkImage.downloaded(from: (drinkData[indexPath.row].strDrinkThumb))
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        downloadDrinkJSON {
           // self.downloadDrinkJSON
         //   {
   
            print("Its Basically  Working!!!")
            self.DrinkTableView.reloadData()
      //  }
            self.DrinkTableView.delegate = self
            self.DrinkTableView.dataSource = self
    }
        func downloadDrinkJSON(completed: @escaping () -> ())
             {

                 let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass")!
                 let urlSession = URLSession.shared
                 let urlRequest = URLRequest(url: url)

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
                            }
                        } catch {
                            print(error)
                        }
                 }.resume()
             }

}
}
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

/*
 var cocktailCollection = [CocktailsProperties]()

 func downloadCocktailsJSON(completed: @escaping () -> ())
      {

          let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass")!
          let urlSession = URLSession.shared
          let urlRequest = URLRequest(url: url)

          let task = urlSession.dataTask(with: urlRequest)
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
                 self.cocktailCollection = try jsonDecoder.decode(Cocktails.self, from: unwrappedData).drinks
                     DispatchQueue.main.async {
                         completed()
                     }
                 } catch {
                     print(error)
                 }
          }.resume()
      }
 */
