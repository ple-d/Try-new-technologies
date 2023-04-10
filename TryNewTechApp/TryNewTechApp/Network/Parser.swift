//
//  Parser.swift
//  TryNewTechApp
//
//  Created by mac on 10.04.2023.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Moya_ObjectMapper

struct ParseError: Error {
    let response: Response
    let parseError: Error
}

// MARK: - ImmutableMappable
public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func parseObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<T> {
        return flatMap { response -> Single<T> in
            do {
                return Single.just(try response.mapObject(type, context: context))
            } catch {
                throw ParseError(response: response, parseError: error)
            }
        }
    }
    
    func parseArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Single<[T]> {
        return flatMap { response -> Single<[T]> in
            do {
                return Single.just(try response.mapArray(type, context: context))
            } catch {
                throw ParseError(response: response, parseError: error)
            }
        }
    }
    
    func parseArrayStrings() -> Single<[String]> {
        return flatMap { response -> Single<[String]> in
            do {
                guard let array = (try response.mapJSON() as? [String]) else {
                    throw MoyaError.jsonMapping(response)
                }
                return Single.just(array)
            } catch {
                throw ParseError(response: response, parseError: error)
            }
        }
    }
}
