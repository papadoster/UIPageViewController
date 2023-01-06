//
//  MyViewController.swift
//  UIPageViewController
//
//  Created by Marina Karpova on 05.01.2023.
//

import UIKit

class MyViewController: UIPageViewController {

    //MARK: - Variable
    
    var cars = [CarsHelper]()
    let mers = UIImage(named: "mers")
    let rr = UIImage(named: "rr")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cars"
        
        let firstCar = CarsHelper(name: "Car - Mersedes", image: mers!)
        let lastCar = CarsHelper(name: "Car - RR", image: rr!)
        
        cars.append(firstCar)
        cars.append(lastCar)

    }

    //MARK: - create VC
    lazy var arrayCarViewController: [CarViewController] = {
        
        var carsVC = [CarViewController]()
        for car in cars {
            carsVC.append(CarViewController(carWith: car))
        }
        return carsVC
    }()
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        self.view.backgroundColor = .systemGray3
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayCarViewController[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MyViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else { return nil }
        if let index = arrayCarViewController.firstIndex(of: viewController) {
            if index > 0 {
                return arrayCarViewController[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CarViewController else { return nil }
        if let index = arrayCarViewController.firstIndex(of: viewController) {
            if index < cars.count - 1 {
                return arrayCarViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return 0
    }
}
