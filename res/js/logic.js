.pragma library

function calcRandomDuration(m_behavior_pause) {
  var rnd = 1 + Math.random() * 0.4 - 0.2
  return Math.floor(m_behavior_pause * rnd)
}
