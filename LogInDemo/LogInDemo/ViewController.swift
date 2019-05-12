//
//  ViewController.swift
//  LogInDemo
//
//  Created by 大兔子殿下 on 5/11/19.
//  Copyright © 2019 大兔子殿下. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var isLogedIn = false // set the status to be unlogged in be default
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var label: UILabel!
    
    @IBOutlet var logIn: UIButton!
    @IBAction func logIn(_ sender: Any) {
        // type in the name, if already has the name loged, update
        // else, save the new name and mark as logedin
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        if isLogedIn {
            // update the username
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        result.setValue(textField.text, forKey: "name")
                        do {
                            try context.save()
                        } catch {
                            print("Update username failed!")
                        }
                    }
                    label.text = "Hi there, " + textField.text! + "!"
                }
            } catch {
                print("Update username failed")
            }
        } else {
            // if didn't logged in, save the username
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newValue.setValue(textField.text, forKey: "name")
            do {
                try context.save()
                logIn.setTitle("Update username", for: [])
                label.alpha = 1 // show the label
                label.text = "Hi there, " + textField.text! + "!"
                isLogedIn = true
                logOut.alpha = 1 // show the logout button
            } catch {
                print("fail to log in")
            }
        }
    }
    
    @IBOutlet var logOut: UIButton!
    @IBAction func logOut(_ sender: Any) {
        // remove the name in the core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                    do {
                        try context.save()
                    } catch {
                        print("failed to save the context")
                    }
                }
            }
            label.alpha = 0 // hide the welcome text
            logOut.alpha = 0 // hide the logout button
            logIn.setTitle("Log In", for: []) // set the log in button to be log in
            isLogedIn = false
            textField.alpha = 1 // show the text field for typing in the username
        } catch {
            print("failed to log out")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // check if there is user, if there is, just show logout or update username
        
        // set the appdelegate and request
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        // search the database
        do {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject] {
                // if the username exist in our database, we take it as change the user name
                if let username = result.value(forKey: "name") as? String {
                    logIn.setTitle("Update username", for: [])
                    logOut.alpha = 1 // show the logout button
                    label.alpha = 1 // show the welcome text
                    label.text = "Hi there, " + username + "!";
                    
                }
            }
        } catch {
            print("request failed!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

