/// Module: faucet_coin
module faucet_coin::faucet_coin;
use sui::coin;
use sui::coin::{TreasuryCap, Coin};
use sui::transfer::{public_freeze_object, public_share_object};
use sui::url;
use sui::url::Url;


public struct FAUCET_COIN has drop {}


fun init(witness: FAUCET_COIN, ctx: &mut TxContext){

    let no_url = option::none<Url>();

    let (treasury_cap, coin_metadata) = coin::create_currency(
        witness,
        8,
        b"faucet bing",
        b"faucet bing",
        b"the faucet coin for bing",
        no_url,
        ctx
    );

    public_freeze_object(coin_metadata);

    public_share_object(treasury_cap);
}

public entry fun mint(cap: &mut TreasuryCap<FAUCET_COIN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext
){
    coin::mint_and_transfer(cap,amount,recipient,ctx);
}

public entry fun burn(cap: &mut TreasuryCap<FAUCET_COIN>, coin: Coin<FAUCET_COIN>){
    coin::burn(cap,coin);
}
