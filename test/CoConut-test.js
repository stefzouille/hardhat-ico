/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
const { expect } = require('chai');

describe('CoConut Token', async function () {
  let dev, owner, Coconut, coconut;
  const NAME = 'CoConut';
  const SYMBOL = 'CONUT';
  const INIT_SUPPLY = ethers.utils.parseEther('1000000');
  beforeEach(async function () {
    [dev, owner] = await ethers.getSigners();
    Coconut = await ethers.getContractFactory('CoConut');
    coconut = await Coconut.connect(dev).deploy(owner.address, INIT_SUPPLY);
    await coconut.deployed();
  });

  it(`Should have name ${NAME}`, async function () {
    expect(await coconut.name()).to.equal(NAME);
  });
  it(`Should have name ${SYMBOL}`, async function () {
    expect(await coconut.symbol()).to.equal(SYMBOL);
  });
  it(`Should have total supply ${INIT_SUPPLY.toString()}`, async function () {
    expect(await coconut.totalSupply()).to.equal(INIT_SUPPLY);
  });
  it(`Should mint initial supply ${INIT_SUPPLY.toString()} to owner`, async function () {
    expect(await coconut.balanceOf(owner.address)).to.equal(INIT_SUPPLY);
  });
});
