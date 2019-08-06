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
    
    @IBOutlet weak var restaurantTable: RestaurantTableView!
    @IBOutlet weak var viewWithMap: MapRestaurantView!
    @IBOutlet weak var viewWithList: ListRestaurantView!
    @IBOutlet weak var switchViewMode: UISegmentedControl!
    @IBOutlet weak var restaurantCollection: RestaurantCollectionView!
    
    @IBOutlet weak var mapView: RestaurantMapView!
    override func viewDidLoad() {
        print("MapRestaurantViewController:viewDidLoad")
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
        
        // abonnement des listes, tables, collections et maps aux changements éventuyels de la liste de restaurants
        ListeRestaurants.subscribe(vue: self.restaurantTable)
        ListeRestaurants.subscribe(vue: self.restaurantCollection)
        ListeRestaurants.subscribe(vue: self.mapView)
        
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
        print("MapRestaurantViewController:viewWillAppear")
        setViewMapMode(switchViewMode)
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewWillDisappear")
        print(self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("MapRestaurantViewController:viewDidDisappear")
        print(self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("MapRestaurantViewController:prepare (\(String(describing: segue.identifier)))")
        if segue.identifier == "showAboutRestaurant"
        {
            let dest = segue.destination as! AboutRestaurantViewController
            dest.currentRestaurant = ListeRestaurants.sharedInstance!.liste[viewWithMap.currentRestaurant]
        }
        if segue.identifier == "showCreateGroup"
        {
            Restaurant.sharedInstance = ListeRestaurants.sharedInstance!.liste[viewWithMap.currentRestaurant]
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
        print("MapRestaurantViewController:setViewMapMode")
        if sender.selectedSegmentIndex == 0
        {
            print("-> afficher la carte")
            viewWithMap.isHidden = false
            viewWithList.isHidden = true
        }
        else
        {
            print("->afficher la liste")
            viewWithMap.isHidden = true
            viewWithList.isHidden = false
            restaurantTable.reloadData()
        }
    }
    
    @IBAction func onChangeViewMode(_ sender: UISegmentedControl) {
        print("MapRestaurantViewController:onChangeViewMode")
        setViewMapMode(sender)
    }
    
}
extension MapRestaurantViewController:CLLocationManagerDelegate
{
    
    fileprivate func recentrageCarte() {
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: mapView!.centerCoordinate, span: span)
        mapView.region = region
        mapView.setCenter(LocationManager.SharedInstance.location!.coordinate, animated: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        recentrageCarte()
        LocationManager.SharedInstance.stopUpdatingLocation()
      //  ListeRestaurants.load(controleur: self)
        Restaurant.load(datasource: self, latitude: LocationManager.SharedInstance.location!.coordinate.latitude, longitude: LocationManager.SharedInstance.location!.coordinate.longitude, range: 10)
    }
}
extension MapRestaurantViewController:RestaurantDataSource
{
    func restaurantOnLoaded(restaurants: ListeRestaurants) {
        print("MapRestaurantViewController:RestaurantDataSource:restaurantOnLoaded(LISTE)")
        ListeRestaurants.sharedInstance = restaurants
        ListeRestaurants.reloadViews()
    }
    
    func restaurantOnLoaded(restaurant: Restaurant) {
        print("MapRestaurantViewController:RestaurantDataSource:restaurantOnLoaded(UN) NOT IMPLENTED")
    }
    
    func restaurantOnNotFoundRestaurant() {
        print("MapRestaurantViewController:RestaurantDataSource:restaurantOnNotFoundRestaurant NOT IMPLENTED")
    }
    
    func restaurantOnWebServiceError(code: Int) {
        print("MapRestaurantViewController:RestaurantDataSource:restaurantOnWebServiceError NOT IMPLENTED")
    }
    
    
}


