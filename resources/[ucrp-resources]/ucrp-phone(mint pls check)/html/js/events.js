function btnHangUp(){
    $.post('https://ucrp-phone/btnHangup', JSON.stringify({}))
}

function btnAnswer(){
    $.post('https://ucrp-phone/btnAnswer', JSON.stringify({}))
}

function pingReject(){
    $.post('https://ucrp-phone/ucrp-ui:pingReject', JSON.stringify({}))
}

function pingAccept(){
    $.post('https://ucrp-phone/ucrp-ui:pingAccept', JSON.stringify({}))
}

function billDecline(){
}

function billAccept(data){
    if (data.pType == "car_sale") {   
        let price = data.amount
        let sID = data.sellerID
        let pType = data.pType
        $.post('https://ucrp-phone/purchaseCar', JSON.stringify({amount: price, sID: sID, pType: pType}))
    } else if (data.pType == "business_charge") {
        let price = data.amount
        let sID = data.sellerID
        let pType = data.pType
        $.post('https://ucrp-phone/accept_bill', JSON.stringify({amount: price, sID: sID, pType: pType}))
    }
}