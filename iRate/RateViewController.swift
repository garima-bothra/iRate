//
//  RateViewController.swift
//  iRate
//
//  Created by Garima Bothra on 17/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var rating: UISlider!
    var rateLimit: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Rate: \(rating.value)")
    }

}
