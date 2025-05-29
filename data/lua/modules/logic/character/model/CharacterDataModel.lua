module("modules.logic.character.model.CharacterDataModel", package.seeall)

local var_0_0 = class("CharacterDataModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._playingList = {}
end

function var_0_0.getCurHeroVoices(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = CharacterDataConfig.instance:getCharacterVoicesCo(arg_2_0._heroId)

	if var_2_1 then
		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			local var_2_2 = {}

			if arg_2_0:_checkShow(arg_2_0._heroId, iter_2_1) then
				var_2_2.id = iter_2_1.audio
				var_2_2.sortId = iter_2_1.sortId
				var_2_2.name = iter_2_1.name
				var_2_2.content = iter_2_1.content
				var_2_2.englishContent = iter_2_1.encontent
				var_2_2.unlockCondition = iter_2_1.unlockCondition
				var_2_2.type = iter_2_1.type
				var_2_2.param = iter_2_1.param
				var_2_2.heroId = iter_2_1.heroId

				local var_2_3 = 0

				if not string.nilorempty(iter_2_1.unlockCondition) then
					local var_2_4 = string.split(iter_2_1.unlockCondition, "#")

					if tonumber(var_2_4[1]) == 1 then
						var_2_3 = tonumber(var_2_4[2])
					end
				end

				var_2_2.score = var_2_3

				table.insert(var_2_0, var_2_2)
			end
		end
	end

	return var_2_0
end

local var_0_1 = {
	[CharacterEnum.VoiceType.GreetingInThumbnail] = true,
	[CharacterEnum.VoiceType.LimitedEntrance] = true,
	[CharacterEnum.VoiceType.MainViewSpecialInteraction] = true,
	[CharacterEnum.VoiceType.MainViewSpecialRespond] = true,
	[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = true
}

function var_0_0._checkShow(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2.show == 2 or var_0_1[arg_3_2.type] then
		return false
	end

	if arg_3_0:_checkSpecialType(arg_3_2) then
		return false
	end

	if arg_3_2.stateCondition ~= 0 then
		local var_3_0 = CharacterVoiceController.instance:getDefaultValue(arg_3_1)
		local var_3_1 = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, arg_3_1, var_3_0)

		if arg_3_2.stateCondition ~= var_3_1 then
			return false
		end
	end

	if string.nilorempty(arg_3_2.skins) then
		return true
	end

	local var_3_2 = HeroModel.instance:getByHeroId(arg_3_1).skin

	return string.find(arg_3_2.skins, var_3_2)
end

function var_0_0._checkSpecialType(arg_4_0, arg_4_1)
	if arg_4_1.type == CharacterEnum.VoiceType.MultiVoice then
		return true
	end

	return arg_4_1.type >= CharacterEnum.VoiceType.SpecialIdle1 and arg_4_1.type <= CharacterEnum.VoiceType.SpecialIdle2
end

function var_0_0.isCurHeroAudioLocked(arg_5_0, arg_5_1)
	return HeroModel.instance:getHeroAllVoice(arg_5_0._heroId)[arg_5_1] == nil
end

function var_0_0.isCurHeroAudioPlaying(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._playingList) do
		if iter_6_1 == arg_6_1 then
			return true
		end
	end

	return false
end

function var_0_0.setPlayingInfo(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._curAudioId = arg_7_1
	arg_7_0._defaultAudioId = arg_7_2
end

function var_0_0.getPlayingAudioId(arg_8_0, arg_8_1)
	if arg_8_0._defaultAudioId ~= arg_8_1 then
		return
	end

	if arg_8_0:isCurHeroAudioPlaying(arg_8_0._curAudioId) then
		return arg_8_0._curAudioId
	end
end

function var_0_0.setCurHeroAudioPlaying(arg_9_0, arg_9_1)
	arg_9_0._playingList = {}

	table.insert(arg_9_0._playingList, arg_9_1)
end

function var_0_0.setCurHeroAudioFinished(arg_10_0, arg_10_1)
	for iter_10_0 = #arg_10_0._playingList, 1, -1 do
		if arg_10_0._playingList[iter_10_0] == arg_10_1 then
			table.remove(arg_10_0._playingList, iter_10_0)

			break
		end
	end
end

function var_0_0.getCurHeroId(arg_11_0)
	return arg_11_0._heroId
end

function var_0_0.setCurHeroId(arg_12_0, arg_12_1)
	if arg_12_0._heroId ~= arg_12_1 then
		arg_12_0._playingList = {}
		arg_12_0._heroId = arg_12_1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
