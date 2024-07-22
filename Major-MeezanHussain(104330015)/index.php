<?php
include 'settings.php';  // Include the settings for database connection

// Fetch rounds
$roundsQuery = "SELECT RoundID, RoundName FROM Round";
$roundsResult = $conn->query($roundsQuery);

// Fetch archers
$archersQuery = "SELECT ArcherID, FirstName, LastName FROM Archer";
$archersResult = $conn->query($archersQuery);

// Fetch equipment types from the Equipment table
$equipmentsQuery = "SELECT EquipmentID, Types FROM Equipment";
$equipmentsResult = $conn->query($equipmentsQuery);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="styles.css">
    <title>Archery Scoring Entry</title>
</head>
<body>
    <h1>Enter Score</h1>
    <form action="fetch_range.php" method="POST">
        <div>
            <label for="round">Choose round:</label>
            <select id="round" name="round">
                <?php while ($row = $roundsResult->fetch_assoc()): ?>
                    <option value="<?= $row['RoundID'] ?>"><?= $row['RoundName'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
        <div>
            <label for="archer">Choose archer:</label>
            <select id="archer" name="archer">
                <?php while ($row = $archersResult->fetch_assoc()): ?>
                    <option value="<?= $row['ArcherID'] ?>"><?= $row['FirstName'] . ' ' . $row['LastName'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
        <div>
            <label for="equipment">Select equipment:</label>
            <select id="equipment" name="EquipmentID">
                <?php while ($equip = $equipmentsResult->fetch_assoc()): ?>
                    <option value="<?= $equip['EquipmentID'] ?>"><?= $equip['Types'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
        <button type="submit">Submit</button>
    </form>
</body>
</html>
