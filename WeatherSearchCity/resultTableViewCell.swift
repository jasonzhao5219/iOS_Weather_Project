import UIKit
protocol AddItemDelegateThree: class {
    func addItem(by controller:ResultTableViewController,messageArr:[String])
}

protocol AddTempDelegateThree: class{
    func addTempMax(by controller:ResultTableViewController,resultTempMax:[Int])
    func addTempMin(by controller:ResultTableViewController,resultTempMin:[Int])
    func addCityName(by controller:ResultTableViewController,resultCityName:[String])
    
}
class resultTableViewCell : UITableViewCell{
    
   
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var TempMaxLabel: UILabel!
    @IBOutlet weak var TempMinLabel: UILabel!
    
}
