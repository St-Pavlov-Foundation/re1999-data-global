module("modules.logic.fight.config.FightRightBottomElementEnum", package.seeall)

local var_0_0 = _M
local var_0_1 = 0

local function var_0_2()
	var_0_1 = var_0_1 + 1

	return var_0_1
end

var_0_0.Elements = {
	ASFD = var_0_2(),
	BloodPool = var_0_2()
}
var_0_0.Priority = {
	var_0_0.Elements.BloodPool,
	var_0_0.Elements.ASFD
}
var_0_0.ElementsSizeDict = {
	[var_0_0.Elements.BloodPool] = Vector2(180, 170),
	[var_0_0.Elements.ASFD] = Vector2(100, 170)
}
var_0_0.ElementsNodeName = {
	[var_0_0.Elements.BloodPool] = "bloodpool",
	[var_0_0.Elements.ASFD] = "asfd"
}

return var_0_0
