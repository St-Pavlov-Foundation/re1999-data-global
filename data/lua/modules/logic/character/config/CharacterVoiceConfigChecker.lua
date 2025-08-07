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
end

function var_0_0._handlerSkip(arg_3_0, arg_3_1)
	return
end

function var_0_0._handlerGetSkin(arg_4_0, arg_4_1)
	if not lua_skin.configDict[tonumber(arg_4_1.param)] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_4_1.audio, arg_4_1.type, arg_4_1.param))

		return
	end
end

function var_0_0._handlerMainViewSpecialTouch(arg_5_0, arg_5_1)
	local var_5_0 = tonumber(arg_5_1.param)

	if var_5_0 < var_0_1 or var_5_0 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_5_1.audio, arg_5_1.type, arg_5_1.param))
	end
end

function var_0_0._handlerWeatherChange(arg_6_0, arg_6_1)
	local var_6_0 = string.splitToNumber(arg_6_1.param, "#")

	if #var_6_0 == 0 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_6_1.audio, arg_6_1.type, arg_6_1.param))

		return
	end

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if not lua_weather_report.configDict[iter_6_1] then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_6_1.audio, arg_6_1.type, arg_6_1.param))

			break
		end
	end
end

function var_0_0._handlerMainViewWelcome(arg_7_0, arg_7_1)
	local var_7_0 = string.split(arg_7_1.time, "#")
	local var_7_1 = string.split(var_7_0[1], ":")
	local var_7_2

	var_7_2 = tonumber(var_7_1[1]) < 12
end

function var_0_0._handlerMainViewNoInteraction(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1.param, "#")

	if #var_8_0 == 0 or not var_8_0[1] or not var_8_0[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_8_1.audio, arg_8_1.type, arg_8_1.param))

		return
	end
end

function var_0_0._handlerGreetingInThumbnail(arg_9_0, arg_9_1)
	local var_9_0 = string.split(arg_9_1.time, "#")
	local var_9_1 = string.split(var_9_0[1], ":")
	local var_9_2

	var_9_2 = tonumber(var_9_1[1]) < 12
end

function var_0_0._handlerMainViewSpecialInteraction(arg_10_0, arg_10_1)
	local var_10_0 = string.splitToNumber(arg_10_1.param, "#")

	if #var_10_0 == 0 or not var_10_0[1] or not var_10_0[2] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_10_1.audio, arg_10_1.type, arg_10_1.param))
	end

	local var_10_1 = tonumber(arg_10_1.param2)

	if not var_10_1 or not lua_character_special_interaction_voice.configDict[var_10_1] then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", arg_10_1.audio, arg_10_1.type, arg_10_1.param2))
	end
end

function var_0_0._handlerMainViewSpecialRespond(arg_11_0, arg_11_1)
	local var_11_0 = tonumber(arg_11_1.param) or 0

	if var_11_0 == 0 then
		return
	end

	if var_11_0 < var_0_1 or var_11_0 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_11_1.audio, arg_11_1.type, arg_11_1.param))
	end
end

function var_0_0._handlerMainViewDragSpecialRespond(arg_12_0, arg_12_1)
	if not string.nilorempty(arg_12_1.param2) then
		local var_12_0 = string.split(arg_12_1.param2, "#")

		if #var_12_0 == 0 or not var_12_0[1] or not tonumber(var_12_0[2]) or not tonumber(var_12_0[3]) then
			logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param2:%s is invalid", arg_12_1.audio, arg_12_1.type, arg_12_1.param2))
		end
	end

	local var_12_1 = tonumber(arg_12_1.param) or 0

	if var_12_1 == 0 then
		return
	end

	if var_12_1 < var_0_1 or var_12_1 > var_0_2 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_12_1.audio, arg_12_1.type, arg_12_1.param))
	end
end

function var_0_0._handlerMultiVoice(arg_13_0, arg_13_1)
	local var_13_0 = lua_character_voice.configDict[arg_13_1.heroId][tonumber(arg_13_1.param)]

	if not var_13_0 or var_13_0 == arg_13_1 then
		logError(string.format("CharacterVoiceConfigChecker audio:%s type:%s param:%s is invalid", arg_13_1.audio, arg_13_1.type, arg_13_1.param))
	end
end

function var_0_0._handlerFightCardSkill3Voice(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.param

	if not string.nilorempty(var_14_0) then
		local var_14_1 = FightHelper.getRolesTimelinePath(var_14_0)
		local var_14_2 = SLFramework.FrameworkSettings.AssetRootDir .. "/" .. var_14_1

		if not SLFramework.FileHelper.IsFileExists(var_14_2) then
			logError(string.format("[CharacterVoiceConfigChecker] 角色语音表配置的timeline不存在, audio:%s, type:%s, param:%s, is invalid", arg_14_1.audio, arg_14_1.type, arg_14_1.param))
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
