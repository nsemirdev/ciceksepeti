//
//  HomeFeedViewModel.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class HomeFeedViewModel {
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
}
