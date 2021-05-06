//
//  PlanetsViewController.swift
//  Planets
//
//  Created by SOM on 04/05/21.
//

import UIKit

///Class which controls the overall operation to display planets.
class PlanetsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        
        self.fetchPlanets()
    }
    
    /**
     Fetches planets data.
    */
    private func fetchPlanets() {
        self.showSpinner(onView: self.view)
        PlanetViewModel.shared.fetchData(completionHandler: { [weak self] error in
            
            self?.removeSpinner()
            
            if error != nil {
                //show alert
                DispatchQueue.main.async {
                    self?.showAlert(withTitle: "Error!", withMessage: error?.localizedDescription ?? "Some error occurred.")
                }
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
}

extension PlanetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanetViewModel.shared.allPlanetNames?.count ?? 0 //1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier"),
              let planetNamesArray = PlanetViewModel.shared.allPlanetNames else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = (!planetNamesArray.isEmpty && planetNamesArray.count > indexPath.section) ? planetNamesArray[indexPath.section] : ""

        return cell
    }
    
}
