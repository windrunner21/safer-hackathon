import UIKit
import Flutter
import GoogleMaps
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    //Add your Google Maps API Key here
    GMSServices.provideAPIKey("AIzaSyCmRV4g0sR4JYwjzHGg-AmISbCjAVi42P0")
    GeneratedPluginRegistrant.register(with: self)
    WorkmanagerPlugin.register(with: self.registrar(forPlugin: "be.tramckrijte.workmanager.WorkmanagerPlugin")!)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(5))



        return true
    //return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}