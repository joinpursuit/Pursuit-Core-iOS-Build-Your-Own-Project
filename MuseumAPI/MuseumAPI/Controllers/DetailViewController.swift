//
//  DetailViewController.swift
//  MuseumAPI
//
//  Created by Stephanie Ramirez on 12/28/18.
//  Copyright © 2018 Stephanie Ramirez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var objectDepartment: UILabel!
    @IBOutlet weak var objectArtist: UILabel!
    
    public var objectId: Int!
    private var object: ObjectData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateObject()
    }
    private func updateObject() {
        MuseumAPIClient.searchEvents(keyword: objectId) { (appError, object) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let object = object {
                self.object = object
                print(object)
                DispatchQueue.main.async {
                    self.objectName.text = object.title
                    self.objectDepartment.text = object.department
                    self.objectArtist.text = object.artistDisplayName
                    if let imageUrl = object.primaryImage {
                        if let image = ImageClient.getImage(StringURL: imageUrl) {
                            self.imageView.image = image
                        }
                    }
                }
            }
        }
    }
}
