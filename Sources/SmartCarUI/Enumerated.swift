//
//  Enumerated.swift
//  SmartCarUI
//
//  Created by Robert Smith on 6/10/20.
//  Copyright © 2020 Robert Smith. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Enumerating<S: Sequence, Content: View>: View {
    public init(_ sequence: S, content: @escaping (S.Element, Int) -> Content) {
        self.sequence = sequence
        self.content = content
    }
    
    private let sequence: S
    private let content: (S.Element, Int) -> Content
    
    public var body: some View {
        ForEach(Array(sequence.enumerated()), id: \.0) { enumeration in
            self.content(enumeration.1, enumeration.0)
        }
    }
}
