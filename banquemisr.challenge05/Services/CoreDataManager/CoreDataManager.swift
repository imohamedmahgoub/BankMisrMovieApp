//
//  CoreDataManager.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

//import CoreData
//import UIKit
//
//class CoreDataManager {
//    static let shared = CoreDataManager()
//    let persistentContainer: NSPersistentContainer
//
//    private init() {
//        persistentContainer = NSPersistentContainer(name: "CoreDataManager")
//        persistentContainer.loadPersistentStores { _, error in
//            if let error = error {
//                fatalError("Failed to load Core Data stack: \(error)")
//            }
//        }
//    }
//
//    var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
//    func saveMovies(_ movieEntity: MovieEntity) {
//        
//        let movie = Movie(context: context)
//        
//        movie.page = Int64(movieEntity.page ?? 0)
//        movie.totalPages = Int64(movieEntity.totalPages ?? 0)
//        movie.totalResults = Int64(movieEntity.totalResults ?? 0)
//
//        movieEntity.results?.forEach { movieDetail in
//            let movieDetails = MovieDetails(context: self.context)
//            movieDetails.id = Int64(movieDetail.id ?? 0)
//            movieDetails.posterPath = movieDetail.posterPath
//            movieDetails.releaseDate = movieDetail.releaseDate
//            movieDetails.title = movieDetail.title
//            movie.addToDetails(movieDetails)
//        }
//        saveContext()
//    }
//
//    func fetchSavedMovies() -> [MovieEntity]? {
//        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
//        do {
//            let savedMovies = try context.fetch(request)
//            var movieEntities = [MovieEntity]()
//            
//            for movie in savedMovies {
//                var detailsEntities = [MovieDetailsEntity]()
//                if let details = movie.details?.allObjects as? [MovieDetails] {
//                    details.forEach { detail in
//                        detailsEntities.append(MovieDetailsEntity(id: Int(detail.id), posterPath: detail.posterPath, releaseDate: detail.releaseDate, title: detail.title))
//                    }
//                }
//
//                let movieEntity = MovieEntity(page: Int(movie.page), results: detailsEntities, totalPages: Int(movie.totalPages), totalResults: Int(movie.totalResults))
//                movieEntities.append(movieEntity)
//            }
//            return movieEntities
//        } catch {
//            print("Failed to fetch movies: \(error)")
//            return nil
//        }
//    }
//
//    func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save context: \(error)")
//            }
//        }
//    }
//}
//
