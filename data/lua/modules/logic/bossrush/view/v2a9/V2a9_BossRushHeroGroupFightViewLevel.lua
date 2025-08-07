module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("V2a9_BossRushHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	local var_1_0 = gohelper.findChild(arg_1_0._gonormalcondition, "star")

	gohelper.setActive(var_1_0, false)
end

return var_0_0
