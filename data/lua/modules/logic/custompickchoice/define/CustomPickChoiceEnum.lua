module("modules.logic.custompickchoice.define.CustomPickChoiceEnum", package.seeall)

slot0 = _M
slot0.style = {
	SummonCustomPick = 2,
	OptionalHeroGift = 1
}
slot0.FixedText = {
	[slot0.style.OptionalHeroGift] = {
		_txttitle = "herogift_custom_pick_title"
	}
}
slot0.ComponentVisible = {
	[slot0.style.OptionalHeroGift] = {
		_gomask = true,
		_gobg = true,
		_goTips = false
	}
}

return slot0
