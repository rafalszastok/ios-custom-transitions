//
//  DetailViewController.swift
//  CustomTransitions
//
//  Created by Rafal on 22/10/2017.
//  Copyright © 2017 Rafal Szastok. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let threeSeconds = DispatchTime.now() + DispatchTimeInterval.seconds(3)
        view.backgroundColor = .blue
        DispatchQueue.main.asyncAfter(deadline: threeSeconds) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
