//
//  ViewController.swift
//  WeatherSearchCity
//
//  Created by Jason Zhao on 8/19/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//



    import UIKit
    import CoreData
    class MainViewController: UIViewController,AddItemDelegate{
        func addItem(by controller: FirstTableViewController, messageArr: [String]) {
            
        }
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        

        
        @IBOutlet weak var CityNameField: UITextField!
        
        
        @IBAction func AddItemPressed(_ sender: UIButton) {
            
        }
        weak var delegate:AddItemDelegate?
        
        
        
        //init weather info
      
        var cityname:[String] = []
        
        var cityKey:[String] = []
        
        
        //use segue to pass city name value to next page
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let navigationController = segue.destination as! UINavigationController
            let FirstTableViewController = navigationController.topViewController as! FirstTableViewController
            
            FirstTableViewController.delegate = self as? AddItemDelegate
           
            FirstTableViewController.passingCityName.append(CityNameField.text!)
            
           
        }
        override func viewDidLoad() {
            super.viewDidLoad()
        
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
       
    }





