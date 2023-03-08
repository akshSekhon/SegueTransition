//
//  InitialViewController.swift
//  ElasticTransitionExample
//
//  Created by Luke Zhao on 2015-12-16.
//  Copyright © 2015 lkzhao. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
  
  var transition = ElasticTransition()
  let lgr = UIPanGestureRecognizer()//UIScreenEdgePanGestureRecognizer()
  let rgr = UIPanGestureRecognizer()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // customization
      transition.interactive = false
    transition.sticky = false
      transition.radiusFactor = 0.5
      transition.isApplyCurve = true
//      transition.interactiveRadiusFactor = 0
//    transition.showShadow = true
//    transition.panThreshold = 0.3
      transition.transformType = .translatePush//.translateMid
//    transition.overlayColor = UIColor(white: 0, alpha: 0.5)
//    transition.shadowColor = UIColor(white: 0, alpha: 0.5)
    
    // gesture recognizer
    lgr.addTarget(self, action: #selector(handlePan(_:)))
    rgr.addTarget(self, action: #selector(handleRightPan(_:)))
      
//    lgr.edges = .left
//    rgr.edges = .right
    view.addGestureRecognizer(lgr)
    view.addGestureRecognizer(rgr)
  }
  
    @objc func handlePan(_ pan:UIPanGestureRecognizer){
    if pan.state == .began{
      transition.edge = .left
      transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)
    }else{
      _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
    }
  }
  
    @objc func handleRightPan(_ pan:UIPanGestureRecognizer){
        let loctn = pan.location(in: self.view)
        if loctn.x < (view.bounds.width / 2) - 50{
            if pan.state == .began{
              transition.edge = .left

              transition.startInteractiveTransition(self, segueIdentifier: "menu", gestureRecognizer: pan)

            }else{
              _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
            }
        }else if loctn.x > (view.bounds.width / 2) + 50{
            if pan.state == .began{
              transition.edge = .right

              transition.startInteractiveTransition(self, segueIdentifier: "demo", gestureRecognizer: pan)
            }else{
              _ = transition.updateInteractiveTransition(gestureRecognizer: pan)
            }
        }
  }
  
  @IBAction func codeBtnTouched(_ sender: AnyObject) {
    transition.edge = .left
    transition.startingPoint = sender.center
    performSegue(withIdentifier: "menu", sender: self)
  }
  
  @IBAction func optionBtnTouched(_ sender: AnyObject) {
    transition.edge = .bottom
    transition.startingPoint = sender.center
    performSegue(withIdentifier: "option", sender: self)
  }

  @IBAction func aboutBtnTouched(_ sender: AnyObject) {
      

    transition.edge = .right
    transition.startingPoint = sender.center
    performSegue(withIdentifier: "about", sender: self)
  }
  
  @IBAction func modalBtnTouched(_ sender: AnyObject) {
    let modalViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalExampleViewController") as! ModalExampleViewController
    present(modalViewController, animated: true, completion: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "about"{
          if let vc = segue.destination as? AboutViewController{
              vc.name = "Aksh"
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
          }
      }else if segue.identifier == "menu"{
          if let vc = segue.destination as? MenuViewController{
              vc.name = "Sekhon"
              
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
      }
  }
      else{
          let vc = segue.destination
        vc.transitioningDelegate = transition
        vc.modalPresentationStyle = .custom
      }
  }
    
   
  }
  

extension CATransition {

//New viewController will appear from bottom of screen.
func segueFromBottom() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromTop
    return self
}
//New viewController will appear from top of screen.
func segueFromTop() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromBottom
    return self
}
 //New viewController will appear from left side of screen.
func segueFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromLeft
    return self
}
//New viewController will pop from right side of screen.
func popFromRight() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromRight
    return self
}
//New viewController will appear from left side of screen.
func popFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromLeft
    return self
   }
}
