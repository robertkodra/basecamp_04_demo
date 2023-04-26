# Cohort 04 - Session 4: Testing Demo

This session aims to teach you how to start testing your contract in Cairo v1 by using various tools.

## Getting Started

What we need before we start:

Setting up Cairo v1 and cairo-lang v0.11 and scarb.

- [cairo-lang](https://github.com/starkware-libs/cairo-lang)
- [cairo_v1](https://github.com/starkware-libs/cairo)
- [scarb](https://github.com/software-mansion/scarb/)

More useful materials at the Further Reading section.

# Initializing your repo with Scarb

Once your project is created, run the following command to initilize the project with scarb.

`scarb init`

Once initialized, your project should look like this:

<ul>
  <li>src
    <ul>
      <li>lib.cairo</li>
    </ul>
  </li>
  <li>Scarb.toml</li>
</ul>

TBD

# Testing the ERC20 contract

For our testing contract, we will be using the ERC20 implementation example from Starkware. You can find the contract [here](https://github.com/starkware-libs/cairo/blob/main/crates/cairo-lang-starknet/test_data/erc20.cairo).

## Unit Testing

Focuses on a single function within the application.

## Integration Testing

Focuses on all of the modules and tests it as a group.

## Fuzz Testing

## Interacting with your contract on the block explorer

starknet-devnet

# Homework

## Part 1

In the `test_00.cairo` file, complete the following exercises:

- `test_02_decimals()`
  - TBD
- `test_03_total_supplly()`
  - TBD
- `test_04_balance_account()`
  - TBD

## Part 2

In the `test_01.cairo` file, complete the following exercises:

- Increase Allowance
- Decrease Allowance
- Transfer From

# Further reading

## Protostar

TBD

## Scarb

TBD

## starknet-devnet

TBD

## Setting up your profile

If you haven't set up a profile for your Cairo 1 development yet, you can follow these steps to do so. Using profiles makes our lives simpler as we don't need to run all of these commands every time.

### Linux

Run the following command in your terminal:

`nano ~/.bashrc`

Add at the end of your terminal the following:

```bash
# Setup for Cario Testnet v1.0
function cairo1dev() {
    python3.9 -m venv ~/cairo1_venv
    source ~/cairo1_venv/bin/activate
    export PATH=/YOUR_SCARB_PATH/bin/:$PATH
    export PATH=$HOME/YOUR_CAIRO_PATH/target/release:$PATH
    export STARKNET_NETWORK=alpha-goerli
    export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount
}
```

Once added, simply run `cairo1dev` in your vs-code terminal.
