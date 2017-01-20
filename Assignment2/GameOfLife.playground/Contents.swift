import Foundation

/*:
 # Assignment 2
 
 The intent of this homework set is to:
 
 1. make sure that you can correctly use important concepts from Swift
 1. have a base set of code from which we can build our Conway's Game
    of Life app.
 
 This code will be incorporated into your final project, so it is very
 important that we get it right.  To the extent possible, I have given you
 a template for all the neccesary code here and have
 only asked you to fill in the details. You are being asked to 
 demonstrate that you understand the meaning of those details

 To complete this assignment, you need to have a basic understanding
 of the following Swift concepts:
 * Type Aliases
 * Base operations, in particular the modulo and ternary operators
 * Base data types, in particular Int and Tuple
 * Arrays and Arrays of Arrays
 * Basic control flow including: if, guard and switch
 * Why and when we avoid the use of "for" as a control flow mechanism
    and use functional constructs instead
 * The Swift types: enum, struct and class and their syntax, differences and similarities
 * Properties of enums, structs and classes
 * Subscripts on structs and classes
 * Functions and in particular higher order functions which take closures as arguments
 * Closures and in particular their capture rules and the trailing closure syntax
 * How to read the signature and therefore the type of a func or closure
 * Parameterized types (aka Generics) and their uses
 * Optional types and why they are genericized enums
 * The if-let and guard-let constructs

 It sounds like a lot I know, but these are parts of the language that you will use
 every day if programming professionally.  There's just no getting around them.
 
 Before attempting this homework, you should first read:
 * the Tour of Swift section of the Apple Swift book
 * all of the learn-swift examples
 * the wikipedia page on Conway's Game of Life
 
 You should also keep these readily at hand while doing this assignment.
 
 **ALL** answers are to be given in line.  Please do not erase the formatted 
 comments as we will
 be grading by reading through this playground.  i.e. go to Editor->Show Rendered Markup 
 in Xcode and leave rendering on while doing the homework
 
 You should make changes to this file **ONLY**
 in the places specified by the comments in green.  Put your code and or comments ONLY in
 those places!  Where the instructions specify a limit on the length of your answers, please
 be aware that we are serious about this.  Swift is built to facilitate concise coding style.
 This homework set has been created to teach you this style.
 
 As you work through this assignment you should reference the learn-swift workspace
 which has been provided in the course materials repository.  I will include references
 to specific playgrounds in that workspace inline below where appropriate.
 
 To understand what we are doing you will need to make sure that you familiar 
 with Conway's Game of Life.  We discussed this extensively in class, but
 you may want to review: [The Wikipedia page](https://en.wikipedia.org/wiki/Conway's_Game_of_Life)
 
 You are **strongly** advised to work the problems in order.  And as you progress to make sure that
 the playground stays in a state where it compiles and runs.  An excellent practice to get into
 is to do frequent commits of your work so that you don't lose it and can roll back to previous 
 versions if you make a mistake.  Xcode will help you with this.
 
 ## Problem 1:  
 Problem 1 has already been worked for you as an example.  Everyone gets 5 free points!
 
 Create a typealias named Position for a tuple which has
 two integer variables: `row` and `col` in that order
 
 * learn-swift 1b
 * learn-swift 1c
*/
// ** Your Problem 1 code goes here! replace the following line **
typealias Position = (row: Int, col: Int)

/*:
 ## Problem 2: 
 Using the enum `CellState` defined below:
 1. create the following 4 possible values: `alive`, `empty`, `born` and `died`.
 1. equip `CellState` with a computed variable `isAlive` of type `Bool` which
    is true if the CellState is alive or born, false otherwise.
 1. Note that `isAlive` MUST use **ONLY** a switch statement on self
 1. `isAlive` can be no more than 8 readablelines long
 
 Failure to follow all rules will result in zero credit
 
 see:
 * learn-swift 8
 * learn-swift 10
 */

enum CellState {
    // ** Your Problem 2 code goes here! Replace the contents of CellState **
    //  This shell code is here so that at all times the playground compiles and runs
    case empty
    
    var isAlive: Bool {
        return false
    }
}

/*:
 The next 2 problems have to do with the struct `Cell`, a template for which is
 defined below
 
 ## Problem 3:
 In a comment here, explain what the contents
 of the variable named `offsets` in the struct `Cell` below represent.
 **Hint:** they are relative to the missing entry in the center and
 have to do with the rules to Conway's Game of Life.
 
 **Your answer may be no more than one sentence.**
 
* learn-swift 10
 */

// ** Your Problem 3 comment goes here! **
/*

 */

/*:
 ## Problem 4:
 1. Initialize `position` to `(0,0)` and `state` to `empty`,
 2. allow Swift to infer the two types, i.e. **do not** put `:Type` on the
 left hand side of the equals sign.

 see:
 * learn-swift 10
*/

// A struct representing a Cell in Conway's Game of Life
struct Cell {
    static let offsets: [Position] = [
        (row: -1, col:  1), (row: 0, col:  1), (row: 1, col:  1),
        (row: -1, col:  0),                    (row: 1, col:  0),
        (row: -1, col: -1), (row: 0, col: -1), (row: 1, col: -1)
    ]

    // ** Your Problem 4 code goes here! replace the following two lines **
    var position: Position
    var state: CellState
}

/*:
 ## Problem 5:
 In the extension to `Cell` below, provide a return 
 value of type `Position` for the function `neighbors`
 such that `neighbors` returns the coordinates of all neighbor cells of self.
 Where by neighbor we mean one of the 8 cells in a grid which touches the current 
 cell.
 
 Your answer MUST:
 1. consist of a return statement followed by the creation
 of a single Position object,
 1. implement the "wrap-around" rules of Conway's Game of Life
 1. take advantage of the following facts:
 
`            0 <= (position.row + offsetRow    + maxRows) % maxRows < maxRows`
 
`            0 <= (position.col + offsetColumn + maxCols) % maxCols < maxCols`

 
 4. make use of `$0` as passed into map
 5. be no longer than 4 readable lines long
 
 Failure to follow all rules will result in zero credit
 
 **HINT** Note that the code you are being asked to write is inside of a map
 function operating over the `offsets` array and that it returns a position
 which represents a neighbor of the given cell which has its own position.
 */

// An extension of Cell to add a function for computing the positions
// of the 8 neighboring cells of a given cell
extension Cell {
    // For the given cell in Conways' GoL, find all 8 of its neighbors, 
    // "wrapping around" a maximum number of rows and columns
    func neighbors(maxRows: Int, maxCols: Int) -> [Position] {
        return Cell.offsets.map {
            // ** Your Problem 5 Code goes here! replace the following line **
            return Position(row: $0, col: $1)
        }
    }
}

/*:
 Problems 6 and 7 refer to the class `Grid` which I provide a template for below.
 
 ## Problem 6:
 The class `Grid` has been provided with 3 variables `rows`, `cols` and `cells`:
 1. Initialize `rows` of type `Int` to be 10 by default
 1. Intialize `cols` of type `Int` to be 10 by default
 
 ## Problem 7:
 Equip Grid with an initializer which:
 1. Initializes the `rows` and `cols` properties from the arguments
 1. initializes the `cells` array to be an array of length `rows` with 
 each entry in that array being an array of type `[Cell]` of length `cols` by using:
 
 `    [[Cell]](repeatElement([Cell](repeatElement ...))`
 
 1. Uses the default values of the Cell struct in initialization
 1. is no more than 10 readable lines long
 
 Failure to follow all rules will result in zero credit
 */

// A grid of cells representing the world of Conway's GoL
class Grid {
    // ** Your Problem 6 code goes here! **
    var rows: Int = 0
    var cols: Int = 0
    var cells: [[Cell]] = [[Cell]]()
    
    required init(_ rows: Int, _ cols: Int) {
        // ** Your Problem 7 code goes here! **
    }
}

/*:
 ## Problem 8: 
 I am providing the following function, `map2` immediately below.
 
 Answer the following questions on `map2` in the places shown.  (Your answers may consist of **AT MOST** once sentence):
 1. what do the _ characters do
 */
// ** Your Problem 8.1 answer goes here **
/*

 */
/*:
 2. what is the type of the transform variable
 */
// ** Your Problem 8.2 answer goes here **
/*

 */
/*:
 3. what is the return type of map2
 */
// ** Your Problem 8.3 answer goes here **
/*

 */
/*:
 4. what is T in this declaration
 */
// ** Your Problem 8.4 answer goes here **
/*

 */
// A function which is like the standard map function but
// which will operate only on a two dimensional array
func map2<T>(_ rows: Int, _ cols: Int, transform: (Int, Int) -> T) -> [[T]] {
    return (0 ..< rows).map { row in
        return (0 ..< cols).map { col in
            return transform(row, col)
        }
    }
}
/*:
 ## Problem 9:
 In the extension to `Grid` immediately below, write
 precisely one line of code in the function `positionCells`
 which sets the position of the cell specified
 by row and col to its correct value.
 
 **HINT** you are setting the position property of a value
 in `cells` which is of type `Position`
 
 More than one line of code will result in zero credit
 */
// An extension to Grid which sets each cell to 'know' its position within the grid
extension Grid {
    func positionCells() -> Self {
        map2(self.rows, self.cols) { row, col in
            // ** Your Problem 9 code goes here! replace the following line
            // this line is here only to make sure that the playground compiles
            return cells[row][col]
        }
        return self
    }
}

/*:
 ## Problem 10:
 Write precisely one line of code which sets the state of the cell specified
 by row and col to to be `alive` with probability 1/3 and `empty` otherwise
 
 Use the following expression to determine if the `state` should be .alive or empty:
 
 `     arc4random_uniform(3) == 2`
 
 Assign the state using the ternary operator `?`
 
 **HINT** you are setting the `state` property of a value in `cells` to a `CellState`
 to `alive` or `empty` based on a roll of of a 3-sided die
 
 Failure to follow all rules will result in zero credit
 */
// An extension to grid which will randomly assign each cell a value of alive or empty
extension Grid {
    func randomizeCells() -> Self {
        map2(self.rows, self.cols) { row, col in
            // ** Your Problem 10 code goes here.  replace the following line **
            // this line is here only to make sure that the playground compiles
            return cells[row][col]
        }
        return self
    }
}

/*:
 ## Problem 11:
 I am providing the following function, reduce2. Answer the following questions
 with **AT MOST** one sentence each.
 1. what do you expect the combine argument to do
 */
// ** Your Problem 11.1 answer goes here **
/*
 
 */
/*:
 2. what is the return type of reduce2
 */
// ** Your Problem 11.2 answer goes here **
/*
 
 */
/*:
 3. why is there no T parameter here as in map2 above
 */
// ** Your Problem 11.3 answer goes here **
/*
 
 */

// A function which is useful for counting things in an array of arrays of things
func reduce2(_ rows: Int, _ cols: Int, combine: (Int, Int, Int) -> Int) -> Int  {
    return (0 ..< rows).reduce(0) { (total: Int, row: Int) -> Int in
        return (0 ..< cols).reduce(total) { (subtotal, col) -> Int in
            return combine(subtotal, row, col)
        }
    }
}
/*:
 ## Problem 12:
 In the extension to Grid below:
 
 1. write precisely one line of code which:
 1. uses the ternary operator ?
 1. returns `total + 1` if the state of the referenced cell is `alive`, otherwise return `total`
 
 **HINT** you are returning a running count of living neighbors
 
 Failure to follow all rules will result in zero credit
 */
// An extension to Grid which will count the number of living cells in the grid
extension Grid {
    var numLiving: Int {
        return reduce2(self.rows, self.cols) { total, row, col in
            // ** Your Problem 12 code goes here! replace the following line
            return 0
        }
    }
}

/*:
 ## Problem 13:
 Uncomment the 4 lines of working code below.
 If your code above compiles and runs the value returned from grid.numLiving
 should be approximately 33. If it is not debug your code above.
 
 Explain why it should be approximately but not necessarily exactly 33
 in a **one sentence** comment in the location shown below.
 */

// Code to initialize a 10x10 grid, set up every cell in the grid
// and randomly turn each cell on or off.  Uncomment following 4 lines
//var grid = Grid(10, 10)
//    .positionCells()
//    .randomizeCells()
//grid.numLiving

// ** Your Problem 13 comment goes here! **
/*
 
 */

/*:
 ## Problem 14:
 In the extension to `Grid` below, equip `Grid` with a subscript which allows you to
 get and set the values of the a cell of type `Cell` in the following manner:
 ```
 aGrid[1,2] = aCell
 aGrid[2,3].state = .born
 let someCell = aGrid[4,7]
 let somePosition = aGrid[2,5].position
 ```
 Your solution MUST:
 1. implement both a `get` and a `set`
 1. in each case consist **ONLY** of a guard-else statement followed by a single line of code
 1. use the guard statement in both the `get` and the `set` to ensure that row and col
 are between 0 and rows or cols respectively
 1. use the guard statement in set to ensure that the new value is not nil
 1. be no more than 4 lines for the `get` and 4 lines for the `set`
 */
// An extension to grid to allow each cell to be referenced by its position
extension Grid {
    subscript (row: Int, col: Int) -> Cell? {
        get {
            // ** Your Problem 14 `get` code goes here! replace the following line **
            return nil
        }
        set {
            // ** Your Problem 14 `set` code goes here! replace the following line **
            return
        }
    }
}

/*:
 The following 4 problems all refer to the extension to `Grid` immediately below
 
 ## Problem 15:
 Answer the following questions about numLivingNeighbors with **AT MOST ONE SENTENCE**.
 1. what is the type of `cell`?
 */
// Problem 15.1 answer goes here
/*
 
 */
/*:
 2. what the type of `self[row,col]`?
 */
// Problem 15.2 answer goes here
/*
 
 */
/*:
 3. why those two types are different?
 */
// Problem 15.3 comment goes here
/*
 
 */
/*:
 4. what under what circumstances the else will be executed?
 */
// Problem 15.4 comment goes here
/*
 
 */
/*:
 ## Problem 16:
 In a comment explain what the reduce function
 in the following extension returns in the context of Conway's Game of Life.
 
 Your answer may consist of **AT MOST** 2 sentences
 */

// Problem 16 comment goes here
/*
 
 */

/*:
 ## Problem 17:
 In a comment explain what `$1` in:
 
 `                self[$1.row, $1.col]`
 
 does
 
 Your answer may consist of **AT MOST** one sentence
 */

// Problem 17 comment goes here
/*
 
 */

/*:
 ## Problem 18:
 In the location shown below, write precisely ONE line of code which returns
 the correct value for computing the number of living neighbors
 of cell.
 
 Your answer must use:
 1. the ternary operator,
 1. $0 and
 1. the state of neighborCell
 
 Failure to follow all rules will result in zero credit
 */
// An extension to Grid which counts the number of living neighbors for the
// cell in position row, col
extension Grid {
    func numLivingNeighbors (_ row: Int, _ col: Int) -> Int {
        guard let cell = self[row,col]
            else { return 0 }
        return cell
            .neighbors(maxRows: rows, maxCols: cols)
            .reduce(0) {
                guard let neighborCell = self[$1.row, $1.col] else { return $0 }
                // ** Problem 18 code goes here!  replace the following 2 lines **
                neighborCell
                return $0
        }
    }
}

/*:
 ## Problem 19:
 In the extension to `Grid` shown below, implement a function nextState which:
 1. takes parameters `row` and `col`
 1. returns a properly initialized CellState
 1. implements the rules of Conway's Game of Life
 
 Your answer MUST:
 * consist solely of one guard-let statement followed by one switch statement
 * use the guard-let to create a local variable `cell` from `self[row,col]`
 * guard against `self[row,col]` being nil otherwise return `empty`
 * use a `switch` statement on `numLivingNeighbors(row,col)` from above to determine
 the value to return
 * the switch statement should consist of a single case and a default statement
 * use the `isAlive` property of `CellState` from above in
 a where clause attached to the case as part of the determination of state
 * return `alive` if the cell `isAlive` and has two living neighbors
 * return `alive` if the cell has 3 living neighbors regardless of
 the cell itself is alive or not
 * return `empty` otherwise
 * be no more than 10 lines long
 
 Failure to follow all rules will result in zero credit
 */
// An extension to Grid to implement Conway's rules for transitioning a cell
// from one state of the game to the next
extension Grid {
    func nextState(_ row: Int, _ col: Int) -> CellState {
        // ** Problem 19 code goes here! Replace the following line **
        return .empty
    }
}

/*:
 ## Problem 20:
 In the location shown in the following extension of Grid, write precisely one line of
 code which sets the state of cell
 corresponding to `row, col` in nextGrid to the correct state for
 Conway's Game of Life using the `nextState` function from above
 */
// An extension to grid to jump to the next state of Conway's GoL
extension Grid {
    func next() -> Grid {
        let nextGrid = Grid(rows, cols).positionCells()
        map2(self.rows, self.cols) { (row, col)  in
            // ** Problem 20 code goes here! **
        }
        return nextGrid
    }
}
/*:
 ## Problem 21:
 Explain what nextGrid variable immediately above represents
 in the context of Conway's Game of Life
 
 Your answer may consist of **ONLY ONE** sentence.
 */

// ** Your Problem 21 comment goes here! **
/*
 
 */
/*:
 ## Problem 22:
 Uncomment the following 2 lines of code.
 Verify that the number living is still in the neighborhood of 33
 If it is not please debug all your code
 */
//grid = grid.next()
//grid.numLiving

/*
 It works!
 */

let theEnd = "The End"
