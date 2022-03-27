//
//  MoviesListViewController.swift
//  PopularMovies
//
//  Created by waheedCodes on 26/03/2022.
//

import UIKit

class MoviesListViewController: UIViewController, UpdateTableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var viewModel: MoviesListViewModel = MoviesListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: -
    private func setupView() {
        setNavigationBar()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.viewModel.delegate = self
        loadData()
    }

    private func loadData() {
        viewModel.retrieveDataFromCoreData()
    }

    // Update the tableView if changes have been made
    func reloadData(sender: MoviesListViewModel) {
        self.tableView.reloadData()
    }

    // MARK: - Navigation Bar appearance
    private func setNavigationBar() {
        // Transparent the navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Navigation bar item color (time, battery) - white
        self.navigationController?.navigationBar.barStyle = .black
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectedMovie" {
            guard let detailViewController =
                    segue.destination as? MovieDetailsViewController else { return }
            guard let selectedMovieCell = sender as? UITableViewCell else { return }

            if let indexpath = tableView.indexPath(for: selectedMovieCell) {
                let selectedMovie = viewModel.object(indexPath: indexpath)
                detailViewController.viewModel = MovieDetailsViewModel(movieDetails: selectedMovie)
            }

            // Back button without title on the next screen
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}

extension MoviesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesListTableViewCell.reuseIdentifier,
            for: indexPath) as! MoviesListTableViewCell

        if let movie = viewModel.object(indexPath: indexPath) {
            cell.setupCellWithValuesOf(movie)
        }

        return cell
    }
}

extension MoviesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
