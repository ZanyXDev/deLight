.pragma library

let m_cellsCount = 25

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

function addEmptyCell( m_model ){
    m_model.clear()
    for( var i = 0; i < m_cellsCount; i++ ) {
        m_model.append({"cell":0,"delay":0})
    }
}
function fillModelFromLevel(m_srcModel,m_dstModel,m_level,m_effectModel,m_effectType){
    let abs_index
    let effect_index = m_effectType * m_cellsCount
    let m_delay
    addEmptyCell(m_dstModel)

    for( var i = 0; i < m_srcModel.rowCount(); i++ ) {
        if ( m_srcModel.get(i).lvl === m_level){
            abs_index = i % m_cellsCount
            m_delay =  m_effectModel.get( abs_index + effect_index).cell_in_effect
            m_dstModel.setProperty(abs_index, "cell", m_srcModel.get(i).cell)
            m_dstModel.setProperty(abs_index, "delay", m_delay * 200)
        }
    }
}

function clickOnTile( m_model, x_pos,y_pos ){

    let m_index = -1
    let m_value

    if ( (x_pos - 1) >= 0 ){
        m_index = (x_pos - 1) + (y_pos *5)
        m_value = (m_model.get(m_index).cell) ? 0 : 1
        m_model.setProperty(m_index, "cell", m_value)
    }

    if ( (x_pos + 1) < 5 ){
        m_index = (x_pos + 1) + (y_pos *5)
        m_value = (m_model.get(m_index).cell) ? 0 : 1
        m_model.setProperty(m_index, "cell", m_value)
    }

    if ( (y_pos - 1) >= 0 ){
        m_index = x_pos + ( (y_pos - 1) *5)
        m_value = (m_model.get(m_index).cell) ? 0 : 1
        m_model.setProperty(m_index, "cell", m_value)
    }

    if ( (y_pos + 1) < 5 ){
        m_index = x_pos + ( (y_pos + 1) *5)
        m_value = (m_model.get(m_index).cell) ? 0 : 1
        m_model.setProperty(m_index, "cell", m_value)
    }
}

function clearAll( m_model ){
    for( var i = 0; i < m_model.rowCount(); i++ ) {
        m_model.setProperty(i, "cell", 0)
    }
}

function isWinGame( m_model ){
    let flag= false

    for( var i = 0; i < m_model.rowCount(); i++ ) {
        flag = flag || m_model.get(i).cell ;
    }

    return !flag
}
