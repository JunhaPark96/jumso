import SwiftUI
import MapKit
import CoreLocation

struct SignUpLocationView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    // MARK: - 상태 변수
    @State private var isButtonEnabled: Bool = true
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    @State private var searchAddress: String = ""
    @State private var selectedLocation: String = "검색한 위치가 여기에 표시됩니다."
    @State private var currentLocation: String = "현재 위치위치를 가져오는중.."
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 기본 서울 좌표
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    
    @StateObject private var locationManager = LocationManager()
    private let defaultSelectedLocation = "검색한 위치가 여기에 표시됩니다."
    
    // ProgressBar 상태
    private let currentSignUpStep = SignUpStep.allCases.firstIndex(of: .location) ?? 0
    
    var body: some View {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(SignUpStep.allCases.count))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 30)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 20){
                            SignUpHeaderView(title: "내 회사 위치는")
                            
                            // 검색 필드
                            HStack {
                                TextField("회사 위치를 입력하세요", text: $searchAddress)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.leading, 10)
                                
                                Button(action: {
                                    locationManager.geocodeAddress(searchAddress) { location, address in
                                        if let location = location {
                                            region.center = location.coordinate
                                            selectedLocation = address
                                            registerViewModel.currentAddress = address
                                            registerViewModel.currentCoordinates = location.coordinate
                                            registerViewModel.logCurrentSignUpData() // 로그 출력
                                        } else {
                                            selectedLocation = "주소를 찾을 수 없습니다."
                                            print("❌ 검색 실패")
                                        }
                                    }
                                }) {
                                    Text("검색")
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 8)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                        .padding(.trailing, 10)
                                }
                            } // Hstack end
                            
                            // 지도 뷰
                            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: locationManager.annotations) { item in
                                MapMarker(coordinate: item.coordinate, tint: .red)
                            }
                            .frame(height: 300)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding(.horizontal, 16)
                            
                            // 현재 위치
                            Text("📍 내 위치: \(currentLocation)")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .padding(.horizontal, 16)
                            
                            Text("🏢 선택된 위치: \(selectedLocation.isEmpty ? defaultSelectedLocation : selectedLocation)")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .padding(.horizontal, 16)
                            
                            Spacer()
                        } // VStack end
                        .padding(.top, 30)
                        
                    } // GeometryReader end
                    

                }
                VStack {
                    Spacer()
                    SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                        registerViewModel.navigationPath.append(NavigationStep.introduction.rawValue)
                    }
                    .disabled(!isButtonEnabled)
                    .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                    .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                
            } // 가장 바깥쪽 Vstack
            .onTapGesture {
                keyboardManager.hideKeyboard()
            }
            
            .onAppear {
                // 키보드 관찰자 시작
                KeyboardObserver.shared.startListening { height in
                    SignUpDebugLog.debugLog("키보드 높이 업데이트: \(height)")
                    //                    print("키보드 높이 업데이트: \(height)")
                    withAnimation(.easeOut(duration: 0.3)){
                        keyboardHeight = height
                    }
                }
            }
            .onAppear {
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.requestLocation { location, address in
                        if let location = location, let address = address {
                            region.center = location.coordinate
                            currentLocation = address
                            registerViewModel.currentAddress = address
                            registerViewModel.currentCoordinates = location.coordinate
                            registerViewModel.logCurrentSignUpData()
                        } else {
                            print("❌ 위치 정보를 가져올 수 없습니다.")
                        }
                    }
                } else {
                    print("❌ 위치 서비스가 비활성화되었습니다.")
                }
            }
//            .onAppear {
//                if CLLocationManager.locationServicesEnabled() {
//                    if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
//                        locationManager.requestLocation { location, address in
//                            if let location = location, let address = address {
//                                region.center = location.coordinate
//                                currentLocation = address
//                                registerViewModel.currentAddress = address
//                                registerViewModel.currentCoordinates = location.coordinate
//                                registerViewModel.logCurrentSignUpData()
//                            } else {
//                                print("❌ 위치 정보를 가져올 수 없습니다.")
//                            }
//                        }
//                    } else if locationManager.authorizationStatus == .notDetermined {
//                        locationManager.requestLocationPermission()
//                    } else {
//                        print("❌ 위치 서비스가 비활성화되었습니다.")
//                    }
//                } else {
//                    print("❌ 위치 서비스가 비활성화되었습니다.")
//                }
//            }

            .onDisappear {
                // 키보드 관찰자 해제
                KeyboardObserver.shared.stopListening()
            }
    }
}



//struct SignUpLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpLocationView()
//    }
//}
