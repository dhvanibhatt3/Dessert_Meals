//
//  MealsViewController.swift
//  Meals
//
//  Created by Dhvani Bhatt on 12/5/22.
//

import UIKit
import AlamofireImage

class MealsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var results=[[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource=self
        tableView.delegate=self
        
        // Fetch data from URL
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 self.results=dataDictionary["meals"] as! [[String:Any]]
                 self.tableView.reloadData()
             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell") as! MealCell
        
        let meal = results[indexPath.row]
        let title = meal["strMeal"] as! String
        cell.titleLabel!.text = title
        let posterPath = meal["strMealThumb"] as! String
        let posterUrl = URL(string: posterPath)!
        cell.posterView.af_setImage(withURL: posterUrl)
        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let meal = results[indexPath.row]
        let detailsViewController = segue.destination as! MealDetailsViewController
        detailsViewController.meal=meal
        tableView.deselectRow(at: indexPath, animated: true)

    }

}
