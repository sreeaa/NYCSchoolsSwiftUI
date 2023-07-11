//
//  SchoolListItem.swift
//  NYCSchoolsSwiftUITest
//
//  Created by Akshitha atmakuri on 7/10/23.
//

import SwiftUI

struct SchoolListItem: View {
    let school: School
    var body: some View {
        Text(school.name)
            .lineLimit(1)
            .font(.system(.title3))
            .foregroundColor(.black)
    }
}

struct SchoolListItem_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListItem(school: School.sampleData[0])
    }
}
