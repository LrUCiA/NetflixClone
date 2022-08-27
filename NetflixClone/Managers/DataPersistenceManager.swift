//
//  DataPersistenceManager.swift
//  NetflixClone
//
//  Created by LrUCiA.
//

import Foundation
import UIKit
import CoreData


class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitle(with model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        // context manager 와 연결
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // save data
        let item = TitleItem(context: context)
        item.title = model.title
        item.id = Int64(model.id)
        item.overview = model.overview
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        
        do {
            try context.save()
            // void 전달.
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchTitleFromDatabase(completion: @escaping(Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitle(with model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model) // 데이터베이스에 특정 object 삭제 요청
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
