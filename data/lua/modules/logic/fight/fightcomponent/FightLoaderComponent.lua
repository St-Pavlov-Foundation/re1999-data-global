module("modules.logic.fight.fightcomponent.FightLoaderComponent", package.seeall)

local var_0_0 = class("FightLoaderComponent", FightBaseClass)

function var_0_0.loadAsset(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:newClass(FightLoaderItem, arg_1_1, arg_1_2, arg_1_3, arg_1_4):startLoad()
end

function var_0_0.loadListAsset(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:newClass(FightLoaderList, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5):startLoad()
end

return var_0_0
