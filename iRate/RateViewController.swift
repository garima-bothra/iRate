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
    @IBOutlet weak var rateLabel: UILabel!
    var rateLimit: Int!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = "Rate"
        rating.maximumValue = Float(rateLimit)
        rating.minimumValue = 1.0
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
         sender.setValue(Float(lroundf(rating.value)), animated: false)
        rateLabel.text = "Rating: \(Int(rating.value))"
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        print("Rate: \(rating.value)")
    }

}
