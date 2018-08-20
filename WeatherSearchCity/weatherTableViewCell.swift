import UIKit
protocol AddItemDelegateTwo: class {
    func addItem(by controller:SecondTableViewController,messageArr:[String])
}

protocol AddTempDelegateTwo: class{
    func addTempMax(by controller:SecondTableViewController,passingTempMax:[Int])
    func addTempMin(by controller:SecondTableViewController,passingTempMin:[Int])
    func addCityName(by controller:SecondTableViewController,passingCityName:[String])

}
class weatherTableViewCell : UITableViewCell{
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
}
