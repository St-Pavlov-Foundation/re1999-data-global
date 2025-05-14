module("modules.logic.fight.model.FightViewTechniqueListModel", package.seeall)

local var_0_0 = class("FightViewTechniqueListModel", ListScrollModel)

function var_0_0.showUnreadFightViewTechniqueList(arg_1_0, arg_1_1)
	arg_1_0:setList(arg_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
