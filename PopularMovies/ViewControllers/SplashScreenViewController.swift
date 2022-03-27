//
//  SplashScreenViewController.swift
//  PopularMovies
//
//  Created by waheedCodes on 25/03/2022.
//

import UIKit

class SplashScreenViewController: UIViewController {

    private var apiClient = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularMovies()
    }

    private func loadPopularMovies() {

        // Fetch data from server
        apiClient.getPopularMoviesData { [weak self] result in
            switch result {
                case .success(let listOf):
                    // Save data to Core Data
                    CoreData.sharedInstance.saveDataOf(movies: listOf.movies)
                    self?.perform(#selector(self?.moveToMainScreen))
                case .failure(let error):
                    // Show alert message in case of error
                    self?.showAlertWith(title: "Could Not Connect!", message: "Please check your internet connection \n or try again later")
                    // Something is wrong with JSON file or the model
                    print("Error processing json data: \(error)")
            }
        }
    }

    // MARK: - Alert Message
    func showAlertWith(title: String,
                       message: String,
                       style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }

        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    // Perform a transition to the main screen (MoviesListViewController)
    @objc func moveToMainScreen() {
        performSegue(withIdentifier: "MoviesListViewController", sender: self)
    }
}
