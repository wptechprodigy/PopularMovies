//
//  MoviesListTableViewCell.swift
//  PopularMovies
//
//  Created by waheedCodes on 26/03/2022.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MoviesListTableViewCell"

    @IBOutlet weak var movieBackdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    private var apiClient = APIClient()
    private var urlString: String = ""

    // MARK: - Setup movie cell
    func setupCellWithValuesOf(_ movie: MovieEntity) {
        updateUI(
            title: movie.title,
            rate: movie.rate,
            overview: movie.overview,
            backdrop: movie.backdropImage)
    }

    // MARK: - Update the UI Views
    private func updateUI(title: String?,
                          rate: String?,
                          overview: String?,
                          backdrop: String?) {
        self.titleLabel.text = title
        self.ratingLabel.text = rate
        self.overviewLabel.text = overview

        guard let backdropString = backdrop else { return }
        urlString = "https://image.tmdb.org/t/p/w300" + backdropString

        guard let backdropImageURL = URL(string: urlString) else {
            self.movieBackdropImageView.image = UIImage(named: "noImageAvailable")
            return
        }

        // Before we download the image we clear out the old one
        self.movieBackdropImageView.image = nil

        apiClient.getImageDataFrom(url: backdropImageURL) { [weak self] (data: Data) in
            if let image = UIImage(data: data) {
                self?.movieBackdropImageView.image = image
            } else {
                self?.movieBackdropImageView.image = UIImage(named: "noImageAvailable")
            }
        }

        setViewAttributes()
    }

    // MARK: - Views Attributes
    private func setViewAttributes() {

        // Movie Backdrop attributes
        movieBackdropImageView.layer.cornerRadius = 20
        movieBackdropImageView.layer.borderWidth = 0.8
        movieBackdropImageView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85).cgColor
        movieBackdropImageView.contentMode = .scaleAspectFill

        // Movie Rate attributes
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 10
    }
}
