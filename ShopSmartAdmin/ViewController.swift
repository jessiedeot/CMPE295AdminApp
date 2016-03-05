//
//  ViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/2/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    enum JSONError: String, ErrorType {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
    
    @IBAction func loginBtn(sender: UIButton) {
        
        let usernameText = usernameField.text!
        let passwordText = passwordField.text!
        
        if ( usernameText == "" || passwordText == "" ) {
            
            let alert = UIAlertController(title: "Login Failed!", message:"Please enter a valid Username and Password", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            
        } else {
            
            
            let urlPath = "http://127.0.0.1:8000/smartretailapp/login/?username=\(usernameText)&password=\(passwordText)"
            print(urlPath)
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do {
                    guard let dat = data else { throw JSONError.NoData }
                    guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                    //print(json["id"] as! Int)
                    
                    let result = json["status"] as? String
                    
                    
                    if (result == "success"){
                        
                        print("Redirecting to Home Screen")
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.performSegueWithIdentifier("LoggedIn", sender: nil)
                        })
                        
                    } else if (result == "error: disabled account"){
                        print("error: disabled account")
                        let alert = UIAlertController(title: "Login Failed!", message:"The Account has been Disabled", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "OK", style: .Default) { _ in}
                        alert.addAction(action)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.presentViewController(alert, animated: true){}
                        })
                        
                    } else if (result == "error: invalid credentials"){
                        print("error: invalid credentials")
                        let alert = UIAlertController(title: "Login Failed!", message:"Invalid Credentials", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "OK", style: .Default) { _ in}
                        alert.addAction(action)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.presentViewController(alert, animated: true){}
                        })
                    }
                } catch let error as JSONError {
                    print(error.rawValue)
                } catch {
                    print(error)
                }
                }.resume()
        }

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

