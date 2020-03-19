var deck = getDeck();
var board = dealBoard();
var cards = ["", "", ""];
var score;


function getDeck() {
  const numbers = ["one", "two", "three"];
  const fills = ["blank", "solid", "stripe"];
  const colors = ["red", "green", "purple"];
  const shapes = ["triangle", "oval", "squiggle"];
  let deck = new Array();
  for (var i = 0; i < numbers.length; i++) {
    for (var j = 0; j < fills.length; j++) {
      for (var k = 0; k < colors.length; k++) {
        for (var l = 0; l < shapes.length; l++) {
          var card = {number: numbers[i],
                      fill: fills[j],
                      color: colors[k],
                      shape: shapes[l]}
          deck.push(card);
        }
      }
    }
  }
  return deck;
}

/**
 * Get a random card from the deck
 * @param {Array} pile the overall deck
 */
function draw(pile) {
  let index = Math.floor(Math.random()*pile.length);
  return pile.splice(index,1)[0];
}

/**
 * Returns the number of matches found on the board
 * @param {Array} board array consisting of 12 cards to represent the current board
 */
function ensureMatchesExist(board) {
  let numMatches = 0;

  // Find all the possible combinations of 3 cards (12 choose 3 = 220)
  const allCardCombinations = k_combinations(board,3);
  for(let i = 0; i < allCardCombinations.length; i++) {
    const cardSet = [];

    // Combine the properties of each card in the combination to a string 
    // and then check if the those three cards make a set 
    for(const card of allCardCombinations[i]) {
      const line = `${card.number} ${card.fill} ${card.color} ${card.shape}`;
      cardSet.push(line);
    }
    if(checkSet(cardSet)) {
      numMatches++;
    }
  }
  return numMatches;
}

function dealBoard() {
  let board = new Array();

  //the cards in the board will be regenerated as many times as is necessary to ensure
  //there is at least one match
  do {
    for (let i = 0; i < 12; i++) {
      board.push(draw(deck));
    }
  } while (ensureMatchesExist(board) == 0)

  return board;
}

/**
 * Display the cards by creating a 3x4 table for all the cards in the board
 */
function displayBoard() {
  document.getElementById('setBoard').innerHTML = '';
  let cardTableRow = document.createElement("TR");
  for(let j = 1; j < board.length+1; j++) {
    let cardTableEntry = document.createElement("TD");
    cardTableEntry.className = "cardTableEntry";
    let card = board[j-1];
    let cardPic = document.createElement("img");
    cardTableEntry.onclick = () => userClickEvent(cardPic);
    cardPic.src = "../pictures/SET/" + card.number + "-" + card.fill + "-" + card.color + "-" + card.shape + ".png";
    cardPic.alt = card.number + " " + card.fill + " " + card.color + " " + card.shape;
    cardPic.className = "card";
    cardPic.style.display = "block";
    cardTableEntry.appendChild(cardPic)
    cardTableRow.appendChild(cardTableEntry);

    // Start a new row after 4 cards have been placed
    if( j % 4 == 0 ) {
      document.getElementById('setBoard').appendChild(cardTableRow);
      cardTableRow = document.createElement("TR");
    }
  }
}

/**
 * This function deals with when the user chooses a card
 * @param {HTMLElement} clickedCard the card element that was clicked on
 */
function userClickEvent(clickedCard) {
  let cardInfo = clickedCard.alt
  clickedCard.parentElement.style.border = "3px solid red";
  clickedCard.classList.add("selectedCard");

  // Deselect the card if it was previously selected by removing its border
  // and deleting the information saved in the cards array
  if(cards[0] == cardInfo || cards[1] == cardInfo || cards[2] == cardInfo){
    clickedCard.parentElement.style.border = "3px solid #bfbfbf";
    for(let i = 0; i < cards.length; i++){
      if(cards[i] == cardInfo){
        cards[i] = "";
      }
    }
    return;
  }

  // Store the three cards that were selected into the cards array and then check for a set once the third card has been selected
  if(cards[0] == ""){
    cards[0] = cardInfo;
  } else if (cards[1] == "") {
    cards[1] = cardInfo;
  } else {
    cards[2] = cardInfo;
    setTimeout(function () {
      const isMatch = checkSet(cards);
      if(isMatch) {

        // Match found - update score and update the board
        score++;
        document.getElementById('score').innerHTML = score;
        alert("You got a set!");
        removeThree(cardOne, cardTwo, cardThree);
        addThree();
      } else {

        // Match not found - decrement score and deselect cards by changing the border back to black
        score--;
        alert("Incorrect set!");
        const selectedCards = document.getElementsByClassName("selectedCard");
        for (let i = 0; i < selectedCards.length; i++) {
          selectedCards[i].parentElement.style.border = "3px solid #bfbfbf";
        }
        document.getElementById('score').innerHTML = score;
      }
    }, 100);
  }
};

function shuffleBoard() {
  let newBoard = new Array();
  while(board.length > 0) {
    newBoard.push(draw(board));
  }
  board = newBoard;
  displayBoard();
}

function newGame() {
  deck = getDeck();
  board = dealBoard();
  score = 0;
  cards = ["", "", ""];
  document.getElementById("score").innerHTML = score;
  document.getElementById("gameRules").style.display = "none";
  displayBoard();
}

/**
 * Finds if the selected cards form a correct set
 * @param {Array} cardSet array of cards that are selected
 */
function checkSet(cardSet) {
  let cardOne = cardSet[0].split(" ");
  let cardTwo = cardSet[1].split(" ");
  let cardThree = cardSet[2].split(" ");
  cards = ["", "", ""];
  if((allSame(cardOne[0], cardTwo[0], cardThree[0]) || allDifferent(cardOne[0], cardTwo[0], cardThree[0])) &&
     (allSame(cardOne[1], cardTwo[1], cardThree[1]) || allDifferent(cardOne[1], cardTwo[1], cardThree[1])) &&
     (allSame(cardOne[2], cardTwo[2], cardThree[2]) || allDifferent(cardOne[2], cardTwo[2], cardThree[2])) &&
     (allSame(cardOne[3], cardTwo[3], cardThree[3]) || allDifferent(cardOne[3], cardTwo[3], cardThree[3]))) {
      //if in here then a match was found hooray
      return true;
     
  } else {
    return false;
  }
}

function allSame(one, two, three) {
  return (one == two && two == three);
}

function allDifferent(one, two, three) {
  return (one != two && one != three && two != three);
}


function removeThree(cardOne, cardTwo, cardThree){
  let newBoard = new Array();
  for (let i = 0; i < 12; i++) {
    if((board[i].number == cardOne[0] && board[i].fill == cardOne[1] && board[i].color == cardOne[2] && board[i].shape == cardOne[3]) ||
      (board[i].number == cardTwo[0] && board[i].fill == cardTwo[1] && board[i].color == cardTwo[2] && board[i].shape == cardTwo[3]) ||
      (board[i].number == cardThree[0] && board[i].fill == cardThree[1] && board[i].color == cardThree[2] && board[i].shape == cardThree[3]))
      alert(board[i].number);
    else {
      newBoard.push(board[i]);
    }
  }
  board = newBoard;
}

function addThree(){
  let newBoard = new Array();
  newBoard = board;
  newBoard.push(draw(deck));
  newBoard.push(draw(deck));
  newBoard.push(draw(deck));
  board = newBoard;
  displayBoard();
}

function openRules () {
  document.getElementById("rules-background").style.display = "block";
  document.getElementById("rules-content").style.display = "block";
}

function closeRules() {
  document.getElementById("rules-background").style.display = "none";
  document.getElementById("rules-content").style.display = "none";
}


/**
 * SOURCE: https://gist.github.com/axelpale/3118596
 * Get k-sized combinations of elements in a set
 * @param {Array} set Array of objects of any type
 * @param {number} k size of combinations to search for
 */
function k_combinations(set, k) {
	var i, j, combs, head, tailcombs;
	
	// There is no way to take e.g. sets of 5 elements from
	// a set of 4.
	if (k > set.length || k <= 0) {
		return [];
	}
	
	// K-sized set has only one K-sized subset.
	if (k == set.length) {
		return [set];
	}
	
	// There is N 1-sized subsets in a N-sized set.
	if (k == 1) {
		combs = [];
		for (i = 0; i < set.length; i++) {
			combs.push([set[i]]);
		}
		return combs;
	}
	
	// Assert {1 < k < set.length}
	
	// Algorithm description:
	// To get k-combinations of a set, we want to join each element
	// with all (k-1)-combinations of the other elements. The set of
	// these k-sized sets would be the desired result. However, as we
	// represent sets with lists, we need to take duplicates into
	// account. To avoid producing duplicates and also unnecessary
	// computing, we use the following approach: each element i
	// divides the list into three: the preceding elements, the
	// current element i, and the subsequent elements. For the first
	// element, the list of preceding elements is empty. For element i,
	// we compute the (k-1)-computations of the subsequent elements,
	// join each with the element i, and store the joined to the set of
	// computed k-combinations. We do not need to take the preceding
	// elements into account, because they have already been the i:th
	// element so they are already computed and stored. When the length
	// of the subsequent list drops below (k-1), we cannot find any
	// (k-1)-combs, hence the upper limit for the iteration:
	combs = [];
	for (i = 0; i < set.length - k + 1; i++) {
		// head is a list that includes only our current element.
		head = set.slice(i, i + 1);
		// We take smaller combinations from the subsequent elements
		tailcombs = k_combinations(set.slice(i + 1), k - 1);
		// For each (k-1)-combination we join it with the current
		// and store it to the set of k-combinations.
		for (j = 0; j < tailcombs.length; j++) {
			combs.push(head.concat(tailcombs[j]));
		}
	}
	return combs;
}