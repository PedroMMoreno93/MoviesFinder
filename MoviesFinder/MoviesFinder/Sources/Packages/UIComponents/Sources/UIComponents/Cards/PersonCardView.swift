//
//  PersonCardView.swift
//  UIComponents
//
//  Created by Pedro M Moreno on 1/8/25.
//

import SwiftUI
import Theme
import UIUtils

public protocol PersonCardModelView {
    var title: String { get }
    var description: String { get }
    var imageUrl: String? { get }
}

public struct PersonCardView: View {
    let model: PersonCardModelView
    
    public init(model: PersonCardModelView) {
        self.model = model
    }
    
    public var body: some View {
        VStack {
            image
            titleView
            descriptionView
        }
    }
    
    @ViewBuilder private var image: some View {
        if let backdropPath = model.imageUrl {
            AsyncImage(
                url: URL(string: backdropPath)
            ) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: ThemeLayout.Frame.thumbnailS.width)
            } placeholder: {
                Spinner()
                    .frame(height: ThemeLayout.Frame.iconStatus.height)
            }
        } else {
            ZStack {
                ThemeColors.background
                ThemeImages.placeholder
                    .resizable()
                    .scaledToFit()
                    .frame(size: ThemeLayout.Frame.iconStatus)
            }
            .frame(size: ThemeLayout.Frame.thumbnailS)
        }

    }
    
    private var titleView: some View {
        Text(model.title)
            .font(ThemeFonts.title)
            .foregroundStyle(ThemeColors.primaryText)
    }
    
    private var descriptionView: some View {
        Text(model.description)
            .font(ThemeFonts.body)
            .foregroundStyle(ThemeColors.primaryText)
    }
    
}
