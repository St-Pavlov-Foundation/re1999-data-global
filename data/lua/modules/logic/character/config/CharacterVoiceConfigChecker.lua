module("modules.logic.character.config.CharacterVoiceConfigChecker", package.seeall)

local var_0_0 = class("CharacterVoiceConfigChecker")
local var_0_1 = 1
local var_0_2 = 5

function var_0_0.checkConfig(arg_1_0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local var_1_0 = {
		[CharacterEnum.VoiceType.HeroGroup] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.EnterFight] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar12] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardStar3] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightCardUnique] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightBehit] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightResult] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.FightDie] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.GetSkin] = arg_1_0._handlerGetSkin,
		[CharacterEnum.VoiceType.BreakThrough] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.Summon] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialTouch] = arg_1_0._handlerMainViewSpecialTouch,
		[CharacterEnum.VoiceType.MainViewNormalTouch] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.WeatherChange] = arg_1_0._handlerWeatherChange,
		[CharacterEnum.VoiceType.MainViewWelcome] = arg_1_0._handlerMainViewWelcome,
		[CharacterEnum.VoiceType.MainViewNoInteraction] = arg_1_0._handlerMainViewNoInteraction,
		[CharacterEnum.VoiceType.Greeting] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.Skill] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.GreetingInThumbnail] = arg_1_0._handlerGreetingInThumbnail,
		[CharacterEnum.VoiceType.SpecialIdle1] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.SpecialIdle2] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.LimitedEntrance] = arg_1_0._handlerSkip,
		[CharacterEnum.VoiceType.MainViewSpecialInteraction] = arg_1_0._handlerMainViewSpecialInteraction,
		[CharacterEnum.VoiceType.MainViewSpecialRespond] = arg_1_0._handlerMainViewSpecialRespond,
		[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = arg_1_0._handlerMainViewDragSpecialRespond,
		[CharacterEnum.VoiceType.MultiVoice] = arg_1_0._handlerMultiVoice,
		[CharacterEnum.VoiceType.FightCardSkill3] = arg_1_0._handlerFightCardSkill3Voice
	}

	for iter_1_0, iter_1_1 in ipairs(lua_character_voice.configList) do
		if not callWithCatch(arg_1_0._commonCheck, arg_1_0, iter_1_1) then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", iter_1_1.audio, iter_1_1.type))
		end

		local var_1_1 = var_1_0[iter_1_1.type]

		if var_1_1 then
			if not callWithCatch(var_1_1, arg_1_0, iter_1_1) then
				logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s is invalid", iter_1_1.audio, iter_1_1.type))
			end
		else
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s no handler", iter_1_1.audio, iter_1_1.type))
		end
	end
end

function var_0_0._commonCheck(arg_2_0, arg_2_1)
	local var_2_0 = string.splitToNumber(arg_2_1.skins, "#")

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if not lua_skin.configDict[iter_2_1] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s skinId:%s is invalid", arg_2_1.audio, arg_2_1.type, iter_2_1))
		end
	end

	arg_2_0:_addAudioCheck(arg_2_1)
end

function var_0_0._addAudioCheck(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_1.addaudio) then
		return
	end

	local var_3_0 = string.split(arg_3_1.addaudio, "|")

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_1 = string.split(iter_3_1, "#")

		for iter_3_2, iter_3_3 in ipairs(var_3_1) do
			if not tonumber(iter_3_3) then
				logError(string.format("CharacterVoiceConfigChecker _addAudioCheck audio:%s type:%s audioParam:%s index:%s is invalid", arg_3_1.audio, arg_3_1.type, iter_3_1, iter_3_2))
			end
		end
	end
end

function var_0_0._handlerSkip(arg_4_0, arg_4_1)
	return
end

function var_0_0._handlerGetSkin(arg_5_0, arg_5_1)
	if not lua_skin.configDict[tonumber(arg_5_1.param)] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_5_1.audio, arg_5_1.type, arg_5_1.param))

		return
	end
end

function var_0_0._handlerMainViewSpecialTouch(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(arg_6_1.param)

	if var_6_0 < var_0_1 or var_6_0 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_6_1.audio, arg_6_1.type, arg_6_1.param))
	end
end

function var_0_0._handlerWeatherChange(arg_7_0, arg_7_1)
	local var_7_0 = string.splitToNumber(arg_7_1.param, "#")

	if #var_7_0 == 0 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_7_1.audio, arg_7_1.type, arg_7_1.param))

		return
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if not lua_weather_report.configDict[iter_7_1] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_7_1.audio, arg_7_1.type, arg_7_1.param))

			break
		end
	end
end

function var_0_0._handlerMainViewWelcome(arg_8_0, arg_8_1)
	local var_8_0 = string.split(arg_8_1.time, "#")
	local var_8_1 = string.split(var_8_0[1], ":")
	local var_8_2

	var_8_2 = tonumber(var_8_1[1]) < 12
end

function var_0_0._handlerMainViewNoInteraction(arg_9_0, arg_9_1)
	local var_9_0 = string.splitToNumber(arg_9_1.param, "#")

	if #var_9_0 == 0 or not var_9_0[1] or not var_9_0[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_9_1.audio, arg_9_1.type, arg_9_1.param))

		return
	end
end

function var_0_0._handlerGreetingInThumbnail(arg_10_0, arg_10_1)
	local var_10_0 = string.split(arg_10_1.time, "#")
	local var_10_1 = string.split(var_10_0[1], ":")
	local var_10_2

	var_10_2 = tonumber(var_10_1[1]) < 12
end

function var_0_0._handlerMainViewSpecialInteraction(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1.param, "#")

	if #var_11_0 == 0 or not var_11_0[1] or not var_11_0[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_11_1.audio, arg_11_1.type, arg_11_1.param))
	end

	local var_11_1 = tonumber(arg_11_1.param2)

	if not var_11_1 or not lua_character_special_interaction_voice.configDict[var_11_1] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", arg_11_1.audio, arg_11_1.type, arg_11_1.param2))
	end
end

function var_0_0._handlerMainViewSpecialRespond(arg_12_0, arg_12_1)
	local var_12_0 = tonumber(arg_12_1.param) or 0

	if var_12_0 == 0 then
		return
	end

	if var_12_0 < var_0_1 or var_12_0 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_12_1.audio, arg_12_1.type, arg_12_1.param))
	end
end

function var_0_0._handlerMainViewDragSpecialRespond(arg_13_0, arg_13_1)
	if not string.nilorempty(arg_13_1.param2) then
		local var_13_0 = string.split(arg_13_1.param2, "#")

		if #var_13_0 == 0 or not var_13_0[1] or not tonumber(var_13_0[2]) or not tonumber(var_13_0[3]) then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", arg_13_1.audio, arg_13_1.type, arg_13_1.param2))
		end
	end

	local var_13_1 = tonumber(arg_13_1.param) or 0

	if var_13_1 == 0 then
		return
	end

	if var_13_1 < var_0_1 or var_13_1 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_13_1.audio, arg_13_1.type, arg_13_1.param))
	end
end

function var_0_0._handlerMultiVoice(arg_14_0, arg_14_1)
	local var_14_0 = lua_character_voice.configDict[arg_14_1.heroId][tonumber(arg_14_1.param)]

	if not var_14_0 or var_14_0 == arg_14_1 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_14_1.audio, arg_14_1.type, arg_14_1.param))
	end
end

function var_0_0._handlerFightCardSkill3Voice(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.param
	local var_15_1 = string.split(var_15_0, "#")

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if not string.nilorempty(iter_15_1) then
			iter_15_1 = FightHelper.getRolesTimelinePath(iter_15_1)

			local var_15_2 = SLFramework.FrameworkSettings.AssetRootDir .. "/" .. iter_15_1

			if not SLFramework.FileHelper.IsFileExists(var_15_2) then
				logError(string.format("[CharacterVoiceConfigChecker] 角色语音表配置的timeline不存在, audio:%s, type:%s, param:%s, is invalid", arg_15_1.audio, arg_15_1.type, arg_15_1.param))
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
