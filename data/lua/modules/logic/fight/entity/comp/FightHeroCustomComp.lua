module("modules.logic.fight.entity.comp.FightHeroCustomComp", package.seeall)

local var_0_0 = class("FightHeroCustomComp", LuaCompBase)

var_0_0.HeroId2CustomComp = {
	[3113] = FightHeroALFComp
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	local var_2_0 = arg_2_0.entity:getMO()
	local var_2_1 = var_0_0.HeroId2CustomComp[var_2_0.modelId]

	if var_2_1 then
		arg_2_0.customComp = var_2_1.New(arg_2_0.entity)

		arg_2_0.customComp:init(arg_2_1)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	if arg_3_0.customComp then
		arg_3_0.customComp:addEventListeners()
	end
end

function var_0_0.removeEventListeners(arg_4_0)
	if arg_4_0.customComp then
		arg_4_0.customComp:removeEventListeners()
	end
end

function var_0_0.getCustomComp(arg_5_0)
	return arg_5_0.customComp
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0.customComp then
		arg_6_0.customComp:onDestroy()

		arg_6_0.customComp = nil
	end
end

return var_0_0
