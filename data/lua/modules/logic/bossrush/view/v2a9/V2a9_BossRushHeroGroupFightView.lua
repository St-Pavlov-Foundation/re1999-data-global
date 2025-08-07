module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightView", package.seeall)

local var_0_0 = class("V2a9_BossRushHeroGroupFightView", HeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_assassinskill")
	local var_1_1 = arg_1_0.viewContainer:getSetting().otherRes[2]
	local var_1_2 = arg_1_0:getResInst(var_1_1, var_1_0, "skillComp")

	arg_1_0._skillComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_2, V2a9_BossRushHeroGroupSkillComp)

	arg_1_0._skillComp:onUpdateMO()
	gohelper.setActive(var_1_0, true)

	local var_1_3 = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero")
	local var_1_4 = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")

	recthelper.setAnchorX(var_1_3.transform, -350)
	recthelper.setAnchorX(var_1_4.transform, -350)
end

function var_0_0._refreshCloth(arg_2_0)
	gohelper.setActive(arg_2_0._btncloth.gameObject, false)
end

return var_0_0
