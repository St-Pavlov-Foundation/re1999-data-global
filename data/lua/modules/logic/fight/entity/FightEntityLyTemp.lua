module("modules.logic.fight.entity.FightEntityLyTemp", package.seeall)

local var_0_0 = class("FightEntityLyTemp", FightEntityTemp)

function var_0_0.initComponents(arg_1_0)
	arg_1_0:addComp("spine", UnitSpine)
	arg_1_0:addComp("spineRenderer", UnitSpineRenderer)
	arg_1_0:addComp("effect", FightEffectComp)
end

return var_0_0
