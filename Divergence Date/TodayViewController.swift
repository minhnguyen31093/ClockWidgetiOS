//
//  TodayViewController.swift
//  Divergence Date
//
//  Created by minh on 2/2/18.
//  Copyright © 2018 minh. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var imgD1: UIImageView!
    @IBOutlet weak var imgD2: UIImageView!
    @IBOutlet weak var imgM1: UIImageView!
    @IBOutlet weak var imgM2: UIImageView!
    @IBOutlet weak var imgY1: UIImageView!
    @IBOutlet weak var imgY2: UIImageView!
    @IBOutlet weak var imgY3: UIImageView!
    @IBOutlet weak var imgY4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        changeDisplayTime()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeDisplayTime() {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let tomorrow = getTomorrowAt(hour: 0, minutes: 0)
        
        setDay(number: day)
        setMonth(number: month)
        setYear(number: year)
        Timer.scheduledTimer(timeInterval: tomorrow.timeIntervalSinceNow, target: self, selector: #selector(self.changeDisplayTime), userInfo: nil, repeats: false)
    }
    
    func getTomorrowAt(hour: Int, minutes: Int) -> Date {
        let today = Date()
        let morrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        return Calendar.current.date(bySettingHour: hour, minute: minutes, second: 0, of: morrow!)!
    }
    
    func setDay(number : Int) {
        let numbers = getNumbers(number: number);
        imgD1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgD2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
    }
    
    func setMonth(number : Int) {
        let numbers = getNumbers(number: number);
        imgM1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgM2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
    }
    
    func setYear(number : Int) {
        let numbers = getNumbersYear(number: number);
        imgY1.image = UIImage(named: getImageForNumber(number: (numbers?.first)!))
        imgY2.image = UIImage(named: getImageForNumber(number: (numbers?.second)!))
        imgY3.image = UIImage(named: getImageForNumber(number: (numbers?.third)!))
        imgY4.image = UIImage(named: getImageForNumber(number: (numbers?.four)!))
    }
    
    func getNumbers(number : Int) -> (first : Int, second : Int)? {
        var first = 0
        var second = 0
        if number < 10 {
            first = 0
            second = number
        } else {
            first = number / 10
            second = number % 10
        }
        return (first, second)
    }
    
    func getNumbersYear(number : Int) -> (first : Int, second : Int, third : Int, four : Int)? {
        let first = number / 1000
        let second = (number - first * 1000) / 100
        let third = (number - (first * 1000 + second * 100)) / 10
        let four = number % 10
        return (first, second, third, four)
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
