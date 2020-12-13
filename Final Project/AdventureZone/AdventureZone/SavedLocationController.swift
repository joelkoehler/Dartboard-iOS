//
//  SavedLocationController.swift
//  AdventureZone
//
//  Created by Joel Koehler on 12/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreData

class SavedLocationController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list = [ListItem]()
    @IBOutlet weak var table: UITableView!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
         //load in data
        let listItemFetchRequest:NSFetchRequest = ListItem.fetchRequest()
        do{
            let fetchResults = try managedObjectContext.fetch(listItemFetchRequest)

            if( fetchResults.count > 0 ){

                //print(fetchResults)

                for item in fetchResults {
                    list.append(item as! ListItem)
                }

            }
            else{
                // TODO: Nothing, handle it
            }
        }
        catch{
            print(exception.self)
        }
        
        
        //print(list)
        
        self.table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addItem))
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
            cell.textLabel?.text = self.list[indexPath.row].title
            //cell.backgroundColor = UIColor.lightGray;

            //print(indexPath.row)
            
            //let item = list[indexPath.row]
            
            //let fetchResults = fetchedResultsController.object(at: indexPath)
            //cell.textLabel?.text = item.value(forKey: "title") as? String
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            

            print("you tapped on cell # \(indexPath.row)")
            
            let alertController = UIAlertController(title: "Choose what to do with this location", message: "Open location is Maps or Street View", preferredStyle: .actionSheet)
            
            alertController.addAction(UIAlertAction(title: "Open in Maps", style: .default, handler: { (alertAction) in
                print("Opening in maps")
                let reigionDistance : CLLocationDistance = 500
                
                var coordinates = options.currLoc // temporarily
                var found = false
                let listItemFetchRequest:NSFetchRequest = ListItem.fetchRequest()
                do{
                    let fetchResults = try self.managedObjectContext.fetch(listItemFetchRequest)

                    if( fetchResults.count > 0 ){
                        for item in fetchResults {
                            if (item as! ListItem).title ==                         self.list[indexPath.row].title && !found {
                                coordinates.latitude = (item as! ListItem).lat
                                coordinates.longitude = (item as! ListItem).lon
                                found = true
                            }
                        }

                    }
                    else{
                        // TODO: Nothing, handle it
                    }
                }
                catch{
                    print(exception.self)
                }
                
                let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: reigionDistance, longitudinalMeters: reigionDistance)
                let appearance = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                let placemark = MKPlacemark(coordinate: coordinates)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.openInMaps(launchOptions: appearance)
            }))

            alertController.addAction(UIAlertAction(title: "Open in Street View (If Available)", style: .default, handler: { (alertAction) in
                print("Opening in Street View")
                
                var coordinates = options.currLoc // temporarily
                var found = false
                let listItemFetchRequest:NSFetchRequest = ListItem.fetchRequest()
                do{
                    let fetchResults = try self.managedObjectContext.fetch(listItemFetchRequest)

                    if( fetchResults.count > 0 ){
                        for item in fetchResults {
                            if (item as! ListItem).title ==                         self.list[indexPath.row].title && !found {
                                coordinates.latitude = (item as! ListItem).lat
                                coordinates.longitude = (item as! ListItem).lon
                                found = true
                            }
                        }

                    }
                    else{
                        // TODO: Nothing, handle it
                    }
                }
                catch{
                    print(exception.self)
                }
                
                let urlString = "http://maps.google.com/maps?q=&layer=c&cbll=" + String(coordinates.latitude) + "," + String(coordinates.longitude)
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }))

            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                print("cancel")
            }))

            self.present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}


//// Initialize Fetch Request
//let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListItem")
//
//// Configure Fetch Request
//fetchRequest.includesPropertyValues = false
//
//do {
//    let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
//
//    for item in items {
//        managedObjectContext.delete(item)
//    }
//
//    // Save Changes
//    try managedObjectContext.save()
//
//} catch {
//    // Error Handling
//    // ...
//}
