module("modules.logic.custompickchoice.define.CustomPickChoiceEnum", package.seeall)

local var_0_0 = _M

var_0_0.style = {
	SummonCustomPick = 2,
	OptionalHeroGift = 1
}
var_0_0.FixedText = {
	[var_0_0.style.OptionalHeroGift] = {
		_txttitle = "herogift_custom_pick_title"
	}
}
var_0_0.ComponentVisible = {
	[var_0_0.style.OptionalHeroGift] = {
		_gomask = true,
		_gobg = true,
		_goTips = false
	}
}

return var_0_0
