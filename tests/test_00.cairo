use basecamp_04_demo::ERC20::ERC20;
use starknet::contract_address_const;
use starknet::ContractAddress;
use starknet::testing::set_caller_address;
use integer::u256;
use integer::u256_from_felt252;
use debug::PrintTrait;


const NAME: felt252 = 'Starknet Token';
const SYMBOL: felt252 = 'STAR';

#[test]
#[available_gas(2000000)]
fn test_01_constructor(){
    let initial_supply: u256 = u256_from_felt252(2000);
    let account: ContractAddress = contract_address_const::<1>();
    let decimals: u8 = 18_u8;

    ERC20::constructor(NAME, SYMBOL, decimals, initial_supply, account);

    let res_name = ERC20::get_name();
    assert(res_name == NAME, 'Name does not match.');

    let res_symbol = ERC20::get_symbol();
    assert(res_symbol == SYMBOL, 'Symbol does not match.');

    // Test decimals
    // Your code here

    // Test total_supply
    // Your code here

    // Test the balance of the account variable

    // Your code here

}