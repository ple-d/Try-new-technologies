//
//  ViewModellable.swift
//  TryNewTechApp
//
//  Created by mac on 09.04.2023.
//

/// Each View Model should use Input and Output
protocol ViewModellable {
    associatedtype Input
    associatedtype Output
}

/// ViewModel that does not store inputs and outputs. It takes network service (and any other required data) as a parameter in initialization.
/// Method transform is used to generate Output from provided Input
protocol TransformingViewModellable: ViewModellable {
    func transform(input: Input) -> Output
}

/// ViewModel that stores Inputs and Outputs. It can be used when we cannot create all Input at the same time.
/// Some observables can be bind to inputs later.
protocol StoringViewModellable: ViewModellable {
    // Looks like input should consist of PublishRelays
    var input: Input { get }
    var output: Output { get }
}
