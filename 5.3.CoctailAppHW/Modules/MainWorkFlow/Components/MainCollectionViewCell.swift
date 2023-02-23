//
//  MainCollectionViewCell.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 22/2/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static var reuseID = String(describing: MainCollectionViewCell.self)
    
    @IBOutlet weak var coctailImageView: UIImageView!
    @IBOutlet weak var coctailNameLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    private var product: DrinkModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coctailImageView.layer.cornerRadius = 120 / 3
        buyButton.layer.cornerRadius = 24 / 3
        buyButton.layer.shadowColor = UIColor.black.cgColor
        buyButton.layer.shadowOpacity = 0.3
        buyButton.layer.shadowOffset = CGSize(width: 0.0, height: 5)
    }
    
    func displayInfo(drink: DrinkModel) {
        product = drink
        coctailNameLabel.text = drink.strDrink
        loadImgURL(url: drink.strDrinkThumb)
    }
    
    private func loadImgURL(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.coctailImageView.image = UIImage(data: data)!
            }
        }
        task.resume()
    }
}
