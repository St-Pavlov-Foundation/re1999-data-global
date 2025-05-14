module("modules.logic.fight.fightcomponent.FightObjItemListComponent", package.seeall)

local var_0_0 = class("FightObjItemListComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.registObjItemList(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return arg_2_0:newClass(FightObjItemListItem, arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.registViewItemList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return arg_3_0:newClass(FightViewItemListItem, arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.onDestructor(arg_4_0)
	return
end

return var_0_0
