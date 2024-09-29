//
//  CoreDataManager.swift
//  BankMisrMovieApp
//
//  Created by Mohamed Mahgoub on 29/09/2024.
//

import CoreData
import UIKit


final class MoviesCaching {
    
    private var movieEntity: LocalMovieEntity!
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataManager")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data : \(error)")
            }
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getMovie(type: String, handler: (@escaping(_ result: MovieEntity?, _ error: Error?) -> Void)) {
        let movies = fetchMoviesFromDataBase.first(where: {$0.type == type})
        let movie = decodeMoviesData(movies?.movies)

        (movie == nil) ? handler(nil, NetworkError.somethingWentWrong) : handler(movie, nil)
    }
    
    func saveMovies(type: String, with movie: MovieEntity) {
        movieEntity = LocalMovieEntity(context: managedObjectContext)
        movieEntity.movies = changeMovieEntityToData(movie)
        movieEntity.type = type
        saveInDataBase()
    }
    
}

private extension MoviesCaching {
    var fetchMoviesFromDataBase: [LocalMovieEntity] {
        do {
            return try managedObjectContext.fetch(LocalMovieEntity.fetchRequest())
        } catch {
            return []
        }
    }
    
    func saveInDataBase() {
        do {
            try managedObjectContext.save()
        } catch {
            debugPrint("Can't save data in the DataBase")
        }
    }
    
    func decodeMoviesData(_ movie: Data?) -> MovieEntity? {
        guard let movie else { return nil }
        do {
            return try JSONDecoder().decode(MovieEntity.self, from: movie)
        } catch {
            return nil
        }
    }
    
    func changeMovieEntityToData(_ movie: MovieEntity) -> Data? {
        do {
            return try movie.jsonData()
        } catch {
            return nil
        }
    }
    
    func deleteAllMovies() {
        let logs = LocalMovieEntity.fetchRequest() as NSFetchRequest<NSFetchRequestResult>
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: logs)
        
        do {
            try managedObjectContext.execute(deleteRequest)
        } catch {
            debugPrint("Failed")
        }
    }
}

