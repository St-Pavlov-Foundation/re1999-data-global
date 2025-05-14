module("modules.logic.fightresistancetip.controller.FightResistanceTipController", package.seeall)

local var_0_0 = class("FightResistanceTipController")

function var_0_0.openFightResistanceTipView(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.FightResistanceTipView, {
		resistanceDict = arg_1_1,
		screenPos = arg_1_2
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
