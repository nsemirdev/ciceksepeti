//
//  SlideCell.swift
//  ciceksepeti
//
//  Created by Emir Alkal on 23.01.2023.
//

import UIKit

final class SlideCell: UICollectionViewCell {
  static let identifier = "SlideCell"
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    imageView.layer.cornerRadius = 8

    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
  }

  override func layoutSubviews() {
    imageView.frame = bounds
  }

  func configure(with model: SlideCellModel) {
    imageView.image = UIImage(named: model.image)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
