package common

import (
	sdk "github.com/cosmos/cosmos-sdk/types"
)

const (
	bech32PrefixAccAddr = "xrn:"
	bech32PrefixAccPub  = "xrn:pub"

	bech32PrefixValAddr = "xrn:valoper"
	bech32PrefixValPub  = "xrn:valoperpub"

	bech32PrefixConsAddr = "xrn:valcons"
	bech32PrefixConsPub  = "xrn:valconspub"
)

// SetSDKAccountPrefixes configures address prefixes for validator, accounts and consensus nodes
func SetSDKAccountPrefixes() {
	config := sdk.GetConfig()
	config.SetBech32PrefixForAccount(bech32PrefixAccAddr, bech32PrefixAccPub)
	config.SetBech32PrefixForValidator(bech32PrefixValAddr, bech32PrefixValPub)
	config.SetBech32PrefixForConsensusNode(bech32PrefixConsAddr, bech32PrefixConsPub)

	config.Seal()
}
