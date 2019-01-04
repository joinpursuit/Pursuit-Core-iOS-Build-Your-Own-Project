//
//  ImageHelper.swift
//  MuseumAPI
//
//  Created by Stephanie Ramirez on 1/2/19.
//  Copyright © 2019 Stephanie Ramirez. All rights reserved.
//

import UIKit

final class ImageClient {
    static func getImage(StringURL: String) -> UIImage? {
        guard let myImageURL = URL.init(string: StringURL) else {return nil}
        do {
            let data = try Data.init(contentsOf: myImageURL) // processing image
            guard let image = UIImage.init(data: data) else {return nil}
            return image
        } catch {
            print(error)
            return nil
        }
    }
}
