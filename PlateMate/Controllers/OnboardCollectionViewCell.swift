//
//  OnboardingCollectionViewCell.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-20.
//

import UIKit

class OnboardCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardCollectionViewCell.self)
    
    @IBOutlet weak var slideimageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideimageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
}
    
    
