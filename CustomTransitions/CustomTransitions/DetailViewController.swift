//
//  DetailViewController.swift
//  CustomTransitions
//
//  Created by Rafal on 22/10/2017.
//  Copyright © 2017 Rafal Szastok. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.7, alpha: 1.0)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let threeSeconds = DispatchTime.now() + DispatchTimeInterval.seconds(3)
//        DispatchQueue.main.asyncAfter(deadline: threeSeconds) {
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}
