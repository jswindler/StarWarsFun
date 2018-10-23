//
//  StarshipDetailViewController.swift
//  TestApp
//
//  Created by Joe Swindler on 10/23/18.
//  Copyright © 2018 BambooHR. All rights reserved.
//

import UIKit

class StarshipDetailViewController: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func loadImageFromURL(_ url: URL) -> Bool {
        guard let data = try? Data(contentsOf: url) else {
            return false
        }
        
        //Range of  vehicle image number: 4-42
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            return true
        }
        
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.isHidden = true

        let minNumber: UInt32 = 4
        let maxNumber: UInt32 = 42
        let number = arc4random_uniform(maxNumber - minNumber) + minNumber
        if !loadImageFromURL(URL(string: "https://starwars-visualguide.com/assets/img/vehicles/\(number).jpg")!) {
            _ = loadImageFromURL(URL(string: "https://starwars-visualguide.com/assets/img/big-placeholder.jpg")!)
        }
    }
}
