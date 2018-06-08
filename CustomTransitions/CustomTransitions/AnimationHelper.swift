//
//  AnimationHelper.swift
//  CustomTransitions
//
//  Created by Rafal on 22/10/2017.
//  Copyright © 2017 Rafal Szastok. All rights reserved.
//

import UIKit

final class AnimationHelper {

    static func perspectiveTransformForContainerView(containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
