module("modules.logic.fight.fightcomponent.FightViewItemListItem", package.seeall)

local var_0_0 = class("FightViewItemListItem", FightObjItemListItem)

function var_0_0.newItem(arg_1_0)
	local var_1_0 = var_0_0.super.newItem(arg_1_0)
	local var_1_1 = var_1_0.keyword_gameObject
	local var_1_2 = arg_1_0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS

	var_1_0.viewName = var_1_2.viewName
	var_1_0.viewContainer = var_1_2.viewContainer
	var_1_0.PARENT_VIEW = var_1_2
	var_1_0.viewGO = var_1_1

	var_1_0:inner_startView()

	return var_1_0
end

return var_0_0
