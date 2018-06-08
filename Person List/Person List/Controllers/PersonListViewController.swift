//
//  PersonListViewController
//  Person List
//
//  Created by rejlacanienta on 07/06/2018.
//  Copyright © 2018 rejlacanienta. All rights reserved.
//

import Foundation
import UIKit

class PersonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    @IBOutlet weak var tableView: UITableView!
    
    var persons = [Person]()
    var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData(){
        let cachedData = Cache().retrieveFromCache()
        if cachedData == nil{
            Cache().retrieveListFromAPI(apiRequest: "https://randomapi.com/api/4a5eaa4406278d82729259c175eec5cb", completion: {data -> Void in
                self.persons = data as! [Person]
                Cache().saveCache(array: self.persons)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }else{
            self.persons = cachedData!
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        person = persons[indexPath.row]
        performSegue(withIdentifier: "showPersonDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonTableViewCell
        cell.name.text = "\(persons[indexPath.row].firstName) \(persons[indexPath.row].lastName)"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPersonDetailSegue"{
            let nvc = segue.destination as! PersonDetailViewController
            nvc.person = self.person
        }
    }

}

