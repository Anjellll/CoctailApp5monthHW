//
//  MainViewController.swift
//  5.3.CoctailAppHW
//
//  Created by anjella on 22/2/23.
//

import UIKit
import RxSwift
import RxRelay

class MainViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainMenuCollectioView: UICollectionView!
    
    private let coctailViewModel: MainViewModelType = MainViewModel()
    
    private var coctails: [DrinkModel] = [] {
        didSet {
            mainMenuCollectioView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchCoctails()
        setupCorners(for: mainView)
    }
    
    private func configureCollectionView() {
        mainMenuCollectioView.dataSource = self
        mainMenuCollectioView.delegate = self
        mainMenuCollectioView.register(
            UINib(
                nibName: String(describing: MainCollectionViewCell.self),
                bundle: nil),
            forCellWithReuseIdentifier: MainCollectionViewCell.reuseID)
    }
    
    private func fetchCoctails() {
        Task {
            do {
                let listOfCoctails = try await coctailViewModel.getDrinks()
                self.coctails = listOfCoctails.drinks ?? []
            } catch {
                print(error.localizedDescription)
            }
        }
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
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
    -> Int {
        coctails.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseID, for: indexPath) as! MainCollectionViewCell
        let model = coctails[indexPath.row]
        cell.displayInfo(drink: model)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
}


extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coctailVC = storyboard?.instantiateViewController(withIdentifier: "CoctailPageViewController") as! CoctailPageViewController
        let model = coctails[indexPath.row]
        var observe = BehaviorRelay<DrinkModel>(value: model)
            observe.subscribe(onNext: { drinks in
                coctailVC.coctail = drinks
                print(coctailVC.coctail)
            })
        navigationController?.pushViewController(coctailVC, animated: true)
    }
}
