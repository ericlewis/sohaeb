//
//  EventTableViewController.swift
//  testfb
//
//  Created by may on 2016-08-09.
//  Copyright © 2016 eric. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    var event123 = [Event]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event123.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! EventUITableViewCell
        
        let oneRow = event123[indexPath.row]
        
        cell.nameOutlet.text = oneRow.name
        cell.imageLol.image = oneRow.image
        
        return cell
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let request = FBSDKGraphRequest(graphPath: "/CityofWindsor/events",
                                        parameters: ["fields": "name,cover,start_time,end_time,place,description"],
                                        HTTPMethod: "GET")
        
        request.startWithCompletionHandler { ( connection, result, error) in
            if (error != nil) {
                if let errorMessage = error.userInfo[FBSDKErrorDeveloperMessageKey] {
                    print(errorMessage)
                }
            } else if let data = result.valueForKey("data") {
                for event in data as! NSArray {
                    if let place = event.valueForKey("place"),
                        let placeName = (place.valueForKey("name")),
                        let description = event.valueForKey("description"),
                        let value = event.valueForKey("cover")!.valueForKey("source"),
                        let url = NSURL(string: value as! String),
                        let data = NSData(contentsOfURL: url) {
                        print(placeName, description)
                        self.event123.append(Event(newName: placeName as! String, newImage: UIImage(data: data)!))
                    }
                }
            }
        }
    }
}
