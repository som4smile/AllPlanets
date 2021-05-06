//
//  PlanetViewModel.swift
//  Planets
//
//  Created by SOM on 04/05/21.
//

import Foundation

///Class middleware between APIManager and View Controller. Responsible for APIManager to fetch Data and responsible for data which going to displayed on view.
class PlanetViewModel: NSObject {
    
    /// Shared instance to used as Singleton
    static var shared = PlanetViewModel()
    
    /// Array to store full JSON response received from server
    private(set) var allPlanets = [AllPlanets]()
    
    /// Array to store planet names received in JSON response.
    private(set) var allPlanetNames: [String]?
    
    /**
     Notify API manager to fetch the data from server if Data is not saved locally in UserDefaults. Also responsible to store the fetched and formatted data to be displayed on UI.

     - Parameter completionHandler: Block which notify UI that data has been fetched or error occured.
    */
    func fetchData(completionHandler: @escaping (Error?) -> ()) {
        
        if let allPlanetNamesArray = UserDefaults.standard.value(forKey: "allPlanetNames") as? [String] {
            self.allPlanetNames = allPlanetNamesArray
            completionHandler(nil)
        } else {
            APIManager.shared.fetchData(completion: { [weak self] data, error in
                
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let planetsArray = try! jsonDecoder.decode(AllPlanets.self, from: data)
                    if self?.allPlanets.count == 0 {
                        self?.allPlanets.append(planetsArray)
                    } else {
                        if (self?.allPlanets.first(where: { $0.next == planetsArray.next })) != nil {
                            return
                        } else {
                            self?.allPlanets.append(planetsArray)
                        }
                    }
                    self?.getAllPlanetNames()
                    completionHandler(nil)
                } else {
                    completionHandler(error)
                }
            })
        }
    }
    
    /**
     Fetch the planetnames from received JSON response and store the in seperate array.
     */
    private func getAllPlanetNames() {
        if !self.allPlanets.isEmpty {
            var allPlanetNames = [String]()
                        
            for planets in self.allPlanets {
                let planetNames = planets.results.map({ $0.name })
                allPlanetNames.append(contentsOf: planetNames)
            }
            
            if !allPlanetNames.isEmpty {
                UserDefaults.standard.setValue(allPlanetNames, forKey: "allPlanetNames")
                self.allPlanetNames = allPlanetNames
            }
        }
    }
}
