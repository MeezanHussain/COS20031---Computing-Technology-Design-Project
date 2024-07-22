<?php
include 'settings.php';  // Include settings for database connection

// Retrieve the passed RoundID, ArcherID, and EquipmentID from POST request
$roundID = $_POST['round'];
$archerID = $_POST['archer'];
$equipmentID = $_POST['EquipmentID'];

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

// Fetch range details (assuming the Range table just has distances like 5 or 6 meters)
$rangeDetailsQuery = "SELECT RangeID, `Range` AS Distance FROM Ranges";
$rangeStmt = $conn->prepare($rangeDetailsQuery);

if ($rangeStmt === false) {
    die('Prepare failed: ' . htmlspecialchars($conn->error));
}

$rangeStmt->execute();
$rangeResult = $rangeStmt->get_result();
$rangeStmt->close();

// Fetch round details
$roundDetailsQuery = "SELECT RoundID, RoundName FROM Round WHERE RoundID = ?";
$roundStmt = $conn->prepare($roundDetailsQuery);

if ($roundStmt === false) {
    die('Prepare failed: ' . htmlspecialchars($conn->error));
}

$roundStmt->bind_param("i", $roundID);
$roundStmt->execute();
$roundResult = $roundStmt->get_result();
$round = $roundResult->fetch_assoc();
$roundStmt->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select End and Range</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Select End and Range for Scoring</h1>
    <div>
        <h2>Archer: <?= htmlspecialchars($archer['FirstName']) . ' ' . htmlspecialchars($archer['LastName']) ?></h2>
        <p>Round: <?= htmlspecialchars($round['RoundName']) ?></p>
        <form action="score_entry.php" method="post">
            <label for="range">Choose a Range:</label>
            <select id="range" name="rangeID">
                <?php while ($range = $rangeResult->fetch_assoc()): ?>
                    <option value="<?= $range['RangeID'] ?>"><?= $range['Distance'] ?>m</option>
                <?php endwhile; ?>
            </select>
            <!-- Include the archer ID, round ID, and equipment ID as hidden fields -->
            <input type="hidden" name="archerID" value="<?= $archerID ?>">
            <input type="hidden" name="roundID" value="<?= $roundID ?>">
            <input type="hidden" name="equipmentID" value="<?= $equipmentID ?>">
            <button type="submit">Proceed to Score Entry</button>
        </form>
    </div>
</body>
</html>
