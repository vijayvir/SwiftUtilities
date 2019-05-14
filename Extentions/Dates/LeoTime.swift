//
//  LeoTime.swift
//  MyTaxiRide
//
//  Created by vijay vir on 8/22/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//

import Foundation

func leoHrsMinsSeconds( seconds: Int) -> String {

	let hours = Int(seconds) / 3600

	let minutes = Int(seconds) / 60 % 60

	let seconds = Int(seconds) % 60

	return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
}
