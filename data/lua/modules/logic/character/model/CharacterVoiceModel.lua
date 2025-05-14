module("modules.logic.character.model.CharacterVoiceModel", package.seeall)

local var_0_0 = class("CharacterVoiceModel", ListScrollModel)

function var_0_0.setVoiceList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	if arg_1_1 then
		arg_1_0._moList = arg_1_1

		table.sort(arg_1_0._moList, function(arg_2_0, arg_2_1)
			local var_2_0 = CharacterDataModel.instance:isCurHeroAudioLocked(arg_2_0.id) and 1 or 0
			local var_2_1 = CharacterDataModel.instance:isCurHeroAudioLocked(arg_2_1.id) and 1 or 0

			if var_2_0 ~= var_2_1 then
				return var_2_0 < var_2_1
			elseif arg_2_0.score ~= arg_2_1.score and var_2_0 == 1 and var_2_1 == 1 then
				return arg_2_0.score < arg_2_1.score
			elseif arg_2_0.sortId ~= arg_2_1.sortId then
				return arg_2_0.sortId < arg_2_1.sortId
			else
				return arg_2_0.id < arg_2_1.id
			end
		end)
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.setNeedItemAni(arg_3_0, arg_3_1)
	arg_3_0._needItemAni = arg_3_1
end

function var_0_0.isNeedItemAni(arg_4_0)
	return arg_4_0._needItemAni
end

var_0_0.instance = var_0_0.New()

return var_0_0
