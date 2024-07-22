<?php
include 'settings.php'; // Include settings for database connection

// Retrieve the passed ArcherID, RoundID, RangeID, and EquipmentID from POST request
$archerID = $_POST['archerID'];
$roundID = $_POST['roundID'];
$rangeID = $_POST['rangeID'];
$equipmentID = $_POST['equipmentID'];

// Fetch archer details
$archerQuery = "SELECT FirstName, LastName FROM Archer WHERE ArcherID = ?";
$archerStmt = $conn->prepare($archerQuery);
if ($archerStmt === false) {
    die('Prepare failed: ' . htmlspecialchars($conn->error));
}
$archerStmt->bind_param("i", $archerID);
$archerStmt->execute();
$archerResult = $archerStmt->get_result();
$archer = $archerResult->fetch_assoc();
$archerStmt->close();

// Fetch equipment details
$equipmentQuery = "SELECT Types FROM Equipment WHERE EquipmentID = ?";
$equipmentStmt = $conn->prepare($equipmentQuery);
if ($equipmentStmt === false) {
    die('Prepare failed: ' . htmlspecialchars($conn->error));
}
$equipmentStmt->bind_param("s", $equipmentID);
$equipmentStmt->execute();
$equipmentResult = $equipmentStmt->get_result();
$equipment = $equipmentResult->fetch_assoc();
$equipmentStmt->close();

// Fetch round and range details combined
$detailsQuery = "SELECT R.Range AS Distance, RD.RoundName 
                 FROM Ranges R
                 JOIN Round RD ON RD.RoundID = ?";
$detailsStmt = $conn->prepare($detailsQuery);
if ($detailsStmt === false) {
    die('Prepare failed: ' . htmlspecialchars($conn->error));
}
$detailsStmt->bind_param("i", $roundID);
$detailsStmt->execute();
$detailsResult = $detailsStmt->get_result();
$details = $detailsResult->fetch_assoc();
$detailsStmt->close();

// Define the scores and their labels
$scores = ['X' => 10, '10' => 10, '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2, '1' => 1, 'M' => 0];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Score Entry</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #eef;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .score-entry {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }

        #score-buttons {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin: 20px 0;
        }

        .score-button {
            padding: 10px 0;
            font-size: 16px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        .score-button:active {
            background-color: #367B39;
        }

        input {
            margin-top: 10px;
            text-align: center;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 4px;
        }

        button {
            margin-top: 10px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        h1 {
            color: #005f69;
            text-align: center;
        }
    </style>
    <script src="script.js"></script> 
</head>
<body>
    <div class="score-entry">
        <h2><?= htmlspecialchars($archer['FirstName']) . ' ' . htmlspecialchars($archer['LastName']) ?>, <?= htmlspecialchars($equipment['Types']) ?></h2>
        <p><?= htmlspecialchars($details['Distance']) ?>m <?= htmlspecialchars($details['RoundName']) ?></p>
        <form id="score-form" action="save_scores.php" method="post">
            <div id="score-buttons">
                <?php foreach ($scores as $label => $value): ?>
                    <button type="button" class="score-button" data-score="<?= $value ?>"><?= $label ?></button>
                <?php endforeach; ?>
            </div>
            <input type="text" id="scores-input" readonly>
            <input type="text" id="total" readonly>
            <input type="hidden" name="archerID" value="<?= htmlspecialchars($archerID) ?>">
            <input type="hidden" name="roundID" value="<?= htmlspecialchars($roundID) ?>">
            <input type="hidden" name="rangeID" value="<?= htmlspecialchars($rangeID) ?>">
            <input type="hidden" name="equipmentID" value="<?= htmlspecialchars($equipmentID) ?>">
            <input type="hidden" name="scores" id="scores">
            <input type="hidden" name="total" id="total-score">
            <button type="button" id="reset">Cancel</button>
            <button type="submit" id="save">Save</button>
        </form>
    </div>
</body>
</html>
