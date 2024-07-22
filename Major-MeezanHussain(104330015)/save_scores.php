<?php
include 'settings.php'; // Include settings for database connection

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve data from POST request and trim any potential whitespace
$archerID = trim($_POST['archerID']);
$roundID = trim($_POST['roundID']);
$rangeID = trim($_POST['rangeID']);
$equipmentID = trim($_POST['equipmentID']);
$scores = array_map('trim', explode(',', $_POST['scores']));

if (count($scores) != 6) {
    die('Invalid number of scores provided.');
}

// Convert scores to integers
$scores = array_map('intval', $scores);

$conn->query("START TRANSACTION");

try {
    // Insert a new end without specifying the EndID (AUTO_INCREMENT will handle it)
    $insertEndQuery = "INSERT INTO `End` (Arrow1, Arrow2, Arrow3, Arrow4, Arrow5, Arrow6) VALUES (?, ?, ?, ?, ?, ?)";
    $endStmt = $conn->prepare($insertEndQuery);
    if (!$endStmt) {
        throw new Exception('Prepare failed for end insert: ' . $conn->error);
    }

    // Bind each score individually
    $endStmt->bind_param("iiiiii", $scores[0], $scores[1], $scores[2], $scores[3], $scores[4], $scores[5]);

    if (!$endStmt->execute()) {
        throw new Exception('Execute failed for end insert: ' . $endStmt->error);
    }
    $generatedEndID = $conn->insert_id; // Get the last inserted ID for End
    $endStmt->close();

    // Insert into Score table
    $insertScoreQuery = "INSERT INTO `Score` (EndID) VALUES (?)";
    $scoreStmt = $conn->prepare($insertScoreQuery);
    if (!$scoreStmt) {
        throw new Exception('Prepare failed for score insert: ' . $conn->error);
    }
    if (!$scoreStmt->bind_param("i", $generatedEndID)) {
        throw new Exception('Binding parameters failed for score insert: ' . $scoreStmt->error);
    }
    if (!$scoreStmt->execute()) {
        throw new Exception('Execute failed for score insert: ' . $scoreStmt->error);
    }
    $scoreID = $conn->insert_id; // Get the last inserted ID for Score
    $scoreStmt->close();

    // Verify that the RangeID exists in the Ranges table
    $rangeCheckQuery = "SELECT COUNT(*) AS count FROM Ranges WHERE TRIM(RangeID) = ?";
    $rangeCheckStmt = $conn->prepare($rangeCheckQuery);
    if (!$rangeCheckStmt) {
        throw new Exception('Prepare failed for range check: ' . $conn->error);
    }
    if (!$rangeCheckStmt->bind_param("s", $rangeID)) {
        throw new Exception('Binding parameters failed for range check: ' . $rangeCheckStmt->error);
    }
    if (!$rangeCheckStmt->execute()) {
        throw new Exception('Execute failed for range check: ' . $rangeCheckStmt->error);
    }
    $rangeCheckResult = $rangeCheckStmt->get_result();
    $rangeCheck = $rangeCheckResult->fetch_assoc();
    $rangeCheckStmt->close();
    
    if ($rangeCheck['count'] == 0) {
        throw new Exception("Invalid RangeID: $rangeID does not exist in the Ranges table.");
    }

    // Insert the staging record without specifying the StagingID (AUTO_INCREMENT will handle it)
    $insertStagingQuery = "INSERT INTO `Staging` (ArcherID, EquipmentID, ScoreID, RoundID, RangeID, StageDate, StageTime) VALUES (?, ?, ?, ?, ?, CURDATE(), CURTIME())";
    $stagingStmt = $conn->prepare($insertStagingQuery);
    if (!$stagingStmt) {
        throw new Exception('Prepare failed for staging insert: ' . $conn->error);
    }

    // Explicitly cast all variables to ensure correct types
    $archerID = (int)$archerID;
    $scoreID = (int)$scoreID;
    $roundID = (int)$roundID;
    $rangeID = (string)$rangeID;

    // Corrected the bind_param call to match the number of placeholders in the query
    if (!$stagingStmt->bind_param("isiis", $archerID, $equipmentID, $scoreID, $roundID, $rangeID)) {
        throw new Exception('Binding parameters failed for staging insert: ' . $stagingStmt->error);
    }
    if (!$stagingStmt->execute()) {
        throw new Exception('Execute failed for staging insert: ' . $stagingStmt->error);
    }
    $stagingStmt->close();

    $conn->query("COMMIT"); // Commit the transaction
    echo "Scores saved successfully!";
} catch (Exception $e) {
    $conn->query("ROLLBACK"); // Roll back the transaction on error
    echo $e->getMessage();
}

$conn->close();
?>
