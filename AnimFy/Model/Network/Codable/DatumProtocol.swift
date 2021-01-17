//
//  DatumProtocol.swift
//  AnimFy
//
//  Created by António Bastião on 1t.01.21.

protocol Datum: Codable {

    associatedtype attributesType

    var id: String { get }
    var links: DatumLinks { get }
    var attributes: attributesType { get }
    var relationships: [String: Relationship] { get }
}