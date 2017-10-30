//
//  FirstViewController.swift
//  CustomTransitions
//
//  Created by Rafal on 22/10/2017.
//  Copyright © 2017 Rafal Szastok. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func buttonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail")
        detailViewController.transitioningDelegate = self
        present(detailViewController, animated: true, completion: nil)
    }

    var transition: PopAnimator = {
        let animator = PopAnimator()
        return animator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension FirstViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
