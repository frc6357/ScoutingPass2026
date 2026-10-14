FRC 6357 Scouting Pass

Contents of the scouting pass.
1) Assets:
	General - contains images that will likely be used each season.
	Season Specific - contains temporary images and should be deleted when making a new copy of the scouting pass.
2) Scenes:
	General - contains pages that may be used each season, but can also be deleted if unimportant.
	
	Important - contains scenes that are essential to all scouting passes and SHOULD NEVER BE DELETED. These files include:
		data_storage.tscn - contains the data_storage script
		history.tscn - Allows the user to access previously recorded data in the form of QR codes.
		main.tscn - The main menu for the scouting pass. The code starts running in this scene.
		qr_code_generator - Contains the QR code generating feature and all code needed to run it.
		settings.tscn - Allows the user to mess with the export format of the scouting pass.
		
	Season Specific - Contains scenes that will consistently be used but need to be reset each season:
		help_auto -  Gives the user instructions on how to use the auto portion(s) of scouting.
		help_tele - Gives the user instructions on how to use the teleop portion(s) of scouting.
		match_scouting(1-4) - Put the methods of collecting any match data you need in these files.
		pit_scouting - Put the pit scouting questions here.
3) Scripts:
	General - Contains scripts that are consistently used, but not vital to the scouting pass
	Important - Contains scripts that are essential for the scouting pass to run properly:
		clear_data.gd - Clears all scouting data from the device's memory
		data_storage.gd - Contains all major variables. Stores and loads data on the device.
		history.gd - Lets the user navigate through the QR codes from previous matches
		main.gd - Allows the user to navigate between various important files
		qr_code_generator - generates a qr code based on the data in data_storage.
		settings.gd - changes the method of exporting datd through the qr codes.
	Season Specific -  Contains scripts that may be consistently used but need to be reset each season
	

How to set up the Scouting Pass for a new season:
	1. Plan out the layout for the scouting pass on paper.
	2. Create a copy of the scouting pass and rename it to match the current season.
	3. Delete all season specific assets.
	4. Create a new file titled match_scouting.tscn or reuse the existing one. Use this file to collect data for autonomous.
	5. Add additional match_scouting files as needed. (Teleop, Endgame, etc.)
