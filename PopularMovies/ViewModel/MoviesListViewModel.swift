//
//  MoviesListViewModel.swift
//  PopularMovies
//
//  Created by waheedCodes on 26/03/2022.
//

import UIKit
import CoreData

protocol UpdateTableViewDelegate: NSObjectProtocol {
    func reloadData(sender: MoviesListViewModel)
}

class MoviesListViewModel: NSObject, NSFetchedResultsControllerDelegate {

    private let container: NSPersistentContainer? =
    (UIApplication.shared.delegate as? AppDelegate)?
        .persistentContainer

    private var fetchedResultController: NSFetchedResultsController<MovieEntity>?
    weak var delegate: UpdateTableViewDelegate?

    // MARK: - Fetched Results Controller - Retrieves data from Core Data
    func retrieveDataFromCoreData() {

        if let context = self.container?.viewContext {
            let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()

            // Sort movies by rating
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(MovieEntity.rate), ascending: false)]

            self.fetchedResultController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            // Notify the tableView when any changes have occurred to the data
            fetchedResultController?.delegate = self

            // Fetch data
            do {
                try self.fetchedResultController?.performFetch()
            } catch {
                print("Failed to initialize FetchedResultsController: \(error)")
            }
        }
    }

    // Changes have happened in fetchedResultsController so we need to notify the tableView
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            // Update the tableView
            self.delegate?.reloadData(sender: self)
    }

    // MARK: - TableView Datasource Functions
    func numberOfRowsInSection(section: Int) -> Int {
        return fetchedResultController?.sections?[section].numberOfObjects ?? 0
    }

    func object(indexPath: IndexPath) -> MovieEntity? {
        return fetchedResultController?.object(at: indexPath)
    }
}
