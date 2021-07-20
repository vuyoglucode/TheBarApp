import UIKit

//This is your model
struct Drink: Decodable
{
    let drinks: [DrinkProperties]
}
struct DrinkProperties: Decodable
{
    let strDrink: String
    let strDrinkThumb: String
}
























/*struct Drink: Decodable, Identifiable{

    let strDrink: String
  //  let nickname: String
  //  var id = UUID()
  // var id: ObjectIdentifier
    
  var id = UUID()

   // let ingredient: String
   // let img : String
    //let category : String
    //let alcoholic : [String]
    //let glass: [String]
    //let instructions : String
    
    
  //  enum CodingKeys: String, CodingKey {
      //  case name = "strGlass"
        //case nickname
    // case id = "idDrink"
       // case ingredient = "strIngredient1"
       // case img = "strDrinkThumb"
       // case alcoholic = "strAlcoholic"
       // case glass = "strGlass"
        //case category = "strCategory"
        //case instructions = "strInstructions"
    
  //}
}

*/

