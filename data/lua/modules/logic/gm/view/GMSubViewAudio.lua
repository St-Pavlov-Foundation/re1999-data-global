module("modules.logic.gm.view.GMSubViewAudio", package.seeall)

slot0 = class("GMSubViewAudio", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "音效"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	slot0.lineIndex = 1

	GMSubViewBase.initViewContent(slot0)
	slot0:addTitleSplitLine("音频播放")
	slot0:addLabel(slot0:getLineGroup(), "音效")

	slot0._inpAudio = slot0:addInputText("L1", "", "音效配置Id")

	slot0:addButton(slot0:getLineGroup(), "播放", slot0._onClickAudioPlay, slot0)
	slot0:addButton(slot0:getLineGroup(), "停止", slot0._onClickAudioStop, slot0)

	slot0._autoStopToggle = slot0:addToggle(slot0:getLineGroup(), "播放音效自动关闭上次音效", slot0._onAutoStopChange, slot0, {
		fsize = 24
	})
	slot0._showLogToggle = slot0:addToggle(slot0:getLineGroup(), "打开日志", slot0._onShowLogChange, slot0)

	slot0:addLineIndex()

	slot0._inpEvent = slot0:addInputText(slot0:getLineGroup(), "", "事件名称")
	slot0._inpBank = slot0:addInputText(slot0:getLineGroup(), "", "bank名称")

	slot0:addButton(slot0:getLineGroup(), "播放", slot0._onClickEventPlay, slot0)
	slot0:addButton(slot0:getLineGroup(), "停止", slot0._onClickEventStop, slot0)

	slot0._langDrop = slot0:addDropDown(slot0:getLineGroup(), "语言", nil, slot0._onLangDropChange, slot0)

	slot0:addLineIndex()

	slot0._inpRtpcName = slot0:addInputText(slot0:getLineGroup(), "", "RTPC名称", nil, , {
		w = 230
	})
	slot0._inpRtpcValue = slot0:addInputText(slot0:getLineGroup(), "", "RTPC值", nil, , {
		w = 200
	})

	slot0:addButton(slot0:getLineGroup(), "设置", slot0._onClickSetRtpc, slot0)

	slot0._inpSwitchName = slot0:addInputText(slot0:getLineGroup(), "", "Switch Group")
	slot0._inpSwitchValue = slot0:addInputText(slot0:getLineGroup(), "", "Switch Value")

	slot0:addButton(slot0:getLineGroup(), "设置", slot0._onClickSwitch, slot0)
	slot0:addTitleSplitLine("音频资源检查")
	slot0:addLineIndex()

	slot0._textCheckAudio2 = slot0:addButton(slot0:getLineGroup(), "检查音效调用", slot0._onClickCheckAudioCall, slot0)[2]

	slot0:addLabel(slot0:getLineGroup(), "调用音频数量/GC:", {
		fsize = 30
	})

	slot0._textCallAudioGCThreshold = slot0:addInputText(slot0:getLineGroup(), "10000")

	slot0:addButton(slot0:getLineGroup(), "检查音效调用(仅章节,活动部分)", slot0._onClickCheckAudioChapterAndActiviy, slot0, {
		fsize = 32
	})
	slot0:addLineIndex()
	slot0:addLabel(slot0:getLineGroup(), "章节ID:\n[逗号分隔]", {
		w = 100,
		h = 200,
		fsize = 36
	})

	slot0._chatperIdsToCheckAudio = slot0:addInputText(slot0:getLineGroup(), PlayerPrefsHelper.getString("checkAudioChatperIdsKey", ""), "", slot0._onChatperIdsChange, slot0, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	slot0:addLabel(slot0:getLineGroup(), "角色活动:", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	slot0._charActCfgsToCheckAudio = slot0:addInputText(slot0:getLineGroup(), PlayerPrefsHelper.getString("checkAudioCharActCfgsKey", ""), "", slot0._onCharActCfgsChange, slot0, {
		w = 500,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})

	slot0:addLineIndex()
	slot0:addLabel(slot0:getLineGroup(), "音频Id调用:\n[表,字段1,字段2|表，字段]", {
		fsize = 30,
		align = TMPro.TextAlignmentOptions.TopLeft
	})

	slot0._charAudioIdInConfig = slot0:addInputText(slot0:getLineGroup(), PlayerPrefsHelper.getString("checkAudioIdInConfigKey", ""), "", slot0._CallAudioInConfig, slot0, {
		w = 600,
		h = 200,
		align = UnityEngine.TextAnchor.UpperLeft
	})
	slot0._textCheckAudioIdInConfig = slot0:addButton(slot0:getLineGroup(), "调用配置音效", slot0._callAudioInConfig, slot0)[2]

	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "检查音效配置项", slot0._onClickCheckAudio1, slot0)
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "检查冗余音效", slot0._onClickCheckAudioResource, slot0)
	slot0:addLabel(slot0:getLineGroup(), "（检查不在音效表和代码中的音效）", {
		fsize = 30
	})
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "检查Bnk文件冗余", slot0._checkAudioResInSoundbanksInfoXml, slot0)
	slot0:addButton(slot0:getLineGroup(), "检查Bnk多语言缺失", slot0._checkBnkLangInSoundbanksInfoXml, slot0)
	slot0:addLabel(slot0:getLineGroup(), "(扫描本地文件和Soundbanksinfo中音频文件资源)", {
		fsize = 26
	})
	slot0:addLineIndex()

	slot8 = slot0

	slot0:addButton(slot0:getLineGroup(), "释放音效Bnk", slot0._onReleaseAudioResource, slot8)

	slot0.autoStopPrePlayingId = true
	slot0.prePlayingId = 0
	slot0.curLang = GameConfig:GetCurVoiceShortcut()
	slot0._autoStopToggle.isOn = slot0.autoStopPrePlayingId
	slot0._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	slot0.langList = {}
	slot4 = 0

	for slot8 = 0, GameConfig:GetSupportedVoiceShortcuts().Length - 1 do
		slot9 = slot2[slot8]

		table.insert(slot0.langList, slot9)

		if slot9 == slot0.curLang then
			slot4 = slot8
		end
	end

	slot0._langDrop:ClearOptions()
	slot0._langDrop:AddOptions(slot0.langList)
	slot0._langDrop:SetValue(slot4)

	slot0._inited = true
end

function slot0._onClickAudioPlay(slot0)
	if not string.nilorempty(slot0._inpAudio:GetText()) and tonumber(slot1) then
		if slot0.autoStopPrePlayingId then
			slot0:stopPlayingID()
		end

		slot0.prePlayingId = AudioMgr.instance:trigger(slot2)
	end
end

function slot0._getVoiceEmitter(slot0)
	if not slot0._emitter then
		slot0._emitter = ZProj.AudioEmitter.Get(slot0.viewGO)
	end

	return slot0._emitter
end

function slot0._onClickAudioStop(slot0)
	slot0:stopPlayingID()
end

function slot0.stopPlayingID(slot0)
	AudioMgr.instance:stopPlayingID(slot0.prePlayingId)
end

function slot0._onAutoStopChange(slot0, slot1, slot2)
	slot0.autoStopPrePlayingId = slot2
end

function slot0._onShowLogChange(slot0, slot1, slot2)
	if GMController.instance:getShowAudioLog() == slot2 then
		return
	end

	AudioMgr.GMOpenLog = slot2
	ZProj.AudioManager.Instance.gmOpenLog = slot2

	GMController.instance:setShowAudioLog(slot2)
end

function slot0._onClickEventPlay(slot0)
	slot2 = slot0._inpBank:GetText()

	if string.nilorempty(slot0._inpEvent:GetText()) then
		return
	end

	if string.nilorempty(slot2) then
		return
	end

	slot0:initAudioEditorTool()

	if slot0.autoStopPrePlayingId then
		slot0:stopPlayingID()
	end

	slot0.prePlayingId = slot0.audioTool:PlayEvent(slot1, slot2)
end

function slot0._onClickEventStop(slot0)
	slot0:stopPlayingID()
end

function slot0.initAudioEditorTool(slot0)
	if not slot0.audioTool then
		slot0.audioTool = ZProj.AudioEditorTool.Instance
	end
end

function slot0._onLangDropChange(slot0, slot1)
	if slot0.langList[slot1 + 1] == slot0.curLang then
		return
	end

	slot0.curLang = slot2

	slot0:stopPlayingID()
	slot0:initAudioEditorTool()
	slot0.audioTool:SetLanguage(slot0.curLang)
end

function slot0._onClickSetRtpc(slot0)
	slot2 = slot0._inpRtpcValue:GetText()

	if string.nilorempty(slot0._inpRtpcName:GetText()) then
		return
	end

	if string.nilorempty(slot2) then
		return
	end

	if not tonumber(slot2) then
		return
	end

	slot0:initAudioEditorTool()
	slot0.audioTool:SetRtpc(slot1, slot2)
end

function slot0._onClickSwitch(slot0)
	slot2 = slot0._inpSwitchValue:GetText()

	if string.nilorempty(slot0._inpSwitchName:GetText()) then
		return
	end

	if string.nilorempty(slot2) then
		return
	end

	slot0:initAudioEditorTool()
	slot0.audioTool:SetSwitch(slot1, slot2)
end

function slot0._onChatperIdsChange(slot0, slot1)
	PlayerPrefsHelper.setString("checkAudioChatperIdsKey", slot1)
end

function slot0._onCharActCfgsChange(slot0, slot1)
	PlayerPrefsHelper.setString("checkAudioCharActCfgsKey", slot1)
end

function slot0._onCharAudioIdInConfigKeyChange(slot0, slot1)
	PlayerPrefsHelper.setString("checkAudioIdInConfigKey", slot1)
end

function slot0._onClickCheckAudio1(slot0)
	logNormal("检查音效配置项--------------------------------")

	slot0._audioConfigs = {}

	slot0:_checkAudioConfigs(lua_role_audio, "Y音效表.xlsx export_角色语音")
	slot0:_checkAudioConfigs(lua_ui_audio, "Y音效表-UI音效表.xlsx export_UI音效")
	slot0:_checkAudioConfigs(lua_bg_audio, "Y音效表-战斗&场景音效表.xlsx export_背景音乐")
	slot0:_checkAudioConfigs(lua_fight_audio, "Y音效表-战斗&场景音效表.xlsx export_战斗音效")
	slot0:_checkAudioConfigs(lua_story_audio, "Y音效表.xlsx export_剧情音效")
	slot0:_checkAudioConfigs(lua_story_audio_main, "Y剧情配音2.0.xlsx export_主线剧情配音")
	slot0:_checkAudioConfigs(lua_story_audio_branch, "Y剧情配音2.0.xlsx export_支线剧情配音")
	slot0:_checkAudioConfigs(lua_story_audio_system, "Y剧情配音2.0.xlsx export_系统剧情配音")
	slot0:_checkAudioConfigs(lua_story_audio_role, "Y剧情配音2.0.xlsx export_角色语音")
	slot0:_checkAudioConfigs(lua_story_audio_effect, "Y剧情配音2.0.xlsx export_剧情音效")
	slot0:_checkAudioConfigs(lua_story_audio_short, "Y剧情配音2.0.xlsx export_短语音")
	slot0:_checkAudioConfigs(lua_story_role_audio, "Y音效表.xlsx export_剧情配音")
	slot0:_checkAudioConfigs(lua_effect_audio, "Y音效表-战斗&场景音效表.xlsx export_特效音效")
	slot0:_checkLowerName(slot0._audioConfigs)
	logNormal("count = " .. #slot0._audioConfigs)
	ZProj.AudioManager.Instance:SetErrorCallback(slot0._onErrorCallback, slot0)
	TaskDispatcher.runRepeat(slot0._checkPlayConfigAudio, slot0, 0.1)
end

function slot0._checkAudioConfigs(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1.configList) do
		if slot7.id and slot7.id > 0 and not tabletool.indexOf(slot0._audioConfigs, slot7.id) then
			table.insert(slot0._audioConfigs, slot7.id)

			slot0._audioId2Excel = slot0._audioId2Excel or {}
			slot0._audioId2Excel[slot7.id] = slot2
		end
	end
end

function slot0._checkLowerName(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = AudioConfig.instance:getAudioCOById(slot8)

		if string.lower(slot9.bankName) ~= slot9.bankName and not slot3[slot9.bankName] then
			slot3[slot9.bankName] = true

			table.insert(slot2, "bank: " .. slot9.bankName)
		end

		if string.lower(slot9.eventName) ~= slot9.eventName then
			table.insert(slot2, "event: " .. slot9.eventName)
		end
	end

	if #slot2 > 0 then
		logError("大小写问题：\n" .. table.concat(slot2, "\n"))
	end
end

function slot0._checkPlayConfigAudio(slot0)
	if slot0._audioConfigs and #slot0._audioConfigs > 0 then
		for slot5 = 1, 1000 do
			if table.remove(slot0._audioConfigs, #slot0._audioConfigs) then
				if #slot0._audioConfigs % 100 == 0 and not false then
					GameFacade.showToast(ToastEnum.IconId, "剩余" .. #slot0._audioConfigs)

					slot1 = true
				end

				if not slot0:_triggerAudio(slot6) then
					slot0._errorAudioId = slot6

					return
				end
			else
				GameFacade.showToast(ToastEnum.IconId, "检查完毕")
				slot0:_logAudioError()
				ZProj.AudioManager.Instance:SetErrorCallback(nil, )
				TaskDispatcher.cancelTask(slot0._checkPlayConfigAudio, slot0)

				break
			end
		end
	end
end

function slot0._triggerAudio(slot0, slot1)
	if slot1 > 0 and slot0:_getAudioConfig(slot1) and AudioMgr.instance:trigger(slot1) > 0 then
		AudioMgr.instance:stopPlayingID(slot2)

		return true
	end
end

function slot0._getAudioConfig(slot0, slot1)
	return AudioConfig.instance:getAudioCOById(slot1)
end

function slot0._onClickCheckAudioCall(slot0)
	slot0:_CheckAudioCall()
end

function slot0._CheckAudioCall(slot0)
	slot0._checkAudioTextStr = slot0._textCheckAudio2.text

	logNormal("检查音效调用--------------------------------")

	slot0._callAudioIdList = {}

	slot0:_checkAddConfigCallAudios(lua_character_voice, "audio", "J角色语音表.xlsx export_角色语音")
	slot0:_checkAddConfigCallAudios(lua_effect_with_audio, "audioId", "T特效音效表.xlsx export_特效音效")
	slot0:_checkAddConfigCallAudios(lua_fight_voice, {
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
	slot0:_checkAddConfigCallAudios(lua_guide_step, "audio", "Z指引表.xlsx export_指引步骤")
	slot0:_checkAddConfigCallAudios(lua_skill_behavior, "audioId", "J技能表.xlsx export_技能效果")
	slot0:_checkAddConfigCallAudios(lua_skill_buff, {
		"audio",
		"triggerAudio",
		"delAudio"
	}, "J技能表.xlsx export_buff")
	slot0:_checkAddConfigCallAudios(lua_buff_act, "audioId", "J技能表.xlsx export_基础buff效果")
	slot0:_checkAddConfigCallAudios(lua_skin_spine_action, "audioId", "P皮肤表.xlsx export_战斗动作表现")
	slot0:_checkAddConfigCallAudios(lua_chapter_map_element_dialog, "audio", "F副本表.xlsx export_元件对话")
	slot0:_checkAddConfigCallAudios(lua_battle_dialog, "audioId", "Z战斗喊话表.xlsx export_战斗喊话")
	slot0:_checkAddConfigCallAudios(lua_fight_debut_show, "audioId", "Z战斗补丁-出场表现表.xlsx export_出场表现")
	slot0:_checkAddConfigCallAudios(lua_fight_summon_show, "audioId", "Z战斗补丁-召唤表现表.xlsx export_召唤表现")
	slot0:_checkAddConfigCallAudios(lua_guide_step_addition, "audio", "Z指引表.xlsx export_附加步骤")
	slot0:_checkAddConfigCallAudios(lua_production_part, "audio", "X小屋.xlsx export_枢纽部件")
	slot0:_checkAddConfigCallAudios(lua_room_audio_extend, "audioId", "X小屋地块包表.xlsx export_音效拓展")
	slot0:_checkAddConfigCallAudios(lua_character_shop_voice, "audio", "J角色语音表.xlsx export_商店语音表")
	slot0:_checkAddConfigCallAudios(lua_explore_dialogue, "audio", "M密室探索表.xlsx export_对话")
	slot0:_checkAddConfigCallAudios(lua_explore_hero_effect, "audioId", "M密室探索表.xlsx export_角色特效")
	slot0:_checkAddConfigCallAudios(lua_explore_item, "audioId", "M密室探索表.xlsx export_物品")
	slot0:_checkAddConfigCallAudios(lua_explore_unit_effect, "audioId", "M密室探索表.xlsx export_元件特效")
	slot0:_checkAddConfigCallAudios(lua_toast, "audioId", "P飘字表.xlsx export_飘字表")
	slot0:_checkAddConfigCallAudios(lua_character_limited, {
		"audio",
		"stopAudio"
	}, "J角色限定表现.xlsx export_限定角色表现")
	slot0:_checkAddConfigCallAudios(lua_chapter_map, "effectAudio", "F副本表.xlsx export_主线地图")
	slot0:_checkAddConfigCallAudios(lua_bgm_switch, "audio", "B背景音效切换.xlsx export_背景音效切换")
	slot0:_checkAddConfigCallAudios(lua_fairyland_puzzle_talk, "audioId", "H幻境.xlsx export_幻境对话")
	slot0:_checkAddConfigCallAudios(lua_fight_buff_layer_effect, {
		"loopEffectAudio",
		"createAudio",
		"destroyEffectAudio"
	}, "Z战斗配置-buff层数特效.xlsx export_buff层数特效")
	slot0:_checkAddConfigCallAudios(lua_fight_effect_buff_skin, "audio", "Z战斗补丁-被动特效对应皮肤表.xlsx export_释放技能后延迟")
	slot0:_checkAddConfigCallAudios(lua_magic_circle, {
		"enterAudio",
		"closeAudio"
	}, "S术阵表.xlsx export_法阵")
	slot0:_checkAddConfigCallAudios(lua_room_building, "placeAudio", "X小屋地块包表.xlsx export_建筑")
	slot0:_checkAddConfigCallAudios(lua_room_character_interaction, "buildingAudio", "X小屋角色表.xlsx export_角色交互")
	slot0:_checkAddConfigCallAudios(lua_room_effect, "audioId", "X小屋.xlsx export_特效配置")
	slot0:_checkAddConfigCallAudios(lua_room_vehicle, {
		"audioTurn",
		"audioTurnAround",
		"audioCrossload",
		"audioWalk",
		"audioStop"
	}, "X小屋地块包表.xlsx export_交通工具")
	slot0:_checkAddConfigCallAudios(lua_rouge_short_voice, "audioId", "R肉鸽地图表.xlsx export_短语音表")
	slot0:_checkAddConfigCallAudios(lua_summoned, {
		"enterAudio",
		"closeAudio"
	}, "Z召唤物挂件表.xlsx export_召唤物挂件")
	slot0:_checkAddAudioEnumCall()
	slot0:_checkTimelineCall(function ()
		uv0:_checkStoryCall()
	end)
end

function slot0._checkStoryCall(slot0)
	if not SLFramework.FrameworkSettings.IsEditor then
		slot0._storyLoaded = true

		return
	end

	slot3 = {}

	for slot8 = 0, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/story/steps/").Length - 1 do
		if string.sub(slot2[slot8], -5) == ".json" then
			table.insert(slot3, string.getLastNum(slot9))
		end
	end

	slot0._loadStoryCount = #slot3
	slot0._storyAudioIdDict = {}

	for slot8, slot9 in ipairs(slot3) do
		StoryController.instance:initStoryData(slot9, function ()
			uv0:_loadStoryStepConfigCallback(uv1)
		end)
	end
end

function slot0._checkAddAudioEnumCall(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(AudioEnum) do
		if type(slot6) == "table" then
			for slot10, slot11 in pairs(slot6) do
				if type(slot11) == "number" and slot11 > 500000 then
					slot0:_tableAddValues(slot1, slot6, "代码调用 AudioEnum." .. slot5)
				end

				break
			end
		end
	end

	for slot5, slot6 in pairs(slot1) do
		if not tabletool.indexOf(slot0._callAudioIdList, slot6[1]) and tonumber(slot7) then
			table.insert(slot0._callAudioIdList, slot7)

			slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}
			slot0._audioId2CallExcel[slot7] = slot6[2]
		end
	end
end

function slot0._checkAddConfigCallAudios(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1.configList) do
		if type(slot2) == "string" then
			if not tabletool.indexOf(slot0._callAudioIdList, slot8[slot2]) then
				table.insert(slot0._callAudioIdList, slot9)

				slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}
				slot0._audioId2CallExcel[slot9] = slot3
			end
		elseif type(slot2) == "table" then
			for slot12, slot13 in ipairs(slot2) do
				if not tabletool.indexOf(slot0._callAudioIdList, slot8[slot13]) then
					table.insert(slot0._callAudioIdList, slot14)

					slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}
					slot0._audioId2CallExcel[slot14] = slot3
				end
			end
		end
	end
end

function slot0._checkTimelineCall(slot0, slot1)
	slot0._timelineLoadedCb = slot1
	slot0._timelienLoader = MultiAbLoader.New()
	slot2 = {}

	for slot6, slot7 in ipairs(lua_skill.configList) do
		if not string.nilorempty(slot7.timeline) and not tabletool.indexOf(slot2, FightHelper.getRolesTimelinePath(slot7.timeline)) and SLFramework.FileHelper.IsFileExists(SLFramework.FrameworkSettings.AssetRootDir .. "/" .. slot8) then
			table.insert(slot2, slot8)
		end
	end

	slot0._timelienLoader:setPathList(slot2)
	slot0._timelienLoader:startLoad(slot0._onLoadTimelineDone, slot0)
end

function slot0._onLoadTimelineDone(slot0)
	slot1 = {}
	slot4 = slot0._timelienLoader
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.getAssetItemDict(slot6)) do
		if not string.nilorempty(ZProj.SkillTimelineAssetHelper.GeAssetJson(slot6, slot5)) then
			for slot12 = 1, #cjson.decode(slot7), 2 do
				if tonumber(slot8[slot12]) == 3 then
					if tonumber(slot8[slot12 + 1][5]) then
						slot1[slot15] = true
						slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}
						slot0._audioId2CallExcel[slot15] = "Timeline " .. SLFramework.FileHelper.GetFileName(slot5, false)
					end
				elseif slot13 == 10 and tonumber(slot14[1]) then
					slot1[slot15] = true
					slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}
					slot0._audioId2CallExcel[slot15] = "Timeline " .. SLFramework.FileHelper.GetFileName(slot5, false)
				end
			end
		end
	end

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0._callAudioIdList, slot5)
	end

	if slot0._timelineLoadedCb then
		slot0._timelineLoadedCb()

		slot0._timelineLoadedCb = nil
	end
end

function slot0._beginCallAudiosLoop(slot0)
	for slot5, slot6 in ipairs(slot0._callAudioIdList) do
		-- Nothing
	end

	slot0._callAudioIdList = {}

	for slot5, slot6 in pairs({
		[slot6] = true
	}) do
		table.insert(slot0._callAudioIdList, slot5)
	end

	slot0._totalAudioCount = #slot0._callAudioIdList

	logNormal("Total audio Id count = " .. slot0._totalAudioCount)
	ZProj.AudioManager.Instance:SetErrorCallback(slot0._onErrorCallback, slot0)

	slot0._callAudioLoopParams = {
		callAudioPerLoop = 2
	}
	slot0._callAudioIdx = 1
	slot0._releaseAudioThreshold = tonumber(slot0._textCallAudioGCThreshold:GetText()) or 10000
	slot0._releaseAudioCountNum = 0

	logNormal("Audio GC Per " .. slot0._releaseAudioThreshold .. " Audio Call")
	TaskDispatcher.runRepeat(slot0._callAudiosLoopAction, slot0, 0.01)
end

function slot0._callAudiosLoopAction(slot0)
	if not slot0._callAudioIdList or #slot0._callAudioIdList == 0 then
		slot0:_endCallAudiosLoop()

		return
	end

	for slot4 = 1, slot0._callAudioLoopParams.callAudioPerLoop do
		slot0._callAudioIdx = slot0._callAudioIdx + 1

		if slot0._callAudioIdList[slot0._callAudioIdx] then
			slot0._errorAudioId = nil

			if not slot0:_triggerAndStopAudio(slot5) then
				slot0._errorAudioId = slot5

				return
			end
		else
			slot0:_endCallAudiosLoop()

			return
		end
	end

	slot0._textCheckAudio2.text = slot0._callAudioIdx .. "/" .. slot0._totalAudioCount
	slot0._releaseAudioCountNum = slot0._releaseAudioCountNum + slot0._callAudioLoopParams.callAudioPerLoop

	if slot0._releaseAudioCountNum == slot0._releaseAudioThreshold then
		AudioMgr.instance:clearUnusedBanks()

		slot0._releaseAudioCountNum = 0

		logNormal("Call Audio Bnk GC, Cur Call Audio Count:" .. slot0._callAudioIdx)
	end
end

function slot0._endCallAudiosLoop(slot0)
	logNormal("Check Audio Done")
	GameFacade.showToast(ToastEnum.IconId, "检查完毕")
	slot0:_logAudioError()
	ZProj.AudioManager.Instance:SetErrorCallback(nil, )
	TaskDispatcher.cancelTask(slot0._callAudiosLoopAction, slot0)
	AudioMgr.instance:clearUnusedBanks()

	slot0._textCheckAudio2.text = slot0._checkAudioTextStr
end

function slot0._triggerAndStopAudio(slot0, slot1)
	if slot1 > 0 and slot0:_getAudioConfig(slot1) and AudioMgr.instance:trigger(slot1) > 0 then
		AudioMgr.instance:stopPlayingID(slot2)

		return true
	end
end

slot1 = {
	[54.0] = true,
	[52.0] = true,
	[46.0] = true
}

function slot0._onErrorCallback(slot0, slot1, slot2, slot3)
	if slot0._errorAudioId then
		slot4 = slot0._errorAudioId
		slot0._errorList = slot0._errorList or {}

		table.insert(slot0._errorList, {
			audioId = slot4,
			errorCode = slot1,
			msg = slot3
		})

		slot5 = AudioConfig.instance:getAudioCOById(slot4)

		if slot1 ~= 0 and not uv0[slot1] then
			logError("error_" .. slot1 .. " bank:" .. slot5.bankName .. " evt:" .. slot5.eventName .. "\n" .. slot3)
		end
	end
end

function slot0._logAudioError(slot0)
	if not slot0._errorList then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0._errorList) do
		slot7 = AudioConfig.instance:getAudioCOById(slot6.audioId)

		if uv0[slot6.errorCode] then
			if not slot1[slot6.errorCode] then
				slot1[slot6.errorCode] = {
					slot6.msg
				}
			end

			slot8 = nil
			slot10 = slot0._audioId2CallExcel and slot0._audioId2CallExcel[slot6.audioId]

			if slot0._audioId2Excel and slot0._audioId2Excel[slot6.audioId] then
				if not slot7 then
					logError("没有找到音效配置：" .. slot6.audioId)
				else
					slot8 = slot9 .. " " .. slot6.audioId .. " " .. slot7.bankName .. " " .. slot7.eventName
				end
			elseif slot10 then
				if not slot7 then
					logError("没有找到音效配置：" .. slot6.audioId)
				else
					slot8 = slot10 .. " " .. slot6.audioId .. " " .. slot7.bankName .. " " .. slot7.eventName
				end
			elseif not slot7 then
				logError("没有找到音效调用源：" .. slot6.audioId)
			else
				logError("没有设置源配置/调用源名称：" .. slot6.audioId)
			end

			table.insert(slot1[slot6.errorCode], slot8)
		end
	end

	for slot5, slot6 in pairs(slot1) do
		for slot11 = 1, math.ceil(#slot6 / 100) do
			logError("error_" .. slot5 .. " count = " .. #slot6 - 1 .. "\n" .. table.concat(slot6, "\n", (slot11 - 1) * 100 + 1, math.min(slot11 * 100, #slot6)))
		end
	end

	slot0._audioId2Excel = nil
	slot0._audioId2CallExcel = nil
	slot0._errorList = nil
end

function slot0._tableAddValues(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot2) do
		slot1[slot7] = {
			slot8,
			slot3
		}
	end
end

function slot0._onClickCheckAudioChapterAndActiviy(slot0)
	slot0._checkAudioTextStr = slot0._textCheckAudio2.text
	slot0._callAudioIdList = {}
	slot1 = {}
	slot2 = slot0._charActCfgsToCheckAudio:GetText()
	slot3 = string.split(slot2, "|")

	if not string.nilorempty(slot2) then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = string.split(slot8, ",")
			slot11 = slot9[2]

			if not ConfigMgr.instance._configDict[slot9[1]] then
				logError("配置名称错误 " .. slot10)

				return
			end

			for slot16, slot17 in ipairs(slot12.configList) do
				if type(slot11) == "string" then
					if type(slot17[slot11]) == "string" then
						for slot23, slot24 in ipairs(string.splitToNumber(slot18, "#")) do
							if slot24 ~= 0 then
								slot1[#slot1 + 1] = slot24
							end
						end
					elseif slot18 ~= 0 then
						slot1[#slot1 + 1] = slot18
					end
				elseif type(slot11) == "table" then
					for slot21, slot22 in ipairs(slot11) do
						if slot17[slot22] ~= 0 then
							slot1[#slot1 + 1] = slot23
						end
					end
				end
			end
		end
	end

	if not string.nilorempty(slot0._chatperIdsToCheckAudio:GetText()) then
		for slot9, slot10 in ipairs(string.split(slot4, ",")) do
			if DungeonConfig.instance:getChapterEpisodeCOList(tonumber(slot10)) then
				for slot15, slot16 in ipairs(slot11) do
					if slot16.beforeStory > 0 then
						slot1[#slot1 + 1] = slot16.beforeStory
					end

					if slot16.afterStory > 0 then
						slot1[#slot1 + 1] = slot16.afterStory
					end

					if not string.nilorempty(slot16.story) then
						for slot21 = 1, #string.split(slot16.story, "|") do
							if string.split(slot17[slot9], "#")[3] and tonumber(slot22[3]) and slot23 > 0 then
								slot1[#slot1 + 1] = slot23
							end
						end
					end
				end
			else
				logError("未找到章节数据 " .. slot10)

				return
			end
		end
	end

	slot0._loadStoryCount = #slot1
	slot0._storyAudioIdDict = {}

	for slot8, slot9 in ipairs(slot1) do
		StoryController.instance:initStoryData(slot9, function ()
			uv0:_loadStoryStepConfigCallback(uv1)
		end)
	end
end

function slot0._loadStoryStepConfigCallback(slot0, slot1)
	slot0._loadStoryCount = slot0._loadStoryCount - 1

	for slot6, slot7 in ipairs(StoryStepModel.instance:getStepList()) do
		for slot12, slot13 in ipairs(slot7.audioList) do
			if slot13.audio > 0 then
				slot0._storyAudioIdDict[slot13.audio] = slot1
			end
		end

		for slot14, slot15 in ipairs(slot7.conversation.audios) do
			if slot15 > 0 then
				slot0._storyAudioIdDict[slot15] = slot1
			end
		end
	end

	if slot0._loadStoryCount == 0 then
		slot0._audioId2CallExcel = slot0._audioId2CallExcel or {}

		for slot6, slot7 in pairs(slot0._storyAudioIdDict) do
			slot0._audioId2CallExcel[slot6] = "剧情" .. slot7

			table.insert(slot0._callAudioIdList, slot6)
		end

		slot0:_beginCallAudiosLoop()
	end
end

function slot0._callAudioInConfig(slot0)
	slot0._audioIdInConfigTextStr = slot0._charAudioIdInConfig:GetText()
	slot0._callAudioIdList = {}

	for slot5, slot6 in ipairs(string.split(slot0._audioIdInConfigTextStr, "|")) do
		if not _G["lua_" .. string.split(slot6, ",")[1]] then
			logError("配置名称错误 " .. slot8)

			return
		end

		table.remove(slot7, 1)
		slot0:_checkAddConfigCallAudios(slot9, slot7, slot8)
	end

	slot0:_beginCallAudiosLoop()
end

function slot0._onClickCheckAudioResource(slot0)
	logNormal("开始检查冗余音效资源--------------------------------")

	slot1 = {
		[slot7.eventName] = true
	}

	for slot6, slot7 in pairs(AudioConfig.instance:getAudioCO()) do
		-- Nothing
	end

	slot3 = {}

	slot0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Android", slot3)
	slot0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/iOS", slot3)
	slot0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Mac", slot3)

	slot8 = slot3

	slot0:_getAudioEventsInResourceDir("Assets/ZResourcesLib/audios/Windows", slot8)

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		if not slot1[slot8] then
			if not slot4[SLFramework.FileHelper.GetFileName(slot9, false)] then
				slot4[slot10] = {}
			end

			slot11 = slot4[slot10]
			slot11[#slot11 + 1] = slot8
		end
	end

	slot6 = 0

	for slot10, slot11 in pairs(slot4) do
		slot12 = ""

		if #slot11 > 0 then
			slot16 = " ------------"
			slot17 = "\n"

			for slot16, slot17 in ipairs(slot11) do
				slot5 = "" .. "----------- bnk：" .. slot10 .. slot16 .. slot17 .. slot17 .. "\n"
				slot6 = slot6 + 1
			end

			slot5 = slot5 .. "\n"
		end
	end

	if slot5 ~= "" then
		slot7 = "AudioCheckResult.txt"

		SLFramework.FileHelper.WriteTextToPath(string.format("%s/../", UnityEngine.Application.dataPath) .. slot7, slot5)
		logNormal("共发现 " .. slot6 .. " 个未配置音频 Event，" .. "结果已保存至 " .. (string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. slot7))
	else
		logNormal("未发现冗余音频资源")
	end
end

function slot0._getAudioEventsInResourceDir(slot0, slot1, slot2)
	for slot7 = 0, SLFramework.FileHelper.GetDirFilePaths(slot1).Length - 1 do
		if slot3[slot7]:match("[.txt]$") then
			slot13 = "[^\\]play_[%w_]+"

			for slot13 in SLFramework.FileHelper.ReadText(slot8):gmatch(slot13) do
				slot2[slot13:match("^[%s]*(.-)[%s]*$")] = slot8
			end
		end
	end
end

function slot0._fillAudioBnkWemFilePath(slot0, slot1, slot2, slot3, slot4)
	for slot9 = 0, SLFramework.FileHelper.GetDirFilePaths(slot2).Length - 1 do
		if slot5[slot9]:match("[.wem]$") then
			slot11, slot12 = uv0._getFolderAndParent(slot10)

			if slot11 == slot1 then
				slot4[SLFramework.FileHelper.GetFileName(slot10, false)] = SLFramework.FileHelper.GetFileName(slot10, true)
			elseif slot12 == slot1 then
				slot4[slot14] = slot11 .. "/" .. slot13
			end
		elseif slot10:match("[.bnk]$") then
			slot11, slot12 = uv0._getFolderAndParent(slot10)

			if slot11 == slot1 then
				slot3[SLFramework.FileHelper.GetFileName(slot10, true)] = true
			elseif slot12 == slot1 then
				slot3[slot11 .. "/" .. slot13] = true
			end
		end
	end
end

function slot0._checkAudioResInSoundbanksInfoXml(slot0)
	logNormal("开始检查 SoundbanksInfo 冗余音效资源--------------------------------")

	slot3 = io.open("Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml", "r")

	slot3:close()

	slot5 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(slot5):parse(slot3:read("*a"))

	slot7 = {
		[slot14.Path:gsub("\\", "/")] = true
	}
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in pairs(slot5.root.SoundBanksInfo.SoundBanks.SoundBank) do
		slot16 = slot14.ShortName

		if ({
			zh = true,
			en = true
		})[slot14._attr.Language] then
			slot9[slot16] = slot9[slot16] or {}
			slot18 = slot9[slot16]
			slot18[#slot18 + 1] = slot15
		end
	end

	for slot13, slot14 in pairs(slot5.root.SoundBanksInfo.StreamedFiles.File) do
		slot15 = slot14._attr.Language
		slot8[slot14._attr.Id] = true
	end

	slot15 = "Android"
	slot16 = "Assets/ZResourcesLib/audios/Android"

	slot0:_fillAudioBnkWemFilePath(slot15, slot16, {}, {})

	for slot15, slot16 in pairs(slot7) do
		if slot10[slot15] then
			slot10[slot15] = nil
		end
	end

	for slot15, slot16 in pairs(slot8) do
		if slot11[slot15] then
			slot11[slot15] = nil
		end
	end

	slot12 = {}
	slot13 = {}

	for slot17, slot18 in pairs(slot10) do
		slot12[#slot12 + 1] = slot17
	end

	function slot17(slot0, slot1)
		return slot0:sub(1, 1) < slot1:sub(1, 1)
	end

	table.sort(slot12, slot17)

	for slot17, slot18 in pairs(slot11) do
		slot13[#slot13 + 1] = slot18
	end

	table.sort(slot13, function (slot0, slot1)
		return slot0:sub(1, 1) < slot1:sub(1, 1)
	end)

	if #slot12 + #slot11 > 0 then
		for slot19, slot20 in ipairs(slot12) do
			slot15 = "SoundbanksInfo.xml 中不存在的 Bnk：\n" .. "\t" .. slot20 .. "\n"
		end

		for slot19, slot20 in pairs(slot11) do
			slot15 = slot15 .. "SoundbanksInfo.xml 中不存在的 Wem:\n" .. "\t" .. slot20 .. "\n"
		end

		slot16 = "bnkCheckResult.txt"

		SLFramework.FileHelper.WriteTextToPath(string.format("%s/../", UnityEngine.Application.dataPath) .. slot16, slot15)
		logNormal("扫描 SoundbanksInfo.xml 发现 " .. slot14 .. " 个冗余资源，" .. "结果已保存至 " .. (string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. slot16))
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现冗余音频资源")
	end
end

function slot0._checkBnkLangInSoundbanksInfoXml(slot0)
	logNormal("开始检查 Bnk 文件多语言缺失--------------------------------")

	slot3 = io.open("Assets/ZResourcesLib/audios/Android/SoundbanksInfo.xml", "r")

	slot3:close()

	slot5 = ResSplitXmlTree:new()

	ResSplitXml2lua.parser(slot5):parse(slot3:read("*a"))

	slot7 = {}
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in pairs(slot5.root.SoundBanksInfo.SoundBanks.SoundBank) do
		slot16 = slot14.ShortName
		slot17 = slot14.Path:gsub("\\", "/")

		if ({
			zh = true,
			en = true
		})[slot14._attr.Language] then
			slot9[slot16] = slot9[slot16] or {}
			slot18 = slot9[slot16]
			slot18[#slot18 + 1] = slot15
		end
	end

	slot10 = {}

	for slot14, slot15 in pairs(slot9) do
		if slot15 and #slot15 ~= tabletool.len(slot2) then
			slot10[#slot10 + 1] = slot10
		end
	end

	if #slot10 > 0 then
		slot11 = ""

		for slot15, slot16 in ipairs(slot10) do
			for slot21, slot22 in pairs(slot2) do
				if not tabletool.indexOf(slot9[slot16], slot21) then
					slot11 = slot11 .. slot16 .. "缺少" .. slot21 .. " 内容\n"
				end
			end
		end

		slot12 = "SoundbanksInfoCheckLangResult.txt"

		SLFramework.FileHelper.WriteTextToPath(string.format("%s/../", UnityEngine.Application.dataPath) .. slot12, slot11)
		logNormal("扫描 SoundbanksInfo.xml 发现 " .. #slot10 .. " 个多语言版本缺失的资源，" .. "结果已保存至 " .. (string.gsub(UnityEngine.Application.dataPath, "Assets", "") .. slot12))
	else
		logNormal("扫描 SoundbanksInfo.xml 未发现多语言缺失资源")
	end
end

function slot0._onReleaseAudioResource(slot0)
	AudioMgr.instance:clearUnusedBanks()
end

function slot0._getFolderAndParent(slot0)
	slot1 = {}
	slot5 = "[^/]+"

	for slot5 in slot0:gmatch(slot5) do
		table.insert(slot1, slot5)
	end

	if #slot1 >= 2 then
		return slot1[slot2 - 1], slot1[slot2 - 2]
	elseif slot2 == 1 then
		return slot1[1], nil
	else
		return nil, 
	end
end

return slot0
