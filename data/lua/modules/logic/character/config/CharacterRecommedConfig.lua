module("modules.logic.character.config.CharacterRecommedConfig", package.seeall)

local var_0_0 = class("CharacterRecommedConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"character_recommend"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._heroConfigDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character_recommend" then
		arg_3_0._heroConfigDict = arg_3_2.configDict

		CharacterRecommedModel.instance:initMO(arg_3_0._heroConfigDict)
	end
end

function var_0_0.getAllHeroConfigs(arg_4_0)
	return arg_4_0._heroConfigDict
end

function var_0_0.getHeroConfig(arg_5_0, arg_5_1)
	return arg_5_0._heroConfigDict[arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
