# SuggestionSearchBar
This is a search bar that inherits from UISearchBar. It has a UITableView populate with suggestions underneath.


## Usage
In order to implement the SuggestionSearchBar.swift file should be added to your project. Next the following should be added to your view controller where ```allPossibilities``` should be the list that you want to be filtered through in a search. Additionally, ```actionForSearch()``` should include the code you wish to occur when a you select search or select a item in the list.
```
import UIKit

struct Constants {  
    struct DataPassing {
        static var cellClicked = 0
    }
}

class ViewController: UIViewController {

    var allPossibilities = ["green","yellow","blue","red"]
    
    lazy var suggestionsListContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBar = SuggestionSearchBar(
        del: self,
        suggestionsListContainer: suggestionsListContainer,
        dropDownPossibilities: allPossibilities,
        clickAction: tickerClickedAction
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        setUpSuggestionsListContainer()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func setUpSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.layer.zPosition = 1000
        navigationItem.titleView = searchBar
    }
    
    func setUpSuggestionsListContainer() {
        self.view.addSubview(suggestionsListContainer)
        
        NSLayoutConstraint.activate([
            suggestionsListContainer.topAnchor.constraint(equalTo: self.view.topAnchor),
            suggestionsListContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            suggestionsListContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func actionForSearch(searchText: String) {
        //Place the action here that you want to occur when you hit search or when you click an item.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchText = searchBar.text
        actionForSearch(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func tickerClickedAction() {
        searchBar.endEditing(true)
        searchText = allPossibilities.filter {$0.contains(searchBar.text?.uppercased() ?? "")}[Constants.DataPassing.cellClicked]
        actionForSearch(searchText: searchText)
    }
    
}

```
