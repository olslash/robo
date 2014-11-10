# helper for the ship factory, so it can construct ships with string names for modules
# (bsfy doesn't support dynamic loading)

module.exports = {
  ships: {
    base: require('../entities/Ship'),
    wedge: require('../entities/Ship-Wedge')
  },

  modules: {
    thruster: require('../entities/Thruster')
  }
}
