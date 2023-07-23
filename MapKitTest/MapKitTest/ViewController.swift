//
//  ViewController.swift
//  MapKitTest
//
//  Created by 박다미 on 2023/07/23.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let myLocationButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 지도 뷰 설정
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        // 위치 관리자 설정
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 위치 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        // SnapKit을 사용하여 레이아웃 설정
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 내 위치로 이동하는 버튼 설정
        myLocationButton.setTitle("내 위치", for: .normal)
        myLocationButton.setTitleColor(.white, for: .normal)
        myLocationButton.backgroundColor = .blue
        myLocationButton.layer.cornerRadius = 8.0
        myLocationButton.addTarget(self, action: #selector(showMyLocation), for: .touchUpInside)
        
        view.addSubview(myLocationButton)
        myLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - 내 위치로 이동하는 액션
    
    @objc private func showMyLocation() {
        if let userLocation = mapView.userLocation.location?.coordinate {
                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 500, longitudinalMeters: 500)

                mapView.setRegion(region, animated: true)
            mapView.removeOverlays(mapView.overlays)

                // 100미터 반경의 동그라미를 그리기 위해 코드 추가
                let circle = MKCircle(center: userLocation, radius: 100)
                mapView.addOverlay(circle)
                
                // 원 안에 있는 장소들 검색하여 표시
                searchPlacesWithinCircle(center: userLocation, radius: 100)
            }
    }
    private func searchPlacesWithinCircle(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        // 기존에 표시된 장소들을 지도에서 제거
        mapView.removeAnnotations(mapView.annotations)
        
        // MKLocalSearchRequest 생성
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "cafe" // 검색할 장소 종류
        let region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
            request.region = region
        
        // MKLocalSearch 객체 생성
        let search = MKLocalSearch(request: request)
        
        // 장소 검색 시작
        search.start { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Error searching places: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
//            // 검색 결과 중 장소들을 지도에 표시
//            for item in response.mapItems {
//                self.addAnnotationToMap(item)
//              //  print(item)
//            }
            // 검색 결과 중 원 안에 있는 카페들을 지도에 표시
                  for item in response.mapItems {
                      let itemLocation = CLLocation(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                      let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
                      let distance = centerLocation.distance(from: itemLocation)
                      print(distance)
                      print(radius)
                      if distance <= radius {
                          self.addAnnotationToMap(item)
                      }
                  }

            // 검색된 장소들을 바텀 시트에 표시
            
            self.showPlacesInBottomSheet(response.mapItems)
        }
    }

    // 장소를 지도에 표시하는 메서드
    private func addAnnotationToMap(_ mapItem: MKMapItem) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapItem.placemark.coordinate
        annotation.title = mapItem.name
        print(annotation.title)
        mapView.addAnnotation(annotation)
    }

    // 검색된 장소들을 바텀 시트에 표시하는 메서드
    private func showPlacesInBottomSheet(_ places: [MKMapItem]) {
    }
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 위치 업데이트를 받았을 때 호출되는 메서드
        if let location = locations.last {
            // 위치를 가져왔을 때, 지도 중심을 해당 위치로 이동
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 위치 권한이 변경되었을 때 호출되는 메서드
        if status == .authorizedWhenInUse {
            // 위치 권한이 허용된 경우, 내 위치 업데이트 시작
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 위치 업데이트 실패 시 호출되는 메서드
        print("Location manager error: \(error.localizedDescription)")
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circleOverlay)
            circleRenderer.fillColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3) // 동그라미 내부 색상
            circleRenderer.strokeColor = UIColor.blue // 동그라미 테두리 색상
            circleRenderer.lineWidth = 1 // 동그라미 테두리 두께
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
