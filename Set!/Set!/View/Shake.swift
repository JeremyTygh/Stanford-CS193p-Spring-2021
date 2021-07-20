//
//  Shake.swift
//  Set!
//
//  Created by Jeremy Tygh on 7/18/21.
//

import Foundation
import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

extension View {
    func shake(animatableData: CGFloat) -> some View {
        return self.modifier(Shake(animatableData: animatableData))
    }
}
