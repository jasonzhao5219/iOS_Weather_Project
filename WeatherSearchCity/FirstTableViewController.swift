import UIKit
import CoreData
class FirstTableViewController: UITableViewController,AddItemDelegateTwo {
    func addItem(by controller: SecondTableViewController, messageArr: [String]) {
        
    }
    
    func addItem(by controller: FirstTableViewController, messageArr: [String]) {
        
    }
    
    //Back to start Page:
    @IBAction func BackToStartController(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //call CoreDate into context
    
    var forecastEntity:[WeatherEntity] = [WeatherEntity]()
  
    weak var delegate:AddItemDelegate?
    
    //init weather info variable
    var messageArr = ["aa"]
    
    var passingCityName:[String] = []
    var cityKey:[String] = []
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "EastPath"{
        let navigationController = segue.destination as! UINavigationController
        let SecondTableViewController = navigationController.topViewController as! SecondTableViewController
        
        SecondTableViewController.delegate = self as? AddItemDelegateTwo
     
        SecondTableViewController.cityKeyFinal.append(cityKey[0])
        
    }
    
    //Generate Tableview Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableViewCell") as! cityTableViewCell
       
        cell.CityNameLabel.text = passingCityName[0]
        
        delegate?.addItem(by: self, messageArr: messageArr)
        
        return cell
    }
    //Set Check Mark for every tableview cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    override func viewDidLoad() {
        //Key Point One:
        //send request to WEB API, to get the city localized Key
        
        //search city key from weatherAPI
        let urlSearchCity = URL(string: "http://dataservice.accuweather.com/locations/v1/cities/autocomplete.json?apikey=DEyd9EYRG39KKFs1WMiUwBDtRYLxy5FW&q=\(passingCityName[0])")
        
        
        
        let sessionSearchCity = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let taskSearchCity = sessionSearchCity.dataTask(with: urlSearchCity!, completionHandler: {
            
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                   
                    if let results = jsonResult[0] as? NSDictionary {
                        
                        let resultKey = results["Key"]! as! String
                        self.cityKey.append(resultKey)
                        //print(self.cityKey[0])
                    }
                    
                }
            } catch {
                print("here is my error message: \(error)")
            }
        })
        // execute the task and then wait for the response
        // to run the completion handler. This is async! Stuck here for a while!
        taskSearchCity.resume()
        
        
        
        
    }
    
    
    
    
    
}


