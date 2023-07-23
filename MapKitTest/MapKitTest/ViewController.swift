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
        private var bottomSheetView: BottomSheetView?

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
                let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
                mapView.setRegion(region, animated: true)

                // 50미터 반경의 동그라미를 그리기 위해 코드 추가
                let circle = MKCircle(center: userLocation, radius: 50)
                mapView.addOverlay(circle)

                // 바텀 시트를 생성하고 지도 아래에 추가
                bottomSheetView = BottomSheetView()
                view.addSubview(bottomSheetView!)
                bottomSheetView?.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(200) // 바텀 시트의 높이 설정
                    make.bottom.equalTo(view.safeAreaLayoutGuide) // 바텀 시트를 지도 아래에 위치
                }
            }
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
class BottomSheetView: UIView {

    // 여기에 바텀 시트에 들어갈 컨텐츠나 레이아웃을 구성합니다.
    // 예시로 "바텀 시트 내용"이라는 레이블을 추가하겠습니다.
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "바텀 시트 내용"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 바텀 시트의 배경색과 모서리를 설정합니다.
        backgroundColor = .white
        layer.cornerRadius = 16

        // 컨텐츠 레이블을 바텀 시트에 추가합니다.
        addSubview(contentLabel)

        // SnapKit을 사용하여 컨텐츠 레이블을 바텀 시트에 레이아웃합니다.
        contentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
