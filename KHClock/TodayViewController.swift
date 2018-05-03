//
//  TodayViewController.swift
//  KHClock
//
//  Created by minh on 1/29/18.
//  Copyright © 2018 minh. All rights reserved.
//

import UIKit
import NotificationCenter
import QuartzCore
import Shimmer

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var vParent: UIView!
    @IBOutlet weak var imgFrame: UIImageView!
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var imgDot: UIImageView!
    @IBOutlet weak var imgS: UIImageView!
    @IBOutlet weak var imgM: UIImageView!
    @IBOutlet weak var imgH: UIImageView!
    @IBOutlet weak var imgDot2: UIImageView!
    @IBOutlet weak var imgFg: UIImageView!
    
    @IBOutlet weak var svS: FBShimmeringView!
    @IBOutlet weak var svM: FBShimmeringView!
    @IBOutlet weak var svH: FBShimmeringView!
    @IBOutlet weak var svFg: FBShimmeringView!
    
    var currentBg = "bg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        //Shimmer
        svH.isShimmering = true
        svH.shimmeringOpacity = 1
        svH.shimmeringAnimationOpacity = 0.85
        svH.contentView = imgH
//        svH.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi * (330) / 180.0));
        
        svM.isShimmering = true
        svM.shimmeringOpacity = 1
        svM.shimmeringAnimationOpacity = 0.85
        svM.contentView = imgM
//        svM.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi * (330) / 180.0));
        
        svS.isShimmering = true
        svS.shimmeringOpacity = 1
        svS.shimmeringAnimationOpacity = 0.85
        svS.contentView = imgS
//        svS.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi * (330) / 180.0));
        
        svFg.isShimmering = true
        svFg.shimmeringOpacity = 1
        svFg.shimmeringAnimationOpacity = 0.75
        svFg.contentView = imgFg
//        svFg.transform = CGAffineTransform(rotationAngle: CGFloat(Float.pi * (330) / 180.0));

        //Parallax
        let min = CGFloat(-10)
        let max = CGFloat(10)
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        
        imgBg.addMotionEffect(motionEffectGroup)
        imgS.addMotionEffect(motionEffectGroup)
        imgM.addMotionEffect(motionEffectGroup)
        imgH.addMotionEffect(motionEffectGroup)
        imgDot.addMotionEffect(motionEffectGroup)
        imgDot2.addMotionEffect(motionEffectGroup)
        
        //Shadow
        imgFrame.layer.masksToBounds = false
        imgFrame.layer.shadowColor = UIColor.black.cgColor
        imgFrame.layer.shadowOpacity = 1
        imgFrame.layer.shadowOffset = CGSize(width: 2, height: 2)
        imgFrame.layer.shadowRadius = 2
        
        imgDot.layer.masksToBounds = false
        imgDot.layer.shadowColor = UIColor.black.cgColor
        imgDot.layer.shadowOpacity = 1
        imgDot.layer.shadowOffset = CGSize(width: 1, height: 1)
        imgDot.layer.shadowRadius = 1
        
        imgH.layer.masksToBounds = false
        imgH.layer.shadowColor = UIColor.black.cgColor
        imgH.layer.shadowOpacity = 1
        imgH.layer.shadowOffset = CGSize(width: 0, height: 1)
        imgH.layer.shadowRadius = 1
        
        imgM.layer.masksToBounds = false
        imgM.layer.shadowColor = UIColor.black.cgColor
        imgM.layer.shadowOpacity = 1
        imgM.layer.shadowOffset = CGSize(width: 0, height: 1)
        imgM.layer.shadowRadius = 1
        
        imgS.layer.masksToBounds = false
        imgS.layer.shadowColor = UIColor.black.cgColor
        imgS.layer.shadowOpacity = 1
        imgS.layer.shadowOffset = CGSize(width: 0, height: 1)
        imgS.layer.shadowRadius = 1
        
        imgDot2.layer.masksToBounds = false
        imgDot2.layer.shadowColor = UIColor.black.cgColor
        imgDot2.layer.shadowOpacity = 0.5
        imgDot2.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        imgDot2.layer.shadowRadius = 0.5
        
        // Do any additional setup after loading the view from its nib.
        changeDisplayTime()
    }
    
    @objc func changeDisplayTime() {
        let date = Date()
        let calendar = Calendar.current
        let seconds = Float(calendar.component(.second, from: date))
        let minutes = Float(calendar.component(.minute, from: date)) + seconds / 60.0
        let hour = Float(calendar.component(.hour, from: date)) + minutes / 60.0
        let sa = seconds * 360.0 / 60.0; //degree
        let s = Float.pi * sa / 180.0;  //angle
        let ma = minutes * 360.0 / 60.0;
        let m = Float.pi * ma / 180.0;
        let ha = hour * 360.0 / 12.0;
        let h = Float.pi * ha / 180.0;
        
        imgS.layer.shadowOffset = CGSize(width: sa > 0 && sa < 180 ? 1 : sa > 180 && sa < 360 ? -1 : 0, height: 1)
        
//        UIView.animate(withDuration:1, animations: {
            self.imgS.transform = CGAffineTransform(rotationAngle: CGFloat(s));
//        })
            imgM.layer.shadowOffset = CGSize(width: ma > 0 && ma < 180 ? 1 : ma > 180 && ma < 360 ? -1 : 0, height: 1)
            imgH.layer.shadowOffset = CGSize(width: ha > 0 && ha < 180 ? 1 : ha > 180 && ha < 360 ? -1 : 0, height: 1)
//            UIView.animate(withDuration:1, animations: {
                self.imgM.transform = CGAffineTransform(rotationAngle: CGFloat(m));
                self.imgH.transform = CGAffineTransform(rotationAngle: CGFloat(h));
//            })
        
        let formatter = DateFormatter()
        formatter.dateFormat = "k"
        let hourString = (formatter.string(from: Date()) as NSString).integerValue

        if hourString >= 7 && hourString < 22 && currentBg == "bgn" {
            currentBg = "bg"
//            imgBg.image = UIImage(named: currentBg)
            UIView.transition(with: imgBg, duration: 1, options: .transitionCrossDissolve, animations: { self.imgBg.image = UIImage(named: self.currentBg) }, completion: nil)
        } else if (hourString < 7 || hourString >= 22) && currentBg == "bg" {
            currentBg = "bgn"
//            imgBg.image = UIImage(named: currentBg)
            UIView.transition(with: imgBg, duration: 1, options: .transitionCrossDissolve, animations: { self.imgBg.image = UIImage(named: self.currentBg) }, completion: nil)
        }
        
//        let tillNextMinute = (60 - seconds) % 60;
//        Timer.scheduledTimer(timeInterval: TimeInterval(tillNextMinute), target: self, selector: #selector(self.changeDisplayTime), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeDisplayTime), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize){
        if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: 0, height: 256) //Size of the widget you want to show in expanded mode
        } else {
            preferredContentSize = maxSize
        }
    }
    
}
