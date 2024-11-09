/*
 DependencyClient.swift
 DataLayer

 Created by Takuto Nakamura on 2024/11/07.
 
*/

public protocol DependencyClient: Sendable {
    static var liveValue: Self { get }
    static var testValue: Self { get }
}
