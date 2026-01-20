-- chunkname: @modules/logic/custompickchoice/define/CustomPickChoiceEnum.lua

module("modules.logic.custompickchoice.define.CustomPickChoiceEnum", package.seeall)

local CustomPickChoiceEnum = _M

CustomPickChoiceEnum.style = {
	SummonCustomPick = 2,
	OptionalHeroGift = 1
}
CustomPickChoiceEnum.FixedText = {
	[CustomPickChoiceEnum.style.OptionalHeroGift] = {
		_txttitle = "herogift_custom_pick_title"
	}
}
CustomPickChoiceEnum.ComponentVisible = {
	[CustomPickChoiceEnum.style.OptionalHeroGift] = {
		_gomask = true,
		_gobg = true,
		_goTips = false
	}
}

return CustomPickChoiceEnum
