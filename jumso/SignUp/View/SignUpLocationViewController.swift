import UIKit
import MapKit
import CoreLocation

class SignUpLocationViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    private var mapView: MKMapView!
    private var locationManager: CLLocationManager!
    private var geocoder = CLGeocoder()
    
    
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var LocationInputTextField: UITextField!
    @IBOutlet weak var LocationMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CLLocationManager 설정
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 사용자에게 위치 권한 요청
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 텍스트 필드 델리게이트 설정
        LocationInputTextField.delegate = self
    }
    
    // 현재 위치를 업데이트 받는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            print("현재 위치 - 위도: \(latitude), 경도: \(longitude)")
            // 지도를 현재 위치로 이동
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            LocationMapView.setRegion(region, animated: true)
            // 현재 위치 표시
            LocationMapView.showsUserLocation = true
            
            // 현재 위치 주소 가져오기
            geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                if let placemark = placemarks?.first {
                    let address = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                    self.LocationLabel.text = "현재 위치: \(address)"
                }
            }
        }
    }
    
    // 권한 거부 시 메시지 표시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    // 텍스트 필드에서 Return 키를 눌렀을 때 주소를 검색
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let address = textField.text {
            geocodeAddress(address)
        }
        
        return true
    }
    
    // 주소를 좌표로 변환하고 지도 이동
    func geocodeAddress(_ address: String) {
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                
                
                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                print("입력된 주소 좌표 - 위도: \(latitude), 경도: \(longitude)")
                // 지도 이동
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                strongSelf.LocationMapView.setRegion(region, animated: true)
                
                // 좌표 정보 표시
                strongSelf.LocationLabel.text = "선택된 위치: \(placemark.locality ?? ""), \(placemark.country ?? "")"
            }
        }
    }
}
