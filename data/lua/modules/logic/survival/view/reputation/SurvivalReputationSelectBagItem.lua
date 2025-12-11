module("modules.logic.survival.view.reputation.SurvivalReputationSelectBagItem", package.seeall)

local var_0_0 = class("SurvivalReputationSelectBagItem", SurvivalSimpleListItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1

	local var_1_0 = "ui/viewres/survival/map/survivalmapbagitem.prefab"
	local var_1_1 = arg_1_0.viewContainer:getResInst(var_1_0, arg_1_0.viewGO)

	arg_1_0.survivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, SurvivalBagItem)
end

function var_0_0.onItemShow(arg_2_0, arg_2_1)
	arg_2_0.survivalBagItem:updateMo(arg_2_1)
end

function var_0_0.playSearch(arg_3_0)
	arg_3_0.survivalBagItem:playSearch()
end

return var_0_0
