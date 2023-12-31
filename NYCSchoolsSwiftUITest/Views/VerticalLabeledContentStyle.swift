//
//  VerticalLabeledContentStyle.swift
//  NYCSchoolsSwiftUITest
//
//  Created by Akshitha atmakuri on 7/10/23.
//

import SwiftUI

struct VerticalLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            configuration.label
                .foregroundColor(.secondary)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            configuration.content
                .font(.system(.title, design: .rounded, weight: .semibold))
                .foregroundColor(.publicNavy)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

extension LabeledContentStyle where Self == VerticalLabeledContentStyle {
    static var vertical: Self { Self() }
}


