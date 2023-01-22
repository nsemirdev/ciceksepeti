//
//  HomeFeedViewModel.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class HomeFeedViewModel {
  private var maximumIndexForSliding = SlideCellMock.data.count - 1
  private var descending = false
  var indexForSlide = Box<Int>(0)
  var timer: Timer?
  
  func getSection(_ sectionIndex: Int) -> NSCollectionLayoutSection? {
    switch sectionIndex {
    case 0:
      return CompositionalLayoutHelper.createFirstSection()
    case 1:
      return CompositionalLayoutHelper.createSecondSection()
    case 2:
      return CompositionalLayoutHelper.createThirdSection()
    default:
      return nil
    }
  }
  
  func startAnimating() {
    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [unowned self] _ in
      if !descending && indexForSlide.value < maximumIndexForSliding {
        indexForSlide.value += 1
      }
      
      if descending && indexForSlide.value > 0 {
        indexForSlide.value -= 1
      }
      
      if indexForSlide.value == maximumIndexForSliding {
        descending = true
      }
      
      if indexForSlide.value == 0 {
        descending = false
      }
    }
  }
  
  func endAnimating() {
    timer?.invalidate()
  }
}
