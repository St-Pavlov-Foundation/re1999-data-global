module("modules.logic.character.model.DestinyStoneMO", package.seeall)

local var_0_0 = class("DestinyStoneMO")

function var_0_0.initMo(arg_1_0, arg_1_1)
	arg_1_0.stoneId = arg_1_1
	arg_1_0.facetCos = CharacterDestinyConfig.instance:getDestinyFacetCo(arg_1_1)
	arg_1_0.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_1_1)
end

function var_0_0.refresUnlock(arg_2_0, arg_2_1)
	arg_2_0.isUnlock = arg_2_1
end

function var_0_0.refreshUse(arg_3_0, arg_3_1)
	arg_3_0.isUse = arg_3_1
end

function var_0_0.getFacetCo(arg_4_0, arg_4_1)
	if arg_4_1 then
		return arg_4_0.facetCos[arg_4_1]
	end

	return arg_4_0.facetCos
end

function var_0_0.getNameAndIcon(arg_5_0)
	return arg_5_0.conusmeCo.name, ResUrl.getDestinyIcon(arg_5_0.conusmeCo.icon), arg_5_0.conusmeCo
end

return var_0_0
