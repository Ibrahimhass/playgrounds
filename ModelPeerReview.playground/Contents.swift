//: Peer Review Assignment Md. Ibrahim Hassan

import UIKit

//: Enumerations 

enum sortType {
    case alpabetical
    case leastToMost
    case mostToLeast
}
enum selectedArray{
    case favoriteFood
    case favoritePlaces
    case favoriteMovies
}

//: Model Class

class Model {
   var favFood: [String] = []
   var favMovies : [String] = []
   var favPlaces : [String] = []
    init()
    {
    self.favFood = ["kebab", "biryani", "doughnut", "steak", "pizza"]
    self.favMovies =  ["Pulp Fiction", "Fight Club", "Inception", "Logan", "Matrix"]
    self.favPlaces = ["Istanbul", "Maldives", "Paris", "Madrid", "Barcelona"]
    }
func switchCase(sortType: sortType, array: [String]) -> [String]
{
    switch sortType {
    case .alpabetical:
        let sortedArray = array.sorted(by: <)
        return (sortedArray)
    case .leastToMost:
         return (array.reversed())
    case .mostToLeast:
        return (array)
    }
}
    func selectFsvoritetype (type: selectedArray) -> [String]
    {
        switch type {
        case .favoriteFood:
            return (favFood)
        case .favoriteMovies:
            return (favMovies)
        case .favoritePlaces:
            return (favPlaces)
        }
    }
}

//: Controller Class

class Controller {
    
    func askQuestion(name: selectedArray, sortBy: sortType)
    {
        let selectedId : selectedArray
        let sortType1 : sortType
        let arrayName : String!
        switch name {
        case .favoriteFood:
            arrayName = "favorite foods"
            selectedId = .favoriteFood
        case .favoriteMovies:
            arrayName = "favorite movies"
            selectedId = .favoriteMovies
        case .favoritePlaces:
            arrayName = "favorite places"
            selectedId = .favoritePlaces
        }
        print ("What are your \(arrayName!)?")
        switch sortBy {
        case .alpabetical:
            sortType1 = .alpabetical
        case .leastToMost:
            sortType1 = .leastToMost
        case .mostToLeast:
            sortType1 = .mostToLeast
        }

        self.printFavorite(name: selectedId, sortBy: sortType1)
    }
    func printFavorite(name: selectedArray, sortBy: sortType)
    {
        let tempStr : String!
        switch name {
        case .favoriteFood:
            tempStr = "favorite foods"
        case .favoriteMovies:
            tempStr = "favorite movies"
        case .favoritePlaces:
            tempStr = "favorite places"
    }

        let model = Model()
        let choice = model.selectFsvoritetype(type: name)
        let result = model.switchCase(sortType: sortBy, array: choice)
        var resultString : String = "My \(tempStr!) are "
        for (x, i) in result.enumerated()
        {
            if (x != 3 && x != 4)
            {
              resultString = resultString + i + ", "
            }
            if (x == 4)
            {
                resultString = resultString + i + "."
            }
            if (x == 3)
            {
               resultString = resultString + i + " and "
            }
        }
        print (resultString)
    }
}

//: Function Call

let cont = Controller()
cont.askQuestion(name: .favoritePlaces, sortBy: .leastToMost)
