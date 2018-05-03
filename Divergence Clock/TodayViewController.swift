//
//  TodayViewController.swift
//  Divergence Clock
//
//  Created by minh on 2/2/18.
//  Copyright © 2018 minh. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var imgH1: UIImageView!
    @IBOutlet weak var imgH2: UIImageView!
    @IBOutlet weak var imgM1: UIImageView!
    @IBOutlet weak var imgM2: UIImageView!
    @IBOutlet weak var imgS1: UIImageView!
    @IBOutlet weak var imgS2: UIImageView!
    
    var currentHour = 0
    var currentMinute = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
//        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        changeDisplayTime()
    }
    
    @objc func changeDisplayTime() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        if currentHour != hour {
            currentHour = hour
            setHour(number: hour)
        }
        if currentMinute != minute {
            currentMinute = minute
            setMinute(number: minute)
        }
        setSecond(number: second)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.changeDisplayTime), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setHour(number : Int) {
        let numbers = getNumbers(number: number);
        imgH1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgH2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
    }
    
    func setMinute(number : Int) {
        let numbers = getNumbers(number: number);
        imgM1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgM2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
    }
    
    func setSecond(number : Int) {
        let numbers = getNumbers(number: number);
        imgS1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgS2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
    }
    
    func getNumbers(number : Int) -> (first : Int, second : Int)? {
        var first = 0
        var second = 0
        if number != 0 {
            if number < 10 {
                first = 0
                second = number
            } else {
                first = number / 10
                second = number % 10
            }
        }
        return (first, second)
    }
    
    func getImageForNumber(number : Int) -> String {
        switch number {
            case 0:
                return "img_nixietube00"
            case 1:
                return "img_nixietube01"
            case 2:
                return "img_nixietube02"
            case 3:
                return "img_nixietube03"
            case 4:
                return "img_nixietube04"
            case 5:
                return "img_nixietube05"
            case 6:
                return "img_nixietube06"
            case 7:
                return "img_nixietube07"
            case 8:
                return "img_nixietube08"
            case 9:
                return "img_nixietube09"
            default:
                return "img_nixietube00"
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
