//
//  MovieDetailsViewController.swift
//  PopularMovies
//
//  Created by waheedCodes on 26/03/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    static let reusIdentifier = "MovieDetailsViewController"

    // MARK: - Interface Builder Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        setNavigationBackButtonColor()
        updateUI()
    }

    private func setNavigationBackButtonColor() {
        self.navigationController?.navigationBar.tintColor = .white
    }

    // MARK: - Update UI
    private func updateUI() {
        self.titleLabel.text = viewModel.title
        self.ratingLabel.text = viewModel.rate
        self.releaseDateLabel.text = viewModel.year
        self.overviewLabel.text = viewModel.overview
        self.posterImageView.setImageFromPath(viewModel.posterImage)

        viewsAttributes()
    }

    // MARK: - Views attributes
    private func viewsAttributes() {
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 10
    }
}

// MARK: - Extension to set an image into UIImageView
extension UIImageView {
    func setImageFromPath(_ path: String?) {
        image = nil

        DispatchQueue.global(qos: .background).async {
            var image: UIImage?
            guard let imagePath = path else { return }
            if let imageURL = URL(string: imagePath) {
                if let imageData = NSData(contentsOf: imageURL) {
                    image = UIImage(data: imageData as Data)
                } else {
                    // Image default - In case of error
                    image = UIImage(named: "noImageAvailable")
                }

                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
