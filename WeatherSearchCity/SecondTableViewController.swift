import UIKit
import CoreData
class SecondTableViewController: UITableViewController {
    
    @IBAction func AddBarPressed(_ sender: UIBarButtonItem) {
        
    }
    
    var weather:[String] = []
    var weatherTempMax:[Int] = []
    var weatherTempMin:[Int] = []
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //call CoreDate into context
    
    var forecastEntity:[WeatherEntity] = [WeatherEntity]()
   
    weak var delegate:AddItemDelegateTwo?
    
    
    var messageArrInSecond = ["aa","bb","cc"]

    var cityKeyFinal:[String] = []
    
    //segue, pass value
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        let navigationController = segue.destination as! UINavigationController
        let ResultTableViewController = navigationController.topViewController as! ResultTableViewController
        
        ResultTableViewController.delegate = self as? AddItemDelegateThree
        ResultTableViewController.resultTempMax = weatherTempMax
        ResultTableViewController.resultTempMin = weatherTempMin
        ResultTableViewController.resultWeather = weather
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell") as! weatherTableViewCell
       
        
        
        delegate?.addItem(by: self, messageArr: messageArrInSecond)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArrInSecond.count
    }
    
    override func viewDidLoad() {
        
        //to save HTTP data into weather
        
        // specify the url that we will be sending the GET request to
        let url = URL(string: "http://dataservice.accuweather.com/forecasts/v1/daily/1day/\(cityKeyFinal[0]).json?apikey=DEyd9EYRG39KKFs1WMiUwBDtRYLxy5FW")
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    print(jsonResult)
                    
                    
                    //downcast jason data to get weather description
                    if let results = jsonResult["Headline"]{
                        
                        let resultsDictionaryOne = results as! NSDictionary
                        
                        
                        if let resultsWeatherDescription = resultsDictionaryOne["Text"]{
                            self.weather.append(resultsWeatherDescription as! String)
                            print(self.weather[0])
                        }
                        
                        
                    }
                    //downcast jason data to get max/min temperature
                    if let resultsTempOne = jsonResult["DailyForecasts"]{
                        let resultsArrayOne = resultsTempOne as! NSArray
                        
                        let resultTemp = resultsArrayOne[0] as!NSDictionary
                        
                        
                        let resultTempInside = resultTemp["Temperature"] as!NSDictionary
                        
                        //print("curr test: \(resultTempInside["Maximum"])")
                        let  resultTempMax = resultTempInside["Maximum"]
                        let  resultTempMin = resultTempInside["Minimum"]
                        let resultTempMaxValue = resultTempMax as! NSDictionary
                        let resultTempMinValue = resultTempMin as! NSDictionary
                        
                        
                        
                        self.weatherTempMax.append(Int(truncating: resultTempMaxValue["Value"] as! NSNumber))
                        
                        self.weatherTempMin.append(Int(truncating: resultTempMinValue["Value"] as! NSNumber))
                        
                    }
                    
                }
            } catch {
                print(error)
            }
        })
        
       
        task.resume()
        
        //Core Data, I did not use it, but feel it is neccessary for furthur step
        let thing = NSEntityDescription.insertNewObject(forEntityName: "WeatherEntity", into: managedObjectContext) as! WeatherEntity
        thing.weatherdescription = self.messageArrInSecond[0]
        
        
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
               
            } catch {
                print("\(error)")
            }
        }
        //fetch
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        do {
            // get the results by executing the fetch request we made earlier
            let results = try managedObjectContext.fetch(itemRequest)
            
            // downcast the results as an array of AwesomeEntity objects
            forecastEntity = results as! [WeatherEntity]
            
            //Delete(After delete, should save)
            //managedObjectContext.delete(items[3] as NSManagedObject)
            try managedObjectContext.save()
            //Use a loop to Update
            for item in forecastEntity {
                
                print("\(item.weatherdescription)")
            }
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        
    }
    
    
    
    
    
}
