assets = {
  "wedgeship": "wedgeship.png",
  "grid96": "grid96.png",
  "blue32": "blue32.png",
  "cyan32": "cyan32.png",
  "green32": "green32.png",
  "orange32": "orange32.png",
  "red32": "red32.png",
  "brownlongbutton": "brownlongbutton.png",
  "redlongbutton": "redlongbutton.png",
  "yellowlongbutton": "yellowlongbutton.png",
  "cannon_button": "cannon_button.png",
  "engine_button": "engine_button.png",
  "gyro_button": "gyro_button.png",
  "laser_button": "laser_button.png",
  "movement_button": "movement_button.png",
  "weapons_button": "weapons_button.png",
  "special_button": "special_button.png",
  "shield_button": "shield_button.png",
  "north_button": "north_button.png",
  "south_button": "south_button.png",
  "east_button": "east_button.png",
  "west_button": "west_button.png",
  "done_button": "done_button.png",
  "thruster": "thruster.png",
  "circles": "circles.png"
}


module.exports = (source) ->
  path = if source is 'controller' then '../../game/assets/' else 'assets/'
  for assetName of assets
    filename = assets[assetName]
    assets[assetName] = path + filename

  return assets
