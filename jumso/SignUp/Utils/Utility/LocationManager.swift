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
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private var locationCompletion: ((CLLocation?, String?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestLocationPermission()
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func requestLocation(completion: @escaping (CLLocation?, String?) -> Void) {
        self.locationCompletion = completion
        locationManager.requestLocation()
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            self.authorizationStatus = status
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                print("✅ 위치 서비스가 허용되었습니다.")
            case .denied, .restricted:
                print("❌ 위치 서비스가 거부되었습니다.")
            default:
                break
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
                    let address = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                    self.currentAddress = address
                    self.annotations = [LocationAnnotation(coordinate: userLocation.coordinate)]
                    self.locationCompletion?(userLocation, address) // 위치와 주소 전달
                    self.locationCompletion = nil
                } else {
                    self.locationCompletion?(userLocation, nil)
                    self.locationCompletion = nil
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
        self.locationCompletion?(nil, nil)
        self.locationCompletion = nil
    }
}
