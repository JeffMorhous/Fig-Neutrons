var deck = getDeck();
var board = dealBoard();


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
    let cardPic = document.createElement("IMG");
    cardPic.src = "../pictures/" + card.number + "-" + card.fill + "-" + card.color + "-" + card.shape + ".png";
    cardPic.alt = card.number + " " + card.fill + " " + card.color + " " + card.shape
    cardPic.className = "card";
    cardDiv.appendChild(cardPic);
    document.getElementById('board').appendChild(cardDiv);
  }
}

function newGame() {
  deck = getDeck();
  board = dealBoard();
  displayBoard();
}

function shuffleBoard() {
  let newBoard = new Array();
  while(board.length > 0) {
    newBoard.push(draw(board));
  }
  board = newBoard;
  displayBoard();
}
