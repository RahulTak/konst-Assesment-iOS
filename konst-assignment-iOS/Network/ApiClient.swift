//
//  ApiClient.swift
//  konst-assignment-iOS
//
//  Created by Rahul Tak on 28/07/23.
//

import Foundation

public struct ApiClient {
    
    static func getDataFromServer( completion: @escaping (Result<AnyObject?, NSError>)->() ){
        DispatchQueue.global().async {
            sleep(3)
            if let fileData = ApiClient().loadJson(filename: "Products") {
                completion(.success(fileData as AnyObject))
            } else {
                let error  = NSError(domain: "Something went wrong", code: 1112121)
                completion(.failure(error))
            }
        }
    }
    
    func loadJson(filename fileName: String) -> [String: AnyObject]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                print("Error!! Unable to parse  \(fileName).json")
            }
        }
        return nil
    }
}
