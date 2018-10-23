//
//  TableViewController.swift
//  TestApp
//
//  Created by Joe Swindler on 4/23/18.
//  Copyright © 2018 BambooHR. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var starshipData = [StarshipData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = URL(string: "https://swapi.co/api/starships") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    // Parse JSON response
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data) as! [String: Any]
/*                        if let jsonArray = jsonObject["results"] as? [String: Any] {
                            for ship in jsonArray.values as! Dictionary<String, Any> {
                                let ship = StarshipData()
                                ship.name = ship["name"]
                                //ship.model = ship["model"]
                                //ship.crew = ship["crew"]
                                //ship.cost = ship["cost_in_credits"]
                                starshipData.append(ship)
                            }
                        }*/
                    } catch {
                        // Handle errors
                    }
                }
                }.resume()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }

}

