//
//  ZDQAnimationTransitioningSnapshot.swift
//  CustomTransition
//
//  Created by Zhang on 2017/3/1.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

class ZDQAnimationTransitioningSnapshot: UIViewController {
    
}
extension UIViewController {
   
    func load(){
        let originMethod = class_getMethodImplementation(NSClassFromString("UIViewController"), #selector(ViewController.viewDidLoad))
        let newMethod = class_getMethodImplementation(NSClassFromString("UIViewController"), #selector(self.zdq_viewDidLoad))
        method_exchangeImplementations(originMethod, newMethod)
    }
    func zdq_viewDidLoad(){
        if (self.navigationController != nil) && self != self.navigationController?.viewControllers.first {
            let popRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(self.handlePopRecognizer(recognizer:)))
            self.view.addGestureRecognizer(popRecognizer)
        }
        self.zdq_viewDidLoad()
    }
    
    func handlePopRecognizer(recognizer:UIPanGestureRecognizer){
        let w_isDragging = false;
        
        let progress = recognizer.translation(in: self.view).x / self.view.frame.size.width
        
//        progress =   MIN(1.0, MAX(0.0, progress));
//        if (progress <= 0 && !w_isDragging && recognizer.state != UIGestureRecognizerStateBegan) {
//            return;
//        }
//        if (recognizer.state == UIGestureRecognizerStateBegan)
//        {
//            w_isDragging = YES;
//            self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        else if (recognizer.state == UIGestureRecognizerStateChanged)
//        {
//            w_isDragging = YES;
//            [self.interactivePopTransition updateInteractiveTransition:progress];
//        }
//        else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
//        {
//            if (progress > 0.25)
//            {
//                w_isDragging = NO;
//                [self.interactivePopTransition finishInteractiveTransition];
//            }
//            else
//            {
//                w_isDragging = NO;
//                [self.interactivePopTransition cancelInteractiveTransition];
//            }
//            self.interactivePopTransition = nil;
//        }
    }
    
    var interactivePopTransition:UIPercentDrivenInteractiveTransition{
        get {
            if objc_getAssociatedObject(self, "ZDQInteractivePopTransition") as? UIPercentDrivenInteractiveTransition != nil {
                return objc_getAssociatedObject(self, "ZDQInteractivePopTransition") as! UIPercentDrivenInteractiveTransition
            }else{
                return UIPercentDrivenInteractiveTransition.init()
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, "ZDQInteractivePopTransition", newValue, objc_AssociationPolicy(rawValue: 1)!)
        }
    }
    
    var snapshot:UIView {
        get {
            if objc_getAssociatedObject(self, "ZDQAnimationTransitioningSnapshot") as? UIView != nil {
                return objc_getAssociatedObject(self, "ZDQAnimationTransitioningSnapshot") as! UIView
            }else{
                return UIView.init()
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, "ZDQAnimationTransitioningSnapshot", newValue, objc_AssociationPolicy(rawValue: 1)!)
        }
    }
    
    var topSnapshot: UIView {
        get {
            if objc_getAssociatedObject(self, "ZDQAnimationTransitioningTopSnapshot") as? UIView != nil {
                return objc_getAssociatedObject(self, "ZDQAnimationTransitioningTopSnapshot") as! UIView
            }else{
                return UIView.init()
            }
        }
        set(newValue) {
            objc_setAssociatedObject(self, "ZDQAnimationTransitioningTopSnapshot", newValue, objc_AssociationPolicy(rawValue: 1)!)
        }

    }
    
    var viewSnapshot:UIView{
        get{
            if objc_getAssociatedObject(self, "ZDQAnimationTransitioningViewSnapshot") as? UIView != nil {
                return objc_getAssociatedObject(self, "ZDQAnimationTransitioningViewSnapshot") as! UIView
            }else{
                return UIView.init()
            }

        }set(newValue) {
            objc_setAssociatedObject(self, "ZDQAnimationTransitioningViewSnapshot", newValue, objc_AssociationPolicy(rawValue: 1)!)
        }
    }
    
    func imageFromView(snapView:UIView) -> UIImage{
        UIGraphicsBeginImageContext(snapView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        snapView.layer.render(in: context!)
        let targetImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return targetImage!
    }
 }
