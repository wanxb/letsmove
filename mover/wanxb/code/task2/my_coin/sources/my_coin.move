/// Module: my_coin
module my_coin::my_coin;
use std::option::some;
use sui::coin;
use sui::coin::{TreasuryCap, Coin};
use sui::transfer::{public_freeze_object, public_transfer};
use sui::url;
use sui::url::Url;

public struct MY_COIN has drop {}

fun init(witness: MY_COIN, ctx: &mut TxContext){

    // 不需要图片
    // let no_url = option::none<Url>();

    let url = url::new_unsafe_from_bytes(b"xx");
    let icon_url = some<Url>(url);

    let (treasury_cap, coin_metadata) = coin::create_currency(
        witness,
        8,
        b"bing",
        b"bing coin",
        b"the coin for bing.",
        icon_url,
        ctx
    );

    public_freeze_object(coin_metadata);

    public_transfer(treasury_cap,ctx.sender());
}

public entry fun mint(cap: &mut TreasuryCap<MY_COIN>,
    amount: u64,
    recipient: address,
    ctx: &mut TxContext
){
    coin::mint_and_transfer(cap, amount, recipient, ctx);
}

public entry fun burn(cap: &mut TreasuryCap<MY_COIN>, coin: Coin<MY_COIN>){
    coin::burn(cap, coin);
}