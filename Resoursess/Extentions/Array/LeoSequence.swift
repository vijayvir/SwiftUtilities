//
//  LeoSequence.swift
//  MyTaxiRide
//
//  Created by vijay vir on 7/10/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation

public extension Sequence {

	/* 
	 
	  this function will categories the given array based on nested key values of given array.
	
  */

	func categorise<U: Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {

		var dict: [U:[Iterator.Element]] = [:]

		for el in self {

			let key = key(el)

			if case nil = dict[key]?.append(el) { dict[key] = [el] }
		}

		return dict
	}
}
/*
  var array = ["John", "Snow", "George", "John", "Bush", "George"].unique()
 */

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        
        let some =  self.filter { element in
            print(element, ":  ",seen)
            return seen.updateValue(true, forKey: element) == nil
            
        }
        
        return  some
    }
}
