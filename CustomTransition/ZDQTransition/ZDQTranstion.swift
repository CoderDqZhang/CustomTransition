//
//  ZDQTranstion.swift
//  CustomTransition
//
//  Created by Zhang on 2017/2/28.
//  Copyright © 2017年 Zhang. All rights reserved.
//

import UIKit

enum ZDQAnimationType{
    case Default
    case DiffNavi
}

class ZDQTranstion: NSObject {
    var animationType:ZDQAnimationType!
    var isShowShadow:Bool!
    
    private override init() {
        
    }
    static let shareManager = ZDQTranstion()
    
    func setAnimationType(_ type: ZDQAnimationType, navi:UINavigationController){
        self.animationType = type;
        if self.animationType == .Default {
            navi.delegate = nil
        }
    }
}

extension ZDQTranstion : UINavigationControllerDelegate{
    private func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: ZDQBaseAnimation) -> UIViewControllerInteractiveTransitioning? {
        return animationController.interactivePopTransition
    }
    
    func  navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animation = ZDQBaseAnimation().initWithType(operation, duration: 0.6, type: self.animationType)
        return animation
    }
}

var AssociatedObjectHandle: UInt8 = 0

extension UIViewController{
//    open var sss:UIView!
//    var snapshot:UIView {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! UIView
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy(rawValue: 1)!)
//        }
//    }
//    var topSnapshow:UIView {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! UIView
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy(rawValue: 1)!)
//        }
//    }
//    var viewSnapshot:UIView {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! UIView
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy(rawValue: 1)!)
//        }
//    }
//    var interactivePopTransition:UIPercentDrivenInteractiveTransition {
//        get {
//            let obj = objc_getAssociatedObject(self, "ZDQInteractivePopTransition")
//            return obj as! UIPercentDrivenInteractiveTransition
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy(rawValue: 1)!)
//        }
//    }
}
