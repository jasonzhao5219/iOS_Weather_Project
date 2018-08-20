//
//  File.swift
//  WeatherSearchCity
//
//  Created by Jason Zhao on 8/19/18.
//  Copyright © 2018 Jason Zhao. All rights reserved.
//

import UIKit
import CoreData
class ResultTableViewController: UITableViewController,AddItemDelegateThree {
    func addItem(by controller: ResultTableViewController, messageArr: [String]) {
        
    }
    
    var messageArrInResult = ["aa"]
    var resultTempMax = [1]
    var resultTempMin = [1]
    var resultCityName:[String] = []
    var resultWeather:[String] = ["aa"]
    
    weak var delegate:AddItemDelegateThree?
    
    //genereate table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultTableViewCell") as! resultTableViewCell
        
        //cell.DescripLabel.text = String(passingTempMax[indexPath.row])
        cell.WeatherLabel.text = resultWeather[0]
        cell.TempMinLabel.text = String(resultTempMin[0])
        cell.TempMaxLabel.text = String(resultTempMax[0])
        
        delegate?.addItem(by: self, messageArr: messageArrInResult)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArrInResult.count
    }
    
    override func viewDidLoad() {
        print("the min temp in result tableviewcontroller is : \(self.resultTempMin[0])")
    }
    
}
