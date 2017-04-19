//
//  ViewController.swift
//  SampleAnimations
//
//  Created by 黄启明 on 2017/4/19.
//  Copyright © 2017年 黄启明. All rights reserved.
//

import UIKit

enum AnimationType: Int {
    case fade = 1           //淡化效果
    case push               //push效果
    case reveal             //揭开效果
    case moveIn             //覆盖效果
    case cube               //立方体效果
    case suckEffect         //吮吸效果
    case oglFlip           //翻转效果
    case rippleEffect       //波纹效果
    case pageCurl           //翻页效果
    case pageUnCurl         //反翻页效果
    case cameraIrisHollowOpen   //开镜头效果
    case cameraIrisHollowClose  //关镜头效果
    case curlDown           //下翻页效果
    case curlUp             //上翻页效果
    case flipFromLeft       //左翻转效果
    case flipFromRight      //右翻转效果
}

let image_1 = "image_1.jpg"
let image_2 = "image_2.jpg"

let duration = 1.0

var flag: Bool = true

class ViewController: UIViewController {
    
    var subType = 0 //子类型
    
    var subTypeString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        addBgImageWith(name: image_1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - CATransition动画实现
    func transitionWithType(_ type: String, subtype: String?, forView view: UIView) {
        let animation = CATransition()
        animation.duration = duration
        animation.type = type
        if subtype != nil {
            animation.subtype = subtype
        }
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.add(animation, forKey: "animation")
    }
    
//MARK: - UIView动画实现
    func animationWithAnimationTransition(_ transition: UIViewAnimationTransition, forView view: UIView) {
        UIView.animate(withDuration: duration) { 
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationTransition(transition, for: view, cache: true)
        }
    }
    
    @IBAction func tapButton(_ sender: Any) {
        
        let btn: UIButton = sender as! UIButton;
        let animationType: AnimationType = AnimationType(rawValue: btn.tag)!
        
        print(animationType)
        
        switch subType {
        case 0:
            subTypeString = kCATransitionFromTop
        case 1:
            subTypeString = kCATransitionFromLeft
        case 2:
            subTypeString = kCATransitionFromBottom
        case 3:
            subTypeString = kCATransitionFromRight
        default:
            break
        }
        
        subType += 1
        if subType > 3 {
            subType = 0
        }
        
        switch animationType {
        case .fade:
            transitionWithType(kCATransitionFade, subtype: nil, forView: view)
        case .push:
            transitionWithType(kCATransitionPush, subtype: subTypeString, forView: view)
        case .reveal:
            transitionWithType(kCATransitionReveal, subtype: subTypeString, forView: view)
        case .moveIn:
            transitionWithType(kCATransitionMoveIn, subtype: subTypeString, forView: view)
        case .cube:
            transitionWithType("cube", subtype: subTypeString, forView: view)
        case .suckEffect:
            transitionWithType("suckEffect", subtype: nil, forView: view)
        case .oglFlip:
            transitionWithType("oglFlip", subtype: subTypeString, forView: view)
        case .rippleEffect:
            transitionWithType("rippleEffect", subtype: nil, forView: view)
        case .pageCurl:
            transitionWithType("pageCurl", subtype: subTypeString, forView: view)
        case .pageUnCurl:
            transitionWithType("pageUnCurl", subtype: subTypeString, forView: view)
        case .cameraIrisHollowOpen:
            transitionWithType("cameraIrisHollowOpen", subtype: nil, forView: view)
        case .cameraIrisHollowClose:
            transitionWithType("cameraIrisHollowClose", subtype: nil, forView: view)
        case .curlDown:
            animationWithAnimationTransition(.curlDown, forView: view)
        case .curlUp:
            animationWithAnimationTransition(.curlUp, forView: view)
        case .flipFromLeft:
            animationWithAnimationTransition(.flipFromLeft, forView: view)
        case .flipFromRight:
            animationWithAnimationTransition(.flipFromRight, forView: view)
        }
        
        if flag {
            addBgImageWith(name: image_2)
            flag = false
        }
        else {
            addBgImageWith(name: image_1)
            flag = true
        }
        
        
    }

    //给view添加背景图
    func addBgImageWith(name: String) {
        view.backgroundColor = UIColor(patternImage: UIImage(named: name)!)
    }
    
}

