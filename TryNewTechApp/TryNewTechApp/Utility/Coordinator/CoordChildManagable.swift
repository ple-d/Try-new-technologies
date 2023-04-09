//
//  CoordChildManagable.swift
//  TryNewTechApp
//
//  Created by mac on 07.04.2023.
//

import Foundation

protocol CoordChildManagable {
    var hasPresentedChild: Bool { get }
    var presentedChild: Coordinatable? { get }
    func set(presentedChild: Coordinatable)
    // Param only for validation
    func remove(presentedChild: Coordinatable)
    
    var containedChildren: [Coordinatable] { get }
    func add(internalChild: Coordinatable)
    func remove(internalChild: Coordinatable)
}
