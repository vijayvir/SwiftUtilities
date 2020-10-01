//
//  TodoList.swift
//  Predicate
//
//  Created by Vijayvir Singh on 01/10/20.
//

import Foundation

@objcMembers class Job: NSObject {
    let company: String
    let salary: Float
    let title: String
    
    init(company: String, salary: Float, title: String) {
      self.company = company
      self.salary = salary
      self.title = title
    }
  }

  @objcMembers class Person: NSObject {
    let firstName: String
    let lastName: String
    let job: Job
    
    var fullName: String {
      get {
        return "\(firstName) \(lastName)"
      }
    }
    
    init(firstName: String, lastName: String, job: Job) {
      self.firstName = firstName
      self.lastName = lastName
      self.job = job
    }
  }
