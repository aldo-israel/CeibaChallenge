//
//  HeaderView.swift
//  CeibaChallenge
//
//  Created by Aldo Israel Navarro on 4/23/22.
//

import SwiftUI

struct HeaderView: View {

    @Environment(\.presentationMode) var presentationMode

    var title: String

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.white)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            Spacer()
            Text(title)
                .font(.body)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding()
            .background(Color.accentColor)
    }
}

struct HeaderViewWithoutBackButton: View {

    var title: String

    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(title)
                .font(.body)
                .bold()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding()
            .background(Color.accentColor)
    }
}
