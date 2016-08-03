//
//  ViewController.swift
//  testfb
//
//  Created by Eric Lewis on 8/2/16.
//  Copyright © 2016 eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let request = FBSDKGraphRequest(graphPath: "/CommunityCupWindsor/events",
                                        parameters: ["fields": "name,cover,start_time,end_time,place,description"],
                                        HTTPMethod: "GET")
        
        request.startWithCompletionHandler { ( connection, result, error) in
            if (error != nil) {
                if let errorMessage = error.userInfo[FBSDKErrorDeveloperMessageKey] {
                    print(errorMessage)
                }
            } else {
                print(result)
            }
        }
    }
}

