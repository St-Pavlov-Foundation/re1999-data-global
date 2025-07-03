module("modules.logic.gm.view.GMToolView2", package.seeall)

local var_0_0 = class("GMToolView2", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._inpDumpHierarchy = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item16/inpText")
	arg_1_0._btnDumpHierarchy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item16/btnDumpHierarchy")
	arg_1_0._btnHierarchy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item16/btnHierarchy")
	arg_1_0._btnSkillPreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item9/btnSkillPreview")
	arg_1_0._btnVersion = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item17/btnVersion")
	arg_1_0._btnHardware = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item17/btnHardware")
	arg_1_0._sliderRenderScale = gohelper.findChildSlider(arg_1_0.viewGO, "viewport/content/item19/Slider")
	arg_1_0._txtRenderScale = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item19/Text")
	arg_1_0._btnForbidFightEffect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item26/Button1")
	arg_1_0._btnCancelForbidFightEffect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item26/Button2")
	arg_1_0._btnTest1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item27/Button1")
	arg_1_0._btnTest2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item27/Button2")
	arg_1_0._textCheckAudio2 = gohelper.findChildText(arg_1_0.viewGO, "viewport/content/item47/btnCheckAudio2/Text")
	arg_1_0._textCallAudioGCThreshold = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item47/InputField")
	arg_1_0._inpTestAudio = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/testAudio1/inpTextAudio")
	arg_1_0._inpBeginTestAudio = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/testAudio1/inpTextAudioBegin")
	arg_1_0._inpEndTestAudio = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/testAudio1/inpTextAudioEnd")
	arg_1_0._btnLoadTestAudio = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/testAudio2/btnLoadTestAudio")
	arg_1_0._btnUnloadTestAudio = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/testAudio2/btnUnloadTestAudio")
	arg_1_0._visualToggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/item48/visualToggle")
	arg_1_0._visualToggle.isOn = GMController.instance:getVisualInteractive()
	arg_1_0._dropActivity = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/versionactivity/activityDropdown")
	arg_1_0._dropActivityStatus = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/versionactivity/activityStatusDropdown")
	arg_1_0._btnChangeActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/versionactivity1/btnChangeActivity")
	arg_1_0._btnResetActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/versionactivity1/btnResetActivity")
	arg_1_0._btnEnterActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/versionactivity2/btnEnterActivity")
	arg_1_0._btnResetActivityUnlockAnim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/versionactivity2/btnResetUnlockAnim")
	arg_1_0._btnEnterDialogue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item51/Button")
	arg_1_0._inputDialogue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/item51/dialogueInput")
	arg_1_0._startEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item52/startEditV1a5HoleBtn")
	arg_1_0._endEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "viewport/content/item52/endEditV1a5HoleBtn")

	local var_1_0 = gohelper.cloneInPlace(arg_1_0._btnHardware.gameObject, "btnOnekeyFightSucc")

	recthelper.setAnchorX(var_1_0.transform, 210)

	gohelper.findChildText(var_1_0, "Text").text = "战斗胜利"
	arg_1_0._btnOnekeyFightSucc = gohelper.getClick(var_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnDumpHierarchy, arg_2_0._onClickBtnDumpHierarchy, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnHierarchy, arg_2_0._onClickBtnHierarchy, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnSkillPreview, arg_2_0._onClickBtnSkillPreview, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnVersion, arg_2_0._onClickBtnVersion, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnHardware, arg_2_0._onClickBtnHardware, arg_2_0)
	arg_2_0:_AddOnValueChanged(arg_2_0._sliderRenderScale, arg_2_0._onRenderScaleChange, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnForbidFightEffect, arg_2_0._onClickForbidFightEffect, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnCancelForbidFightEffect, arg_2_0._onClickCancelForbidFightEffect, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnTest1, arg_2_0._onClickTest1, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnTest2, arg_2_0._onClickTest2, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnLoadTestAudio, arg_2_0._onClickLoadTestAudio, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnUnloadTestAudio, arg_2_0._onClickUnloadTestAudio, arg_2_0)
	arg_2_0:_AddOnValueChanged(arg_2_0._visualToggle, arg_2_0._onVisualToggleValueChange, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnChangeActivity, arg_2_0._onClickChangeActivityBtn, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnResetActivity, arg_2_0._onClickResetActivityBtn, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnEnterActivity, arg_2_0._onClickEnterActivity, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnResetActivityUnlockAnim, arg_2_0._onClickResetActivityUnlockAim, arg_2_0)
	arg_2_0:_AddOnValueChanged(arg_2_0._dropActivity, arg_2_0._onActivityDropValueChange, arg_2_0)
	arg_2_0:_AddOnValueChanged(arg_2_0._dropActivityStatus, arg_2_0._onActivityStatusDropValueChange, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnOnekeyFightSucc, arg_2_0._onClickOnekeyFightSucc, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._btnEnterDialogue, arg_2_0._onClickEnterDialogue, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._startEditV1a5HoleBtn, arg_2_0._onClickStartEditV1a5HoleBtn, arg_2_0)
	arg_2_0:_AddClickListener(arg_2_0._endEditV1a5HoleBtn, arg_2_0._onClickEndEditV1a5HoleBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:_RemoveClickListener(arg_3_0._btnDumpHierarchy)
	arg_3_0:_RemoveClickListener(arg_3_0._btnHierarchy)
	arg_3_0:_RemoveClickListener(arg_3_0._btnSkillPreview)
	arg_3_0:_RemoveClickListener(arg_3_0._btnVersion)
	arg_3_0:_RemoveClickListener(arg_3_0._btnHardware)
	arg_3_0:_RemoveOnValueChanged(arg_3_0._sliderRenderScale)
	arg_3_0:_RemoveClickListener(arg_3_0._btnForbidFightEffect)
	arg_3_0:_RemoveClickListener(arg_3_0._btnCancelForbidFightEffect)
	arg_3_0:_RemoveClickListener(arg_3_0._btnTest1)
	arg_3_0:_RemoveClickListener(arg_3_0._btnTest2)
	arg_3_0:_RemoveClickListener(arg_3_0._btnLoadTestAudio)
	arg_3_0:_RemoveClickListener(arg_3_0._btnUnloadTestAudio)
	arg_3_0:_RemoveOnValueChanged(arg_3_0._visualToggle)
	arg_3_0:_RemoveClickListener(arg_3_0._btnChangeActivity)
	arg_3_0:_RemoveClickListener(arg_3_0._btnResetActivity)
	arg_3_0:_RemoveOnValueChanged(arg_3_0._dropActivity)
	arg_3_0:_RemoveOnValueChanged(arg_3_0._dropActivityStatus)
	arg_3_0:_RemoveClickListener(arg_3_0._btnEnterActivity)
	arg_3_0:_RemoveClickListener(arg_3_0._btnResetActivityUnlockAnim)
	arg_3_0:_RemoveClickListener(arg_3_0._btnOnekeyFightSucc)
	arg_3_0:_RemoveClickListener(arg_3_0._btnEnterDialogue)
	arg_3_0:_RemoveClickListener(arg_3_0._startEditV1a5HoleBtn)
	arg_3_0:_RemoveClickListener(arg_3_0._endEditV1a5HoleBtn)
end

function var_0_0._AddClickListener(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 then
		arg_4_1:AddClickListener(arg_4_2, arg_4_3)
	end
end

function var_0_0._RemoveClickListener(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_1:RemoveClickListener()
	end
end

function var_0_0._AddOnValueChanged(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 then
		arg_6_1:AddOnValueChanged(arg_6_2, arg_6_3)
	end
end

function var_0_0._RemoveOnValueChanged(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_1:RemoveOnValueChanged()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = CameraMgr.instance:getRenderScale() or 1

	arg_9_0._sliderRenderScale:SetValue(var_9_0)

	arg_9_0._txtRenderScale.text = string.format("RenderScale\n%.2f", var_9_0)

	arg_9_0:initActivityDrop()
	arg_9_0:initActivityEnterFunc()
end

function var_0_0.initActivityDrop(arg_10_0)
	local var_10_0 = ActivityLiveMgr.instance:getLiveMgrVersion()
	local var_10_1 = _G[string.format("VersionActivity%sEnum", var_10_0)]

	if not var_10_1 then
		logError("GMToolView2 initActivityDrop getLiveMgrVersion error version:" .. tostring(var_10_0))

		return
	end

	local var_10_2 = {
		var_10_1.ActivityId
	}

	arg_10_0.activityIdList = {}
	arg_10_0.activityShowStrList = {}

	local var_10_3 = {}

	tabletool.addValues(var_10_3, var_10_1.ActivityId)

	arg_10_0.activityAll = {
		[string.format("%sall", var_10_0)] = var_10_3
	}

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			if type(iter_10_3) == "table" then
				for iter_10_4, iter_10_5 in pairs(iter_10_3) do
					table.insert(arg_10_0.activityIdList, iter_10_5)
				end
			else
				table.insert(arg_10_0.activityIdList, iter_10_3)
			end
		end
	end

	for iter_10_6, iter_10_7 in ipairs(arg_10_0.activityIdList) do
		local var_10_4 = lua_activity.configDict[iter_10_7]

		table.insert(arg_10_0.activityShowStrList, (var_10_4 and var_10_4.name or "") .. string.format("(%s)", iter_10_7))
	end

	for iter_10_8, iter_10_9 in pairs(arg_10_0.activityAll) do
		table.insert(arg_10_0.activityIdList, 1, iter_10_8)
		table.insert(arg_10_0.activityShowStrList, 1, iter_10_8)
	end

	arg_10_0.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	arg_10_0.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	arg_10_0.selectActivityIndex = 1
	arg_10_0.selectStatusIndex = 1

	if arg_10_0._dropActivity then
		arg_10_0._dropActivity:ClearOptions()
		arg_10_0._dropActivityStatus:ClearOptions()
		arg_10_0._dropActivity:AddOptions(arg_10_0.activityShowStrList)
		arg_10_0._dropActivityStatus:AddOptions(arg_10_0.statusShowStrList)
	end
end

function var_0_0.onOpenFinish(arg_11_0)
	arg_11_0.isOpenFinish = true
end

function var_0_0.onClose(arg_12_0)
	ZProj.AudioManager.Instance:SetErrorCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_12_0._checkCallAudiosLoop, arg_12_0)
end

function var_0_0._checkLowerName(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_2 = AudioConfig.instance:getAudioCOById(iter_13_1)

		if string.lower(var_13_2.bankName) ~= var_13_2.bankName and not var_13_1[var_13_2.bankName] then
			var_13_1[var_13_2.bankName] = true

			table.insert(var_13_0, "bank: " .. var_13_2.bankName)
		end

		if string.lower(var_13_2.eventName) ~= var_13_2.eventName then
			table.insert(var_13_0, "event: " .. var_13_2.eventName)
		end
	end

	if #var_13_0 > 0 then
		logError("大小写问题：\n" .. table.concat(var_13_0, "\n"))
	end
end

function var_0_0._checkAudioConfigs(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.configList) do
		if iter_14_1.id and iter_14_1.id > 0 and not tabletool.indexOf(arg_14_0._audioConfigs, iter_14_1.id) then
			table.insert(arg_14_0._audioConfigs, iter_14_1.id)

			arg_14_0._audioId2Excel = arg_14_0._audioId2Excel or {}
			arg_14_0._audioId2Excel[iter_14_1.id] = arg_14_2
		end
	end
end

function var_0_0._onClickLoadTestAudio(arg_15_0)
	local var_15_0 = arg_15_0._inpTestAudio:GetText() or ""
	local var_15_1 = arg_15_0._inpBeginTestAudio:GetText() or ""
	local var_15_2 = arg_15_0._inpEndTestAudio:GetText() or ""

	arg_15_0:_testAudioParseParam(true, var_15_0, var_15_1, var_15_2)
end

function var_0_0._onClickUnloadTestAudio(arg_16_0)
	local var_16_0 = arg_16_0._inpTestAudio:GetText() or ""
	local var_16_1 = arg_16_0._inpBeginTestAudio:GetText() or ""
	local var_16_2 = arg_16_0._inpEndTestAudio:GetText() or ""

	arg_16_0:_testAudioParseParam(false, var_16_0, var_16_1, var_16_2)
end

function var_0_0._testAudioParseParam(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if string.nilorempty(arg_17_2) then
		return
	end

	local var_17_0 = SLFramework.FrameworkSettings.CurPlatformName
	local var_17_1 = SLFramework.FrameworkSettings.AssetRootDir
	local var_17_2 = string.format("%s/audios/%s", var_17_1, var_17_0)
	local var_17_3 = tonumber(arg_17_3)

	if var_17_3 then
		local var_17_4 = tonumber(arg_17_4)

		if not var_17_4 or var_17_4 < var_17_3 then
			var_17_4 = var_17_3
		end

		arg_17_0:_multiLoadOrUnloadAudio(arg_17_2, var_17_3, var_17_4, var_17_2, arg_17_1)
	else
		local var_17_5 = arg_17_0:_getAudioNameWithSuffix(arg_17_2)

		arg_17_0:_singleLoadOrUnloadAudio(var_17_5, var_17_2, arg_17_1, true)
	end
end

function var_0_0._getAudioNameWithSuffix(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = string.format("%s.bnk", arg_18_1)

	if arg_18_2 then
		var_18_0 = string.format("%s_%s.bnk", arg_18_1, arg_18_2)
	end

	return var_18_0
end

function var_0_0._singleLoadOrUnloadAudio(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = string.format("%s/%s", arg_19_2, arg_19_1)
	local var_19_1 = AudioMgr.instance:getCurLang()
	local var_19_2 = string.format("%s/%s/%s", arg_19_2, var_19_1, arg_19_1)

	if SLFramework.FileHelper.IsFileExists(var_19_0) or SLFramework.FileHelper.IsFileExists(var_19_2) then
		if arg_19_3 then
			ZProj.AudioManager.Instance:LoadBank(arg_19_1)
			logNormal("加载音频---" .. arg_19_1)
		else
			ZProj.AudioManager.Instance:UnloadBank(arg_19_1)
			logNormal("卸载音频---" .. arg_19_1)

			if arg_19_4 then
				GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, arg_19_0)
			end
		end
	else
		local var_19_3 = SLFramework.FrameworkSettings.CurPlatformName
		local var_19_4 = string.format("音频文件：%s 不存在，平台：%s，语言：%s", arg_19_1, var_19_3, var_19_1)

		logError(var_19_4)
	end
end

function var_0_0._multiLoadOrUnloadAudio(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	for iter_20_0 = arg_20_2, arg_20_3 do
		local var_20_0 = arg_20_0:_getAudioNameWithSuffix(arg_20_1, iter_20_0)

		arg_20_0:_singleLoadOrUnloadAudio(var_20_0, arg_20_4, arg_20_5, false)
	end

	if not arg_20_5 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, arg_20_0)
	end
end

function var_0_0._onClickBtnDumpHierarchy(arg_21_0)
	arg_21_0:closeThis()

	local var_21_0 = 100
	local var_21_1 = arg_21_0._inpDumpHierarchy:GetText()

	var_21_0 = not string.nilorempty(var_21_1) and tonumber(var_21_1) or var_21_0

	local var_21_2 = SLFramework.GameObjectHelper.GetRootGameObjects()
	local var_21_3 = {}

	for iter_21_0 = 0, var_21_2.Length - 1 do
		local var_21_4 = var_21_2[iter_21_0]

		arg_21_0:_dumpGOSelf(var_21_4.transform, var_21_3, 0)
		arg_21_0:_dumpChildren(var_21_4.transform, var_21_3, 1, var_21_0)
	end

	local var_21_5 = table.concat(var_21_3, "\n")

	logError("\n" .. var_21_5)
	ZProj.GameHelper.SetSystemBuffer(var_21_5)
	GameFacade.showToast(ToastEnum.IconId, "Hierarchy信息已复制到粘贴板")
end

function var_0_0._onClickBtnHierarchy(arg_22_0)
	arg_22_0:closeThis()
	ViewMgr.instance:openView(ViewName.HierarchyView)
end

function var_0_0._dumpGOSelf(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = ""

	for iter_23_0 = 1, arg_23_3 do
		var_23_0 = var_23_0 .. " - "
	end

	local var_23_1 = var_23_0 .. "[" .. arg_23_1.name .. "]" .. (arg_23_1.gameObject.activeSelf and " √" or " ×")

	if arg_23_1:GetComponent(typeof(UnityEngine.RectTransform)) then
		local var_23_2 = arg_23_0:_getIntOrFloat2Str(arg_23_1.anchoredPosition.x)
		local var_23_3 = arg_23_0:_getIntOrFloat2Str(arg_23_1.anchoredPosition.y)

		var_23_1 = var_23_1 .. string.format(" rectPos(%s,%s)", var_23_2, var_23_3)

		local var_23_4 = arg_23_1:GetComponent(typeof(UnityEngine.CanvasGroup))

		if var_23_4 then
			local var_23_5 = arg_23_0:_getIntOrFloat2Str(var_23_4.alpha)

			var_23_1 = var_23_1 .. string.format(" canvasGroup.alpha(%s)", var_23_5)
		end
	else
		local var_23_6 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localPosition.x)
		local var_23_7 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localPosition.y)
		local var_23_8 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localPosition.z)

		var_23_1 = var_23_1 .. string.format(" pos(%s,%s,%s)", var_23_6, var_23_7, var_23_8)
	end

	if arg_23_1.localScale.x == arg_23_1.localScale.y and arg_23_1.localScale.x == arg_23_1.localScale.z then
		if arg_23_1.localScale.x ~= 1 then
			local var_23_9 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localScale.x)

			var_23_1 = var_23_1 .. string.format(" scale(%s)", var_23_9)
		end
	else
		local var_23_10 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localScale.x)
		local var_23_11 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localScale.y)
		local var_23_12 = arg_23_0:_getIntOrFloat2Str(arg_23_1.localScale.z)

		var_23_1 = var_23_1 .. string.format(" scale(%s,%s,%s)", var_23_10, var_23_11, var_23_12)
	end

	table.insert(arg_23_2, var_23_1)
end

function var_0_0._getIntOrFloat2Str(arg_24_0, arg_24_1)
	local var_24_0 = math.floor(arg_24_1 * 100 + 0.5) / 100

	if var_24_0 % 1 == 0 then
		return tostring(var_24_0)
	elseif var_24_0 % 0.1 == 0 then
		return string.format("%.1f", var_24_0)
	else
		return string.format("%.2f", var_24_0)
	end
end

function var_0_0._dumpChildren(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	for iter_25_0 = 0, arg_25_1.childCount - 1 do
		local var_25_0 = arg_25_1:GetChild(iter_25_0)

		arg_25_0:_dumpGOSelf(var_25_0, arg_25_2, arg_25_3)

		if arg_25_3 < arg_25_4 - 1 then
			arg_25_0:_dumpChildren(var_25_0, arg_25_2, arg_25_3 + 1, arg_25_4)
		end
	end
end

function var_0_0._onClickBtnSkillPreview(arg_26_0)
	SkillEditorMgr.instance:start()
end

function var_0_0._onClickBtnVersion(arg_27_0)
	local var_27_0 = SDKMgr.instance:getGameId()
	local var_27_1 = BootNativeUtil.getAppVersion()
	local var_27_2 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_27_3 = "gameId=" .. var_27_0 .. "  type=" .. type(var_27_0)
	local var_27_4 = "appVersion=" .. var_27_1 .. "  type=" .. type(var_27_1)
	local var_27_5 = "hotUpdateVersion=" .. var_27_2 .. "  type=" .. type(var_27_2)

	logError(var_27_3)
	logError(var_27_4)
	logError(var_27_5)
	MessageBoxController.instance:showMsgBoxByStr(var_27_3 .. "\n" .. var_27_4 .. "\n" .. var_27_5)
end

local var_0_1 = {
	[ModuleEnum.Performance.High] = "高配",
	[ModuleEnum.Performance.Middle] = "中配",
	[ModuleEnum.Performance.Low] = "低配"
}

function var_0_0._onClickBtnHardware(arg_28_0)
	local var_28_0 = UnityEngine.SystemInfo.deviceModel
	local var_28_1 = BootNativeUtil.getCpuName()
	local var_28_2 = UnityEngine.SystemInfo.graphicsDeviceName
	local var_28_3 = UnityEngine.SystemInfo.systemMemorySize
	local var_28_4, var_28_5 = HardwareUtil.getPerformanceGrade()
	local var_28_6 = var_0_1[var_28_4]
	local var_28_7 = "设备名: " .. (var_28_0 or "nil")
	local var_28_8 = "CPU: " .. (var_28_1 or "nil")
	local var_28_9 = "GPU: " .. (var_28_2 or "nil")
	local var_28_10 = "Memory: " .. (var_28_3 or "nil")
	local var_28_11 = "硬件分级：" .. var_28_6 .. " by " .. var_28_5
	local var_28_12 = "设备DPI：" .. UnityEngine.Screen.dpi
	local var_28_13 = "分辨率：" .. UnityEngine.Screen.currentResolution:ToString()

	logError(var_28_7)
	logError(var_28_8)
	logError(var_28_9)
	logError(var_28_10)
	logError(var_28_11)
	logError(var_28_12)
	logError(var_28_13)
	MessageBoxController.instance:showMsgBoxByStr(var_28_7)
	MessageBoxController.instance:showMsgBoxByStr(var_28_8 .. "\n" .. var_28_9)
	MessageBoxController.instance:showMsgBoxByStr(var_28_10 .. "\n" .. var_28_11)
	MessageBoxController.instance:showMsgBoxByStr(var_28_12 .. "\n" .. var_28_13)
end

function var_0_0._onRenderScaleChange(arg_29_0, arg_29_1, arg_29_2)
	CameraMgr.instance:setRenderScale(arg_29_2)

	arg_29_0._txtRenderScale.text = string.format("RenderScale\n%.2f", arg_29_2)
end

function var_0_0._onClickForbidFightEffect(arg_30_0)
	FightEffectPool.isForbidEffect = true
end

function var_0_0._onClickCancelForbidFightEffect(arg_31_0)
	FightEffectPool.isForbidEffect = nil
end

function var_0_0._onClickTest1(arg_32_0)
	ViewMgr.instance:openView(ViewName.GMLangTxtView)
end

function var_0_0._onQueryProductDetailsCallBack(arg_33_0)
	logError("_onQueryProductDetailsCallBack")
end

function var_0_0._onClickTest2(arg_34_0)
	logError("test2")
	System.GC.Collect(2, System.GCCollectionMode.Forced, true, true)
end

function var_0_0._onVisualToggleValueChange(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0.isOpenFinish then
		return
	end

	GMController.instance:setVisualInteractive(arg_35_2)

	if arg_35_2 then
		GMController.instance:getVisualInteractiveMgr():start()
	else
		GMController.instance:getVisualInteractiveMgr():stop()
	end
end

function var_0_0._onClickChangeActivityBtn(arg_36_0)
	local var_36_0 = arg_36_0.activityIdList[arg_36_0.selectActivityIndex or 1]

	if arg_36_0.activityAll[var_36_0] then
		for iter_36_0, iter_36_1 in pairs(arg_36_0.activityAll[var_36_0]) do
			arg_36_0:_changeActivityInfo(iter_36_1)
		end

		return
	end

	arg_36_0:_changeActivityInfo(var_36_0)
end

function var_0_0._changeActivityInfo(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.statusList[arg_37_0.selectStatusIndex or 1]
	local var_37_1 = ActivityModel.instance:getActivityInfo()[arg_37_1]

	if ActivityHelper.getActivityStatus(arg_37_1) == var_37_0 then
		return
	end

	local var_37_2 = ServerTime.now() * 1000
	local var_37_3 = TimeUtil.maxDateTimeStamp * 1000

	var_37_1.config = arg_37_0:copyConfig(var_37_1.config)

	if var_37_0 == ActivityEnum.ActivityStatus.Normal then
		var_37_1.startTime = var_37_2 - 1
		var_37_1.endTime = var_37_3
		var_37_1.config.openId = 0
		var_37_1.online = true
	elseif var_37_0 == ActivityEnum.ActivityStatus.NotOpen then
		var_37_1.startTime = var_37_3
	elseif var_37_0 == ActivityEnum.ActivityStatus.Expired then
		var_37_1.startTime = var_37_2 - 1
		var_37_1.endTime = var_37_1.startTime
	elseif var_37_0 == ActivityEnum.ActivityStatus.NotUnlock then
		var_37_1.startTime = var_37_2 - 1
		var_37_1.endTime = var_37_3
		var_37_1.config.openId = arg_37_1
		OpenModel.instance._unlocks[arg_37_1] = false
	elseif var_37_0 == ActivityEnum.ActivityStatus.NotOnLine then
		var_37_1.startTime = var_37_2 - 1
		var_37_1.endTime = var_37_3
		var_37_1.config.openId = 0
		var_37_1.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, arg_37_1)
end

function var_0_0.copyConfig(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = {
		logoName = 9,
		name = 3,
		banner = 13,
		actDesc = 5,
		desc = 14,
		openId = 17,
		tabButton = 25,
		logoType = 8,
		isRetroAcitivity = 21,
		confirmCondition = 11,
		achievementGroupPath = 22,
		achievementGroup = 19,
		tabBgmId = 26,
		showCenter = 15,
		param = 16,
		redDotId = 18,
		storyId = 20,
		tabBgPath = 24,
		typeId = 7,
		actTip = 6,
		activityBonus = 23,
		tabName = 2,
		id = 1,
		joinCondition = 10,
		displayPriority = 12,
		nameEn = 4
	}

	for iter_38_0, iter_38_1 in pairs(var_38_1) do
		var_38_0[iter_38_0] = arg_38_1[iter_38_0]
	end

	return var_38_0
end

function var_0_0._onClickResetActivityBtn(arg_39_0)
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function var_0_0._onActivityDropValueChange(arg_40_0, arg_40_1)
	arg_40_0.selectActivityIndex = arg_40_1 + 1
end

function var_0_0._onActivityStatusDropValueChange(arg_41_0, arg_41_1)
	arg_41_0.selectStatusIndex = arg_41_1 + 1
end

function var_0_0._onClickResetActivityUnlockAim(arg_42_0)
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function var_0_0._onClickEnterActivity(arg_43_0)
	local var_43_0 = arg_43_0.activityIdList[arg_43_0.selectActivityIndex or 1]
	local var_43_1 = arg_43_0._activityEnterFuncMap[var_43_0]

	if not var_43_1 then
		return
	end

	local var_43_2 = arg_43_0._activityEnterFuncParamsMap[var_43_0]

	var_43_1(var_43_2.obj, var_43_2.params)
end

function var_0_0.initActivityEnterFunc(arg_44_0)
	arg_44_0._activityEnterFuncMap = {
		[11304] = Activity1_3ChessController.openMapView,
		[12204] = LoperaController.openLoperaMainView
	}
	arg_44_0._activityEnterFuncParamsMap = {
		[11304] = {
			params = 1,
			obj = Activity1_3ChessController
		},
		[12204] = {
			obj = LoperaController.instance
		}
	}
end

function var_0_0._onClickOnekeyFightSucc(arg_45_0)
	arg_45_0:closeThis()
	GMRpc.instance:sendGMRequest("set fight 1")
end

function var_0_0._onClickEnterDialogue(arg_46_0)
	local var_46_0 = arg_46_0._inputDialogue:GetText()
	local var_46_1 = tonumber(var_46_0)

	if not var_46_1 then
		return
	end

	if lua_tip_dialog.configDict[var_46_1] then
		TipDialogController.instance:openTipDialogView(var_46_1)

		return
	end

	if not DialogueConfig.instance:getDialogueCo(var_46_1) then
		GameFacade.showToastString("对话id不存在，请检查配置")
	end

	DialogueController.instance:enterDialogue(var_46_1)
end

function var_0_0._onClickStartEditV1a5HoleBtn(arg_47_0)
	local var_47_0 = ViewMgr.instance:getContainer(ViewName.VersionActivity1_5DungeonMapView)

	if not var_47_0 then
		ToastController.instance:showToastWithString("请先打开1.5副本界面")

		return
	end

	if not var_47_0:isOpenFinish() then
		ToastController.instance:showToastWithString("请等待1.5副本界面打开完成")

		return
	end

	arg_47_0.holeEditView = EditorV1a5DungeonHoleView.start(var_47_0)

	arg_47_0:closeThis()
end

return var_0_0
