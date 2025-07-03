module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseAndBadgeRuleComp", package.seeall)

local var_0_0 = class("Act183DungeonBaseAndBadgeRuleComp", Act183DungeonBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._gobadgerules = gohelper.findChild(arg_1_0.go, "#go_badgerules")
	arg_1_0._gobaserules = gohelper.findChild(arg_1_0.go, "#go_baserules")
	arg_1_0._badgeRuleComp = MonoHelper.addLuaComOnceToGo(arg_1_0._gobadgerules, Act183DungeonBadgeRuleComp)
	arg_1_0._baseRuleComp = MonoHelper.addLuaComOnceToGo(arg_1_0._gobaserules, Act183DungeonBaseRuleComp)
	arg_1_0._badgeRuleComp.container = arg_1_0
	arg_1_0._baseRuleComp.container = arg_1_0
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	var_0_0.super.updateInfo(arg_4_0, arg_4_1)
	arg_4_0._badgeRuleComp:updateInfo(arg_4_1)
	arg_4_0._baseRuleComp:updateInfo(arg_4_1)
end

function var_0_0.refresh(arg_5_0)
	var_0_0.super.refresh(arg_5_0)
	arg_5_0._badgeRuleComp:refresh()
	arg_5_0._baseRuleComp:refresh()
end

function var_0_0.checkIsVisible(arg_6_0)
	return arg_6_0._badgeRuleComp:checkIsVisible() or arg_6_0._baseRuleComp:checkIsVisible()
end

function var_0_0.focus(arg_7_0, arg_7_1)
	if arg_7_1 then
		return arg_7_0._badgeRuleComp:focus()
	end

	return arg_7_0._baseRuleComp:focus()
end

return var_0_0
