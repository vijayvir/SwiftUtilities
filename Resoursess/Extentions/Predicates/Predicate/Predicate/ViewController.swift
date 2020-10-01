//
//  ViewController.swift
//  Predicate
//
//  Created by Vijayvir Singh on 01/10/20.
//

import UIKit
//https://www.andyibanez.com/posts/filtering-arrays-nspredicate/
//
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let people = [
          Person(firstName: "Andy", lastName: "Ibanez", job:
            Job(company: "Fairese", salary: 5000, title: "CEO")),
          Person(firstName: "Sakura", lastName: "Kinomoto", job:
            Job(company: "Tomoeda Gakkou", salary: 4000, title: "Card Captor")),
          Person(firstName: "Daidouji", lastName: "Tomoyo", job:
            Job(company: "Daidouji Group", salary: 4000, title: "Filmmaker")),
          Person(firstName: "Nae", lastName: "Kinomoto", job:
            Job(company: "Animal Group", salary: 3000, title: "Animal Captor")),
          Person(firstName: "Tae", lastName: "Kinoshita", job:
            Job(company: "Zombie, Co.", salary: 2500, title: "Dancer"))
        ]
        let nsPeople = people as NSArray
        
        
        let lastNameKinomotoPredicate = NSPredicate(format: "lastName = %@", "Kinomoto")
        let lastNameKinomoto = nsPeople.filtered(using: lastNameKinomotoPredicate)

        print("People whose last name is Kinomoto:")
        (lastNameKinomoto as! [Person]).forEach {
          print($0.fullName)
          // Prints:
          // Sakura Kinomoto
          // Nae Kinomoto
        }
        
        let lastNameBeginsKinoPredicate = NSPredicate(format: "lastName BEGINSWITH[c] %@", "Kino")
        let lastNameBeginsKino = nsPeople.filtered(using: lastNameBeginsKinoPredicate)

        print("People whose last name contains \"Kino\":")
        (lastNameBeginsKino as! [Person]).forEach {
          print($0.fullName)
          // Prints:
          // Sakura Kinomoto
          // Nae Kinomoto
          // Tae Kinoshita
        }
        
        
    }


}

