//
//  ViewController.swift
//  iRate
//
//  Created by Garima Bothra on 16/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ratingStepper: UIStepper!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        ratingStepper.maximumValue = 9.0
        ratingStepper.minimumValue = 2.0
        // Do any additional setup after loading the view.
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        rateLabel.text = Int(sender.value).description
        rateButton.setTitle("Rating 1-\(Int(sender.value))", for: UIControl.State.normal) 
    }

    @IBAction func rateButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "rating", sender: Any.self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rating" {
            let destination = segue.destination as! RateViewController
            destination.rateLimit = Int(ratingStepper.value)
        }
    }

}

