# SuggestionSearchBar
This is a search bar that inherits from UISearchBar. It has a UITableView populate with suggestions underneath.


## Usage
To use, implement the following in your desired UIViewController:
```
import UIKit

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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchText = searchBar.text
        setUpUI()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func tickerClickedAction() {
        print(Constants.DataPassing.cellClicked)
        searchBar.endEditing(true)
        ticker = allPossibilities.filter {$0.contains(searchBar.text?.uppercased() ?? "")}[Constants.DataPassing.cellClicked]
        searchBar.text = ""
        //place action that you want to occur when searchbar is clicked here
    }
    
}


```
