// Check for winning states - after 5th move?
// Save winning id and redirect to each users results page

var board =[];
var index;
var currentUser;
var piece;
var gameID;
var newBoard;
var ref;

$(document).ready(function() {

  gameID = $("#game_id");

  function renderBoard(newStuff) {
    board = JSON.parse(newStuff.board);
    $("span#0").html(board[0]);
    $("span#1").html(board[1]);
    $("span#2").html(board[2]);
    $("span#3").html(board[3]);
    $("span#4").html(board[4]);
    $("span#5").html(board[5]);
    $("span#6").html(board[6]);
    $("span#7").html(board[7]);
    $("span#8").html(board[8]);
    $("#turn_id").html(newStuff.turn_id);
  }

  function getBoard() {
   $.get("/game/" + gameID.html() + "/status", {}, function(newStuff) {
      renderBoard(newStuff);
    });
  }

  setInterval(function(){
    getBoard();
  }, 1000);

  // getBoard();

  ref = ".container #gameboard .current_turn ";
  if ($(ref + '#current_user_id').html() == $(ref + '#creator_id').html()) {
    piece = "X";
  } else {
    piece = "O";
  }

  $('#gameboard span').click(function() {
    if ($('#current_user_id').html() == $(ref + '#turn_id').html() && $(this).html() === "") {
      index = $(this).attr("id");
      $('span#' + index).html(piece);
      board[index] = piece;
      var turnID = $(ref + '#turn_id').html();
      var jboard = JSON.stringify(board);
      $.post("/game/" + gameID.html() + "/update", {"board": jboard, "turn_id": turnID}, function(){
        getBoard();
      });
    }
  });

});
