// Script.js

//Functions
function calculateTip(){
    
    //store data of inputs
    var billAmount = document.getElementById("billAmount").value;
    var serviceQuality = document.getElementById("serviceQuality").value;
    var numPeople = document.getElementById("totalPeople").value;
    
    //Quick Validation
    if(billAmount === "" || serviceQuality == 0){
        window.alert("Please enter some numbers to find out how much to tip!");
        return; //this will stop the function continuing.
    }
    
    //check to see if the input is less than or equal to 1
    if(numPeople === ""|| numPeople<=1){
        numPeople = 1;
        document.getElementById("each").style.display = "none";
    } else {
        document.getElementById("each").style.display = "block";
    }
    
    // Do Some Math
    var total = (billAmount * serviceQuality)/numPeople;
    total = Math.round(total * 100) /100;
    total = total.toFixed(2);
    
    // Display The Tip
    document.getElementById("totalTip").style.display = "block";
    document.getElementById("tip").innerHTML = total;
}

//Hide the tip amount on load
document.getElementById("totalTip").style.display ="none";
document.getElementById("each").style.display = "none";

//clicking the button calls our custom function
document.getElementById("calculate").onclick = function(){calculateTip();};


