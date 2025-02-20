module("modules.logic.gm.view.GMSubViewCommon", package.seeall)

slot0 = class("GMSubViewCommon", GMSubViewBase)

function slot0.ctor(slot0)
	slot0.tabName = "其他"
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

slot1 = tolua.findtype("UnityEngine.UI.InputField+LineType")
slot2 = System.Enum.Parse(slot1, "MultiLineSubmit")
slot3 = System.Enum.Parse(slot1, "MultiLineNewline")

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)
	slot0:addTitleSplitLine("服务端GM多行输入")

	slot0._gmInput = slot0:addInputText("L0", "", "GM ...", nil, , {
		w = 1000,
		h = 500
	})
	slot0._gmInput.inputField.lineType = uv0

	slot0._gmInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewMultiServerGM, ""))
	slot0:addButton("L0", "发送", slot0._onClickOk, slot0)
	slot0:addTitleSplitLine("检查")
	slot0:addButton("L1", "资源完整性验证", slot0._onClickCheckMD5, slot0)
	slot0:addButton("L1", "配置描述Tag检测", slot0._onClickCheckSkillTag, slot0)

	slot0._langDrop = slot0:addDropDown("L1", "UI多语言", nil, slot0._onLangDropChange, slot0)

	slot0:addTitleSplitLine("报错提示")
	slot0:addButton("L5", "开启报错提示", slot0._onClickShowLog, slot0)
	slot0:addButton("L5", "关闭报错提示", slot0._onClickHideLog, slot0)
	slot0:addTitleSplitLine("BGM")
	slot0:addButton("L2", "显示BGM播放进度", slot0._onClickBGMProgress, slot0)
	slot0:addButton("L2", "视频资源列表", slot0._onClickVideoList, slot0)
	slot0:addTitleSplitLine("剧情")

	slot0._inpClearStoryValue = slot0:addInputText("L3", "", "剧情id", nil, , {
		w = 1000
	})

	slot0:addButton("L3", "重置剧情", slot0._onClickClearStory, slot0)

	slot0._inpFinishStoryValue = slot0:addInputText("L4", "", "剧情id", nil, , {
		w = 1000
	})

	slot0:addButton("L4", "完成剧情", slot0._onClickFinishStory, slot0)
	slot0:addButton("L5", "监听按键", slot0._onClickListenKeyboard, slot0)
	slot0:addTitleSplitLine("内置浏览器")

	slot0._inpUrl = slot0:addInputText("L6", "", "url", nil, , {
		w = 1000
	})

	slot0:addButton("L6", "打开链接", slot0._onClickOpenWebView, slot0)

	slot0.recordUserToggle = slot0:addToggle("L6", "携带用\n户信息", nil, , {
		fsize = 20
	})

	slot0:addTitleSplitLine("按键")

	slot0._switchKeyToggle = slot0:addToggle("L7", "切换按键功能", slot0._switchKeyInput, slot0, {
		fsize = 40
	})
	slot0._switchKeyToggle.isOn = UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
	slot0.langList = {}
	slot0.langShortCutList = {}
	slot0.curUILang = LangSettings.instance:getCurLang()
	slot1 = 0
	slot2 = 0

	for slot6, slot7 in pairs(LangSettings.shortcutTab) do
		table.insert(slot0.langList, slot6)
		table.insert(slot0.langShortCutList, slot7)

		if slot6 == slot0.curUILang then
			slot1 = slot2
		end

		slot2 = slot2 + 1
	end

	slot0._langDrop:ClearOptions()
	slot0._langDrop:AddOptions(slot0.langShortCutList)
	slot0._langDrop:SetValue(slot1)
end

function slot0._onClickOpenWebView(slot0)
	if string.nilorempty(slot0._inpUrl:GetText()) then
		return
	end

	WebViewController.instance:openWebView(slot1, slot0.recordUserToggle.isOn)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._tickListenKeyboard, slot0)
end

function slot0._onClickOk(slot0)
	if string.nilorempty(slot0._gmInput:GetText()) then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewMultiServerGM, slot1)

	for slot6, slot7 in ipairs(string.split(slot1, "\n")) do
		if not string.nilorempty(string.trim(slot7)) then
			GMRpc.instance:sendGMRequest(slot7)
		end
	end
end

function slot0._onClickShowLog(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowErrorAlert, 1)
end

function slot0._onClickHideLog(slot0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowErrorAlert, 0)
end

function slot0._onClickCheckMD5(slot0)
	MessageBoxController.instance:showMsgBoxByStr("正在验证资源完整性", MsgBoxEnum.BoxType.Yes)

	slot1 = ResCheckMgr.instance:_getAllLocalLang()
	slot2, slot3 = ResCheckMgr.instance:_getDLCInfo(slot1)
	slot0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.ResChecker_Finish, slot0._onResCheckFinish, slot0)
	SLFramework.ResChecker.Instance:CheckAllRes(slot1, slot2, slot3)
end

function slot0._onResCheckFinish(slot0, slot1)
	slot2 = nil

	slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.ResChecker_Finish)

	slot0.eventDispatcher = nil

	MessageBoxController.instance:showSystemMsgBoxByStr(slot1 and "验证通过" or "资源完整性验证失败！！请查看日志", MsgBoxEnum.BoxType.Yes)
end

function slot0._onClickBGMProgress(slot0)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		GameFacade.showToast(ToastEnum.IconId, "show bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 1)
	else
		GameFacade.showToast(ToastEnum.IconId, "hide bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0)
	end
end

function slot0._onClickVideoList(slot0)
	ViewMgr.instance:openView(ViewName.GMVideoList)
end

function slot0._onClickClearRougeStories(slot0)
	for slot4, slot5 in ipairs(lua_rouge_story_list.configList) do
		for slot10, slot11 in ipairs(string.splitToNumber(slot5.storyIdList, "#")) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", slot11))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickFinishRougeStories(slot0)
	for slot4, slot5 in ipairs(lua_rouge_story_list.configList) do
		for slot10, slot11 in ipairs(string.splitToNumber(slot5.storyIdList, "#")) do
			StoryRpc.instance:sendUpdateStoryRequest(slot11, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickClearStory(slot0)
	slot3 = slot0._inpClearStoryValue
	slot5 = slot3

	for slot5, slot6 in ipairs(string.splitToNumber(slot3.GetText(slot5), "#")) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot6))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickFinishStory(slot0)
	slot3 = slot0._inpFinishStoryValue
	slot5 = slot3

	for slot5, slot6 in ipairs(string.splitToNumber(slot3.GetText(slot5), "#")) do
		StoryRpc.instance:sendUpdateStoryRequest(slot6, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickListenKeyboard(slot0)
	if not slot0._keyCodes then
		slot0._keyCodeStrs = {}
		slot0._keyCodes = {}

		for slot5 = 8, 329 do
			if UnityEngine.KeyCode.IntToEnum(slot5) then
				table.insert(slot0._keyCodes, slot6)
				table.insert(slot0._keyCodeStrs, slot6:ToString())
			end
		end
	end

	TaskDispatcher.cancelTask(slot0._tickListenKeyboard, slot0)
	TaskDispatcher.runRepeat(slot0._tickListenKeyboard, slot0, 0.01)
	GameFacade.showToast(ToastEnum.IconId, "请按下键盘，按键码将复制到粘贴板")
end

slot4 = UnityEngine.Input

function slot0._tickListenKeyboard(slot0)
	if uv0.anyKey then
		for slot4, slot5 in ipairs(slot0._keyCodes) do
			if uv0.GetKey(slot5) then
				slot6 = slot0._keyCodeStrs[slot4]

				logError(slot6)
				GameFacade.showToast(ToastEnum.IconId, slot6)
				ZProj.GameHelper.SetSystemBuffer(slot6)

				break
			end
		end
	end
end

function slot0._onClickCheckSkillTag(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_skill_eff_desc.configList) do
		if slot1[slot6.name] and slot6.name ~= "？？？" then
			logError(string.format("技能Tag 重复 [%s] %d -> %d", slot6.name, slot6.id, slot1[slot6.name]))
		end

		slot1[slot6.name] = slot6.id
	end

	FightConfig.instance:setGetDescFlag(true)
	slot0:_checkDescHaveTag(slot1, "skill_effect", "desc")
	slot0:_checkDescHaveTag(slot1, "skill_buff", "desc", slot0._isCheckBuff)
	slot0:_checkDescHaveTag(slot1, "skill_eff_desc", "desc")
	slot0:_checkDescHaveTag(slot1, "equip_skill", "baseDesc")
	slot0:_checkDescHaveTag(slot1, "rule", "desc")
	slot0:_checkDescHaveTag(slot1, "rouge_desc", "desc")
	FightConfig.instance:setGetDescFlag(false)
end

function slot0._isCheckBuff(slot0, slot1)
	if slot1 and slot1.isNoShow == 1 then
		return false
	end

	return true
end

function slot0._checkDescHaveTag(slot0, slot1, slot2, slot3, slot4)
	if not _G["lua_" .. slot2] then
		logError(slot2 .. "配置不存在 !!!!!!!!!!!!!")

		return
	end

	for slot9, slot10 in ipairs(slot5.configList) do
		if not slot4 or slot4(slot0, slot10) then
			if slot10[slot3]:find("不外显") then
				-- Nothing
			elseif type(slot11) == "string" then
				string.gsub(slot11, "%[(.-)%]", function (slot0)
					if not uv0[slot0] then
						logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", uv1, uv2, uv3[1], slot0, uv4))
					end

					return slot0
				end)
				string.gsub(slot11, "【(.-)】", function (slot0)
					if not uv0[slot0] then
						logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", uv1, uv2, uv3[1], slot0, uv4))
					end

					return slot0
				end)
			else
				logError(slot2 .. "." .. slot3 .. "配置字段不存在 !!!!!!!!!!!!!")

				break
			end
		end
	end
end

function slot0._onLangDropChange(slot0, slot1)
	if slot0.langList[slot1 + 1] == slot0.curLang then
		return
	end

	GameConfig:SetCurLangType(slot0.langShortCutList[slot1 + 1])

	LangSettings.instance._curLang = slot2
	LangSettings.instance._captionsActive = LangSettings._captionsSetting[slot2] ~= false

	UnityEngine.PlayerPrefs.SetInt("CurLanguageType", GameConfig:GetCurLangType())
	UnityEngine.PlayerPrefs.Save()
end

function slot0._switchKeyInput(slot0, slot1, slot2)
	UnityEngine.PlayerPrefs.SetInt("PCInputSwitch", slot2 and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
	PCInputController.instance:Switch()
end

return slot0
