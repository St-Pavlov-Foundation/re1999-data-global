module("modules.logic.equip.controller.EquipController", package.seeall)

local var_0_0 = class("EquipController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openEquipStrengthenAlertView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:openView(ViewName.EquipStrengthenAlertView, arg_5_1, arg_5_2)
end

function var_0_0.openEquipView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.EquipView, arg_6_1, arg_6_2)
end

function var_0_0.openEquipBreakResultView(arg_7_0, arg_7_1, arg_7_2)
	ViewMgr.instance:openView(ViewName.EquipBreakResultView, arg_7_1, arg_7_2)
end

function var_0_0.openEquipSkillLevelUpView(arg_8_0, arg_8_1, arg_8_2)
	ViewMgr.instance:openView(ViewName.EquipSkillLevelUpView, arg_8_1, arg_8_2)
end

function var_0_0.openEquipSkillTipView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.EquipSkillTipView, arg_9_1, arg_9_2)
end

function var_0_0.closeEquipSkillTipView(arg_10_0)
	ViewMgr.instance:closeView(ViewName.EquipSkillTipView)
end

function var_0_0.openEquipInfoTeamView(arg_11_0, arg_11_1)
	ViewMgr.instance:openView(ViewName.EquipInfoTeamShowView, arg_11_1)
end

function var_0_0.openEquipTeamView(arg_12_0, arg_12_1, arg_12_2)
	EquipTeamListModel.instance:openTeamEquip(arg_12_1, arg_12_2.heroMO)
	ViewMgr.instance:openView(ViewName.EquipTeamView, arg_12_2)
end

function var_0_0.openEquipTeamShowView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.EquipTeamShowView, arg_13_1, arg_13_2)
end

function var_0_0.openEquipDecomposeView(arg_14_0)
	ViewMgr.instance:openView(ViewName.EquipDecomposeView)
end

function var_0_0.closeEquipTeamShowView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:closeView(ViewName.EquipTeamShowView, arg_15_1, arg_15_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
