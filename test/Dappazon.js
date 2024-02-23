const { expect } = require("chai")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("Dappazon", () => {

  beforeEach(async() => {

    //deploy Contract
    const Dappazon = await ethers.getContractFactory('Dappazon')
    dappazon = await Dappazon.deploy()
  })

  it("has a name", async() => {
    expect(await dappazon.name()).to.be.equal('Dappazon')
  }) 

})
