
import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    func setupViewControllers() {
        
        let shoppingVC = UINavigationController(rootViewController: ShoppingTableViewController())
        shoppingVC.tabBarItem = UITabBarItem(title: "Compras", image: UIImage(systemName: "bag"), tag: 0)
        shoppingVC.navigationController?.title = "Lista de compras"
        
        let adjustVC = AdjustsViewController()
        adjustVC.tabBarItem = UITabBarItem(title: "Ajustes", image: UIImage(systemName: "gear"), tag: 1)
        
        let totalShoppingVC = TotalShoppingViewController()
        totalShoppingVC.tabBarItem = UITabBarItem(title: "Total de compras", image: UIImage(systemName: "bag.fill"), tag: 2)
        
        self.viewControllers = [shoppingVC, adjustVC, totalShoppingVC]
    }


}

