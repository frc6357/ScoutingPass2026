extends Node2D
#Description: 
#This script generates a QR code with the requested pit or match data.
#Variables for this script.
@onready var data: Node2D = $"../DataStorage"
@onready var qr_code: QRCodeRect = $QRCodeRect

var storedData
var combinedData

#Functions for this script:
#generate_pit: generates a QR code for the pit data of whichever robot's number is contained in data.team
#generate_all_pit: generates a QR code for the pit data of ALL robots contained in data.pit_history
#generate: generates a QR code for the match data from the match contained in data.matchNum
#generate_between(first,last): generates a QR code containing the combined data of all matches between first and last. (including first and last)t

func generate_pit():
	#Placeholder in case a robot matching data.team is not found in data.pit_history
	storedData="No pit data on this robot" 
	
	#Searches for a robot matching data.team in data.pit_history and stores its information in storedData
	for robot in data.pit_history:
		if robot[0]==data.team:
			storedData=str(robot)
			storedData=storedData.replace("[","").replace("]","").replace('"',"").replace(" ","")
	
	#Adjusts storedData's format and stores it in a QR code
	storedData=(data.prefix2+storedData).to_utf8_buffer()
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	
	#prints the QR code data so we can make sure everything is working properly without having to scan the codee
	print("QR code data: "+qr_code.data)

func generate_all_pit():
	#placeholder for combined data in case list is empty
	combinedData=''
	
	#Puts all pit data into one list with individual teams seperated by "`" 
	#This allows it to be added to the http server easier. 
	#If you are using another method to store the data, you can swap "`" out with "/N" or something like that)
	for i in range(len(data.pit_history)):
		combinedData+=str(data.pit_history[i])
		if i<len(data.pit_history)-1:
			combinedData+="`"

	#removes characters which can cause issues with http server (or other exporting methods)
	combinedData=combinedData.replace("[","").replace("]","").replace('"',"").replace(" ","")
	combinedData=data.prefix2+combinedData
	
	#Stores the data in a QR code.
	storedData=(combinedData).to_utf8_buffer() 
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	
	#prints the QR code data so we can make sure everything is working properly without having to scan the codee
	print("QR code data: "+qr_code.data)
	
func generate():
	#adjusts QR code scale
	qr_code.scale.x=1
	qr_code.scale.y=1
	
	#Creates placeholder for storedData in case data.matchNum doesn't exist in data.history
	storedData="there is no data from this match"
	
	#Searches data.history for match #data.matchNum and stores it in storedData
	for round in data.history:
		if round[1]==data.matchNum:
			storedData=str(round)
			storedData=storedData.replace("[","").replace("]","").replace('"',"").replace(" ","")
	
	#Stores the sortedData in a QR code
	storedData=(data.prefix+storedData).to_utf8_buffer()
	qr_code._qr.put_byte(storedData)
	qr_code._update_qr()
	
	#prints the QR code data so we can make sure everything is working properly without having to scan the codee
	print("QR code data: "+qr_code.data)
	
func generate_between(first,last):
	#placeholder for combinedData
	combinedData=''
	
	#makes shure the imputed values are numbers
	if first.is_valid_int() and last.is_valid_int():
		first=int(first)
		last=int(last)
		
		#Puts all data between first and last into one list with individual matches seperated by "`" 
		#This allows it to be added to the http server easier. 
		#If you are using another method to store the data, you can swap "`" out with "/N" or something like that)
		for _match in data.history:
			
			#Adds the match if it is between first and last
			if first<=int(_match[1]) and int(_match[1]<=last):
				combinedData+=str(_match)+"`"
		combinedData=combinedData.left(-1) #removes the last "`" from the string
		combinedData=combinedData.replace("[","").replace("]","").replace('"',"").replace(" ","")

		#Stores combinedData in a QR code
		combinedData=(data.prefix+combinedData).to_utf8_buffer()
		qr_code._qr.put_byte(combinedData)
		
		#Adjusts QR code scale to account for how large this data can get
		qr_code.scale.x=1-.1*(last-first)
		qr_code.scale.y=1-.1*(last-first)
		
		#Makes sure the code isn't smaller than a set value.
		if qr_code.scale.x<.25:
			qr_code.scale.x=.25
			qr_code.scale.y=.25
		qr_code._update_qr()
		
		#Prints the QR code data so we can make sure everything is working properly without having to scan the codee
		print("QR code data: "+qr_code.data)
	else:
		#generates a normal QR code if numbers aren't valid
		generate()
