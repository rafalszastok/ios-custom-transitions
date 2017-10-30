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
        toView.frame = fromView.frame

        toView.isHidden = true
        let snapshot = fromView.snapshotView(afterScreenUpdates: true)!
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true

        containerView.addSubview(toView)
        containerView.addSubview(snapshot)
        fromView.isHidden = true
        toView.layer.cornerRadius = 25
        toView.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 1.0)
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
                    snapshot.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0)
                })
                UIView.addKeyframe(withRelativeStartTime:2/3, relativeDuration: 1/3, animations: {
                    toView.isHidden = false
                    snapshot.layer.transform = CATransform3DIdentity
                    toView.layer.transform = CATransform3DIdentity
                    snapshot.alpha = 0.0
                })
        }) { (finished) in
            toView.layer.cornerRadius = 0.0
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }

//        UIView.animateKeyframes(
//            withDuration: duration,
//            delay: 0,
//            options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
//
//                UIView.addKeyframe(withRelativeStartTime:0.0, relativeDuration: 1/3, animations: {
//                    fromView.layer.transform = AnimationHelper.yRotation(angle: -Double.pi/2)
//                })
//
//                UIView.addKeyframe(withRelativeStartTime:1/3, relativeDuration: 1/3, animations: {
//                    snapshot.layer.transform = AnimationHelper.yRotation(angle: 0.0)
//                })
//
//                UIView.addKeyframe(withRelativeStartTime:2/3, relativeDuration: 1/3, animations: {
//                    snapshot.frame = finalFrame
//                })
//        }) { (_) in
//            toView.isHidden = false
//            snapshot.removeFromSuperview()
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }

//        let containerView = transitionContext.containerView
//        let toView = transitionContext.view(forKey: .to)!
//        let herbView = presenting ? toView : transitionContext.view(forKey: .from)!
//
//        let initialFrame = presenting ? originFrame : herbView.frame
//        let finalFrame = presenting ? herbView.frame : originFrame
//
//        let xScaleFactor = presenting ?
//            initialFrame.width / finalFrame.width :
//            finalFrame.width / initialFrame.width
//
//        let yScaleFactor = presenting ?
//            initialFrame.height / finalFrame.height :
//            finalFrame.height / initialFrame.height
//
//        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
//
//        if presenting {
//            herbView.transform = scaleTransform
//            herbView.center = CGPoint(
//                x: initialFrame.midX,
//                y: initialFrame.midY)
//            herbView.clipsToBounds = true
//        }
//
//        containerView.addSubview(toView)
//        containerView.bringSubview(toFront: herbView)
//
//        UIView.animate(withDuration: duration,
//                       delay:0.0,
//                       usingSpringWithDamping: 0.4,
//                       initialSpringVelocity: 0.0,
//                       animations: {
//                        herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
//                        herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
//        }, completion: { _ in
//            if !self.presenting {
//                self.dismissCompletion?()
//            }
//            transitionContext.completeTransition(true)
//        })
    }

}
