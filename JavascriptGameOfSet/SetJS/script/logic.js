var deck = getDeck();
var board = dealBoard();
var cards = ["", "", ""];
var score = 0;


function getDeck() {
  const numbers = ["one", "two", "three"];
  const fills = ["blank", "solid", "striped"];
  const colors = ["red", "purple", "yellow"];
  const shapes = ["glasses", "hallows", "lightning"];
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

function draw(pile) {
  let index = Math.floor(Math.random()*pile.length);
  return pile.splice(index,1)[0];
}

function dealBoard() {
  let board = new Array();
  for (let i = 0; i < 12; i++) {
    board.push(draw(deck));
  }
  return board;
}

function displayBoard() {
  document.getElementById('board').innerHTML = '';
  for (let i = 0; i < board.length; i++) {
    let card = board[i];
    let cardDiv = document.createElement("div");
    let cardPic = document.createElement("img");
    cardPic.onclick = () => userClickEvent(cardPic.alt);
    cardPic.src = "../pictures/" + card.number + "-" + card.fill + "-" + card.color + "-" + card.shape + ".png";
    cardPic.alt = card.number + " " + card.fill + " " + card.color + " " + card.shape
    cardPic.className = "card";
    cardDiv.appendChild(cardPic);
    document.getElementById('board').appendChild(cardDiv);
  }
}

//this function deals with when the user chooses a card
function userClickEvent(cardInfo) {
  //first make sure that this card wasn't previously selected
  if(cards[0] == cardInfo || cards[1] == cardInfo || cards[2] == cardInfo){
    alert("Error: A Card Has Been Selected More Than Once");
    return;
  }

  if(cards[0] == ""){
    cards[0] = cardInfo;
  } else if (cards[1] == "") {
    cards[1] = cardInfo;
  } else {
    cards[2] = cardInfo;
    checkSet();
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
  displayBoard();
}

function checkSet() {
  let cardOne = cards[0].split(" ");
  let cardTwo = cards[1].split(" ");
  let cardThree = cards[2].split(" ");
  if((allSame(cardOne[0], cardTwo[0], cardThree[0]) || allDifferent(cardOne[0], cardTwo[0], cardThree[0])) &&
     (allSame(cardOne[1], cardTwo[1], cardThree[1]) || allDifferent(cardOne[1], cardTwo[1], cardThree[1])) &&
     (allSame(cardOne[2], cardTwo[2], cardThree[2]) || allDifferent(cardOne[2], cardTwo[2], cardThree[2])) &&
     (allSame(cardOne[3], cardTwo[3], cardThree[3]) || allDifferent(cardOne[3], cardTwo[3], cardThree[3]))) {
      //if in here then a match was found hooray
      score++;
      document.getElementById('score').innerHTML = score;
  } else {
    score--;
    document.getElementById('score').innerHTML = score;
  }

  cards = ["", "", ""];
}

function allSame(one, two, three) {
  return (one == two && two == three);
}

function allDifferent(one, two, three) {
  return (one != two && one != three);
}
