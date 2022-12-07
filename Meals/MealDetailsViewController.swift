//
//  MealDetailsViewController.swift
//  Meals
//
//  Created by Dhvani Bhatt on 12/5/22.
//

import UIKit
import AlamofireImage

class MealDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var instructiondetailsLabel: UILabel!
    @IBOutlet weak var ingrediantsLabel: UILabel!
    @IBOutlet weak var ingrediantsdetailsLabel: UILabel!
    
    var meal: [String:Any]!
    var meal_data=[[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        
        let mealId=meal["idMeal"] as! String
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [])as! [String: Any]
        self.meal_data=dataDictionary["meals"]  as! [[String:Any]]
        let temp = meal_data.first as! [String:Any]
        titleLabel.text=temp["strMeal"] as! String
        let posterPath = temp["strMealThumb"] as! String
        let posterUrl = URL(string: posterPath)!
        posterView.af_setImage(withURL: posterUrl)
        instructiondetailsLabel.text=temp["strInstructions"] as! String
                 var ingrediants: [Any]=[]
                 for (key,value) in temp {
                     if key.contains("strIngredient") {
                         if !(value is NSNull) && !(value as! String==""){
                             ingrediantsdetailsLabel.text!+=value as! String + "\n" as! String
                         }
                     }
                 }
        }
    }
        task.resume()
    }
}
