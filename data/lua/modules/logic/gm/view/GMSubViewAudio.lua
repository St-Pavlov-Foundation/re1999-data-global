module("modules.logic.gm.view.GMSubViewAudio", package.seeall)

local var_0_0 = class("GMSubViewAudio", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "音效"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	arg_4_0.lineIndex = 1

	GMSubViewBase.initViewContent(arg_4_0)
	arg_4_0:addTitleSplitLine("音频播放")
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "音效")

	arg_4_0._inpAudio = arg_4_0:addInputText("L1", "", "音效配置Id")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "播放", arg_4_0._onClickAudioPlay, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "停止", arg_4_0._onClickAudioStop, arg_4_0)

	arg_4_0._autoStopToggle = arg_4_0:addToggle(arg_4_0:getLineGroup(), "播放音效自动关闭上次音效", arg_4_0._onAutoStopChange, arg_4_0, {
		fsize = 24
	})
	arg_4_0._showLogToggle = arg_4_0:addToggle(arg_4_0:getLineGroup(), "打开日志", arg_4_0._onShowLogChange, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0._inpEvent = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "事件名称")
	arg_4_0._inpBank = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "bank名称")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "播放", arg_4_0._onClickEventPlay, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "停止", arg_4_0._onClickEventStop, arg_4_0)

	arg_4_0._langDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "语言", nil, arg_4_0._onLangDropChange, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0._inpRtpcName = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "RTPC名称", nil, nil, {
		w = 230
	})
	arg_4_0._inpRtpcValue = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "RTPC值", nil, nil, {
		w = 200
	})

	arg_4_0:addButton(arg_4_0:getLineGroup(), "设置", arg_4_0._onClickSetRtpc, arg_4_0)

	arg_4_0._inpSwitchName = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "Switch Group")
	arg_4_0._inpSwitchValue = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "Switch Value")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "设置", arg_4_0._onClickSwitch, arg_4_0)
	arg_4_0:addTitleSplitLine("音频资源检查")
	arg_4_0:addLineIndex()

	arg_4_0._textCheckAudio2 = arg_4_0:addButton(arg_4_0:getLineGroup(), "检查音效调用", arg_4_0._onClickCheckAudioCall, arg_4_0)[2]

	arg_4_0:addLabel(arg_4_0:getLineGroup(), "调用音频数量/GC:", {
		fsize = 30
	})

	arg_4_0._textCallAudioGCThreshold = arg_4_0:addInputText(arg_4_0:getLineGroup(), "10000")

	arg_4_0:addButton(arg_4_0:getLineGroup(), "检查音效调用(仅章节,活动部分)", arg_4_0._onClickCheckAudioChapterAndActiviy, arg_4_0, {
		fsize = 32
	})
	arg_4_0:addLineIndex()
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "章节ID:\n[逗号分隔]", {
		w = 100,
		h = 200,
		fsize = 36
	})

	local var_4_0 = PlayerPrefsHelper.getString("checkAudioChatperIdsKey", "")

	arg_4_0._chatperIdsToCheckAudio = arg_4_0:addInputText(arg_4_0:getLineGroup(), var_4_0, "", arg_4_0._onChatperIdsChange, arg_4_0, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	arg_4_0:addLabel(arg_4_0:getLineGroup(), "角色活动:", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	local var_4_1 = PlayerPrefsHelper.getString("checkAudioCharActCfgsKey", "")

	arg_4_0._charActCfgsToCheckAudio = arg_4_0:addInputText(arg_4_0:getLineGroup(), var_4_1, "", arg_4_0._onCharActCfgsChange, arg_4_0, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	arg_4_0:addLineIndex()
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "音频Id调用:\n[表,字段1,字段2|表，字段]", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	local var_4_2 = PlayerPrefsHelper.getString("checkAudioIdInConfigKey", "")

	arg_4_0._charAudioIdInConfig = arg_4_0:addInputText(arg_4_0:getLineGroup(), var_4_2, "", arg_4_0._CallAudioInConfig, arg_4_0, {
		w = 600,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})
	arg_4_0._textCheckAudioIdInConfig = arg_4_0:addButton(arg_4_0:getLineGroup(), "调用配置音效", arg_4_0._callAudioInConfig, arg_4_0)[2]

	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "检查音效配置项", arg_4_0._onClickCheckAudio1, arg_4_0)
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "检查冗余音效", arg_4_0._onClickCheckAudioResource, arg_4_0)
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "（检查不在音效表和代码中的音效）", {
		fsize = 30
	})
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "检查Bnk文件冗余", arg_4_0._checkAudioResInSoundbanksInfoXml, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "检查Bnk多语言缺失", arg_4_0._checkBnkLangInSoundbanksInfoXml, arg_4_0)
	arg_4_0:addLabel(arg_4_0:getLineGroup(), "(扫描本地文件和Soundbanksinfo中音频文件资源)", {
		fsize = 26
	})
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "释放音效Bnk", arg_4_0._onReleaseAudioResource, arg_4_0)

	arg_4_0.autoStopPrePlayingId = true
	arg_4_0.prePlayingId = 0
	arg_4_0.curLang = GameConfig:GetCurVoiceShortcut()
	arg_4_0._autoStopToggle.isOn = arg_4_0.autoStopPrePlayingId
	arg_4_0._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	arg_4_0.langList = {}

	local var_4_3 = GameConfig:GetSupportedVoiceShortcuts()
	local var_4_4 = var_4_3.Length
	local var_4_5 = 0

	for iter_4_0 = 0, var_4_4 - 1 do
		local var_4_6 = var_4_3[iter_4_0]

		table.insert(arg_4_0.langList, var_4_6)

		if var_4_6 == arg_4_0.curLang then
			var_4_5 = iter_4_0
		end
	end

	arg_4_0._langDrop:ClearOptions()
	arg_4_0._langDrop:AddOptions(arg_4_0.langList)
	arg_4_0._langDrop:SetValue(var_4_5)

	arg_4_0._inited = true
end

function var_0_0._onClickAudioPlay(arg_5_0)
	local var_5_0 = arg_5_0._inpAudio:GetText()

	if not string.nilorempty(var_5_0) then
		local var_5_1 = tonumber(var_5_0)

		if var_5_1 then
			if arg_5_0.autoStopPrePlayingId then
				arg_5_0:stopPlayingID()
			end

			arg_5_0.prePlayingId = AudioMgr.instance:trigger(var_5_1)
		end
	end
end

function var_0_0._getVoiceEmitter(arg_6_0)
	if not arg_6_0._emitter then
		arg_6_0._emitter = ZProj.AudioEmitter.Get(arg_6_0.viewGO)
	end

	return arg_6_0._emitter
end

function var_0_0._onClickAudioStop(arg_7_0)
	arg_7_0:stopPlayingID()
end

function var_0_0.stopPlayingID(arg_8_0)
	AudioMgr.instance:stopPlayingID(arg_8_0.prePlayingId)
end

function var_0_0._onAutoStopChange(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.autoStopPrePlayingId = arg_9_2
end

function var_0_0._onShowLogChange(arg_10_0, arg_10_1, arg_10_2)
	if GMController.instance:getShowAudioLog() == arg_10_2 then
		return
	end

	AudioMgr.GMOpenLog = arg_10_2
	ZProj.AudioManager.Instance.gmOpenLog = arg_10_2

	GMController.instance:setShowAudioLog(arg_10_2)
end

function var_0_0._onClickEventPlay(arg_11_0)
	local var_11_0 = arg_11_0._inpEvent:GetText()
	local var_11_1 = arg_11_0._inpBank:GetText()

	if string.nilorempty(var_11_0) then
		return
	end

	if string.nilorempty(var_11_1) then
		return
	end

	arg_11_0:initAudioEditorTool()

	if arg_11_0.autoStopPrePlayingId then
		arg_11_0:stopPlayingID()
	end

	arg_11_0.prePlayingId = arg_11_0.audioTool:PlayEvent(var_11_0, var_11_1)
end

function var_0_0._onClickEventStop(arg_12_0)
	arg_12_0:stopPlayingID()
end

function var_0_0.initAudioEditorTool(arg_13_0)
	if not arg_13_0.audioTool then
		arg_13_0.audioTool = ZProj.AudioEditorTool.Instance
	end
end

function var_0_0._onLangDropChange(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.langList[arg_14_1 + 1]

	if var_14_0 == arg_14_0.curLang then
		return
	end

	arg_14_0.curLang = var_14_0

	arg_14_0:stopPlayingID()
	arg_14_0:initAudioEditorTool()
	arg_14_0.audioTool:SetLanguage(arg_14_0.curLang)
end

function var_0_0._onClickSetRtpc(arg_15_0)
	local var_15_0 = arg_15_0._inpRtpcName:GetText()
	local var_15_1 = arg_15_0._inpRtpcValue:GetText()

	if string.nilorempty(var_15_0) then
		return
	end

	if string.nilorempty(var_15_1) then
		return
	end

	local var_15_2 = tonumber(var_15_1)

	if not var_15_2 then
		return
	end

	arg_15_0:initAudioEditorTool()
	arg_15_0.audioTool:SetRtpc(var_15_0, var_15_2)
end

function var_0_0._onClickSwitch(arg_16_0)
	local var_16_0 = arg_16_0._inpSwitchName:GetText()
	local var_16_1 = arg_16_0._inpSwitchValue:GetText()

	if string.nilorempty(var_16_0) then
		return
	end

	if string.nilorempty(var_16_1) then
		return
	end

	arg_16_0:initAudioEditorTool()
	arg_16_0.audioTool:SetSwitch(var_16_0, var_16_1)
end

function var_0_0._onChatperIdsChange(arg_17_0, arg_17_1)
	PlayerPrefsHelper.setString("checkAudioChatperIdsKey", arg_17_1)
end

function var_0_0._onCharActCfgsChange(arg_18_0, arg_18_1)
	PlayerPrefsHelper.setString("checkAudioCharActCfgsKey", arg_18_1)
end

function var_0_0._onCharAudioIdInConfigKeyChange(arg_19_0, arg_19_1)
	PlayerPrefsHelper.setString("checkAudioIdInConfigKey", arg_19_1)
end

function var_0_0._onClickCheckAudio1(arg_20_0)
	logNormal("检查音效配置项--------------------------------")

	arg_20_0._audioConfigs = {}

	arg_20_0:_checkAudioConfigs(lua_role_audio, "Y音效表.xlsx export_角色语音")
	arg_20_0:_checkAudioConfigs(lua_ui_audio, "Y音效表-UI音效表.xlsx export_UI音效")
	arg_20_0:_checkAudioConfigs(lua_bg_audio, "Y音效表-战斗&场景音效表.xlsx export_背景音乐")
	arg_20_0:_checkAudioConfigs(lua_fight_audio, "Y音效表-战斗&场景音效表.xlsx export_战斗音效")
	arg_20_0:_checkAudioConfigs(lua_story_audio, "Y音效表.xlsx export_剧情音效")
	arg_20_0:_checkAudioConfigs(lua_story_audio_main, "Y剧情配音2.0.xlsx export_主线剧情配音")
	arg_20_0:_checkAudioConfigs(lua_story_audio_branch, "Y剧情配音2.0.xlsx export_支线剧情配音")
	arg_20_0:_checkAudioConfigs(lua_story_audio_system, "Y剧情配音2.0.xlsx export_系统剧情配音")
	arg_20_0:_checkAudioConfigs(lua_story_audio_role, "Y剧情配音2.0.xlsx export_角色语音")
	arg_20_0:_checkAudioConfigs(lua_story_audio_effect, "Y剧情配音2.0.xlsx export_剧情音效")
	arg_20_0:_checkAudioConfigs(lua_story_audio_short, "Y剧情配音2.0.xlsx export_短语音")
	arg_20_0:_checkAudioConfigs(lua_story_role_audio, "Y音效表.xlsx export_剧情配音")
	arg_20_0:_checkAudioConfigs(lua_effect_audio, "Y音效表-战斗&场景音效表.xlsx export_特效音效")
	arg_20_0:_checkLowerName(arg_20_0._audioConfigs)
	logNormal("count = " .. #arg_20_0._audioConfigs)
	ZProj.AudioManager.Instance:SetErrorCallback(arg_20_0._onErrorCallback, arg_20_0)
	TaskDispatcher.runRepeat(arg_20_0._checkPlayConfigAudio, arg_20_0, 0.1)
end

function var_0_0._checkAudioConfigs(arg_21_0, arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1.configList) do
		if iter_21_1.id and iter_21_1.id > 0 and not tabletool.indexOf(arg_21_0._audioConfigs, iter_21_1.id) then
			table.insert(arg_21_0._audioConfigs, iter_21_1.id)

			arg_21_0._audioId2Excel = arg_21_0._audioId2Excel or {}
			arg_21_0._audioId2Excel[iter_21_1.id] = arg_21_2
		end
	end
end

function var_0_0._checkLowerName(arg_22_0, arg_22_1)
	local var_22_0 = {}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_2 = AudioConfig.instance:getAudioCOById(iter_22_1)

		if string.lower(var_22_2.bankName) ~= var_22_2.bankName and not var_22_1[var_22_2.bankName] then
			var_22_1[var_22_2.bankName] = true

			table.insert(var_22_0, "bank: " .. var_22_2.bankName)
		end

		if string.lower(var_22_2.eventName) ~= var_22_2.eventName then
			table.insert(var_22_0, "event: " .. var_22_2.eventName)
		end
	end

	if #var_22_0 > 0 then
		logError("大小写问题：\n" .. table.concat(var_22_0, "\n"))
	end
end

function var_0_0._checkPlayConfigAudio(arg_23_0)
	if arg_23_0._audioConfigs and #arg_23_0._audioConfigs > 0 then
		local var_23_0 = false

		for iter_23_0 = 1, 1000 do
			local var_23_1 = table.remove(arg_23_0._audioConfigs, #arg_23_0._audioConfigs)

			if var_23_1 then
				if #arg_23_0._audioConfigs % 100 == 0 and not var_23_0 then
					GameFacade.showToast(ToastEnum.IconId, "剩余" .. #arg_23_0._audioConfigs)

					var_23_0 = true
				end

				if not arg_23_0:_triggerAudio(var_23_1) then
					arg_23_0._errorAudioId = var_23_1

					return
				end
			else
				GameFacade.showToast(ToastEnum.IconId, "检查完毕")
				arg_23_0:_logAudioError()
				ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
				TaskDispatcher.cancelTask(arg_23_0._checkPlayConfigAudio, arg_23_0)

				break
			end
		end
	end
end

function var_0_0._triggerAudio(arg_24_0, arg_24_1)
	if arg_24_1 > 0 and arg_24_0:_getAudioConfig(arg_24_1) then
		local var_24_0 = AudioMgr.instance:trigger(arg_24_1)

		if var_24_0 > 0 then
			AudioMgr.instance:stopPlayingID(var_24_0)

			return true
		end
	end
end

function var_0_0._getAudioConfig(arg_25_0, arg_25_1)
	return AudioConfig.instance:getAudioCOById(arg_25_1)
end

function var_0_0._onClickCheckAudioCall(arg_26_0)
	arg_26_0:_CheckAudioCall()
end

function var_0_0._CheckAudioCall(arg_27_0)
	arg_27_0._checkAudioTextStr = arg_27_0._textCheckAudio2.text

	logNormal("检查音效调用--------------------------------")

	arg_27_0._callAudioIdList = {}

	arg_27_0:_checkAddConfigCallAudios(lua_character_voice, "audio", "J角色语音表.xlsx export_角色语音")
	arg_27_0:_checkAddConfigCallAudios(lua_effect_with_audio, "audioId", "T特效音效表.xlsx export_特效音效")
	arg_27_0:_checkAddConfigCallAudios(lua_fight_voice, {
		"audio_type1",
		"audio_type2",
		"audio_type3",
		"audio_type4",
		"audio_type5",
		"audio_type6",
		"audio_type7",
		"audio_type8",
		"audio_type9",
		"audio_type10"
	}, "J角色语音表.xlsx export_角色战斗语音")
	arg_27_0:_checkAddConfigCallAudios(lua_guide_step, "audio", "Z指引表.xlsx export_指引步骤")
	arg_27_0:_checkAddConfigCallAudios(lua_skill_behavior, "audioId", "J技能表.xlsx export_技能效果")
	arg_27_0:_checkAddConfigCallAudios(lua_skill_buff, {
		"audio",
		"triggerAudio",
		"delAudio"
	}, "J技能表.xlsx export_buff")
	arg_27_0:_checkAddConfigCallAudios(lua_buff_act, "audioId", "J技能表.xlsx export_基础buff效果")
	arg_27_0:_checkAddConfigCallAudios(lua_skin_spine_action, "audioId", "P皮肤表.xlsx export_战斗动作表现")
	arg_27_0:_checkAddConfigCallAudios(lua_chapter_map_element_dialog, "audio", "F副本表.xlsx export_元件对话")
	arg_27_0:_checkAddConfigCallAudios(lua_battle_dialog, "audioId", "Z战斗喊话表.xlsx export_战斗喊话")
	arg_27_0:_checkAddConfigCallAudios(lua_fight_debut_show, "audioId", "Z战斗补丁-出场表现表.xlsx export_出场表现")
	arg_27_0:_checkAddConfigCallAudios(lua_fight_summon_show, "audioId", "Z战斗补丁-召唤表现表.xlsx export_召唤表现")
	arg_27_0:_checkAddConfigCallAudios(lua_guide_step_addition, "audio", "Z指引表.xlsx export_附加步骤")
	arg_27_0:_checkAddConfigCallAudios(lua_production_part, "audio", "X小屋.xlsx export_枢纽部件")
	arg_27_0:_checkAddConfigCallAudios(lua_room_audio_extend, "audioId", "X小屋地块包表.xlsx export_音效拓展")
	arg_27_0:_checkAddConfigCallAudios(lua_character_shop_voice, "audio", "J角色语音表.xlsx export_商店语音表")
	arg_27_0:_checkAddConfigCallAudios(lua_explore_dialogue, "audio", "M密室探索表.xlsx export_对话")
	arg_27_0:_checkAddConfigCallAudios(lua_explore_hero_effect, "audioId", "M密室探索表.xlsx export_角色特效")
	arg_27_0:_checkAddConfigCallAudios(lua_explore_item, "audioId", "M密室探索表.xlsx export_物品")
	arg_27_0:_checkAddConfigCallAudios(lua_explore_unit_effect, "audioId", "M密室探索表.xlsx export_元件特效")
	arg_27_0:_checkAddConfigCallAudios(lua_toast, "audioId", "P飘字表.xlsx export_飘字表")
	arg_27_0:_checkAddConfigCallAudios(lua_character_limited, {
		"audio",
		"stopAudio"
	}, "J角色限定表现.xlsx export_限定角色表现")
	arg_27_0:_checkAddConfigCallAudios(lua_chapter_map, "effectAudio", "F副本表.xlsx export_主线地图")
	arg_27_0:_checkAddConfigCallAudios(lua_bgm_switch, "audio", "B背景音效切换.xlsx export_背景音效切换")
	arg_27_0:_checkAddConfigCallAudios(lua_fairyland_puzzle_talk, "audioId", "H幻境.xlsx export_幻境对话")
	arg_27_0:_checkAddConfigCallAudios(lua_fight_buff_layer_effect, {
		"loopEffectAudio",
		"createAudio",
		"destroyEffectAudio"
	}, "Z战斗配置-buff层数特效.xlsx export_buff层数特效")
	arg_27_0:_checkAddConfigCallAudios(lua_fight_effect_buff_skin, "audio", "Z战斗补丁-被动特效对应皮肤表.xlsx export_释放技能后延迟")
	arg_27_0:_checkAddConfigCallAudios(lua_magic_circle, {
		"enterAudio",
		"closeAudio"
	}, "S术阵表.xlsx export_法阵")
	arg_27_0:_checkAddConfigCallAudios(lua_room_building, "placeAudio", "X小屋地块包表.xlsx export_建筑")
	arg_27_0:_checkAddConfigCallAudios(lua_room_character_interaction, "buildingAudio", "X小屋角色表.xlsx export_角色交互")
	arg_27_0:_checkAddConfigCallAudios(lua_room_effect, "audioId", "X小屋.xlsx export_特效配置")
	arg_27_0:_checkAddConfigCallAudios(lua_room_vehicle, {
		"audioTurn",
		"audioTurnAround",
		"audioCrossload",
		"audioWalk",
		"audioStop"
	}, "X小屋地块包表.xlsx export_交通工具")
	arg_27_0:_checkAddConfigCallAudios(lua_rouge_short_voice, "audioId", "R肉鸽地图表.xlsx export_短语音表")
	arg_27_0:_checkAddConfigCallAudios(lua_summoned, {
		"enterAudio",
		"closeAudio"
	}, "Z召唤物挂件表.xlsx export_召唤物挂件")
	arg_27_0:_checkAddAudioEnumCall()
	arg_27_0:_checkTimelineCall(function()
		arg_27_0:_checkStoryCall()
	end)
end

function var_0_0._checkStoryCall(arg_29_0)
	if not SLFramework.FrameworkSettings.IsEditor then
		arg_29_0._storyLoaded = true

		return
	end

	local var_29_0 = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/"
	local var_29_1 = SLFramework.FileHelper.GetDirFilePaths(var_29_0)
	local var_29_2 = {}
	local var_29_3 = var_29_1.Length

	for iter_29_0 = 0, var_29_3 - 1 do
		local var_29_4 = var_29_1[iter_29_0]

		if string.sub(var_29_4, -5) == ".json" then
			local var_29_5 = string.getLastNum(var_29_4)

			table.insert(var_29_2, var_29_5)
		end
	end

	arg_29_0._loadStoryCount = #var_29_2
	arg_29_0._storyAudioIdDict = {}

	for iter_29_1, iter_29_2 in ipairs(var_29_2) do
		StoryController.instance:initStoryData(iter_29_2, function()
			arg_29_0:_loadStoryStepConfigCallback(iter_29_2)
		end)
	end
end

function var_0_0._checkAddAudioEnumCall(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs(AudioEnum) do
		if type(iter_31_1) == "table" then
			for iter_31_2, iter_31_3 in pairs(iter_31_1) do
				if type(iter_31_3) == "number" and iter_31_3 > 500000 then
					arg_31_0:_tableAddValues(var_31_0, iter_31_1, "代码调用 AudioEnum." .. iter_31_0)
				end

				break
			end
		end
	end

	for iter_31_4, iter_31_5 in pairs(var_31_0) do
		local var_31_1 = iter_31_5[1]
		local var_31_2 = iter_31_5[2]

		if not tabletool.indexOf(arg_31_0._callAudioIdList, var_31_1) and tonumber(var_31_1) then
			table.insert(arg_31_0._callAudioIdList, var_31_1)

			arg_31_0._audioId2CallExcel = arg_31_0._audioId2CallExcel or {}
			arg_31_0._audioId2CallExcel[var_31_1] = var_31_2
		end
	end
end

function var_0_0._checkAddConfigCallAudios(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1.configList) do
		if type(arg_32_2) == "string" then
			local var_32_0 = iter_32_1[arg_32_2]

			if not tabletool.indexOf(arg_32_0._callAudioIdList, var_32_0) then
				table.insert(arg_32_0._callAudioIdList, var_32_0)

				arg_32_0._audioId2CallExcel = arg_32_0._audioId2CallExcel or {}
				arg_32_0._audioId2CallExcel[var_32_0] = arg_32_3
			end
		elseif type(arg_32_2) == "table" then
			for iter_32_2, iter_32_3 in ipairs(arg_32_2) do
				local var_32_1 = iter_32_1[iter_32_3]

				if not tabletool.indexOf(arg_32_0._callAudioIdList, var_32_1) then
					table.insert(arg_32_0._callAudioIdList, var_32_1)

					arg_32_0._audioId2CallExcel = arg_32_0._audioId2CallExcel or {}
					arg_32_0._audioId2CallExcel[var_32_1] = arg_32_3
				end
			end
		end
	end
end

function var_0_0._checkTimelineCall(arg_33_0, arg_33_1)
	arg_33_0._timelineLoadedCb = arg_33_1
	arg_33_0._timelienLoader = MultiAbLoader.New()

	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(lua_skill.configList) do
		if not string.nilorempty(iter_33_1.timeline) then
			local var_33_1 = FightHelper.getRolesTimelinePath(iter_33_1.timeline)

			if not tabletool.indexOf(var_33_0, var_33_1) then
				local var_33_2 = SLFramework.FrameworkSettings.AssetRootDir .. "/" .. var_33_1

				if SLFramework.FileHelper.IsFileExists(var_33_2) then
					table.insert(var_33_0, var_33_1)
				end
			end
		end
	end

	arg_33_0._timelienLoader:setPathList(var_33_0)
	arg_33_0._timelienLoader:startLoad(arg_33_0._onLoadTimelineDone, arg_33_0)
end

function var_0_0._onLoadTimelineDone(arg_34_0)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_0._timelienLoader:getAssetItemDict()) do
		local var_34_1 = ZProj.SkillTimelineAssetHelper.GeAssetJson(iter_34_1, iter_34_0)

		if not string.nilorempty(var_34_1) then
			local var_34_2 = cjson.decode(var_34_1)

			for iter_34_2 = 1, #var_34_2, 2 do
				local var_34_3 = tonumber(var_34_2[iter_34_2])
				local var_34_4 = var_34_2[iter_34_2 + 1]

				if var_34_3 == 3 then
					local var_34_5 = tonumber(var_34_4[5])

					if var_34_5 then
						var_34_0[var_34_5] = true
						arg_34_0._audioId2CallExcel = arg_34_0._audioId2CallExcel or {}

						local var_34_6 = SLFramework.FileHelper.GetFileName(iter_34_0, false)

						arg_34_0._audioId2CallExcel[var_34_5] = "Timeline " .. var_34_6
					end
				elseif var_34_3 == 10 then
					local var_34_7 = tonumber(var_34_4[1])

					if var_34_7 then
						var_34_0[var_34_7] = true
						arg_34_0._audioId2CallExcel = arg_34_0._audioId2CallExcel or {}

						local var_34_8 = SLFramework.FileHelper.GetFileName(iter_34_0, false)

						arg_34_0._audioId2CallExcel[var_34_7] = "Timeline " .. var_34_8
					end
				end
			end
		end
	end

	for iter_34_3, iter_34_4 in pairs(var_34_0) do
		table.insert(arg_34_0._callAudioIdList, iter_34_3)
	end

	if arg_34_0._timelineLoadedCb then
		arg_34_0._timelineLoadedCb()

		arg_34_0._timelineLoadedCb = nil
	end
end

function var_0_0._beginCallAudiosLoop(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0._callAudioIdList) do
		var_35_0[iter_35_1] = true
	end

	arg_35_0._callAudioIdList = {}

	for iter_35_2, iter_35_3 in pairs(var_35_0) do
		table.insert(arg_35_0._callAudioIdList, iter_35_2)
	end

	arg_35_0._totalAudioCount = #arg_35_0._callAudioIdList

	logNormal("Total audio Id count = " .. arg_35_0._totalAudioCount)
	ZProj.AudioManager.Instance:SetErrorCallback(arg_35_0._onErrorCallback, arg_35_0)

	arg_35_0._callAudioLoopParams = {
		callAudioPerLoop = 2
	}
	arg_35_0._callAudioIdx = 1
	arg_35_0._releaseAudioThreshold = tonumber(arg_35_0._textCallAudioGCThreshold:GetText()) or 10000
	arg_35_0._releaseAudioCountNum = 0

	logNormal("Audio GC Per " .. arg_35_0._releaseAudioThreshold .. " Audio Call")
	TaskDispatcher.runRepeat(arg_35_0._callAudiosLoopAction, arg_35_0, 0.01)
end

function var_0_0._callAudiosLoopAction(arg_36_0)
	if not arg_36_0._callAudioIdList or #arg_36_0._callAudioIdList == 0 then
		arg_36_0:_endCallAudiosLoop()

		return
	end

	for iter_36_0 = 1, arg_36_0._callAudioLoopParams.callAudioPerLoop do
		local var_36_0 = arg_36_0._callAudioIdList[arg_36_0._callAudioIdx]

		arg_36_0._callAudioIdx = arg_36_0._callAudioIdx + 1

		if var_36_0 then
			local var_36_1 = arg_36_0:_triggerAndStopAudio(var_36_0)

			arg_36_0._errorAudioId = nil

			if not var_36_1 then
				arg_36_0._errorAudioId = var_36_0

				return
			end
		else
			arg_36_0:_endCallAudiosLoop()

			return
		end
	end

	arg_36_0._textCheckAudio2.text = arg_36_0._callAudioIdx .. "/" .. arg_36_0._totalAudioCount
	arg_36_0._releaseAudioCountNum = arg_36_0._releaseAudioCountNum + arg_36_0._callAudioLoopParams.callAudioPerLoop

	if arg_36_0._releaseAudioCountNum == arg_36_0._releaseAudioThreshold then
		AudioMgr.instance:clearUnusedBanks()

		arg_36_0._releaseAudioCountNum = 0

		logNormal("Call Audio Bnk GC, Cur Call Audio Count:" .. arg_36_0._callAudioIdx)
	end
end

function var_0_0._endCallAudiosLoop(arg_37_0)
	logNormal("Check Audio Done")
	GameFacade.showToast(ToastEnum.IconId, "检查完毕")
	arg_37_0:_logAudioError()
	ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_37_0._callAudiosLoopAction, arg_37_0)
	AudioMgr.instance:clearUnusedBanks()

	arg_37_0._textCheckAudio2.text = arg_37_0._checkAudioTextStr
end

function var_0_0._triggerAndStopAudio(arg_38_0, arg_38_1)
	if arg_38_1 > 0 and arg_38_0:_getAudioConfig(arg_38_1) then
		local var_38_0 = AudioMgr.instance:trigger(arg_38_1)

		if var_38_0 > 0 then
			AudioMgr.instance:stopPlayingID(var_38_0)

			return true
		end
	end
end

local var_0_1 = {
	[54] = true,
	[52] = true,
	[46] = true
}

function var_0_0._onErrorCallback(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if arg_39_0._errorAudioId then
		local var_39_0 = arg_39_0._errorAudioId

		arg_39_0._errorList = arg_39_0._errorList or {}

		table.insert(arg_39_0._errorList, {
			audioId = var_39_0,
			errorCode = arg_39_1,
			msg = arg_39_3
		})

		local var_39_1 = AudioConfig.instance:getAudioCOById(var_39_0)

		if arg_39_1 ~= 0 and not var_0_1[arg_39_1] then
			logError("error_" .. arg_39_1 .. " bank:" .. var_39_1.bankName .. " evt:" .. var_39_1.eventName .. "\n" .. arg_39_3)
		end
	end
end

function var_0_0._logAudioError(arg_40_0)
	if not arg_40_0._errorList then
		return
	end

	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0._errorList) do
		local var_40_1 = AudioConfig.instance:getAudioCOById(iter_40_1.audioId)

		if var_0_1[iter_40_1.errorCode] then
			if not var_40_0[iter_40_1.errorCode] then
				var_40_0[iter_40_1.errorCode] = {
					iter_40_1.msg
				}
			end

			local var_40_2
			local var_40_3 = arg_40_0._audioId2Excel and arg_40_0._audioId2Excel[iter_40_1.audioId]
			local var_40_4 = arg_40_0._audioId2CallExcel and arg_40_0._audioId2CallExcel[iter_40_1.audioId]

			if var_40_3 then
				if not var_40_1 then
					logError("没有找到音效配置：" .. iter_40_1.audioId)
				else
					var_40_2 = var_40_3 .. " " .. iter_40_1.audioId .. " " .. var_40_1.bankName .. " " .. var_40_1.eventName
				end
			elseif var_40_4 then
				if not var_40_1 then
					logError("没有找到音效配置：" .. iter_40_1.audioId)
				else
					var_40_2 = var_40_4 .. " " .. iter_40_1.audioId .. " " .. var_40_1.bankName .. " " .. var_40_1.eventName
				end
			elseif not var_40_1 then
				logError("没有找到音效调用源：" .. iter_40_1.audioId)
			else
				logError("没有设置源配置/调用源名称：" .. iter_40_1.audioId)
			end

			table.insert(var_40_0[iter_40_1.errorCode], var_40_2)
		end
	end

	for iter_40_2, iter_40_3 in pairs(var_40_0) do
		local var_40_5 = math.ceil(#iter_40_3 / 100)

		for iter_40_4 = 1, var_40_5 do
			local var_40_6 = (iter_40_4 - 1) * 100 + 1
			local var_40_7 = math.min(iter_40_4 * 100, #iter_40_3)

			logError("error_" .. iter_40_2 .. " count = " .. #iter_40_3 - 1 .. "\n" .. table.concat(iter_40_3, "\n", var_40_6, var_40_7))
		end
	end

	arg_40_0._audioId2Excel = nil
	arg_40_0._audioId2CallExcel = nil
	arg_40_0._errorList = nil
end

function var_0_0._tableAddValues(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	for iter_41_0, iter_41_1 in pairs(arg_41_2) do
		arg_41_1[iter_41_0] = {
			iter_41_1,
			arg_41_3
		}
	end
end

function var_0_0._onClickCheckAudioChapterAndActiviy(arg_42_0)
	arg_42_0._checkAudioTextStr = arg_42_0._textCheckAudio2.text
	arg_42_0._callAudioIdList = {}

	local var_42_0 = {}
	local var_42_1 = arg_42_0._charActCfgsToCheckAudio:GetText()
	local var_42_2 = string.split(var_42_1, "|")

	if not string.nilorempty(var_42_1) then
		for iter_42_0, iter_42_1 in ipairs(var_42_2) do
			local var_42_3 = string.split(iter_42_1, ",")
			local var_42_4 = var_42_3[1]
			local var_42_5 = var_42_3[2]
			local var_42_6 = ConfigMgr.instance._configDict[var_42_4]

			if not var_42_6 then
				logError("配置名称错误 " .. var_42_4)

				return
			end

			for iter_42_2, iter_42_3 in ipairs(var_42_6.configList) do
				if type(var_42_5) == "string" then
					local var_42_7 = iter_42_3[var_42_5]

					if type(var_42_7) == "string" then
						local var_42_8 = string.splitToNumber(var_42_7, "#")

						for iter_42_4, iter_42_5 in ipairs(var_42_8) do
							if iter_42_5 ~= 0 then
								var_42_0[#var_42_0 + 1] = iter_42_5
							end
						end
					elseif var_42_7 ~= 0 then
						var_42_0[#var_42_0 + 1] = var_42_7
					end
				elseif type(var_42_5) == "table" then
					for iter_42_6, iter_42_7 in ipairs(var_42_5) do
						local var_42_9 = iter_42_3[iter_42_7]

						if var_42_9 ~= 0 then
							var_42_0[#var_42_0 + 1] = var_42_9
						end
					end
				end
			end
		end
	end

	local var_42_10 = arg_42_0._chatperIdsToCheckAudio:GetText()

	if not string.nilorempty(var_42_10) then
		local var_42_11 = string.split(var_42_10, ",")

		for iter_42_8, iter_42_9 in ipairs(var_42_11) do
			local var_42_12 = DungeonConfig.instance:getChapterEpisodeCOList(tonumber(iter_42_9))

			if var_42_12 then
				for iter_42_10, iter_42_11 in ipairs(var_42_12) do
					if iter_42_11.beforeStory > 0 then
						var_42_0[#var_42_0 + 1] = iter_42_11.beforeStory
					end

					if iter_42_11.afterStory > 0 then
						var_42_0[#var_42_0 + 1] = iter_42_11.afterStory
					end

					if not string.nilorempty(iter_42_11.story) then
						local var_42_13 = string.split(iter_42_11.story, "|")

						for iter_42_12 = 1, #var_42_13 do
							local var_42_14 = var_42_13[iter_42_8]
							local var_42_15 = string.split(var_42_14, "#")
							local var_42_16 = var_42_15[3] and tonumber(var_42_15[3])

							if var_42_16 and var_42_16 > 0 then
								var_42_0[#var_42_0 + 1] = var_42_16
							end
						end
					end
				end
			else
				logError("未找到章节数据 " .. iter_42_9)

				return
			end
		end
	end

	arg_42_0._loadStoryCount = #var_42_0
	arg_42_0._storyAudioIdDict = {}

	for iter_42_13, iter_42_14 in ipairs(var_42_0) do
		StoryController.instance:initStoryData(iter_42_14, function()
			arg_42_0:_loadStoryStepConfigCallback(iter_42_14)
		end)
	end
end

function var_0_0._loadStoryStepConfigCallback(arg_44_0, arg_44_1)
	arg_44_0._loadStoryCount = arg_44_0._loadStoryCount - 1

	local var_44_0 = StoryStepModel.instance:getStepList()

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		local var_44_1 = iter_44_1.audioList

		for iter_44_2, iter_44_3 in ipairs(var_44_1) do
			if iter_44_3.audio > 0 then
				arg_44_0._storyAudioIdDict[iter_44_3.audio] = arg_44_1
			end
		end

		local var_44_2 = iter_44_1.conversation.audios

		for iter_44_4, iter_44_5 in ipairs(var_44_2) do
			if iter_44_5 > 0 then
				arg_44_0._storyAudioIdDict[iter_44_5] = arg_44_1
			end
		end
	end

	if arg_44_0._loadStoryCount == 0 then
		arg_44_0._audioId2CallExcel = arg_44_0._audioId2CallExcel or {}

		for iter_44_6, iter_44_7 in pairs(arg_44_0._storyAudioIdDict) do
			arg_44_0._audioId2CallExcel[iter_44_6] = "剧情" .. iter_44_7

			table.insert(arg_44_0._callAudioIdList, iter_44_6)
		end

		arg_44_0:_beginCallAudiosLoop()
	end
end

function var_0_0._callAudioInConfig(arg_45_0)
	arg_45_0._audioIdInConfigTextStr = arg_45_0._charAudioIdInConfig:GetText()
	arg_45_0._callAudioIdList = {}

	local var_45_0 = string.split(arg_45_0._audioIdInConfigTextStr, "|")

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		local var_45_1 = string.split(iter_45_1, ",")
		local var_45_2 = var_45_1[1]
		local var_45_3 = _G["lua_" .. var_45_2]

		if not var_45_3 then
			logError("配置名称错误 " .. var_45_2)

			return
		end

		table.remove(var_45_1, 1)

		local var_45_4 = var_45_1

		arg_45_0:_checkAddConfigCallAudios(var_45_3, var_45_4, var_45_2)
	end

	arg_45_0:_beginCallAudiosLoop()
end

function var_0_0._onClickCheckAudioResource(arg_46_0)
	logNormal("开始检查冗余音效资源--------------------------------")

	local var_46_0 = {}
	local var_46_1 = AudioConfig.instance:getAudioCO()

	for iter_46_0, iter_46_1 in pairs(var_46_1) do
		var_46_0[iter_46_1.eventName] = true
	end

	local var_46_2 = {}

	arg_46_0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Android", var_46_2)
	arg_46_0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/iOS", var_46_2)
	arg_46_0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Mac", var_46_2)
	arg_46_0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Windows", var_46_2)

	local var_46_3 = {}

	for iter_46_2, iter_46_3 in pairs(var_46_2) do
		if not var_46_0[iter_46_2] then
			local var_46_4 = SLFramework.FileHelper.GetFileName(iter_46_3, false)

			if not var_46_3[var_46_4] then
				var_46_3[var_46_4] = {}
			end

			local var_46_5 = var_46_3[var_46_4]

			var_46_5[#var_46_5 + 1] = iter_46_2
		end
	end

	local var_46_6 = ""
	local var_46_7 = 0

	for iter_46_4, iter_46_5 in pairs(var_46_3) do
		local var_46_8 = ""

		if #iter_46_5 > 0 then
			var_46_6 = var_46_6 .. "----------- bnk：" .. iter_46_4 .. " ------------" .. "\n"

			for iter_46_6, iter_46_7 in ipairs(iter_46_5) do
				var_46_6 = var_46_6 .. iter_46_7 .. "\n"
				var_46_7 = var_46_7 + 1
			end

			var_46_6 = var_46_6 .. "\n"
		end
	end

	if var_46_6 ~= "" then
		local var_46_9 = "AudioCheckResult.txt"
		local var_46_10 = string.format("%s/../", UnityEngine.Application.dataPath) .. var_46_9

		SLFramework.FileHelper.WriteTextToPath(var_46_10, var_46_6)

		local var_46_11 = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. var_46_9

		logNormal("共发现 " .. var_46_7 .. " 个未配置音频 Event，" .. "结果已保存至 " .. var_46_11)
	else
		logNormal("未发现冗余音频资源")
	end
end

function var_0_0._getAudioEventsInResourceDir(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = SLFramework.FileHelper.GetDirFilePaths(arg_47_1)

	for iter_47_0 = 0, var_47_0.Length - 1 do
		local var_47_1 = var_47_0[iter_47_0]

		if var_47_1:match("[.txt]$") then
			for iter_47_1 in SLFramework.FileHelper.ReadText(var_47_1):gmatch("[^\\]play_[%w_]+") do
				iter_47_1 = iter_47_1:match("^[%s]*(.-)[%s]*$")
				arg_47_2[iter_47_1] = var_47_1
			end
		end
	end
end

function var_0_0._fillAudioBnkWemFilePath(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	local var_48_0 = SLFramework.FileHelper.GetDirFilePaths(arg_48_2)

	for iter_48_0 = 0, var_48_0.Length - 1 do
		local var_48_1 = var_48_0[iter_48_0]

		if var_48_1:match("[.wem]$") then
			local var_48_2, var_48_3 = var_0_0._getFolderAndParent(var_48_1)
			local var_48_4 = SLFramework.FileHelper.GetFileName(var_48_1, true)
			local var_48_5 = SLFramework.FileHelper.GetFileName(var_48_1, false)

			if var_48_2 == arg_48_1 then
				arg_48_4[var_48_5] = var_48_4
			elseif var_48_3 == arg_48_1 then
				arg_48_4[var_48_5] = var_48_2 .. "/" .. var_48_4
			end
		elseif var_48_1:match("[.bnk]$") then
			local var_48_6, var_48_7 = var_0_0._getFolderAndParent(var_48_1)
			local var_48_8 = SLFramework.FileHelper.GetFileName(var_48_1, true)

			if var_48_6 == arg_48_1 then
				arg_48_3[var_48_8] = true
			elseif var_48_7 == arg_48_1 then
				arg_48_3[var_48_6 .. "/" .. var_48_8] = true
			end
		end
	end
end

function var_0_0._checkAudioResInSoundbanksInfoXml(arg_49_0)
	logNormal("开始检查 SoundbanksInfo 冗余音效资源--------------------------------")

	local var_49_0 = "Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml"
	local var_49_1 = {
		zh = true,
		en = true
	}
	local var_49_2 = io.open(var_49_0, "r")
	local var_49_3 = var_49_2:read("*a")

	var_49_2:close()

	local var_49_4 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(var_49_4):parse(var_49_3)

	local var_49_5 = {}
	local var_49_6 = {}
	local var_49_7 = {}

	for iter_49_0, iter_49_1 in pairs(var_49_4.root.SoundBanksInfo.SoundBanks.SoundBank) do
		local var_49_8 = iter_49_1._attr.Language
		local var_49_9 = iter_49_1.ShortName

		var_49_5[iter_49_1.Path:gsub("\\", "/")] = true

		if var_49_1[var_49_8] then
			var_49_7[var_49_9] = var_49_7[var_49_9] or {}

			local var_49_10 = var_49_7[var_49_9]

			var_49_10[#var_49_10 + 1] = var_49_8
		end
	end

	for iter_49_2, iter_49_3 in pairs(var_49_4.root.SoundBanksInfo.StreamedFiles.File) do
		local var_49_11 = iter_49_3._attr.Language

		var_49_6[iter_49_3._attr.Id] = true
	end

	local var_49_12 = {}
	local var_49_13 = {}

	arg_49_0:_fillAudioBnkWemFilePath("Android", "Assets/ZResourcesLib/audios/Android", var_49_12, var_49_13)

	for iter_49_4, iter_49_5 in pairs(var_49_5) do
		if var_49_12[iter_49_4] then
			var_49_12[iter_49_4] = nil
		end
	end

	for iter_49_6, iter_49_7 in pairs(var_49_6) do
		if var_49_13[iter_49_6] then
			var_49_13[iter_49_6] = nil
		end
	end

	local var_49_14 = {}
	local var_49_15 = {}

	for iter_49_8, iter_49_9 in pairs(var_49_12) do
		var_49_14[#var_49_14 + 1] = iter_49_8
	end

	table.sort(var_49_14, function(arg_50_0, arg_50_1)
		return arg_50_0:sub(1, 1) < arg_50_1:sub(1, 1)
	end)

	for iter_49_10, iter_49_11 in pairs(var_49_13) do
		var_49_15[#var_49_15 + 1] = iter_49_11
	end

	table.sort(var_49_15, function(arg_51_0, arg_51_1)
		return arg_51_0:sub(1, 1) < arg_51_1:sub(1, 1)
	end)

	local var_49_16 = #var_49_14 + #var_49_13

	if var_49_16 > 0 then
		local var_49_17 = "SoundbanksInfo.xml 中不存在的 Bnk：\n"

		for iter_49_12, iter_49_13 in ipairs(var_49_14) do
			var_49_17 = var_49_17 .. "\t" .. iter_49_13 .. "\n"
		end

		local var_49_18 = var_49_17 .. "SoundbanksInfo.xml 中不存在的 Wem:\n"

		for iter_49_14, iter_49_15 in pairs(var_49_13) do
			var_49_18 = var_49_18 .. "\t" .. iter_49_15 .. "\n"
		end

		local var_49_19 = "bnkCheckResult.txt"
		local var_49_20 = string.format("%s/../", UnityEngine.Application.dataPath) .. var_49_19

		SLFramework.FileHelper.WriteTextToPath(var_49_20, var_49_18)

		local var_49_21 = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. var_49_19

		logNormal("扫描 SoundbanksInfo.xml 发现 " .. var_49_16 .. " 个冗余资源，" .. "结果已保存至 " .. var_49_21)
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现冗余音频资源")
	end
end

function var_0_0._checkBnkLangInSoundbanksInfoXml(arg_52_0)
	logNormal("开始检查 Bnk 文件多语言缺失--------------------------------")

	local var_52_0 = "Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml"
	local var_52_1 = {
		zh = true,
		en = true
	}
	local var_52_2 = io.open(var_52_0, "r")
	local var_52_3 = var_52_2:read("*a")

	var_52_2:close()

	local var_52_4 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(var_52_4):parse(var_52_3)

	local var_52_5 = {}
	local var_52_6 = {}
	local var_52_7 = {}

	for iter_52_0, iter_52_1 in pairs(var_52_4.root.SoundBanksInfo.SoundBanks.SoundBank) do
		local var_52_8 = iter_52_1._attr.Language
		local var_52_9 = iter_52_1.ShortName
		local var_52_10 = iter_52_1.Path:gsub("\\", "/")

		if var_52_1[var_52_8] then
			var_52_7[var_52_9] = var_52_7[var_52_9] or {}

			local var_52_11 = var_52_7[var_52_9]

			var_52_11[#var_52_11 + 1] = var_52_8
		end
	end

	local var_52_12 = {}

	for iter_52_2, iter_52_3 in pairs(var_52_7) do
		if iter_52_3 and #iter_52_3 ~= tabletool.len(var_52_1) then
			var_52_12[#var_52_12 + 1] = var_52_12
		end
	end

	if #var_52_12 > 0 then
		local var_52_13 = ""

		for iter_52_4, iter_52_5 in ipairs(var_52_12) do
			local var_52_14 = var_52_7[iter_52_5]

			for iter_52_6, iter_52_7 in pairs(var_52_1) do
				if not tabletool.indexOf(var_52_14, iter_52_6) then
					var_52_13 = var_52_13 .. iter_52_5 .. "缺少" .. iter_52_6 .. " 内容\n"
				end
			end
		end

		local var_52_15 = "SoundbanksInfoCheckLangResult.txt"
		local var_52_16 = string.format("%s/../", UnityEngine.Application.dataPath) .. var_52_15

		SLFramework.FileHelper.WriteTextToPath(var_52_16, var_52_13)

		local var_52_17 = string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. var_52_15

		logNormal("扫描 SoundbanksInfo.xml 发现 " .. #var_52_12 .. " 个多语言版本缺失的资源，" .. "结果已保存至 " .. var_52_17)
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现多语言缺失资源")
	end
end

function var_0_0._onReleaseAudioResource(arg_53_0)
	AudioMgr.instance:clearUnusedBanks()
end

function var_0_0._getFolderAndParent(arg_54_0)
	local var_54_0 = {}

	for iter_54_0 in arg_54_0:gmatch("[^/]+") do
		table.insert(var_54_0, iter_54_0)
	end

	local var_54_1 = #var_54_0

	if var_54_1 >= 2 then
		local var_54_2 = var_54_0[var_54_1 - 1]
		local var_54_3 = var_54_0[var_54_1 - 2]

		return var_54_2, var_54_3
	elseif var_54_1 == 1 then
		return var_54_0[1], nil
	else
		return nil, nil
	end
end

return var_0_0
