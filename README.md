# Cohort 04 - Session 4: Testing Demo

This session aims to teach you how to start testing your contract in Cairo v1.

![Nicolas Cage Let's Ride](https://media.tenor.com/PDEhy7xqVdoAAAAC/lets-ride-nicolas-cage.gif)

# Getting Started

What we need before we start:

Setting up Cairo v1 and cairo-lang v0.11 and scarb.

- [cairo-lang](https://github.com/starkware-libs/cairo-lang)
- [cairo_v1](https://github.com/starkware-libs/cairo)
- [scarb](https://github.com/software-mansion/scarb/)

More useful materials at the **Further Reading** section.

## Initializing your repo with Scarb

Once your project is created, run the following command in your terminal to initilize the project with scarb.

```bash
scarb init
```

Once initialized, your project should look like this:

<ul>
  <li>src
    <ul>
      <li>lib.cairo</li>
    </ul>
  </li>
  <li>Scarb.toml</li>
</ul>

Now, we need to setup our project and create additional folders in order to structure our project for our testing environment. We will create a folder called `test` and a file called `test.cairo` which will point to the folder that we created. In addition we need to create a `cairo_project.toml` file so that when we run our testing command it will recognize our project structure and where these files are located.

In addition we will create a `Makefile` to add our shortcut commands.

<ul>
  <li>src
    <ul>
      <li>test</li>
    </ul>
    <ul>
      <li>test.cairo</li>
    </ul>
    <ul>
      <li>lib.cairo</li>
    </ul>
  </li>
  <li>cairo_project.toml</li>
  <li>Makefile</li>
  <li>Scarb.toml</li>
</ul>

## Useful Makefile commands

In order to not repeat lengthy commands, we can use Makefile to simplify this process.

```Makefile
test: FORCE
	cairo-test --starknet .

starknet-declare:
	starknet declare --contract ${file} --account version_2

starknet-deploy:
	starknet deploy --class_hash ${hash} --account version_2
```

# Testing the ERC20 contract

For our testing contract, we will be using the ERC20 implementation example from Starkware. You can find the contract [here](https://github.com/starkware-libs/cairo/blob/main/crates/cairo-lang-starknet/test_data/erc20.cairo).

## Unit Testing

The aim of unit testing is to test individual functions or components of code within a contract. In our example file `test_00.cairo`, we are testing the constructor function of the ERC20 contract example.

First, we need to define the test function as `fn test_constructor()` and denote the `#[test]` attribute. We also need to set the gas limit for the test using the `#[available_gas(200000)]` attribute.

Then we declare the variables which are passed to the constructor. These are: `initial_supply` `account` `decimals` `name` and `symbol`. After that, we initilize the ERC20 contract by calling the constructor from the ERC20 with `ERC20::constructor()`.

Once the constructor has been initilized, it's time to test whether the constructor initialized properly. We invoke the `get_name()` function from the ERC20 contract and store the result as `res_name`. Then, we use an assert function to check if the `res_name` is equal to the `name` variable. If it doesn't match, the assert function will `panic` and tthrow the error message we provided.

## Integration Testing

In this section we will explore how the interation between different functions work within our contract. First we will start by creating a helper function called `setup()` which initialized the ERC20 contract. Then we will create an additional dummy contract address called `recipient` and the variable `amount` which will be the token amount we want to transfer.

Then we invoke the `tranfer()` function from the ERC20 contract with `recipient` and `amount` as parameters.

Now if everything works correctly we expect that the `amount` of `100` has been transfered to the `recipient` account and the balance of the `sender` should decrease by the same amount. We use assert function to check if the logic is valid and if indeeed the transfer function has worked properly. In addition, we do another assert on the `total_supply` as this amount should stay the same as initialized.

In this section, we will explore how the interaction between different functions works within our contract. First, we will start by creating a helper function called `setup()` that initializes the ERC20 contract. Then, we will create an additional dummy contract address called `recipient` and a variable called `amount`, which will be the token amount we want to transfer.

Next, we will invoke the `transfer()` function from the ERC20 contract with `recipient` and `amount` as parameters.

Now, if everything works correctly, we expect that the amount of `100` has been transferred to the `recipient` account and the balance of the `sender` should decrease by the same amount. We use several assert functions to check if the logic is valid and if the transfer function has indeed worked properly. In addition, we perform another assert on the `total_supply` as this amount should stay the same as it was initialized.

# Homework

## Part 1

In the `test_00.cairo` file, within the `test_01_constructor()` function create the following checks:

- check if the variable `decimals` has been initialized correctly.
- check if the variable `total_suply` has been initialized correctly.
- check if the balance of the `account` is equal to the `initial_supply`.

## Part 2

In the `test_01.cairo` file, complete the following exercises:

- Test the `transfer_from` function
  - check the ERC20 contract to see what steps need to be made in order for the transaction to be sucessful

# Further Reading

## Scarb

[Scarb](https://github.com/software-mansion/scarb) is the project management tool for the Cairo language. Scarb manages your dependencies, compiles your projects and works as an extensible platform assisting in development.

- [Instalation](https://docs.swmansion.com/scarb/docs)
- [Cheatsheet](https://docs.swmansion.com/scarb/docs/cheatsheet)
- [Scripts](https://docs.swmansion.com/scarb/docs/reference/scripts)
- [Dependencies](https://docs.swmansion.com/scarb/docs/guides/dependencies)

---

## Protostar

Similar to Scarb, [Protostar](https://github.com/software-mansion/protostar) can manages your dependencies, compiles your project, and runs tests. The difference is that it provide more depth to your tests and can work with other tools such as `starknet-devnet`.

---

## starknet-devnet

[starknet-devnet](https://github.com/0xSpaceShard/starknet-devnet) is a Python library that allows you to spun a local block explorer. Having a local block explorer can be helpful in many way such as interacting with your contract on the block explorer or even speeding up the process of declaring and deploying your contract.

---

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
    python --version
}
```

Once added, simply run `cairo1dev` in your vs-code terminal.
