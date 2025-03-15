//
//  SwiftUIView.swift
//  PersonalPorject
//
//  Created by Pranay2 on 17/02/25.
//

import SwiftUI

struct Second: View {
    var data: String?
    var body: some View {
        Text(data ?? "")
    }
}

#Preview {
    Second(data: "data")
}
