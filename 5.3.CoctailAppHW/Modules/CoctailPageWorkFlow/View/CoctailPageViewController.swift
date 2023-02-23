//
//  CoctailPageViewController.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 23/2/23.
//

import UIKit

class CoctailPageViewController: UIViewController {

    @IBOutlet weak var coctailImage: UIImageView!
    @IBOutlet weak var coctailLabel: UILabel!
    @IBOutlet weak var coctailDescription: UILabel!
    @IBOutlet weak var coctailPageView: UIView!
    
    var coctail: DrinkModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailLabel.text = coctail!.strDrink
        coctailDescription.text = coctail!.strInstructions
        loadImgURL(url: coctail!.strDrinkThumb)
        setupCorners(for: coctailPageView)
    }
    
    private func setupCorners(for view: UIView) {
        let corners = UIRectCorner(
            arrayLiteral: [
                UIRectCorner.topRight,
                UIRectCorner.topLeft
            ]
        )
        
        let cornersize = CGSize (width: 40, height: 20)
        
        let maskPath = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: corners,
            cornerRadii: cornersize
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
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
                self.coctailImage.image = UIImage(data: data)!
            }
        }
        task.resume()
    }
    
}
