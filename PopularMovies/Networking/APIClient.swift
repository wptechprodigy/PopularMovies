//
//  APIClient.swift
//  PopularMovies
//
//  Created by waheedCodes on 25/03/2022.
//

import Foundation

class APIClient {
    private var dataTask: URLSessionDataTask?

    func getPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=24d6427f262bac6aa3746e79241ac088&language=en=US&page=1"

        guard let url = URL(string: popularMoviesURL) else { return }

        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Database error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }

            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                print("Empty Data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        dataTask?.resume()
    }

    func getImageDataFrom(url: URL, completion: @escaping ((Data) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Database error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Empty Data")
                return
            }

            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
