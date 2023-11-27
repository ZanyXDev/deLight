.pragma library

function getRandomBgrImage(last) {
    let rnd = last;
    while (rnd === last) {
        rnd = Math.floor(Math.random() * 21)
    }

    let bgrStr = rnd.toString();

    if (bgrStr.length === 1) {
        bgrStr = "0" + bgrStr
    }
    return "qrc:/res/images/backgrounds/bgr" + bgrStr + ".jpg"
}




