import SwiftUI
import MapKit
import CoreLocation

struct SignUpLocationView: View {
    // MARK: - 상태 변수
    @State private var isButtonEnabled: Bool = true
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    @State private var searchAddress: String = ""
    @State private var selectedLocation: String = "선택된 위치 없음"
    @State private var currentLocation: String = "현재 위치 없음"
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 기본 서울 좌표
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    
    @StateObject private var locationManager = LocationManager()
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 5
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
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
                                MapPin(coordinate: item.coordinate, tint: .red)
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
                            
                            Text("🏢 선택된 위치: \(selectedLocation)")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .padding(.horizontal, 16)
                            
                            Spacer()
                        } // VStack end
                        
                    } // GeometryReader end
                    

                }
                VStack {
                    Spacer()
                    SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                        handleNextButtonTap()
                    }
                    .disabled(!isButtonEnabled)
                    .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                    .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpIntroductionView()
                }
                
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
            
            .onDisappear {
                // 키보드 관찰자 해제
                KeyboardObserver.shared.stopListening()
            }
            
        }
    }
    
    
    // MARK: - 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
}



struct SignUpLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpLocationView()
    }
}
