//
//  LeoReadJson.swift
//  MyTaxiRide
//
//  Created by vijay vir on 7/10/17.
//  Copyright © 2017 vijay vir. All rights reserved.
//
import Foundation

/**
This functions read the files and return the Key: Values Array

- parameter bunldePath:  name of the file.

- parameter extention: files extentions .

- returns  : [String: Any]

	# Example :
	       let response = leoReadJson(bunldePath: "ReservedJobApiResponse", extention: "json")

- Author: Vijavir
*/

public func leoReadObject(bunldePath: String, extention: String) -> [String: Any] {

	if let path = Bundle.main.path(forResource: bunldePath, ofType: extention ), let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {

		return dict

	}
	
	return [:]
	
}

public func leoReadJson(bunldePath: String, extention: String) -> Any? {

	if let filePath = Bundle.main.path(forResource: bunldePath, ofType: extention) {
		do {

			let data = try Data(contentsOf:  URL(fileURLWithPath: filePath))

			let json = try JSONSerialization.jsonObject(with: data, options: [])

			if let object = json as? [String: Any] {
				// json is a dictionary

						return object

			} else if let object = json as? [Any] {
				// json is an array
				return object

			} else {
				return "JSON is invalid"

			}

		} catch {

			return "no File "

			//Handle error
		}
	}
	return "no File "
}

func leoReadDataFromCSV(bunldePath:String, extention: String)-> Any? {

	guard let filepath = Bundle.main.path(forResource: bunldePath, ofType: extention)
		
		else {
			
			return nil
	}
	do {
		
		var contents = try String(contentsOfFile: filepath, encoding: .utf8)
		
		contents = cleanRows(file: contents)
		
	   let data = 	csv(data: contents)
		
		return data
		
	} catch {
		
		print("File Read Error for file \(filepath)")
		
		return nil
	}
}

func cleanRows(file:String)->String{
	
	var cleanFile = file
	
	cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
	
	cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
	
	return cleanFile
}

func csv(data: String) -> [[Any]] {
	
	var result: [[Any]] = []
    
	let rows = data.components(separatedBy: "\n")
	for row in rows {
        
		let columns = row.components(separatedBy: ",")
		
        result.append(columns)
	}
	return result
}
