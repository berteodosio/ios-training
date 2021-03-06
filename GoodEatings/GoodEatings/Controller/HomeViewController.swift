//
//  ViewController.swift
//  GoodEatings
//
//  Created by Bernardo Teodosio on 15/11/18.
//  Copyright © 2018 Bernardo Teodosio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
   
    @IBOutlet weak var categoriesTableView: UITableView!
    
    private let dataSet = DataSet()
    
    private var selectedCategory: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategoriesTableView()
    }
    
    private func configureCategoriesTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeViewController = segue.destination as? RecipeViewController else { return }
        recipeViewController.selectedCategory = self.selectedCategory
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "foodCategoryCell",
            for: indexPath) as? FoodCategoryTableViewCell else { return UITableViewCell() }
        
        cell.configureFoodCategory(dataSet.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.categories.count
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCategory = dataSet.categories[indexPath.row].title
        performSegue(withIdentifier: "navigateToRecipeViewController", sender: self)
    }
}
