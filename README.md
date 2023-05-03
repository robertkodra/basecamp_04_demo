# Cohort 04 - Session 4: Testing Demo

This session aims to teach you how to start testing your contract in Cairo v1.

![Nicolas Cage Let's Ride](https://media.tenor.com/PDEhy7xqVdoAAAAC/lets-ride-nicolas-cage.gif)

# Getting Started

What we need before we start:

Setting up Cairo v1 and Scarb.

- [cairo_v1](https://github.com/starkware-libs/cairo) - in this test we use alpha-7
- [scarb](https://github.com/software-mansion/scarb/) - in this test we use 0.1.0

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

Now, we need to setup our project and create additional folders in order to structure our project for our testing environment. We will create a folder called `test` and a file `lib.cairo` which will point to the test files that we will create. In addition we need to create a `cairo_project.toml` file so that when we run our testing command it will recognize our project structure and where these files are located.

In addition we will create a `Makefile` to add our shortcut commands.

<ul>
  <li>src
    <ul>
      <li>lib.cairo</li>
    </ul>
  </li>
  <li>tests
    <ul>
      <li>lib.cairo</li>
    </ul>
  </li>
  <li>cairo_project.toml</li>
  <li>Scarb.toml</li>
</ul>

In the `cairo_project.toml`, we will define our `src` folder and the `tests` folder.

```rust
[crate_roots]
basecamp_04_demo = "src"
tests = "tests"
```

# Testing the ERC20 contract

For our testing contract, we will be using the ERC20 implementation example from Starkware. You can find the contract [here](https://github.com/starkware-libs/cairo/blob/main/crates/cairo-lang-starknet/test_data/erc20.cairo).

## Unit Testing

The aim of unit testing is to test individual functions or components of code within a contract. In our example file `ERC20.cairo`, we are testing the constructor function of the ERC20 contract example.

First, we need to define the test function as `fn test_constructor()` and denote the `#[test]` attribute. We also need to set the gas limit for the test using the `#[available_gas(200000)]` attribute and the `#[cfg(test)]` attribute which tells the compiler to run it only when the `cairo-test` command is invoked. To read more about this check the [Cairo Book](https://cairo-book.github.io/ch08-01-how-to-write-tests.html).

Then we declare the variables which are passed to the constructor. These are: `initial_supply` `account` `decimals` `name` and `symbol`. After that, we initilize the ERC20 contract by calling the constructor from the ERC20 with `ERC20::constructor()`.

Once the constructor has been initilized, it's time to test whether the constructor initialized properly. We invoke the `get_name()` function from the ERC20 contract and store the result as `res_name`. Then, we use an assert function to check if the `res_name` is the expected value. If it doesn't match, the assert function will `panic` and throw the error message we provided.

## Integration Testing

In this section, we will explore how the interaction between different functions works within our contract.First, we will start by creating a helper function called `setup()` that initializes the ERC20 contract. Then, we will create an additional dummy contract address called `recipient` and a variable called `amount`, which will be the token amount we want to transfer.

Next, we will invoke the `transfer()` function from the ERC20 contract with `recipient` and `amount` as parameters.

Now, if everything works correctly, we expect that the amount of `100` has been transferred to the `recipient` account and the balance of the `sender` should decrease by the same amount. We use several assert functions to check if the logic is valid and if the transfer function has indeed worked properly. In addition, we perform another assert on the `total_supply` as this amount should stay the same as it was initialized.

### Handling expected errors

Another way to handle errors is by expecting them with `should_panic`. We write a new test function called `test_transfer_to_zero()` where we will try the transfer function again, but this time we intend to create an error in the ERC20 contract. We are defining the `recipient` as zero, which will fail once we call the `transfer` function from the ERC20 contract. As we expect this function to fail, we will denote at the top of the function the `shoul_panic` and a message.

```rust
#[test]
#[available_gas(2000000)]
#[should_panic(expected:('ERC20: transfer to 0', ))]
fn test_transfer_to_zero() {
  }
```

### Ignoring test function

Some test functions may take too many resources to run. We can define this test function with the `#[ignore]` attribute at the top of the function to exclude them while running the test.

```rust
#[test]
#[available_gas(2000000)]
#[ignore]
fn test_transfer_to_zero() {
  }
```

# Homework

## Part 1

In the `ERC20.cairo` file, within the `test_01_constructor()` test function, create the following tests:

- check if the variable `decimals` has been initialized correctly.
- check if the variable `total_suply` has been initialized correctly.
- check if the balance of the `account` is equal to the `initial_supply`.

## Part 2

In the `test_01.cairo` file, complete the following exercises:

- Test the `transfer_from` function
  - check the ERC20 contract to see what steps need to be made in order for the transaction to be sucessful

# Further Reading

## Cairo Book

[Cairo Book - Testing](https://cairo-book.github.io/ch08-01-how-to-write-tests.html) - more information regarding testing and setting up your testing organization.

---

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
    python --version
}
```

Once added, simply run `cairo1dev` in your vs-code terminal.
