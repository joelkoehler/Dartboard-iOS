//
//  ViewController.swift
//  AdventureZone
//
//  Created by Joel Koehler on 12/10/20.
//  Copyright © 2020 Joel Koehler. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Foundation



struct Options {
    var radius : Int
    var unit : String
    var currLoc : CLLocationCoordinate2D
}
var startingPoint = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
var options = Options(radius: 10, unit: "mi", currLoc: startingPoint) // initialize an options struct
let annotation = MKPointAnnotation()

class ViewController: UIViewController, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var throwDartBtn: UIButton!
    let locationManager = CLLocationManager()
    var initialTrigger = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        if !initialTrigger {
            moreButton.isHidden = true
        }
        
        mapView.showsUserLocation = true
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !initialTrigger {
            if let currentLocation = locations.first {
                let mapRegion = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                mapView.setRegion(mapRegion, animated: true)
            }
        }
    }
    
    @IBAction func openSaveLocationTapped(_ sender: Any) {
        let SavedLocationController = storyboard?.instantiateViewController(identifier: "SavedLocationController")
        present(SavedLocationController!, animated: true, completion: nil)
    }
    
    
    @IBAction func optionsTapped(_ sender: Any) {
        let OptionsController = storyboard?.instantiateViewController(identifier: "OptionsController")
        present(OptionsController!, animated: true, completion: nil)
    }
    
    @IBAction func throwDartBtn(_ sender: UIButton) {
        // Todo: generate next loc and get it ready here
        if (initialTrigger) {
            mapView.removeAnnotation(annotation)
        }
        let dist = String(format: "%.2f", locGenerator()) // updates glocal currLoc with new random location in bounds
        annotation.coordinate = options.currLoc
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        initialTrigger = true
        moreButton.isHidden = false
        annotation.title = "\(dist) \(options.unit) away"
        mapView.addAnnotation(annotation)
    }
    
    func locGenerator() -> Double {

        let userLoc = locationManager.location
        var latRangeLow = 0.0
        var latRangeHigh = 0.0
        var lonRangeLow = 0.0
        var lonRangeHigh = 0.0
        
        if (options.unit == "mi") {
            latRangeLow = (userLoc?.coordinate.latitude)! - Double(options.radius)/69.00 //111
            latRangeHigh = (userLoc?.coordinate.latitude)! + Double(options.radius)/69.00 //111
            lonRangeLow = (userLoc?.coordinate.longitude)! - Double(options.radius)/69.172 //111.321
            lonRangeHigh = (userLoc?.coordinate.longitude)! + Double(options.radius)/69.172 //111.321
        }
        else {
            latRangeLow = (userLoc?.coordinate.latitude)! - Double(options.radius)/111.00
            latRangeHigh = (userLoc?.coordinate.latitude)! + Double(options.radius)/111.00
            lonRangeLow = (userLoc?.coordinate.longitude)! - Double(options.radius)/111.321
            lonRangeHigh = (userLoc?.coordinate.longitude)! + Double(options.radius)/111.321
        }
        
        print("lat low: \(latRangeLow), lat high: \(latRangeHigh), lon low: \(lonRangeLow), lon high: \(lonRangeHigh), RADIUS: \(options.radius)")
        
        var found = false
        while(!found) {
            // create random location
            var lat = 0.0
            var lon = 0.0
            lat = Double.random(in: latRangeLow ..< latRangeHigh)
            lon = Double.random(in: lonRangeLow ..< lonRangeHigh)

            let dist = distance(destLat: lat, destLon: lon, userLoc: userLoc!)
            print("DISTANCE: \(dist) in \(options.unit)")
            if dist <= Double(options.radius) {
                // todo: create 2d coordinate and update global
                let coor = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                options.currLoc = coor
                found = true
            }
            return dist
        }
        


    }
    
    func distance(destLat: Double, destLon: Double, userLoc: CLLocation) -> Double {
        
        //constants
        var r = 0
        if (options.unit == "mi") {
            r = 3961
        }
        else {
            r = 6371
        }
        
        //convert to rad
        let radCurrLat = deg2rad(userLoc.coordinate.latitude)
        let radCurrLon = deg2rad(userLoc.coordinate.longitude)
        let radDestLat = deg2rad(destLat)
        let radDestLon = deg2rad(destLon)

        // difference math
        let dlat = radDestLat - radCurrLat
        let dlon = radDestLon - radCurrLon
        
        //distance math
        let a = sin(dlat/2) * sin(dlat/2) +
            cos(radCurrLat) * cos(radDestLat) *
            sin(dlon/2) * sin(dlon/2)
        
        let c = Double( 2 * atan2(a.squareRoot(), (1-a).squareRoot()) )
        
        let d = Double(r) * c // where R is the radius of the Earth
        return d
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    @IBAction func moreButton(_ sender: UIButton) {
        
        var savedTitle = "No title given"
        
        let alertController = UIAlertController(title: "Choose what to do with this location", message: "Open location is Maps or Street View, or save it to your Saved Locations list.", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Open in Maps", style: .default, handler: { (alertAction) in
            print("Opening in maps")

            let reigionDistance : CLLocationDistance = 500
            let coordinates = options.currLoc
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: reigionDistance, longitudinalMeters: reigionDistance)
            let appearance = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
            let placemark = MKPlacemark(coordinate: coordinates)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMaps(launchOptions: appearance)
        }))

        alertController.addAction(UIAlertAction(title: "Open in Street View (If Available)", style: .default, handler: { (alertAction) in
            print("Opening in Street View")
            let urlString = "http://maps.google.com/maps?q=&layer=c&cbll=" + String(options.currLoc.latitude) + "," + String(options.currLoc.longitude)
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Save Location", style: .default, handler: { (alertAction) in
            print("Saving Location to list")
            
            //---------------------------------------------------------
            let alertEntry = UIAlertController(title: "Enter a title", message: "Name this location", preferredStyle: .alert)
            
            alertEntry.addTextField()
            alertEntry.textFields![0].placeholder = "Title"
            alertEntry.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                print("Cancelled")
            }))
            alertEntry.addAction(UIAlertAction(title: "Save", style: .default, handler: {(action) in
                savedTitle = alertEntry.textFields![0].text ?? "No title given"
                self.saveLocation(savedTitle: savedTitle)
            }))
            


            self.present(alertEntry, animated: true, completion: nil)

            //---------------------------------------------------------

            
            
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
            print("cancel")
        }))

        present(alertController, animated: true, completion: nil)


    }
    
    func saveLocation(savedTitle: String) {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newItem = ListItem(context: managedObjectContext)
        newItem.lat = options.currLoc.latitude
        newItem.lon = options.currLoc.longitude
        newItem.title = savedTitle

        //SavedLocationController.appendToList(newItem)

        do {
            try managedObjectContext.save()
            print("Saved!")
        }
        catch {
            print("Failed to save")
        }
    }
}

