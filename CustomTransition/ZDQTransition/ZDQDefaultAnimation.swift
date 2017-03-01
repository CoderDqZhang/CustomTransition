//
//  ZDWDefaultAnimation.swift
//  CustomTransition
//
//  Created by Zhang on 2017/2/28.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class ZDQDefaultAnimation: ZDQBaseAnimation {

    override init() {
        
    }
    override func push(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let duration = self.transitionDuration(using: transitionContext)
        let bounds = UIScreen.main.bounds
        fromVC?.view.isHidden = true
        transitionContext.containerView.addSubview((fromVC?.snapshot)!)
        transitionContext.containerView.addSubview((fromVC?.topSnapshot)!)
        fromVC?.viewSnapshot.removeFromSuperview()
        
        transitionContext.containerView.addSubview((toVC?.view)!)
        toVC?.navigationController?.view.superview?.insertSubview((fromVC?.snapshot)!, belowSubview: (toVC?.navigationController?.view)!)
        toVC?.navigationController?.view.transform = CGAffineTransform.init(translationX: bounds.size.width, y: 0)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
            fromVC?.snapshot.alpha = 0.5;
            fromVC?.snapshot.transform =  CGAffineTransform.init(translationX: -bounds.size.width * 0.3, y: 0)
            //                         fromVC.topSnapshot.alpha = 0.5;
            toVC?.navigationController?.view.transform = CGAffineTransform.identity;
        }) { (finished) in
            fromVC?.view.isHidden = false
            fromVC?.snapshot.alpha = 1;
            fromVC?.snapshot.removeFromSuperview()
            toVC?.snapshot.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    override func pushEnded() {
        
    }
    override func pop(_ transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let duration = self.transitionDuration(using: transitionContext)
        let bounds = UIScreen.main.bounds
        
        fromVC?.view.addSubview((fromVC?.snapshot)!)
        fromVC?.navigationController?.navigationBar.isHidden = true
        fromVC?.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
        
        fromVC?.snapshot.layer.shadowColor = UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor
        fromVC?.snapshot.layer.shadowOffset = CGSize.init(width: -3, height: 0)
        fromVC?.snapshot.layer.shadowOpacity = 0.5
        
        toVC?.view.isHidden = true
        toVC?.viewSnapshot.alpha = 0.8
        toVC?.viewSnapshot.transform = CGAffineTransform.init(translationX: bounds.width / 2, y: 64)
        toVC?.topSnapshot.alpha = 0.5
        
        transitionContext.containerView.addSubview((toVC?.view)!)
        transitionContext.containerView.addSubview((toVC?.viewSnapshot)!)
        transitionContext.containerView.sendSubview(toBack: (toVC?.viewSnapshot)!)
        transitionContext.containerView.addSubview((toVC?.topSnapshot)!)
        
        if ((fromVC?.interactivePopTransition) != nil) {
            UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { 
                toVC?.topSnapshot.alpha = 1;
                fromVC?.view.transform = CGAffineTransform.init(translationX: bounds.width + 3, y: 0)
                toVC?.viewSnapshot.alpha = 1.0
                toVC?.viewSnapshot.transform = CGAffineTransform.init(translationX:0, y:64)
            }, completion: { (finish) in
                toVC?.navigationController?.navigationBar.isHidden = false
                toVC?.view.isHidden = false;
                toVC?.view.backgroundColor = UIColor.orange
                
                fromVC?.snapshot.removeFromSuperview()
                toVC?.viewSnapshot.removeFromSuperview()
                toVC?.snapshot.removeFromSuperview()
                fromVC?.topSnapshot.removeFromSuperview()
                toVC?.topSnapshot.removeFromSuperview()
                toVC?.view.backgroundColor = UIColor.orange
                if transitionContext.transitionWasCancelled {
                    
                }
               
                transitionContext.completeTransition(transitionContext.transitionWasCancelled)
            })
        }else{
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: .curveLinear, animations: {
                toVC?.topSnapshot.alpha = 1;
                fromVC?.view.transform = CGAffineTransform.init(translationX: bounds.width + 3, y: 0)
                toVC?.viewSnapshot.alpha = 1.0
                toVC?.viewSnapshot.transform = CGAffineTransform.init(translationX:0, y:64)
            }, completion: { (finish) in
                toVC?.navigationController?.navigationBar.isHidden = false
                toVC?.view.isHidden = false;
                
                fromVC?.snapshot.removeFromSuperview()
                toVC?.viewSnapshot.removeFromSuperview()
                toVC?.snapshot.removeFromSuperview()
                fromVC?.topSnapshot.removeFromSuperview()
                toVC?.topSnapshot.removeFromSuperview()
        
                transitionContext.completeTransition(transitionContext.transitionWasCancelled)
            })
        }
    }
    override func popEnded() {
        
    }
}
