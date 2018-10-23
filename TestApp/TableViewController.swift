//
//  TableViewController.swift
//  TestApp
//
//  Created by Joe Swindler on 4/23/18.
//  Copyright © 2018 BambooHR. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String:Any]

class TableViewController: UITableViewController {
    var starshipData = [StarshipData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        getStarshipData()
    }

    func getStarshipData() {
        if let url = URL(string: "https://swapi.co/api/starships") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    // Parse JSON response
//                    do {
                        let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as! JSONDictionary
                        if let jsonArray = jsonDictionary?["results"] as? [JSONDictionary] {
                            for jsonShip in jsonArray {
                                let ship = StarshipData()
                                ship.name = jsonShip["name"] as? String
                                ship.model = jsonShip["model"] as? String
                                ship.crew = jsonShip["crew"] as? String
                                ship.cost = jsonShip["cost_in_credits"] as? String
                                self.starshipData.append(ship)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    //} catch {
                        // Handle errors
                    //}
                }
                }.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starshipData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as UITableViewCell
        
        let starship = starshipData[indexPath.row]
        cell.textLabel?.text = starship.name
        cell.detailTextLabel?.text = "Crew: \(starship.crew ?? "")    Cost: $\(starship.cost ?? "")"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "StarshipDetailView") {
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

