var toggleBtn = document.getElementById('toggle_answer');
toggleBtn.addEventListener('click', function() {
  var answers = document.getElementsByClassName('answer');
  for (var i = 0; i < answers.length; i++) {
    if (answers[i].style.display === 'none' || answers[i].style.display === '') {
      toggleBtn.innerHTML = 'Hide Answers';
      answers[i].style.display =  'block';
    } else {
      toggleBtn.innerHTML = 'Show Answers';
      answers[i].style.display =  'none';
    }
  }
});
