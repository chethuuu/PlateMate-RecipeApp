//
//  OnBoardViewController.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-20.
//

import UIKit

class OnBoardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
            didSet {
                pageControl.currentPage = currentPage
                if currentPage == slides.count - 1 {
                    nextBtn.setTitle("Get Started", for: .normal)
                } else {
                    nextBtn.setTitle("Next", for: .normal)
                }
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slides = [
                    OnboardingSlide(title: "Delicious Recipes", description: "Experience a variety of amazing recipes from different cultures around the world.", image: #imageLiteral(resourceName: "cook")),
                    OnboardingSlide(title: "World-Class Chefs", description: "Our Recipes are prepared by only the best.", image: #imageLiteral(resourceName: "chef")),
                    OnboardingSlide(title: "Discover delicious recipes with ease", description: "Our user-friendly app makes it easy to learn and create mouth-watering captions for your favorite dishes!", image: #imageLiteral(resourceName: "recipebook"))
                ]
    }
    
  
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "MainVC") as! UINavigationController
                   controller.modalPresentationStyle = .fullScreen
                   controller.modalTransitionStyle = .flipHorizontal
                   present(controller, animated: true, completion: nil)
               } else {
                   currentPage += 1
                   let indexPath = IndexPath(item: currentPage, section: 0)
                   collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
               }
    }
    
}




extension OnBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardCollectionViewCell.identifier, for: indexPath) as! OnboardCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
      }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            currentPage = Int(scrollView.contentOffset.x / width)
        }}
