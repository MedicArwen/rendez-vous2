//
//  MapRestaurantUIView.swift
//  rendez-vous
//
//  Created by Thierry BRU on 18/07/2019.
//  Copyright © 2019 Ramon Technologies. All rights reserved.
//

import UIKit
import MapKit

class MapRestaurantView: UIView {
    var currentRestaurant = 0
    var currentCollection :UICollectionView?
    var currentMap : MKMapView?
    var currentControleur: UIViewController?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension MapRestaurantView:MKMapViewDelegate
{
    fileprivate func returnImageMapPinLitteral(_ restau: Restaurant)->UIImage {
        if restau.indice == self.currentRestaurant
        {
            return #imageLiteral(resourceName: "pinRestaurantActive")
        }
        else
        {
            return #imageLiteral(resourceName: "pinRestaurant")
        }
    }
    
    fileprivate func getAndUpdateAnotationView(_ mapView: MKMapView, _ annotation: MKAnnotation) -> MKAnnotationView? {
        print("getAndUpdateAnotationView")
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: "id")
        if av == nil {
            av = MKAnnotationView(annotation: annotation, reuseIdentifier: "id")
        }
        if av == nil
        {
            return nil
        }
        let restau = annotation as! Restaurant
        print("Construction de la view n°\(restau.indice) du restaurant \(restau.idRestaurant)")
        av!.canShowCallout = true
        
        
        // Provide the annotation view's image.
        let image = returnImageMapPinLitteral(restau)
        // Offset the flag annotation so that the flag pole rests on the map coordinate.
        let offset = CGPoint(x: image.size.width / 2, y: -(image.size.height / 2) )
        av!.centerOffset = offset
        av!.image = image
        av!.isSelected = true
        return av!
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("mapView viewFor")
        if annotation is MKUserLocation
        {
            return nil
        }
        return getAndUpdateAnotationView(mapView, annotation)
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("mapView-DidSelect")
        if view.annotation is MKUserLocation
        {
            print ("user location")
        }
        else{
            let restau = view.annotation as! Restaurant
            print("select le restaurant n°\(restau.indice) - id:\(restau.idRestaurant)")
            if currentRestaurant != restau.indice
            {
                print("CHANGEMENT DE RESTAURANT SELECTIONNE du \(self.currentRestaurant) au \(restau.indice)")
                currentRestaurant = restau.indice
                forceUpdateMapPin()
            }
            view.isSelected = true
            currentCollection!.scrollToItem(at: IndexPath(item: restau.indice, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            //restaurantCollection.reloadData()
        }
    }
    fileprivate func forceUpdateMapPin() {
        print("forceUpdateMapPin()")
        var saveList = [MKAnnotation]()
        for item in currentMap!.annotations
        {
            saveList.append(item)
        }
        currentMap!.removeAnnotations(saveList)
        currentMap!.addAnnotations(saveList)
    }
}
extension MapRestaurantView:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RendezVousApplication.getListeRestaurants().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("update the cell n°#\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCollectionViewCell
        cell.update(restaurant: RendezVousApplication.getListeRestaurants()[indexPath.row],controleur:self.currentControleur!)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("collectionView-didSelectItemAt")
        if self.currentRestaurant != indexPath.row
        {
            let deltaLat = abs(LocationManager.SharedInstance.location!.coordinate.latitude - RendezVousApplication.getListeRestaurants()[indexPath.row].coordinate.latitude) * 2.25
            let deltaLon = abs(LocationManager.SharedInstance.location!.coordinate.longitude - RendezVousApplication.getListeRestaurants()[indexPath.row].coordinate.longitude) * 2.25
            let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLat, longitudeDelta: deltaLon)
            let region : MKCoordinateRegion = MKCoordinateRegion(center: self.currentMap!.centerCoordinate, span: span)
            self.currentMap!.region = region
            print("recentrage de la carte aux positions lat:\(RendezVousApplication.getListeRestaurants()[indexPath.row].coordinate.latitude) +-\(deltaLat)  long,\(RendezVousApplication.getListeRestaurants()[indexPath.row].coordinate.longitude) +-\(deltaLon)  ")
            self.currentMap!.setCenter(RendezVousApplication.getListeRestaurants()[indexPath.row].coordinate, animated: true)
            self.currentRestaurant = indexPath.row
            forceUpdateMapPin()
        }
    }
}
