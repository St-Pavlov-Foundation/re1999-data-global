module("modules.logic.character.controller.CharacterVoiceController", package.seeall)

local var_0_0 = class("CharacterVoiceController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._defaultValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = CharacterVoiceEnum.LuxiState.MetalFace
	}
	arg_1_0._changeValueMap = {
		[CharacterVoiceEnum.Hero.Luxi] = arg_1_0._getLuxiChangeValue
	}
end

function var_0_0.getDefaultValue(arg_2_0, arg_2_1)
	return arg_2_0._defaultValueMap[arg_2_1]
end

function var_0_0.getChangeValue(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._changeValueMap[arg_3_1.heroId]

	return var_3_0 and var_3_0(arg_3_0, arg_3_1)
end

function var_0_0._getLuxiChangeValue(arg_4_0, arg_4_1)
	if arg_4_1.stateCondition == CharacterVoiceEnum.LuxiState.MetalFace then
		return CharacterVoiceEnum.LuxiState.HumanFace
	else
		return CharacterVoiceEnum.LuxiState.MetalFace
	end
end

function var_0_0.getIdle(arg_5_0, arg_5_1)
	if arg_5_1 == CharacterVoiceEnum.Hero.Luxi then
		local var_5_0 = arg_5_0:getDefaultValue(arg_5_1)

		if PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_5_1, var_5_0) == CharacterVoiceEnum.LuxiState.HumanFace then
			return StoryAnimName.B_IDLE1
		else
			return StoryAnimName.B_IDLE
		end
	end

	return StoryAnimName.B_IDLE
end

function var_0_0.setSpecialInteractionPlayType(arg_6_0, arg_6_1)
	arg_6_0._playType = arg_6_1
end

function var_0_0.getSpecialInteractionPlayType(arg_7_0)
	return arg_7_0._playType
end

function var_0_0.trackSpecialInteraction(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_1)

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_3 == CharacterVoiceEnum.PlayType.Click and "主动触发" or "被动触发"
	local var_8_2 = {
		[StatEnum.EventProperties.HeroId] = tonumber(arg_8_1),
		[StatEnum.EventProperties.HeroName] = var_8_0.name,
		[StatEnum.EventProperties.VoiceId] = tostring(arg_8_2),
		[StatEnum.EventProperties.trigger_type] = tostring(var_8_1)
	}

	StatController.instance:track(StatEnum.EventName.Interactive_special_action, var_8_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
