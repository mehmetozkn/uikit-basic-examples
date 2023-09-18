//
//  ViewController.swift
//  MapsApp
//
//  Created by Mehmet Özkan on 17.09.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var noteTextField: UITextField!

    var locationManager = CLLocationManager()
    var selectedLatitude = Double()
    var selectedLongitude = Double()

    var selectedName = ""
    var selectedId: UUID?

    var annotationTitle = ""
    var annotationSubTitle = ""
    var annotationLat = Double()
    var annotationLong = Double()


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(setMyLocation(gestureRecognizer:)))

        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)

        if selectedName != "" {
            if let uuidString = selectedId?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext

                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false

                do {
                    let results = try context.fetch(fetchRequest)

                    if results.count > 0 {

                        for result in results as! [NSManagedObject] {

                            if let name = result.value(forKey: "name") as? String {
                                annotationTitle = name

                                if let note = result.value(forKey: "note") as? String {
                                    annotationSubTitle = note

                                    if let lat = result.value(forKey: "lat") as? Double {
                                        annotationLat = lat

                                        if let long = result.value(forKey: "long") as? Double {
                                            annotationLong = long

                                            let annotation = MKPointAnnotation()
                                            annotation.title = annotationTitle
                                            annotation.subtitle = annotationSubTitle
                                            let coordinate = CLLocationCoordinate2D(latitude: annotationLat, longitude: annotationLong)
                                            annotation.coordinate = coordinate
                                            mapView.addAnnotation(annotation)
                                            nameTextField.text = annotationTitle
                                            noteTextField.text = annotationSubTitle

                                            locationManager.stopUpdatingLocation()

                                            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) // camera zoom
                                            let region = MKCoordinateRegion(center: coordinate, span: span)
                                            mapView.setRegion(region, animated: true)

                                        }

                                    }
                                }


                            }

                        }
                    }

                } catch {

                }
            }
        } else {

        }

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print(locations[0].coordinate.latitude)
        if selectedName == "" {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude
                , longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) // camera zoom
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }

    }

    @objc func setMyLocation(gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

            selectedLatitude = touchCoordinate.latitude
            selectedLongitude = touchCoordinate.longitude

            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinate
            annotation.title = nameTextField.text
            annotation.subtitle = noteTextField.text
            mapView.addAnnotation(annotation)
        }

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let annotationId = "MyAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationId)
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationId)
            pinView?.canShowCallout = true
            pinView?.tintColor = .blue
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
            
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if selectedName != "" {
            var requestLocation = CLLocation(latitude: annotationLat, longitude: annotationLong)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarkArray, error) in
                if let placemarks = placemarkArray {
                    if placemarks.count > 0 {
                        let newPlacemark = MKPlacemark(placemark: placemarks[0])
                        let item = MKMapItem(placemark: newPlacemark)
                        
                        item.name = self.annotationTitle
                        
                        let launcOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        
                        item.openInMaps(launchOptions: launcOptions)
                        
                        
                    }
                }
                
            }
            
        }
    }

    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Place", into: context)

        newPlace.setValue(nameTextField.text, forKey: "name")
        newPlace.setValue(noteTextField.text, forKey: "note")
        newPlace.setValue(selectedLatitude, forKey: "lat")
        newPlace.setValue(selectedLongitude, forKey: "long")
        newPlace.setValue(UUID(), forKey: "id")

        do {
            try context.save()
            print("kayıt edildi")
        } catch {
            print("hata")
        }

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPlaceCreated"), object: nil)
        self.navigationController?.popViewController(animated: true)

    }

}

