//
//  Codable+Extension.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 29/07/23.
//

import Foundation

/// This method is generic type for parsing the data...
func parseJSON<T: Codable>(data: AnyObject) -> T? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(T.self, from: jsonData)
    } catch {
        print("Could not parse the Codable: \(error)")
    }
    return nil
}

func parseDecodable<T: Decodable>(data: AnyObject) -> T? {
    if let resp = data as? [String: Any] {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resp, options: .prettyPrinted)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return try jsonDecoder.decode(T.self, from: jsonData)
        } catch let error as NSError {
            print("Could not parse the Devodable: \(error)")
        }
    }
    return nil
}
/// this method will return the object as [String: AnyObject]? dictionary
func parseEncodable<T: Encodable>(data: T) -> [String: AnyObject]? {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    guard let jsonData = try? jsonEncoder.encode(data) else {
        return nil
    }
    //    let json = String(data: jsonData, encoding: String.Encoding.utf8)
    //    Logs.DLog(object: json ?? "NA")
    return try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
}

func getCurrency<T>(_ price: T) -> String {
    // getting the currency ISO
    let locale = Locale(identifier: "en_IN") //for temprory added the INR
    let numberFormatter = NumberFormatter()
    numberFormatter.usesGroupingSeparator = locale.groupingSeparator != nil
    numberFormatter.numberStyle = .currency
    numberFormatter.locale = locale
    var priceNumber: NSNumber = 0
    if let priceStr = (price as? String)?.intVal as? NSNumber {
        priceNumber = priceStr
    } else if let priceNum = price as? NSNumber {
        priceNumber = priceNum
    } else if let priceDouble = price as? Double {
        priceNumber = NSNumber(value: priceDouble)
    } else if let priceInt = price as? Int {
        priceNumber = NSNumber(value: priceInt)
    }
    return numberFormatter.string(from: priceNumber) ?? priceNumber.stringValue
    
}
