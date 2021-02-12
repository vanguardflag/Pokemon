//
//  PokeService.swift
//  Pokemon
//
//  Created by Jalal Najafi on 09/02/2021.
//

import Foundation

protocol PokeServiceProtocol {
    func getPokeList(url: URL, then handler: @escaping (Result<PokeListResultModel,Error>) -> Void)
    func getPokemon(models: [BaseModel], then handler: @escaping (Result<[PokemonViewModel],Error>) -> Void)
}


class PokeService {
    
    // MARK: - Properties
    private var currentTask: URLSessionTask?
    private var result: [PokemonViewModel] = []
    
}

extension PokeService: PokeServiceProtocol{
    func getPokeList(url: URL, then handler: @escaping (Result<PokeListResultModel,Error>) -> Void) {
        
        if let currentTask = currentTask, currentTask.state == .running {
            currentTask.cancel()
        }
        
        let task = URLSession.shared.dataTask(with: url){ (data,_,error) in
            guard let data = data else {
                handler(.failure(AppError.noData))
                return
            } 
            do {
                let response = try JSONDecoder().decode(PokeListResultModel.self, from: data)
                handler(.success(response))
            } catch let error {
                handler(.failure(error))
                return
            }
        }
        
        currentTask = task
        task.resume()
        
    }
    
    
    func getPokemon(models: [BaseModel], then handler: @escaping (Result<[PokemonViewModel],Error>) -> Void){
        let group = DispatchGroup()
        for model in models{
            group.enter()
            guard let urlString = model.url, let url = URL(string: urlString) else {
                group.leave()
                return
            }
            let task = URLSession.shared.dataTask(with: url){[weak self] (data, _, error) in
                guard let data = data else {
                    group.leave()
                    return
                }
                do {
                    let response = try JSONDecoder().decode(PokemonModel.self, from: data)
                    self?.result.append(.init(pokemonName: model.name ?? "", pokemonDetail: response))
                    group.leave()
                } catch {
                    group.leave()
                    return
                }
            }
            currentTask = task
            task.resume()
        }
        
        group.notify(queue: .global()) {
            // All requests completed
            handler(.success(self.result))
            self.result.removeAll()
        }

    }
}
