//
//  AppDelegate.swift
//  AnimFy
//
//  Created by António Bastião on 10.01.21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let injector = AppInjector()

    var mangaRepository: MangaRepository {
        get {
            injector.mangaRepository
        }
    }

    var animeRepository: AnimeRepository {
        get {
            injector.animeRepository
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    func loadDataController() {
        injector.dataController.load()
    }

    // MARK: - Core Data Saving support
    func saveContext() {
        injector.dataController.saveContext()
    }

    // MARK: - Dependency Injection
    func injectDetailsViewModel(datumID: String, repositoryType type: DataRepositoryType) -> DetailsViewModel {
        injector.injectDetailsViewModel(datumID: datumID, repositoryType: type)
    }

    func destroyDetailsViewModel() {
        injector.destroyDetailsViewModel()
    }

    func injectStoredDatumRepository(repositoryType type: DataRepositoryType) -> DataRepositoryProtocol {
        injector.injectStoredDatumRepository(repositoryType: type)
    }

    func destroyStoredDatumRepository() {
        injector.destroyStoredDatumRepository()
    }


}

