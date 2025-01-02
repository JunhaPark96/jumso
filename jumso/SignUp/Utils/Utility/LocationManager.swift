import Foundation
import CoreLocation
import MapKit
import SwiftUI

// MARK: - Annotation 모델
struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    
    @Published var currentAddress: String = "현재 위치 없음"
    @Published var annotations: [LocationAnnotation] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func geocodeAddress(_ address: String, completion: @escaping (CLLocation?, String) -> Void) {
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil, "주소 변환 실패")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                let address = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                self.annotations = [LocationAnnotation(coordinate: coordinate)]
                completion(location, address)
            }
        }
    }
    
    // 현재 위치 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            print("현재 위치 - 위도: \(latitude), 경도: \(longitude)")
            
            geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
                if let placemark = placemarks?.first {
                    self.currentAddress = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
