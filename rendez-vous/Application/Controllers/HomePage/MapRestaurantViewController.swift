//
//  MapRestaurantViewController.swift
//  rendez-vous
//
//  Created by Thierry BRU on 15/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation
import MapKit
import AlamofireImage

class MapRestaurantViewController: RamonViewController {
    var currentRestaurant: Restaurant?

    @IBOutlet weak var restaurantTable: UITableView!    
    @IBOutlet weak var viewWithMap: MapRestaurantUIView!
    @IBOutlet weak var viewWithList: ListRestaurantUIView!
    @IBOutlet weak var switchViewMode: UISegmentedControl!
    @IBOutlet weak var restaurantCollection: UICollectionView!

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LocationManager.SharedInstance.delegate = self
        // PREPARATION VUE CARTE RESTAURANTS
        viewWithMap.currentCollection = restaurantCollection
        viewWithMap.currentMap = mapView
        // PREPARATION VUE LISTE RESTAURANTS
        
        viewWithMap.currentRestaurant = 0
        viewWithMap.currentControleur = self
        viewWithList.currentControleur = self
        
        
        restaurantCollection.layer.backgroundColor = UIColor.clear.cgColor
        self.restaurantCollection.delegate = self.viewWithMap
        self.restaurantCollection.dataSource = self.viewWithMap
        self.restaurantTable.delegate = self.viewWithList
        self.restaurantTable.dataSource = self.viewWithList
        
        // CONFIGURATION DE LA CARTE
        self.mapView.delegate = self.viewWithMap
        self.mapView.showsUserLocation = true
        self.mapView.showsScale = true
        self.mapView.showsCompass = true
        self.mapView.showsBuildings = true
        self.mapView.register(Restaurant.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Restaurant.self))
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setViewMapMode(switchViewMode)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAboutRestaurant"
        {
            let dest = segue.destination as! AboutRestaurantViewController
            dest.currentRestaurant = RendezVousApplication.getListeRestaurants()[viewWithMap.currentRestaurant]
        }
        if segue.identifier == "showCreateGroup"
        {
            self.currentRestaurant = RendezVousApplication.getListeRestaurants()[viewWithMap.currentRestaurant]
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func setViewMapMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            print("afficher la carte")
            viewWithMap.isHidden = false
            viewWithList.isHidden = true
        }
        else
        {
            print("afficher la liste")
            viewWithMap.isHidden = true
            viewWithList.isHidden = false
            restaurantTable.reloadData()
        }
    }
    
    @IBAction func onChangeViewMode(_ sender: UISegmentedControl) {
        print("onChangeViewMode")
        setViewMapMode(sender)
    }
    
}
extension MapRestaurantViewController:CLLocationManagerDelegate
{
    fileprivate func refreshRestaurantList() {
        ListeRestaurants.getListRestaurant{ (json: JSON?, error: Error?) in
            guard error == nil else {
                print("Une erreur est survenue")
                return
            }
            if let json = json {
                print(json)
                if json["returnCode"].intValue != 200
                {
                    AuthWebService.sendAlertMessage(vc: self, returnCode: json["returnCode"].intValue)
                }
                else
                {
                    RendezVousApplication.sharedInstance.listeRestaurantsProches = ListeRestaurants(json:json["data"])
                    var i = 0
                    for item in RendezVousApplication.sharedInstance.listeRestaurantsProches!.liste
                    {
                        item.indice = i
                        self.mapView.addAnnotation(item)
                        i += 1
                    }
                    print("il y a \(RendezVousApplication.getListeRestaurants().count) restaurants à afficher sur la carte")
                    self.restaurantCollection.reloadData()
                }
            }
        }
    }
    
    fileprivate func recentrageCarte() {
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: mapView!.centerCoordinate, span: span)
        mapView.region = region
        mapView.setCenter(LocationManager.SharedInstance.location!.coordinate, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        recentrageCarte()
        LocationManager.SharedInstance.stopUpdatingLocation()
        refreshRestaurantList()
    }
}


