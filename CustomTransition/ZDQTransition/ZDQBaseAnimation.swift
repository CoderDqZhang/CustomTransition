//
//  ZDQBaseAnimation.swift
//  CustomTransition
//
//  Created by Zhang on 2017/2/28.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

let DefauleAnimationDuration:TimeInterval = 0.6

class ZDQBaseAnimation: NSObject {
    var transtionType:UINavigationControllerOperation!
    var duration:TimeInterval!
    var interactivePopTransition:UIPercentDrivenInteractiveTransition!
    
    func initWithType(_ transitionType:UINavigationControllerOperation, duration:TimeInterval, type:ZDQAnimationType) -> ZDQBaseAnimation {
        var animation:ZDQBaseAnimation!
        switch type {
        case .Default:
            animation = ZDQDefaultAnimation()
        default:
            return ZDQDefaultAnimation()
        }
        animation.duration = duration
        animation.transtionType = transitionType
        return animation
    }
    
    func transitionWithType(_ transitionType:UINavigationControllerOperation, type:ZDQAnimationType) -> ZDQBaseAnimation {
        return self.initWithType(transtionType, duration: DefauleAnimationDuration, type: type)
    }
    
    func transitionWithType(_ transitionType:UINavigationControllerOperation, duration:TimeInterval, type: ZDQAnimationType) -> ZDQBaseAnimation {
        return self.initWithType(transtionType, duration: duration, type: type)
    }
    
    func transitionWithType(_ transitionType:UINavigationControllerOperation, duration:TimeInterval, interactivePopTransiton:UIPercentDrivenInteractiveTransition, type: ZDQAnimationType) -> ZDQBaseAnimation {
        let animation = self.initWithType(transtionType, duration: duration, type: type)
        animation.interactivePopTransition = interactivePopTransition
        return animation
    }
    
    func push(_ transitionContext:UIViewControllerContextTransitioning){}
    
    func pop(_ transitionContext:UIViewControllerContextTransitioning){}
    
    func pushEnded() {}
    
    func popEnded() {}
    
}

extension ZDQBaseAnimation : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.transtionType == UINavigationControllerOperation.push {
            self.push(transitionContext)
        }
        if  self.transtionType == UINavigationControllerOperation.pop {
            self.pop(transitionContext)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        if (!transitionCompleted) {
            return
        }
        if  self.transtionType == UINavigationControllerOperation.push {
            self.popEnded()
        }
        if  self.transtionType == UINavigationControllerOperation.pop {
            self.popEnded()
        }
    }
}
