module("modules.logic.fight.entity.mgr.FightAudioMgr", package.seeall)

local var_0_0 = class("FightAudioMgr")
local var_0_1 = {
	[100102] = 3025,
	[100101] = 3023,
	[100109] = 3023
}

function var_0_0.init(arg_1_0)
	arg_1_0._str2Id = {}
	arg_1_0._cardAudio = {}
	arg_1_0._fightAudio = {}
	arg_1_0._fightAudioStartTime = {}
	arg_1_0._fightAudio2LangDict = {}
	arg_1_0._playingBnk2Lang = {}
	arg_1_0._playingBnk2AudioIds = {}
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:clearCardAudio()
	arg_2_0:stopAllFightAudio()
end

function var_0_0.onDirectPlayAudio(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = Time.time

		arg_3_0._fightAudioStartTime[arg_3_1] = var_3_0
	end
end

function var_0_0.playAudio(arg_4_0, arg_4_1)
	if not arg_4_1 or arg_4_1 <= 0 then
		return
	end

	local var_4_0 = Time.time
	local var_4_1 = arg_4_0._fightAudioStartTime[arg_4_1]

	arg_4_0._fightAudioStartTime[arg_4_1] = var_4_0

	local var_4_2 = AudioEffectMgr.instance:isPlaying(arg_4_1)

	if var_4_2 and var_4_1 and var_4_0 - var_4_1 < 0.01 then
		return
	end

	local var_4_3 = AudioConfig.instance:getAudioCOById(arg_4_1)

	if var_4_3 then
		local var_4_4 = var_4_3.bankName
		local var_4_5 = GameConfig:GetCurVoiceShortcut()

		if arg_4_0._playingBnk2Lang[var_4_4] and arg_4_0._playingBnk2Lang[var_4_4] ~= var_4_5 then
			local var_4_6 = arg_4_0._playingBnk2AudioIds[var_4_4]

			if var_4_6 then
				for iter_4_0, iter_4_1 in ipairs(var_4_6) do
					AudioEffectMgr.instance:stopAudio(iter_4_1)
				end

				arg_4_0._playingBnk2AudioIds[var_4_4] = {}
			end
		end

		arg_4_0._playingBnk2Lang[var_4_4] = var_4_5
		arg_4_0._playingBnk2AudioIds[var_4_4] = arg_4_0._playingBnk2AudioIds[var_4_4] or {}

		table.insert(arg_4_0._playingBnk2AudioIds[var_4_4], arg_4_1)
	end

	if var_4_2 then
		AudioEffectMgr.instance:stopAudio(arg_4_1)
	end

	AudioEffectMgr.instance:playAudio(arg_4_1)

	if not tabletool.indexOf(arg_4_0._fightAudio, arg_4_1) then
		table.insert(arg_4_0._fightAudio, arg_4_1)
	end
end

function var_0_0.playAudioWithLang(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 then
		arg_5_0:playAudio(arg_5_1)

		return
	end

	if not arg_5_1 or arg_5_1 <= 0 then
		return
	end

	local var_5_0 = Time.time
	local var_5_1 = arg_5_0._fightAudioStartTime[arg_5_1]

	arg_5_0._fightAudioStartTime[arg_5_1] = var_5_0

	local var_5_2 = AudioEffectMgr.instance:isPlaying(arg_5_1)

	if var_5_2 and var_5_1 and var_5_0 - var_5_1 < 0.01 then
		return
	end

	local var_5_3 = AudioConfig.instance:getAudioCOById(arg_5_1)

	if var_5_3 then
		local var_5_4 = var_5_3.bankName

		if arg_5_0._playingBnk2Lang[var_5_4] and arg_5_0._playingBnk2Lang[var_5_4] ~= arg_5_2 then
			local var_5_5 = arg_5_0._playingBnk2AudioIds[var_5_4]

			if var_5_5 then
				for iter_5_0, iter_5_1 in ipairs(var_5_5) do
					AudioEffectMgr.instance:stopAudio(iter_5_1)
				end

				arg_5_0._playingBnk2AudioIds[var_5_4] = {}
			end
		end

		arg_5_0._playingBnk2Lang[var_5_4] = arg_5_2
		arg_5_0._playingBnk2AudioIds[var_5_4] = arg_5_0._playingBnk2AudioIds[var_5_4] or {}

		table.insert(arg_5_0._playingBnk2AudioIds[var_5_4], arg_5_1)

		if var_5_2 and arg_5_0._fightAudio2LangDict[arg_5_1] and arg_5_0._fightAudio2LangDict[arg_5_1] ~= arg_5_2 then
			AudioEffectMgr.instance:stopAudio(arg_5_1)
		end

		arg_5_0._fightAudio2LangDict[arg_5_1] = arg_5_2
	end

	if var_5_2 then
		AudioEffectMgr.instance:stopAudio(arg_5_1)
	end

	AudioEffectMgr.instance:playAudio(arg_5_1, nil, arg_5_2)

	if not tabletool.indexOf(arg_5_0._fightAudio, arg_5_1) then
		table.insert(arg_5_0._fightAudio, arg_5_1)
	end
end

function var_0_0.stopAudio(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1 > 0 then
		tabletool.removeValue(arg_6_0._fightAudio, arg_6_1)
		AudioEffectMgr.instance:stopAudio(arg_6_1, 0)
	end
end

function var_0_0.playCardAudio(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:stopCardAudio(arg_7_1)

	arg_7_0._cardAudio[arg_7_1] = arg_7_2

	local var_7_0

	if arg_7_3 then
		local var_7_1, var_7_2, var_7_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_7_3)
		local var_7_4 = LangSettings.shortcutTab[var_7_1]

		if not string.nilorempty(var_7_4) and not var_7_3 then
			var_7_0 = var_7_4
		end
	end

	AudioEffectMgr.instance:playAudio(arg_7_2, nil, var_7_0)

	local var_7_5 = AudioMgr.instance:getIdFromString("card_voc")
	local var_7_6 = AudioMgr.instance:getIdFromString("fightingvoc")

	AudioEffectMgr.instance:setSwitch(arg_7_2, var_7_5, var_7_6)
end

function var_0_0.stopAllFightAudio(arg_8_0)
	if not arg_8_0._fightAudio then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._fightAudio) do
		AudioEffectMgr.instance:stopAudio(iter_8_1)
	end

	arg_8_0._fightAudio = {}
end

function var_0_0.stopAllCardAudio(arg_9_0)
	if not arg_9_0._cardAudio then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._cardAudio) do
		AudioEffectMgr.instance:stopAudio(iter_9_1)
	end
end

function var_0_0.clearCardAudio(arg_10_0)
	arg_10_0._cardAudio = {}
end

function var_0_0.stopCardAudio(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._cardAudio[arg_11_1]

	if var_11_0 then
		AudioEffectMgr.instance:stopAudio(var_11_0)
	end
end

function var_0_0.playHeroVoiceRandom(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getHeroVoiceRandom(arg_12_1, arg_12_2)

	if var_12_0 then
		local var_12_1

		if arg_12_1 then
			local var_12_2, var_12_3, var_12_4 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_12_1)
			local var_12_5 = LangSettings.shortcutTab[var_12_2]

			if not string.nilorempty(var_12_5) and not var_12_4 then
				var_12_1 = var_12_5
			end
		end

		arg_12_0:playAudioWithLang(var_12_0, var_12_1)
	end
end

function var_0_0.getHeroVoiceRandom(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = FightDataHelper.entityMgr:getById(arg_13_3)
	local var_13_1 = arg_13_0:_getHeroVoiceCOs(arg_13_1, arg_13_2, var_13_0 and var_13_0.skin)

	if not var_13_1 or #var_13_1 == 0 then
		return
	end

	local var_13_2 = #var_13_1

	if var_13_2 == 1 then
		return var_13_1[var_13_2].audio
	end

	while true do
		local var_13_3 = var_13_1[math.random(var_13_2)]

		if not arg_13_3 or var_13_3.audio ~= arg_13_0._cardAudio[arg_13_3] then
			return var_13_3.audio
		end
	end
end

function var_0_0.playHitVoice(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = CharacterEnum.VoiceType.FightBehit
	local var_14_1 = arg_14_0:getHeroVoiceWithWeight(arg_14_1, var_14_0)

	if var_14_1 then
		arg_14_0:playAudioWithLang(var_14_1, arg_14_2)

		local var_14_2 = AudioMgr.instance:getIdFromString("Hitvoc")
		local var_14_3 = AudioMgr.instance:getIdFromString("commbatuihitvoc")

		AudioEffectMgr.instance:setSwitch(var_14_1, var_14_2, var_14_3)
	end
end

function var_0_0.getHeroVoiceWithWeight(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:_getHeroVoiceCOs(arg_15_1, arg_15_2)

	if var_15_0 and #var_15_0 > 0 then
		local var_15_1 = 0

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			var_15_1 = var_15_1 + (tonumber(iter_15_1.param) or 0)
		end

		local var_15_2 = math.random()
		local var_15_3 = 0

		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			var_15_3 = var_15_3 + (tonumber(iter_15_3.param) or 0)

			if var_15_2 <= var_15_3 / var_15_1 then
				return iter_15_3.audio
			end
		end
	end
end

function var_0_0._getHeroVoiceCOs(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if CharacterDataConfig.instance:getCharacterVoicesCo(arg_16_1) then
		if HeroModel.instance:getByHeroId(arg_16_1) then
			return HeroModel.instance:getVoiceConfig(arg_16_1, arg_16_2, nil, arg_16_3)
		else
			return CharacterDataConfig.instance:getCharacterTypeVoicesCO(arg_16_1, arg_16_2, arg_16_3)
		end
	else
		local var_16_0 = lua_monster.configDict[arg_16_1]

		if var_16_0 then
			local var_16_1 = FightConfig.instance:getSkinCO(var_16_0.skinId)

			if var_16_1 then
				return CharacterDataConfig.instance:getCharacterTypeVoicesCO(var_16_1.characterId, arg_16_2, var_16_0.skinId)
			end
		end
	end
end

function var_0_0.playHit(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = FightConfig.instance:getSkinCO(arg_17_2)

	if var_17_0 then
		local var_17_1 = arg_17_3 and 2 or 1
		local var_17_2 = var_17_0.matId

		AudioMgr.instance:setSwitch(arg_17_0:getId(FightEnum.HitStatusGroupName), arg_17_0:getId(FightEnum.HitStatusArr[var_17_1]))
		AudioMgr.instance:setSwitch(arg_17_0:getId(FightEnum.HitMaterialGroupName), arg_17_0:getId(FightEnum.HitMaterialArr[var_17_2]))
		AudioMgr.instance:trigger(arg_17_1)
	end
end

function var_0_0.playHitByAtkAudioId(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_1 then
		return
	end

	local var_18_0 = lua_fight_audio.configDict[arg_18_1]
	local var_18_1 = FightConfig.instance:getSkinCO(arg_18_2)

	if var_18_0 and var_18_1 then
		local var_18_2 = tonumber(var_18_0.weapon) or 0

		if var_18_2 == 99 then
			return
		end

		local var_18_3 = FightEnum.WeaponHitSwitchNames[var_18_2] or ""
		local var_18_4 = arg_18_3 and 2 or 1
		local var_18_5 = var_18_1.matId

		AudioMgr.instance:setSwitch(arg_18_0:getId(FightEnum.HitStatusGroupName), arg_18_0:getId(FightEnum.HitStatusArr[var_18_4]))
		AudioMgr.instance:setSwitch(arg_18_0:getId(FightEnum.HitMaterialGroupName), arg_18_0:getId(FightEnum.HitMaterialArr[var_18_5]))
		AudioMgr.instance:setSwitch(arg_18_0:getId(FightEnum.WeaponHitSwitchGroup), arg_18_0:getId(var_18_3))
		AudioMgr.instance:trigger(FightEnum.UniformDefAudioId)
	end
end

function var_0_0.setSwitch(arg_19_0, arg_19_1)
	AudioMgr.instance:setSwitch(arg_19_0:getId(FightEnum.AudioSwitchGroup), arg_19_0:getId(arg_19_1))
end

function var_0_0.getId(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._str2Id[arg_20_1]

	if not var_20_0 then
		var_20_0 = AudioMgr.instance:getIdFromString(arg_20_1)
		arg_20_0._str2Id[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0.obscureBgm(arg_21_0, arg_21_1)
	if not arg_21_0.mainObscureCount then
		arg_21_0.mainObscureCount = 0
	end

	local var_21_0 = arg_21_1 and 1 or -1

	arg_21_0.mainObscureCount = arg_21_0.mainObscureCount + var_21_0

	if not arg_21_1 and arg_21_0.mainObscureCount ~= 0 then
		return
	end

	if arg_21_1 and arg_21_0.mainObscureCount ~= 1 then
		return
	end

	if GameSceneMgr.instance:isFightScene() then
		AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("main_obscure"), AudioMgr.instance:getIdFromString(arg_21_1 and "yes" or "no"))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
