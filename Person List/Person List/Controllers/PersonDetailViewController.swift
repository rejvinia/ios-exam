//
//  PersonDetailViewController.swift
//  Person List
//
//  Created by rejlacanienta on 07/06/2018.
//  Copyright © 2018 rejlacanienta. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailViewController: UIViewController {
    
    var person: Person!
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var bdayTxt: UILabel!
    @IBOutlet weak var ageTxt: UILabel!
    @IBOutlet weak var mobileTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var addressTxt: UILabel!
    @IBOutlet weak var contactPersonTxt: UILabel!
    @IBOutlet weak var contactPersonNumberTxt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTxt.text = "\(person.firstName) \(person.lastName)"
        bdayTxt.text = birthdayParse(birthday: person.birthday)
        mobileTxt.text = person.mobileNumber
        emailTxt.text = person.emailAddress
        addressTxt.text = person.address
        contactPersonTxt.text = person.contactPerson.name
        contactPersonNumberTxt.text = person.contactPerson.contactNumber
        let age = ageCalculator(birthday: person.birthday)
        ageTxt.text = "\(age)"
    }
    
    func ageCalculator(birthday: String) -> Int{
        var age = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        let date = dateFormatter.date(from: birthday) as! Date
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: date, to: Date())
        age = components.year!
        return age
    }
    
    func birthdayParse(birthday: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        let date = dateFormatter.date(from: birthday)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: date!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

