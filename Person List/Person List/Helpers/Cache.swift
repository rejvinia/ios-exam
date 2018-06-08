//
//  Cache.swift
//  Person List
//
//  Created by rejlacanienta on 07/06/2018.
//  Copyright © 2018 rejlacanienta. All rights reserved.
//

import Foundation

class Cache{
    
    func retrieveListFromAPI(apiRequest: String, completion: @escaping (_ returnData : AnyObject) -> (Void)){
        let urlString = URL(string: apiRequest)
        URLSession.shared.dataTask(with:urlString!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                let results = (json.value(forKey: "results") as! NSArray)[0] as! NSDictionary
                var persons = [Person]()
                let list = results.value(forKey: "persons")! as! NSArray
                for item in list{
                    let person = Person()
                    person.firstName = (item as AnyObject).value(forKey: "firstName") as! String
                    person.lastName = (item as AnyObject).value(forKey: "lastName") as! String
                    person.birthday = (item as AnyObject).value(forKey: "birthday") as! String
                    person.emailAddress = (item as AnyObject).value(forKey: "emailAddress") as! String
                    person.address = (item as AnyObject).value(forKey: "address") as! String
                    person.birthday = (item as AnyObject).value(forKey: "lastName") as! String
                    let contactPerson = ContactPerson()
                    contactPerson.name = ((item as AnyObject).value(forKey: "contactPerson") as! NSDictionary).value(forKey: "name") as! String
                    contactPerson.contactNumber = ((item as AnyObject).value(forKey: "contactPerson") as! NSDictionary).value(forKey: "contactNumber") as! String
                    person.contactPerson = contactPerson
                    persons.append(person)
                }
                completion(persons as AnyObject)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
        
    func saveCache(array: [Person]){
            let fileManager = FileManager.default
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                let fileURL = documentDirectory.appendingPathComponent("PersonList.plist")
                try (array as NSArray).write(to: fileURL, atomically: true)
            } catch {
                print(error)
            }
    }
    
    func retrieveFromCache() -> [Person]!{
        let fileManager = FileManager.default
        do{
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent("PersonList.plist")
            // Read from file
            let savedArray = NSArray(contentsOf: fileURL)
            let persons = savedArray as? [Person]
            if persons == nil{
                return nil
            }
            return persons
        } catch {
            print(error)
            return nil
        }
    }
}
