module("modules.logic.common.config.AudioConfig", package.seeall)

local var_0_0 = class("AudioConfig", BaseConfig)

setNeedLoadModule("modules.logic.common.config.auto_mouth_data", "auto_mouth_data")

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"role_audio",
		"ui_audio",
		"bg_audio",
		"fight_audio",
		"story_audio",
		"story_role_audio",
		"effect_audio",
		"effect_with_audio",
		"story_audio_main",
		"story_audio_branch",
		"story_audio_system",
		"story_audio_role",
		"story_audio_effect",
		"story_audio_short"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_loadAutoMouthConfig()
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "effect_with_audio" then
		local var_3_0 = "effects/prefabs/"
		local var_3_1 = ".prefab"

		arg_3_0._effectToAudioConfigDict = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_2.configDict) do
			arg_3_0._effectToAudioConfigDict[var_3_0 .. iter_3_1.effect .. var_3_1] = iter_3_1
		end
	end
end

function var_0_0.InitCSByConfig(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0:getAudioCO()) do
		arg_4_0:_InitCS(arg_4_1, iter_4_1)
	end
end

function var_0_0._InitCS(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	arg_5_1:InitConfig(arg_5_2.id, arg_5_2.eventName, arg_5_2.bankName)
end

function var_0_0.getAudioCO(arg_6_0)
	if not arg_6_0._audioId2AudioCODict then
		arg_6_0._audioId2AudioCODict = {}

		arg_6_0:_buildRelation(lua_role_audio.configList)
		arg_6_0:_buildRelation(lua_ui_audio.configList)
		arg_6_0:_buildRelation(lua_bg_audio.configList)
		arg_6_0:_buildRelation(lua_fight_audio.configList)
		arg_6_0:_buildRelation(lua_story_audio.configList)
		arg_6_0:_buildRelation(lua_story_audio_main.configList)
		arg_6_0:_buildRelation(lua_story_audio_branch.configList)
		arg_6_0:_buildRelation(lua_story_audio_system.configList)
		arg_6_0:_buildRelation(lua_story_audio_role.configList)
		arg_6_0:_buildRelation(lua_story_audio_effect.configList)
		arg_6_0:_buildRelation(lua_story_audio_short.configList)
		arg_6_0:_buildRelation(lua_story_role_audio.configList)
		arg_6_0:_buildRelation(lua_effect_audio.configList)
	end

	return arg_6_0._audioId2AudioCODict
end

function var_0_0.getAudioCOById(arg_7_0, arg_7_1)
	arg_7_0:getAudioCO()

	return arg_7_0._audioId2AudioCODict[arg_7_1]
end

function var_0_0._buildRelation(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		arg_8_0._audioId2AudioCODict[iter_8_1.id] = iter_8_1
	end
end

function var_0_0.getAudioConfig(arg_9_0, arg_9_1)
	return arg_9_0._effectToAudioConfigDict and arg_9_0._effectToAudioConfigDict[arg_9_1]
end

function var_0_0._loadAutoMouthConfig(arg_10_0)
	arg_10_0._allMouthDic = {}

	if GameResMgr.IsFromEditorDir then
		local var_10_0 = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/auto_mouth")
		local var_10_1 = var_10_0.Length

		for iter_10_0 = 1, var_10_1 do
			local var_10_2 = var_10_0[iter_10_0 - 1]

			if not string.find(var_10_2, ".meta") then
				local var_10_3 = SLFramework.FileHelper.GetFileName(var_10_2, true)
				local var_10_4 = "configs/auto_mouth/" .. var_10_3

				loadNonAbAsset(var_10_4, SLFramework.AssetType.TEXT, arg_10_0._onConfigNoAbCallback, arg_10_0)
			end
		end
	else
		loadAbAsset("configs/auto_mouth", false, arg_10_0._onConfigAbCallback, arg_10_0)
	end
end

function var_0_0._onConfigNoAbCallback(arg_11_0, arg_11_1)
	if not arg_11_1.IsLoadSuccess then
		logError("config load fail: " .. arg_11_1.ResPath)

		return
	end

	local var_11_0 = SLFramework.FileHelper.GetFileName(arg_11_1.ResPath, false)
	local var_11_1 = arg_11_0:_decodeJsonStr(arg_11_1.TextAsset)

	arg_11_0._allMouthDic[var_11_0] = var_11_1
end

function var_0_0._decodeJsonStr(arg_12_0, arg_12_1)
	local var_12_0

	if isDebugBuild then
		local var_12_1, var_12_2 = pcall(cjson.decode, arg_12_1)

		if not var_12_1 then
			logError("配置解析失败: " .. arg_12_1)

			return
		end

		var_12_0 = var_12_2
	else
		var_12_0 = cjson.decode(arg_12_1)
	end

	return var_12_0
end

function var_0_0._onConfigAbCallback(arg_13_0, arg_13_1)
	if not arg_13_1.IsLoadSuccess then
		logError("config load fail: " .. arg_13_1.ResPath)

		return
	end

	arg_13_1:Retain()

	arg_13_0._autoMouthAssetItem = arg_13_1
end

function var_0_0.getAutoMouthData(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getAudioCOById(arg_14_1)

	if var_14_0 then
		local var_14_1 = arg_14_0._allMouthDic[var_14_0.bankName]

		if var_14_1 == nil and arg_14_0._autoMouthAssetItem then
			local var_14_2 = arg_14_0._autoMouthAssetItem:GetResource("configs/auto_mouth/" .. var_14_0.bankName .. ".json")

			if var_14_2 then
				var_14_1 = cjson.decode(var_14_2.text)
				arg_14_0._allMouthDic[var_14_0.bankName] = var_14_1
			end
		end

		if var_14_1 and var_14_1[var_14_0.eventName] then
			return var_14_1[var_14_0.eventName][arg_14_2]
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
