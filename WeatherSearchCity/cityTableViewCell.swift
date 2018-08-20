import UIKit

protocol AddItemDelegate: class {
    func addItem(by controller:FirstTableViewController,messageArr:[String])
}

protocol AddTempDelegate: class{
    func addTempMax(by controller:FirstTableViewController,passingTempMax:[Int])
    func addTempMin(by controller:FirstTableViewController,passingTempMin:[Int])
    func addCityName(by controller:FirstTableViewController,passingCityName:[String])

}
class cityTableViewCell : UITableViewCell{
    
    @IBOutlet weak var CityNameLabel: UILabel!
}
