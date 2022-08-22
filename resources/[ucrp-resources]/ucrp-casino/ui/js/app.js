function DisplayUi(toggle) {
	if (toggle == true) {
		$(".main-container").slideDown(250)
		$(".main-container").fadeIn(250)
	} else if (toggle == false) {
		$(".main-container").slideUp(250)
		$(".main-container").fadeOut(250)
	}
}

function SetValue(className, text) {
	$(`.${className}`).html(text)
}

$(function () {   
	window.addEventListener('message', function (event) {
		const data = event.data;
		if (typeof data.show !== 'undefined') { DisplayUi(data.show) } // Works
		if (typeof data.currentHand !== 'undefined') { SetValue("selfcount-text", data.currentHand) } // Works
		if (typeof data.dealersHand !== 'undefined') { SetValue("dealercount-text", data.dealersHand) } // Works
		if (typeof data.currentBetAmount !== 'undefined') {  SetValue("cash-text", `Blackjack ($${data.currentBetAmount} / $${data.maxBetAmount})`)  } // Works Fine
		if (typeof data.time !== 'undefined') { SetValue("time-text", data.time) } // Works
		if (typeof data.balance !== 'undefined') { SetValue("balance-text", data.balance) } // Works
		if (typeof data.cashtext !== 'undefined') { SetValue("cash-text", data.cashtext) } // Works
	});

});