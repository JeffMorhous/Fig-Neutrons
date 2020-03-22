var deck = getDeck();
var board = dealBoard();
var cards = ["", "", ""];
var score;
var p1Score;
var p2Score;
var turn = false; //if true it is player 1's turn
var multiplayer = false; //false = singleplayer, true = multiplayer
var multiplayerTemp = false;
var difficulty = 1; //1 = easy, 2 = medium, 3 = hard
var difficultyTemp = 1;


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
 * @param {boolean} hint a boolean variable to indicate if an alert is brought up when clicking hint
 */
function numberOfSets(hint) {
  let i=0;
  let numMatches = 0;
  while(board.length-i >= 3) {
    card1=board[i]; 
    for(j=i+1;j<board.length-1;j++) {
      card2=board[j];
      for(r=j+1;r<board.length;r++) {function setPlayer(players){
  if(players == "Singleplayer"){
    multiplayerTemp = false;
  } else {
    multiplayerTemp = true;
  }

  if(difficulty != null){
    document.getElementById("menuStartButton").disabled = false;
  }
}
        card3=board[r];
        let card1String = `${card1.number} ${card1.fill} ${card1.color} ${card1.shape}`;
        let card2String = `${card2.number} ${card2.fill} ${card2.color} ${card2.shape}`
        let card3String = `${card3.number} ${card3.fill} ${card3.color} ${card3.shape}`
        if (checkSet([card1String, card2String, card3String])) {
          numMatches ++;
        }
      } 
    }
    i+=1;
  }
  if (hint) {
    if (numMatches === 1) {
      alert(`There is ${numMatches} match`);
    } else {
      alert(`There are ${numMatches} matches`);
    }
    updateScore(-1);
  }
  return numMatches;
}

/**
 * Returns the number of matches found on the board
 * @param {Array} board array consisting of 12 cards to represent the current board
 */
function findASet() {
  let i=0;
  let numMatches = 0;
  while(board.length-i >= 3) {
    card1=board[i]; 
    for(j=i+1;j<board.length-1;j++) {
      card2=board[j];
      for(r=j+1;r<board.length;r++) {
        card3=board[r];
        let card1String = `${card1.number} ${card1.fill} ${card1.color} ${card1.shape}`;
        let card2String = `${card2.number} ${card2.fill} ${card2.color} ${card2.shape}`
        let card3String = `${card3.number} ${card3.fill} ${card3.color} ${card3.shape}`
        if  (checkSet([card1String, card2String, card3String])) {
          document.querySelector(`img[alt='${card1String}']`).parentElement.style.backgroundColor = "yellow";
          document.querySelector(`img[alt='${card2String}']`).parentElement.style.backgroundColor = "yellow";
          document.querySelector(`img[alt='${card3String}']`).parentElement.style.backgroundColor = "yellow";
          updateScore(-2);
          return;
        }
      } 
    }
    i+=1;
  }
  return numMatches ++;
}

function dealBoard() {
  board = new Array();

  //the cards in the board will be regenerated as many times as is necessary to ensure
  //there is at least one match
  do {
    for (let i = 0; i < 12; i++) {
      board.push(draw(deck));
    }
  } while (numberOfSets(false) == 0)

  return board;
}

/**
 * Display the cards by creating a 3x4 table for all the cards in the board
 */
function displayBoard() {
  document.getElementById('setBoard').innerHTML = '';
  let cardTableRow = document.createElement("TR");
  for(let j = 0; j < board.length; j++) {
    let cardTableEntry = document.createElement("TD");
    cardTableEntry.className = "cardTableEntry";
    let card = board[j];
    let cardPic = document.createElement("img");
    cardTableEntry.onclick = () => userClickEvent(cardPic);
    cardPic.src = "../pictures/SET/" + card.number + "-" + card.fill + "-" + card.color + "-" + card.shape + ".png";
    cardPic.alt = card.number + " " + card.fill + " " + card.color + " " + card.shape;
    cardPic.className = "card";
    cardPic.style.display = "block";
    cardTableEntry.appendChild(cardPic)
    cardTableRow.appendChild(cardTableEntry);

    // Start a new row after 4 cards have been placed
    if( (j+1) % 6 == 0 ) {
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
    let cardOne = cards[0].split(" ");
    let cardTwo = cards[1].split(" ");
    let cardThree = cards[2].split(" ");
    setTimeout(function () {
      const isMatch = checkSet(cards);
      if(isMatch) {
        
        // Match found - update score and update the board
        updateScore(3);
        document.getElementById('score').innerHTML = score;
        removeThree(cardOne, cardTwo, cardThree);
        addThree();
        alert("You got a set!");

      } else {

        // Match not found - decrement score and deselect cards by changing the border back to black
        updateScore(-1);
        alert("Incorrect set!");
        const selectedCards = document.getElementsByClassName("selectedCard");
        for (let i = 0; i < selectedCards.length; i++) {
          selectedCards[i].parentElement.style.border = "3px solid #bfbfbf";
        }
        document.getElementById('score').innerHTML = score;
      }
      if(multiplayer){
        turn = !turn;
        if(turn){
          document.getElementById('player').innerHTML = "2";
        } else {
          document.getElementById('player').innerHTML = "1";
        }
      }
    }, 100);
  }
};

/**
 * Shuffle the cards on the board by reordering the board array
 */
function shuffleBoard() {
  let newBoard = new Array();
  while(board.length > 0) {
    newBoard.push(draw(board));
  }
  board = newBoard;
  document.getElementById("gameRules").style.display = "none";
  displayBoard();
}

/**
 * Start a new game of SET by filling the deck and dealing the board
 */
function newGame() {
  difficulty = difficultyTemp;
  multiplayer = multiplayerTemp;
  document.getElementById("player").innerHTML = "1";
  p1Score = 0;
  p2Score = 0;
  updateScore(0);
  deck = getDeck();
  board = dealBoard();
  cards = ["", "", ""];
  setUINewGame();
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

/**
 * Check if all the properties of the 3 cards are the same
 * @param {string} one the first card's properties
 * @param {string} two the second card's properties
 * @param {string} three the third card's properties
 */
function allSame(one, two, three) {
  return (one == two && two == three);
}

/**
 * Check if all the properties of the 3 cards are different
 * @param {string} one the first card's properties
 * @param {string} two the second card's properties
 * @param {string} three the third card's properties
 */
function allDifferent(one, two, three) {
  return (one != two && one != three && two != three);
}

/**
 * Remove three cards out of the current cards on the board
 * @param {Array} cardOne the properties of the first card
 * @param {Array} cardTwo the properties of the second card
 * @param {Array} cardThree the properties of the third card
 */
function removeThree(cardOne, cardTwo, cardThree){
  let newBoard = new Array();
  for (let i = 0; i < 12; i++) {
    if((board[i].number == cardOne[0] && board[i].fill == cardOne[1] && board[i].color == cardOne[2] && board[i].shape == cardOne[3]) ||
      (board[i].number == cardTwo[0] && board[i].fill == cardTwo[1] && board[i].color == cardTwo[2] && board[i].shape == cardTwo[3]) ||
      (board[i].number == cardThree[0] && board[i].fill == cardThree[1] && board[i].color == cardThree[2] && board[i].shape == cardThree[3])){}
      // alert(board[i].number);
    else {
      newBoard.push(board[i]);
    }
  }
  board = newBoard;
}

/**
 * Add three cards to the board
 */
function addThree(){
  let newBoard = new Array();
  newBoard = board;
  newBoard.push(draw(deck));
  newBoard.push(draw(deck));
  newBoard.push(draw(deck));
  board = newBoard;
  displayBoard();
}

/**
 * Update the player's score
 * @param {number} scoreVal 
 */
function updateScore(scoreVal){
  if(turn){
    p2Score+=scoreVal;
  } else {
    p1Score+=scoreVal;
  }

  if(multiplayer){
    score = "Player 1: " + p1Score.toString() + " Player 2: " + p2Score.toString();
  } else {
    score = "Score: " + p1Score.toString();
  }
  document.getElementById("score").innerHTML = score;
}

/**
 * Open the rules modal
 */
function openRules () {
  document.getElementById("rules-background").style.display = "block";
  document.getElementById("rules-content").style.display = "block";
}

/**
 * Close the rules modal
 */
function closeRules() {
  document.getElementById("rules-background").style.display = "none";
  document.getElementById("rules-content").style.display = "none";
}

function openNewGameMenu(){
  document.getElementById("menu-background").style.display = "block";
  document.getElementById("menu-content").style.display = "block";
}

function closeNewGameMenu(){
  document.getElementById("menu-background").style.display = "none";
  document.getElementById("menu-content").style.display = "none";
}
/**
 * Update the state of the UI to show and enable buttons
 */
function setUINewGame(){
  closeNewGameMenu();
  document.getElementById("topNavRules").style.display= "unset";
  document.getElementsByClassName("topNavScore")[0].style.display = "unset";
  document.getElementById("score").innerHTML = score;
  document.getElementById("gameRules").style.display = "none";
  if(multiplayer){
    document.getElementById("currentPlayer").style.display = "block";
  } else {
    document.getElementById("currentPlayer").style.display = "none";
  }
  document.getElementById("topNavShuffle").disabled = false;
  document.getElementById("topNavFindSet").disabled = false;
  document.getElementById("topNavNumSet").disabled = false;
}

function setPlayer(players){
  if(players == "Singleplayer"){
    multiplayerTemp = false;
  } else {
    multiplayerTemp = true;
  }

  if(difficultyTemp != null){
    document.getElementById("menuStartButton").disabled = false;
  }
}

function setDifficulty(challenge){
  if(challenge == "Easy"){
    difficultyTemp = 1;
  } else if(challenge == "Medium") {
    difficultyTemp = 2;
  } else {
    difficultyTemp = 3;
  }

  if(multiplayerTemp != null){
    document.getElementById("menuStartButton").disabled = false;
  }
}

c