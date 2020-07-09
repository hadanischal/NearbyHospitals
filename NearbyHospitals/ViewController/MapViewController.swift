//
//  MapViewController.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 1/7/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//
// https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started

import MapKit
import RxCocoa
import RxSwift
import UIKit

final class MapViewController: UIViewController, BaseViewProtocol {
    @IBOutlet private var mapView: MKMapView!
    private var viewModel: MapDataSource!
    private let disposeBag = DisposeBag()

    convenience init(withDataSource dataSource: MapDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func presentMapVC(withDataSource dataSource: MapDataSource) -> MapViewController {
        let viewController = StoryboardScene.Main.mapViewController.instantiate()
        viewController.viewModel = dataSource
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupViewModel()
        loadInitialData()
    }

    private func setUpUI() {
        viewModel.navigationTitle.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        navigationItem.backBarButtonItem = navigationController?.backBarButtton
    }

    private func setupViewModel() {
        viewModel.viewDidLoad()
    }

    /// Set initial location
    private func loadInitialData() {
        guard let location = viewModel.initialLocation else { return }
        let initialLocation = CLLocation(latitude: location.lat, longitude: location.lng)

        mapView.centerToLocation(initialLocation)

        let region = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 50000, longitudinalMeters: 60000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)

        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200_000)
        mapView.setCameraZoomRange(zoomRange, animated: true)

        mapView.delegate = self

        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.addAnnotations(viewModel.mapInfoList)
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 11000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let mapInfo = view.annotation as? MapModel else { return }
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapInfo.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}
