module("modules.logic.gm.view.GMSubViewCommon", package.seeall)

local var_0_0 = class("GMSubViewCommon", GMSubViewBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "其他"
end

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local var_0_1 = tolua.findtype("UnityEngine.UI.InputField+LineType")
local var_0_2 = System.Enum.Parse(var_0_1, "MultiLineSubmit")
local var_0_3 = System.Enum.Parse(var_0_1, "MultiLineNewline")

function var_0_0.initViewContent(arg_2_0)
	if arg_2_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_2_0)
	arg_2_0:addTitleSplitLine("日志上传")
	arg_2_0:addButton("L-1", "上传此次运行日志文件", arg_2_0._onClickUploadCurLog, arg_2_0)
	arg_2_0:addButton("L-1", "上传上次运行日志文件", arg_2_0._onClickUploadLastLog, arg_2_0)
	arg_2_0:addTitleSplitLine("服务端GM多行输入")

	arg_2_0._gmInput = arg_2_0:addInputText("L0", "", "GM ...", nil, nil, {
		w = 1000,
		h = 500
	})
	arg_2_0._gmInput.inputField.lineType = var_0_3

	arg_2_0._gmInput:SetText(PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewMultiServerGM, ""))
	arg_2_0:addButton("L0", "发送", arg_2_0._onClickOk, arg_2_0)
	arg_2_0:addTitleSplitLine("检查")
	arg_2_0:addButton("L1", "资源完整性验证", arg_2_0._onClickCheckMD5, arg_2_0)
	arg_2_0:addButton("L1", "配置描述Tag检测", arg_2_0._onClickCheckSkillTag, arg_2_0)
	arg_2_0:addButton("L1", "扫描无用配置", arg_2_0._onClickCheckUnuseConfig, arg_2_0)

	arg_2_0._langDrop = arg_2_0:addDropDown("L1", "UI多语言", nil, arg_2_0._onLangDropChange, arg_2_0)

	arg_2_0:addButton("L1.2", "多语言文本查找", arg_2_0._onClickLangTxtSearch, arg_2_0)
	arg_2_0:addTitleSplitLine("报错提示")
	arg_2_0:addButton("L5", "开启报错提示", arg_2_0._onClickShowLog, arg_2_0)
	arg_2_0:addButton("L5", "关闭报错提示", arg_2_0._onClickHideLog, arg_2_0)
	arg_2_0:addTitleSplitLine("BGM")
	arg_2_0:addButton("L2", "显示BGM播放进度", arg_2_0._onClickBGMProgress, arg_2_0)
	arg_2_0:addButton("L2", "视频资源列表", arg_2_0._onClickVideoList, arg_2_0)
	arg_2_0:addTitleSplitLine("剧情")

	arg_2_0._inpClearStoryValue = arg_2_0:addInputText("L3", "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L3", "重置剧情", arg_2_0._onClickClearStory, arg_2_0)

	arg_2_0._inpFinishStoryValue = arg_2_0:addInputText("L4", "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L4", "完成剧情", arg_2_0._onClickFinishStory, arg_2_0)
	arg_2_0:addButton("L5", "监听按键", arg_2_0._onClickListenKeyboard, arg_2_0)
	arg_2_0:addTitleSplitLine("内置浏览器")

	arg_2_0._inpUrl = arg_2_0:addInputText("L6", "", "url", nil, nil, {
		w = 1000
	})

	arg_2_0:addButton("L6", "打开链接", arg_2_0._onClickOpenWebView, arg_2_0)

	arg_2_0.recordUserToggle = arg_2_0:addToggle("L6", "携带用\n户信息", nil, nil, {
		fsize = 20
	})

	arg_2_0:addTitleSplitLine("按键")

	arg_2_0._switchKeyToggle = arg_2_0:addToggle("L7", "切换按键功能", arg_2_0._switchKeyInput, arg_2_0, {
		fsize = 40
	})
	arg_2_0._switchKeyToggle.isOn = UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 0) == 1
	arg_2_0.langList = {}
	arg_2_0.langShortCutList = {}
	arg_2_0.curUILang = LangSettings.instance:getCurLang()

	local var_2_0 = 0
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in pairs(LangSettings.shortcutTab) do
		table.insert(arg_2_0.langList, iter_2_0)
		table.insert(arg_2_0.langShortCutList, iter_2_1)

		if iter_2_0 == arg_2_0.curUILang then
			var_2_0 = var_2_1
		end

		var_2_1 = var_2_1 + 1
	end

	arg_2_0._langDrop:ClearOptions()
	arg_2_0._langDrop:AddOptions(arg_2_0.langShortCutList)
	arg_2_0._langDrop:SetValue(var_2_0)
end

function var_0_0._onClickUploadCurLog(arg_3_0)
	SendWeWorkFileHelper.SendCurLogFile()
end

function var_0_0._onClickUploadLastLog(arg_4_0)
	SendWeWorkFileHelper.SendLastLogFile()
end

function var_0_0._onClickOpenWebView(arg_5_0)
	local var_5_0 = arg_5_0._inpUrl:GetText()

	if string.nilorempty(var_5_0) then
		return
	end

	WebViewController.instance:openWebView(var_5_0, arg_5_0.recordUserToggle.isOn)
end

function var_0_0.removeEvents(arg_6_0)
	var_0_0.super.removeEvents(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._tickListenKeyboard, arg_6_0)
end

function var_0_0._onClickOk(arg_7_0)
	local var_7_0 = arg_7_0._gmInput:GetText()

	if string.nilorempty(var_7_0) then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewMultiServerGM, var_7_0)

	local var_7_1 = string.split(var_7_0, "\n")

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		iter_7_1 = string.trim(iter_7_1)

		if not string.nilorempty(iter_7_1) then
			GMRpc.instance:sendGMRequest(iter_7_1)
		end
	end
end

function var_0_0._onClickShowLog(arg_8_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowErrorAlert, 1)
end

function var_0_0._onClickHideLog(arg_9_0)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewShowErrorAlert, 0)
end

function var_0_0._onClickCheckMD5(arg_10_0)
	MessageBoxController.instance:showMsgBoxByStr("正在验证资源完整性", MsgBoxEnum.BoxType.Yes)

	local var_10_0 = ResCheckMgr.instance:_getAllLocalLang()
	local var_10_1, var_10_2 = ResCheckMgr.instance:_getDLCInfo(var_10_0)

	arg_10_0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	arg_10_0.eventDispatcher:AddListener(arg_10_0.eventDispatcher.ResChecker_Finish, arg_10_0._onResCheckFinish, arg_10_0)
	SLFramework.ResChecker.Instance:CheckAllRes(var_10_0, var_10_1, var_10_2)
end

function var_0_0._onResCheckFinish(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = arg_11_1 and "验证通过" or "资源完整性验证失败！！请查看日志"

	arg_11_0.eventDispatcher:RemoveListener(arg_11_0.eventDispatcher.ResChecker_Finish)

	arg_11_0.eventDispatcher = nil

	MessageBoxController.instance:showSystemMsgBoxByStr(var_11_1, MsgBoxEnum.BoxType.Yes)
end

function var_0_0._onClickBGMProgress(arg_12_0)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0) == 0 then
		GameFacade.showToast(ToastEnum.IconId, "show bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 1)
	else
		GameFacade.showToast(ToastEnum.IconId, "hide bgm progress")
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewBGMProgress, 0)
	end
end

function var_0_0._onClickVideoList(arg_13_0)
	ViewMgr.instance:openView(ViewName.GMVideoList)
end

function var_0_0._onClickClearRougeStories(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(lua_rouge_story_list.configList) do
		local var_14_0 = string.splitToNumber(iter_14_1.storyIdList, "#")

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_14_3))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishRougeStories(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(lua_rouge_story_list.configList) do
		local var_15_0 = string.splitToNumber(iter_15_1.storyIdList, "#")

		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			StoryRpc.instance:sendUpdateStoryRequest(iter_15_3, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickClearStory(arg_16_0)
	local var_16_0 = string.splitToNumber(arg_16_0._inpClearStoryValue:GetText(), "#")

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_16_1))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishStory(arg_17_0)
	local var_17_0 = string.splitToNumber(arg_17_0._inpFinishStoryValue:GetText(), "#")

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		StoryRpc.instance:sendUpdateStoryRequest(iter_17_1, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickListenKeyboard(arg_18_0)
	if not arg_18_0._keyCodes then
		arg_18_0._keyCodeStrs = {}
		arg_18_0._keyCodes = {}

		local var_18_0 = UnityEngine.KeyCode

		for iter_18_0 = 8, 329 do
			local var_18_1 = var_18_0.IntToEnum(iter_18_0)

			if var_18_1 then
				local var_18_2 = var_18_1:ToString()

				table.insert(arg_18_0._keyCodes, var_18_1)
				table.insert(arg_18_0._keyCodeStrs, var_18_2)
			end
		end
	end

	TaskDispatcher.cancelTask(arg_18_0._tickListenKeyboard, arg_18_0)
	TaskDispatcher.runRepeat(arg_18_0._tickListenKeyboard, arg_18_0, 0.01)
	GameFacade.showToast(ToastEnum.IconId, "请按下键盘，按键码将复制到粘贴板")
end

local var_0_4 = UnityEngine.Input

function var_0_0._tickListenKeyboard(arg_19_0)
	if var_0_4.anyKey then
		for iter_19_0, iter_19_1 in ipairs(arg_19_0._keyCodes) do
			if var_0_4.GetKey(iter_19_1) then
				local var_19_0 = arg_19_0._keyCodeStrs[iter_19_0]

				logError(var_19_0)
				GameFacade.showToast(ToastEnum.IconId, var_19_0)
				ZProj.GameHelper.SetSystemBuffer(var_19_0)

				break
			end
		end
	end
end

function var_0_0._onClickCheckSkillTag(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(lua_skill_eff_desc.configList) do
		if var_20_0[iter_20_1.name] and iter_20_1.name ~= "？？？" then
			logError(string.format("技能Tag 重复 [%s] %d -> %d", iter_20_1.name, iter_20_1.id, var_20_0[iter_20_1.name]))
		end

		var_20_0[iter_20_1.name] = iter_20_1.id
	end

	FightConfig.instance:setGetDescFlag(true)
	arg_20_0:_checkDescHaveTag(var_20_0, "skill_effect", "desc")
	arg_20_0:_checkDescHaveTag(var_20_0, "skill_buff", "desc", arg_20_0._isCheckBuff)
	arg_20_0:_checkDescHaveTag(var_20_0, "skill_eff_desc", "desc")
	arg_20_0:_checkDescHaveTag(var_20_0, "equip_skill", "baseDesc")
	arg_20_0:_checkDescHaveTag(var_20_0, "rule", "desc")
	arg_20_0:_checkDescHaveTag(var_20_0, "rouge_desc", "desc")
	FightConfig.instance:setGetDescFlag(false)
end

function var_0_0._onClickCheckUnuseConfig(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(ModuleMgr.instance._moduleSettingList) do
		local var_21_1 = iter_21_1.config

		if var_21_1 then
			for iter_21_2, iter_21_3 in ipairs(var_21_1) do
				local var_21_2 = _G[iter_21_3]

				if var_21_2 then
					local var_21_3 = var_21_2.instance:reqConfigNames()

					if var_21_3 then
						for iter_21_4, iter_21_5 in ipairs(var_21_3) do
							var_21_0[iter_21_5] = true
						end
					end
				end
			end
		end
	end

	local var_21_4 = SLFramework.FrameworkSettings.AssetRootDir .. "/configs/excel2json/"
	local var_21_5 = SLFramework.FileHelper.GetDirFilePaths(var_21_4)
	local var_21_6 = ""
	local var_21_7 = var_21_5.Length

	for iter_21_6 = 0, var_21_7 - 1 do
		local var_21_8 = var_21_5[iter_21_6]

		if not string.find(var_21_8, ".meta") then
			local var_21_9 = SLFramework.FileHelper.GetFileName(var_21_8, false)

			if not var_21_0[string.gsub(var_21_9, "json_", "")] then
				var_21_6 = var_21_6 .. var_21_9 .. "\n"
			end
		end
	end

	logError(var_21_6)
end

function var_0_0._isCheckBuff(arg_22_0, arg_22_1)
	if arg_22_1 and arg_22_1.isNoShow == 1 then
		return false
	end

	return true
end

function var_0_0._checkDescHaveTag(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = _G["lua_" .. arg_23_2]

	if not var_23_0 then
		logError(arg_23_2 .. "配置不存在 !!!!!!!!!!!!!")

		return
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0.configList) do
		local var_23_1 = iter_23_1[arg_23_3]

		if arg_23_4 and not arg_23_4(arg_23_0, iter_23_1) or var_23_1:find("不外显") then
			-- block empty
		elseif type(var_23_1) == "string" then
			string.gsub(var_23_1, "%[(.-)%]", function(arg_24_0)
				if not arg_23_1[arg_24_0] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", arg_23_2, arg_23_3, iter_23_1[1], arg_24_0, var_23_1))
				end

				return arg_24_0
			end)
			string.gsub(var_23_1, "【(.-)】", function(arg_25_0)
				if not arg_23_1[arg_25_0] then
					logError(string.format("%s.%s id:%s tag不存在 ->  %s\n%s", arg_23_2, arg_23_3, iter_23_1[1], arg_25_0, var_23_1))
				end

				return arg_25_0
			end)
		else
			logError(arg_23_2 .. "." .. arg_23_3 .. "配置字段不存在 !!!!!!!!!!!!!")

			break
		end
	end
end

function var_0_0._onClickLangTxtSearch(arg_26_0, arg_26_1)
	ViewMgr.instance:openView(ViewName.GMLangTxtView)
end

function var_0_0._onLangDropChange(arg_27_0, arg_27_1)
	if arg_27_0.langList[arg_27_1 + 1] == arg_27_0.curUILang then
		return
	end

	local var_27_0 = GameConfig:GetCurLangType()

	LangSettings.instance:SetCurLangType(arg_27_0.langShortCutList[arg_27_1 + 1], arg_27_0._onChangeLangTxtType2, arg_27_0)
end

function var_0_0._onChangeLangTxtType2(arg_28_0)
	local var_28_0 = GameConfig:GetCurLangShortcut()
	local var_28_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(var_28_0)

	GameLanguageMgr.instance:setLanguageTypeByStoryIndex(var_28_1)
	PlayerPrefsHelper.setNumber("StoryTxtLanType", var_28_1 - 1)
	SettingsController.instance:changeLangTxt()
end

function var_0_0._switchKeyInput(arg_29_0, arg_29_1, arg_29_2)
	UnityEngine.PlayerPrefs.SetInt("PCInputSwitch", arg_29_2 and 1 or 0)
	UnityEngine.PlayerPrefs.Save()
	PCInputController.instance:Switch()
end

return var_0_0
