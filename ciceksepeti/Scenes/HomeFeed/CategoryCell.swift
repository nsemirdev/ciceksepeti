//
//  CategoryCell.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
  static let identifier = "CategoryCell"
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = 6
    imageView.backgroundColor = .white
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = bounds
  }
  
  func configure(with model: CategoryCellModel) {
    imageView.image = UIImage(named: model.imageName)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
