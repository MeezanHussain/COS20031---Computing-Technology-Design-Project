document.addEventListener('DOMContentLoaded', function() {
    const scoreButtons = document.querySelectorAll('.score-button');
    const scoreInput = document.getElementById('scores-input');
    const totalDisplay = document.getElementById('total');
    let scores = [];

    scoreButtons.forEach(button => {
        button.addEventListener('click', function() {
            if (scores.length < 6) { // Assuming a maximum of 6 scores can be recorded
                scores.push(this.getAttribute('data-score'));
                updateDisplay();
            }
        });
    });

    function updateDisplay() {
        scoreInput.value = scores.join(', ');
        totalDisplay.value = scores.reduce((total, num) => total + parseInt(num, 10), 0);
        document.getElementById('scores').value = scoreInput.value;  // Set hidden field for form submission
        document.getElementById('total-score').value = totalDisplay.value;  // Set hidden field for form submission
    }

    document.getElementById('score-form').addEventListener('submit', function(event) {
        // Make sure all scores are entered
        if (scores.length !== 6) {
            event.preventDefault();  // Prevent form submission
            alert("Please enter all 6 scores.");
        }
    });

    document.getElementById('reset').addEventListener('click', function() {
        scores = [];
        updateDisplay();
    });
});
