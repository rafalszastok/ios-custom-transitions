//
//  PopAnimator.swift
//  CustomTransitions
//
//  Created by Rafal on 22/10/2017.
//  Copyright © 2017 Rafal Szastok. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 3.0
    var presenting = true

    var dismissCompletion: (()->Void)?

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        let superView = fromView.superview
        toView.frame = fromView.frame

        let snapshot = fromView.snapshotView(afterScreenUpdates: true)!
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true

        containerView.addSubview(toView)
        containerView.addSubview(snapshot)
        containerView.backgroundColor = .clear

        fromView.isHidden = true

        toView.alpha = 0.0
        toView.layer.cornerRadius = 25
        toView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 1.0)

        AnimationHelper.perspectiveTransformForContainerView(containerView: containerView)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: [.calculationModeCubic], animations: {

                UIView.addKeyframe(withRelativeStartTime:0, relativeDuration: 1/3, animations: {
                    var transform = CATransform3DMakeRotation(CGFloat.pi/2, 0.0, 1.0, 0.0)
                    transform = CATransform3DScale(transform, 0.5, 0.5, 1.0)
                    snapshot.layer.transform = transform
                })

                UIView.addKeyframe(withRelativeStartTime:1/3, relativeDuration: 1/3, animations: {
                    snapshot.layer.transform = CATransform3DMakeScale(0.7, 0.7, 1.0)
                })
                UIView.addKeyframe(withRelativeStartTime:2/3, relativeDuration: 1/3, animations: {
                    toView.alpha = 1.0
                    toView.layer.transform = CATransform3DIdentity
                    snapshot.layer.transform = CATransform3DIdentity
                    snapshot.alpha = 0.0
                    toView.layer.cornerRadius = 0.0
                })
        }) { (finished) in
            transitionContext.completeTransition(finished)
            superView?.addSubview(toView)
        }
    }

}
