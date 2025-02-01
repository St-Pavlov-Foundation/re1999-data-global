module("modules.logic.gm.view.GMToolView2", package.seeall)

slot0 = class("GMToolView2", BaseView)

function slot0.onInitView(slot0)
	slot0._inpDumpHierarchy = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item16/inpText")
	slot0._btnDumpHierarchy = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item16/btnDumpHierarchy")
	slot0._btnHierarchy = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item16/btnHierarchy")
	slot0._btnSkillPreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item9/btnSkillPreview")
	slot0._btnVersion = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item17/btnVersion")
	slot0._btnHardware = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item17/btnHardware")
	slot0._sliderRenderScale = gohelper.findChildSlider(slot0.viewGO, "viewport/content/item19/Slider")
	slot0._txtRenderScale = gohelper.findChildText(slot0.viewGO, "viewport/content/item19/Text")
	slot0._btnRoomOb = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item23/btnRoomOb")
	slot0._btnRoomMap = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item23/btnRoomMap")
	slot0._btnRoomDebug = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item23/btnRoomDebug")
	slot0._btnRoomDebugBuildingArea = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item23/btnRoomDebugBuildingArea")
	slot0._btnForbidFightEffect = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item26/Button1")
	slot0._btnCancelForbidFightEffect = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item26/Button2")
	slot0._btnTest1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item27/Button1")
	slot0._btnTest2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item27/Button2")
	slot0._btnTest3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item27/Button3")
	slot0._sliderRoomRotateSpeed = gohelper.findChildSlider(slot0.viewGO, "viewport/content/item43/Slider")
	slot0._txtRoomRotateSpeed = gohelper.findChildText(slot0.viewGO, "viewport/content/item43/txtValue")
	slot0._sliderRoomMoveSpeed = gohelper.findChildSlider(slot0.viewGO, "viewport/content/item44/Slider")
	slot0._txtRoomMoveSpeed = gohelper.findChildText(slot0.viewGO, "viewport/content/item44/txtValue")
	slot0._sliderRoomScaleSpeed = gohelper.findChildSlider(slot0.viewGO, "viewport/content/item45/Slider")
	slot0._txtRoomScaleSpeed = gohelper.findChildText(slot0.viewGO, "viewport/content/item45/txtValue")
	slot0._silderRoomTouchSpeed = gohelper.findChildSlider(slot0.viewGO, "viewport/content/roomTouchSpeed/Slider")
	slot0._txtRoomTouchSpeed = gohelper.findChildText(slot0.viewGO, "viewport/content/roomTouchSpeed/txtValue")
	slot0._textCheckAudio2 = gohelper.findChildText(slot0.viewGO, "viewport/content/item47/btnCheckAudio2/Text")
	slot0._textCallAudioGCThreshold = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item47/InputField")
	slot0._inpTestAudio = gohelper.findChildInputField(slot0.viewGO, "viewport/content/testAudio1/inpTextAudio")
	slot0._inpBeginTestAudio = gohelper.findChildInputField(slot0.viewGO, "viewport/content/testAudio1/inpTextAudioBegin")
	slot0._inpEndTestAudio = gohelper.findChildInputField(slot0.viewGO, "viewport/content/testAudio1/inpTextAudioEnd")
	slot0._btnLoadTestAudio = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/testAudio2/btnLoadTestAudio")
	slot0._btnUnloadTestAudio = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/testAudio2/btnUnloadTestAudio")
	slot0._dropRoomClock = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/roomclock/Dropdown")
	slot0._btnRoomBuildingCamera = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/roomclock/btnRoomBuildingCamera")
	slot0._visualToggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/item48/visualToggle")
	slot0._visualToggle.isOn = GMController.instance:getVisualInteractive()
	slot0._dropActivity = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/versionactivity/activityDropdown")
	slot0._dropActivityStatus = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/versionactivity/activityStatusDropdown")
	slot0._btnChangeActivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/versionactivity1/btnChangeActivity")
	slot0._btnResetActivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/versionactivity1/btnResetActivity")
	slot0._btnEnterActivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/versionactivity2/btnEnterActivity")
	slot0._btnResetActivityUnlockAnim = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/versionactivity2/btnResetUnlockAnim")
	slot0._btnEnterDialogue = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item51/Button")
	slot0._inputDialogue = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/item51/dialogueInput")
	slot0._startEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item52/startEditV1a5HoleBtn")
	slot0._endEditV1a5HoleBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "viewport/content/item52/endEditV1a5HoleBtn")
	slot1 = gohelper.cloneInPlace(slot0._btnHardware.gameObject, "btnOnekeyFightSucc")

	recthelper.setAnchorX(slot1.transform, 210)

	gohelper.findChildText(slot1, "Text").text = "战斗胜利"
	slot0._btnOnekeyFightSucc = gohelper.getClick(slot1)
end

function slot0.addEvents(slot0)
	slot0:_AddClickListener(slot0._btnDumpHierarchy, slot0._onClickBtnDumpHierarchy, slot0)
	slot0:_AddClickListener(slot0._btnHierarchy, slot0._onClickBtnHierarchy, slot0)
	slot0:_AddClickListener(slot0._btnSkillPreview, slot0._onClickBtnSkillPreview, slot0)
	slot0:_AddClickListener(slot0._btnVersion, slot0._onClickBtnVersion, slot0)
	slot0:_AddClickListener(slot0._btnHardware, slot0._onClickBtnHardware, slot0)
	slot0:_AddOnValueChanged(slot0._sliderRenderScale, slot0._onRenderScaleChange, slot0)
	slot0:_AddClickListener(slot0._btnRoomOb, slot0._onClickBtnRoomOb, slot0)
	slot0:_AddClickListener(slot0._btnRoomMap, slot0._onClickBtnRoomMap, slot0)
	slot0:_AddClickListener(slot0._btnRoomDebug, slot0._onClickBtnRoomDebug, slot0)
	slot0:_AddClickListener(slot0._btnRoomDebugBuildingArea, slot0._onClickRoomDebugBuildingArea, slot0)
	slot0:_AddClickListener(slot0._btnForbidFightEffect, slot0._onClickForbidFightEffect, slot0)
	slot0:_AddClickListener(slot0._btnCancelForbidFightEffect, slot0._onClickCancelForbidFightEffect, slot0)
	slot0:_AddClickListener(slot0._btnTest1, slot0._onClickTest1, slot0)
	slot0:_AddClickListener(slot0._btnTest2, slot0._onClickTest2, slot0)
	slot0:_AddClickListener(slot0._btnTest3, slot0._onClickTest3, slot0)
	slot0:_AddOnValueChanged(slot0._sliderRoomRotateSpeed, slot0._onRoomRotateSpeedChange, slot0)
	slot0:_AddOnValueChanged(slot0._sliderRoomMoveSpeed, slot0._onRoomMoveSpeedChange, slot0)
	slot0:_AddOnValueChanged(slot0._sliderRoomScaleSpeed, slot0._onRoomScaleSpeedChange, slot0)
	slot0:_AddOnValueChanged(slot0._silderRoomTouchSpeed, slot0._onRoomTouchSpeedChange, slot0)
	slot0:_AddClickListener(slot0._btnLoadTestAudio, slot0._onClickLoadTestAudio, slot0)
	slot0:_AddClickListener(slot0._btnUnloadTestAudio, slot0._onClickUnloadTestAudio, slot0)
	slot0:_AddOnValueChanged(slot0._visualToggle, slot0._onVisualToggleValueChange, slot0)
	slot0:_AddOnValueChanged(slot0._dropRoomClock, slot0._onRoomClockSelectChanged, slot0)
	slot0:_AddClickListener(slot0._btnRoomBuildingCamera, slot0._onClickRoomBuildingCamera, slot0)
	slot0:_AddClickListener(slot0._btnChangeActivity, slot0._onClickChangeActivityBtn, slot0)
	slot0:_AddClickListener(slot0._btnResetActivity, slot0._onClickResetActivityBtn, slot0)
	slot0:_AddClickListener(slot0._btnEnterActivity, slot0._onClickEnterActivity, slot0)
	slot0:_AddClickListener(slot0._btnResetActivityUnlockAnim, slot0._onClickResetActivityUnlockAim, slot0)
	slot0:_AddOnValueChanged(slot0._dropActivity, slot0._onActivityDropValueChange, slot0)
	slot0:_AddOnValueChanged(slot0._dropActivityStatus, slot0._onActivityStatusDropValueChange, slot0)
	slot0:_AddClickListener(slot0._btnOnekeyFightSucc, slot0._onClickOnekeyFightSucc, slot0)
	slot0:_AddClickListener(slot0._btnEnterDialogue, slot0._onClickEnterDialogue, slot0)
	slot0:_AddClickListener(slot0._startEditV1a5HoleBtn, slot0._onClickStartEditV1a5HoleBtn, slot0)
	slot0:_AddClickListener(slot0._endEditV1a5HoleBtn, slot0._onClickEndEditV1a5HoleBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0:_RemoveClickListener(slot0._btnDumpHierarchy)
	slot0:_RemoveClickListener(slot0._btnHierarchy)
	slot0:_RemoveClickListener(slot0._btnSkillPreview)
	slot0:_RemoveClickListener(slot0._btnVersion)
	slot0:_RemoveClickListener(slot0._btnHardware)
	slot0:_RemoveOnValueChanged(slot0._sliderRenderScale)
	slot0:_RemoveClickListener(slot0._btnRoomOb)
	slot0:_RemoveClickListener(slot0._btnRoomMap)
	slot0:_RemoveClickListener(slot0._btnRoomDebug)
	slot0:_RemoveClickListener(slot0._btnRoomDebugBuildingArea)
	slot0:_RemoveClickListener(slot0._btnForbidFightEffect)
	slot0:_RemoveClickListener(slot0._btnCancelForbidFightEffect)
	slot0:_RemoveClickListener(slot0._btnTest1)
	slot0:_RemoveClickListener(slot0._btnTest2)
	slot0:_RemoveClickListener(slot0._btnTest3)
	slot0:_RemoveOnValueChanged(slot0._sliderRoomRotateSpeed)
	slot0:_RemoveOnValueChanged(slot0._sliderRoomMoveSpeed)
	slot0:_RemoveOnValueChanged(slot0._sliderRoomScaleSpeed)
	slot0:_RemoveOnValueChanged(slot0._silderRoomTouchSpeed)
	slot0:_RemoveClickListener(slot0._btnLoadTestAudio)
	slot0:_RemoveClickListener(slot0._btnUnloadTestAudio)
	slot0:_RemoveOnValueChanged(slot0._visualToggle)
	slot0:_RemoveOnValueChanged(slot0._dropRoomClock)
	slot0:_RemoveClickListener(slot0._btnRoomBuildingCamera)
	slot0:_RemoveClickListener(slot0._btnChangeActivity)
	slot0:_RemoveClickListener(slot0._btnResetActivity)
	slot0:_RemoveOnValueChanged(slot0._dropActivity)
	slot0:_RemoveOnValueChanged(slot0._dropActivityStatus)
	slot0:_RemoveClickListener(slot0._btnEnterActivity)
	slot0:_RemoveClickListener(slot0._btnResetActivityUnlockAnim)
	slot0:_RemoveClickListener(slot0._btnOnekeyFightSucc)
	slot0:_RemoveClickListener(slot0._btnEnterDialogue)
	slot0:_RemoveClickListener(slot0._startEditV1a5HoleBtn)
	slot0:_RemoveClickListener(slot0._endEditV1a5HoleBtn)
end

function slot0._AddClickListener(slot0, slot1, slot2, slot3)
	if slot1 then
		slot1:AddClickListener(slot2, slot3)
	end
end

function slot0._RemoveClickListener(slot0, slot1)
	if slot1 then
		slot1:RemoveClickListener()
	end
end

function slot0._AddOnValueChanged(slot0, slot1, slot2, slot3)
	if slot1 then
		slot1:AddOnValueChanged(slot2, slot3)
	end
end

function slot0._RemoveOnValueChanged(slot0, slot1)
	if slot1 then
		slot1:RemoveOnValueChanged()
	end
end

function slot0.onDestroyView(slot0)
end

function slot0.onOpen(slot0)
	slot1 = CameraMgr.instance:getRenderScale() or 1

	slot0._sliderRenderScale:SetValue(slot1)

	slot0._txtRenderScale.text = string.format("RenderScale\n%.2f", slot1)

	slot0._sliderRoomRotateSpeed:SetValue((RoomController.instance.rotateSpeed - 0.2) / 1.8)
	slot0._sliderRoomMoveSpeed:SetValue((RoomController.instance.moveSpeed - 0.2) / 1.8)
	slot0._sliderRoomScaleSpeed:SetValue((RoomController.instance.scaleSpeed - 0.2) / 1.8)

	if slot0._silderRoomTouchSpeed then
		slot0._silderRoomTouchSpeed:SetValue((RoomController.instance.touchMoveSpeed - 0.2) / 1.8)
	end

	if slot0._dropRoomClock then
		slot2 = {
			"选择时间"
		}

		for slot6 = 1, 24 do
			table.insert(slot2, slot6 .. "时")
		end

		slot0._dropRoomClock:ClearOptions()
		slot0._dropRoomClock:AddOptions(slot2)
	end

	slot0:initActivityDrop()
	slot0:initActivityEnterFunc()
end

function slot0.initActivityDrop(slot0)
	if not _G[string.format("VersionActivity%sEnum", ActivityLiveMgr.instance:getLiveMgrVersion())] then
		logError("GMToolView2 initActivityDrop getLiveMgrVersion error version:" .. tostring(slot1))

		return
	end

	slot0.activityIdList = {}
	slot0.activityShowStrList = {}
	slot4 = {}

	tabletool.addValues(slot4, slot2.ActivityId)

	slot8 = slot1
	slot0.activityAll = {
		[string.format("%sall", slot8)] = slot4
	}

	for slot8, slot9 in ipairs({
		slot2.ActivityId
	}) do
		for slot13, slot14 in pairs(slot9) do
			if type(slot14) == "table" then
				for slot18, slot19 in pairs(slot14) do
					table.insert(slot0.activityIdList, slot19)
				end
			else
				table.insert(slot0.activityIdList, slot14)
			end
		end
	end

	for slot8, slot9 in ipairs(slot0.activityIdList) do
		table.insert(slot0.activityShowStrList, (lua_activity.configDict[slot9] and slot10.name or "") .. string.format("(%s)", slot9))
	end

	for slot8, slot9 in pairs(slot0.activityAll) do
		table.insert(slot0.activityIdList, 1, slot8)
		table.insert(slot0.activityShowStrList, 1, slot8)
	end

	slot0.statusList = {
		ActivityEnum.ActivityStatus.Normal,
		ActivityEnum.ActivityStatus.NotOpen,
		ActivityEnum.ActivityStatus.Expired,
		ActivityEnum.ActivityStatus.NotUnlock,
		ActivityEnum.ActivityStatus.NotOnLine
	}
	slot0.statusShowStrList = {
		"正常开启状态",
		"未达到开启时间",
		"活动已结束",
		"活动未解锁",
		"活动已下线"
	}
	slot0.selectActivityIndex = 1
	slot0.selectStatusIndex = 1

	if slot0._dropActivity then
		slot0._dropActivity:ClearOptions()
		slot0._dropActivityStatus:ClearOptions()
		slot0._dropActivity:AddOptions(slot0.activityShowStrList)
		slot0._dropActivityStatus:AddOptions(slot0.statusShowStrList)
	end
end

function slot0.onOpenFinish(slot0)
	slot0.isOpenFinish = true
end

function slot0.onClose(slot0)
	ZProj.AudioManager.Instance:SetErrorCallback(nil, )
	TaskDispatcher.cancelTask(slot0._checkCallAudiosLoop, slot0)
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

function slot0._checkAudioConfigs(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1.configList) do
		if slot7.id and slot7.id > 0 and not tabletool.indexOf(slot0._audioConfigs, slot7.id) then
			table.insert(slot0._audioConfigs, slot7.id)

			slot0._audioId2Excel = slot0._audioId2Excel or {}
			slot0._audioId2Excel[slot7.id] = slot2
		end
	end
end

function slot0._onClickLoadTestAudio(slot0)
	slot0:_testAudioParseParam(true, slot0._inpTestAudio:GetText() or "", slot0._inpBeginTestAudio:GetText() or "", slot0._inpEndTestAudio:GetText() or "")
end

function slot0._onClickUnloadTestAudio(slot0)
	slot0:_testAudioParseParam(false, slot0._inpTestAudio:GetText() or "", slot0._inpBeginTestAudio:GetText() or "", slot0._inpEndTestAudio:GetText() or "")
end

function slot0._testAudioParseParam(slot0, slot1, slot2, slot3, slot4)
	if string.nilorempty(slot2) then
		return
	end

	slot7 = string.format("%s/audios/%s", SLFramework.FrameworkSettings.AssetRootDir, SLFramework.FrameworkSettings.CurPlatformName)

	if tonumber(slot3) then
		if not tonumber(slot4) or slot9 < slot8 then
			slot9 = slot8
		end

		slot0:_multiLoadOrUnloadAudio(slot2, slot8, slot9, slot7, slot1)
	else
		slot0:_singleLoadOrUnloadAudio(slot0:_getAudioNameWithSuffix(slot2), slot7, slot1, true)
	end
end

function slot0._getAudioNameWithSuffix(slot0, slot1, slot2)
	slot3 = string.format("%s.bnk", slot1)

	if slot2 then
		slot3 = string.format("%s_%s.bnk", slot1, slot2)
	end

	return slot3
end

function slot0._singleLoadOrUnloadAudio(slot0, slot1, slot2, slot3, slot4)
	if SLFramework.FileHelper.IsFileExists(string.format("%s/%s", slot2, slot1)) or SLFramework.FileHelper.IsFileExists(string.format("%s/%s/%s", slot2, AudioMgr.instance:getCurLang(), slot1)) then
		if slot3 then
			ZProj.AudioManager.Instance:LoadBank(slot1)
			logNormal("加载音频---" .. slot1)
		else
			ZProj.AudioManager.Instance:UnloadBank(slot1)
			logNormal("卸载音频---" .. slot1)

			if slot4 then
				GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, slot0)
			end
		end
	else
		logError(string.format("音频文件：%s 不存在，平台：%s，语言：%s", slot1, SLFramework.FrameworkSettings.CurPlatformName, slot6))
	end
end

function slot0._multiLoadOrUnloadAudio(slot0, slot1, slot2, slot3, slot4, slot5)
	for slot9 = slot2, slot3 do
		slot0:_singleLoadOrUnloadAudio(slot0:_getAudioNameWithSuffix(slot1, slot9), slot4, slot5, false)
	end

	if not slot5 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, slot0)
	end
end

function slot0._onClickBtnDumpHierarchy(slot0)
	slot0:closeThis()

	if not string.nilorempty(slot0._inpDumpHierarchy:GetText()) then
		slot1 = tonumber(slot2) or 100
	end

	slot4 = {}

	for slot8 = 0, SLFramework.GameObjectHelper.GetRootGameObjects().Length - 1 do
		slot9 = slot3[slot8]

		slot0:_dumpGOSelf(slot9.transform, slot4, 0)
		slot0:_dumpChildren(slot9.transform, slot4, 1, slot1)
	end

	slot5 = table.concat(slot4, "\n")

	logError("\n" .. slot5)
	ZProj.GameHelper.SetSystemBuffer(slot5)
	GameFacade.showToast(ToastEnum.IconId, "Hierarchy信息已复制到粘贴板")
end

function slot0._onClickBtnHierarchy(slot0)
	slot0:closeThis()
	ViewMgr.instance:openView(ViewName.HierarchyView)
end

function slot0._dumpGOSelf(slot0, slot1, slot2, slot3)
	for slot8 = 1, slot3 do
		slot4 = "" .. " - "
	end

	if slot1:GetComponent(typeof(UnityEngine.RectTransform)) then
		if slot1:GetComponent(typeof(UnityEngine.CanvasGroup)) then
			slot4 = slot4 .. "[" .. slot1.name .. "]" .. (slot1.gameObject.activeSelf and " √" or " ×") .. string.format(" rectPos(%s,%s)", slot0:_getIntOrFloat2Str(slot1.anchoredPosition.x), slot0:_getIntOrFloat2Str(slot1.anchoredPosition.y)) .. string.format(" canvasGroup.alpha(%s)", slot0:_getIntOrFloat2Str(slot7.alpha))
		end
	else
		slot4 = slot4 .. string.format(" pos(%s,%s,%s)", slot0:_getIntOrFloat2Str(slot1.localPosition.x), slot0:_getIntOrFloat2Str(slot1.localPosition.y), slot0:_getIntOrFloat2Str(slot1.localPosition.z))
	end

	if slot1.localScale.x == slot1.localScale.y and slot1.localScale.x == slot1.localScale.z then
		if slot1.localScale.x ~= 1 then
			slot4 = slot4 .. string.format(" scale(%s)", slot0:_getIntOrFloat2Str(slot1.localScale.x))
		end
	else
		slot4 = slot4 .. string.format(" scale(%s,%s,%s)", slot0:_getIntOrFloat2Str(slot1.localScale.x), slot0:_getIntOrFloat2Str(slot1.localScale.y), slot0:_getIntOrFloat2Str(slot1.localScale.z))
	end

	table.insert(slot2, slot4)
end

function slot0._getIntOrFloat2Str(slot0, slot1)
	if math.floor(slot1 * 100 + 0.5) / 100 % 1 == 0 then
		return tostring(slot2)
	elseif slot2 % 0.1 == 0 then
		return string.format("%.1f", slot2)
	else
		return string.format("%.2f", slot2)
	end
end

function slot0._dumpChildren(slot0, slot1, slot2, slot3, slot4)
	for slot8 = 0, slot1.childCount - 1 do
		slot0:_dumpGOSelf(slot1:GetChild(slot8), slot2, slot3)

		if slot3 < slot4 - 1 then
			slot0:_dumpChildren(slot9, slot2, slot3 + 1, slot4)
		end
	end
end

function slot0._onClickBtnSkillPreview(slot0)
	SkillEditorMgr.instance:start()
end

function slot0._onClickBtnVersion(slot0)
	slot1 = SDKMgr.instance:getGameId()
	slot2 = BootNativeUtil.getAppVersion()
	slot3 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	slot4 = "gameId=" .. slot1 .. "  type=" .. type(slot1)
	slot5 = "appVersion=" .. slot2 .. "  type=" .. type(slot2)
	slot6 = "hotUpdateVersion=" .. slot3 .. "  type=" .. type(slot3)

	logError(slot4)
	logError(slot5)
	logError(slot6)
	MessageBoxController.instance:showMsgBoxByStr(slot4 .. "\n" .. slot5 .. "\n" .. slot6)
end

slot1 = {
	[ModuleEnum.Performance.High] = "高配",
	[ModuleEnum.Performance.Middle] = "中配",
	[ModuleEnum.Performance.Low] = "低配"
}

function slot0._onClickBtnHardware(slot0)
	slot5, slot6 = HardwareUtil.getPerformanceGrade()
	slot8 = "设备名: " .. (UnityEngine.SystemInfo.deviceModel or "nil")
	slot9 = "CPU: " .. (BootNativeUtil.getCpuName() or "nil")
	slot10 = "GPU: " .. (UnityEngine.SystemInfo.graphicsDeviceName or "nil")
	slot11 = "Memory: " .. (UnityEngine.SystemInfo.systemMemorySize or "nil")
	slot12 = "硬件分级：" .. uv0[slot5] .. " by " .. slot6
	slot13 = "设备DPI：" .. UnityEngine.Screen.dpi
	slot14 = "分辨率：" .. UnityEngine.Screen.currentResolution:ToString()

	logError(slot8)
	logError(slot9)
	logError(slot10)
	logError(slot11)
	logError(slot12)
	logError(slot13)
	logError(slot14)
	MessageBoxController.instance:showMsgBoxByStr(slot8)
	MessageBoxController.instance:showMsgBoxByStr(slot9 .. "\n" .. slot10)
	MessageBoxController.instance:showMsgBoxByStr(slot11 .. "\n" .. slot12)
	MessageBoxController.instance:showMsgBoxByStr(slot13 .. "\n" .. slot14)
end

function slot0._onRenderScaleChange(slot0, slot1, slot2)
	CameraMgr.instance:setRenderScale(slot2)

	slot0._txtRenderScale.text = string.format("RenderScale\n%.2f", slot2)
end

function slot0._onClickBtnRoomOb(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
end

function slot0._onClickBtnRoomMap(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function slot0._onClickBtnRoomDebug(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
end

function slot0._onClickRoomDebugBuildingArea(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingAreaView()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

function slot0._onClickForbidFightEffect(slot0)
	FightEffectPool.isForbidEffect = true
end

function slot0._onClickCancelForbidFightEffect(slot0)
	FightEffectPool.isForbidEffect = nil
end

function slot0._onClickTest1(slot0)
end

function slot0._onQueryProductDetailsCallBack(slot0)
	logError("_onQueryProductDetailsCallBack")
end

function slot0._onClickTest2(slot0)
	logError("test2")
	System.GC.Collect(2, System.GCCollectionMode.Forced, true, true)
end

function slot0._onClickTest3(slot0)
	logError("test3")

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and RoomController.instance:isObMode() then
		slot3 = GameSceneMgr.instance:getCurScene()

		for slot7, slot8 in ipairs(RoomMapVehicleModel.instance:getList()) do
			if slot3.vehiclemgr:getUnit(RoomMapVehicleEntity:getTag(), slot8.id) then
				slot3.cameraFollow:setFollowTarget(slot9.cameraFollowTargetComp)

				return
			end
		end

		GameFacade.showToast(94, "GM交通工具数量：" .. #slot2)
	else
		GameFacade.showToast(94, "GM需要进入小屋后观察模式下使用。")
	end
end

function slot0._onRoomRotateSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.rotateSpeed = slot3
	slot0._txtRoomRotateSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomMoveSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.moveSpeed = slot3
	slot0._txtRoomMoveSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomScaleSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.scaleSpeed = slot3
	slot0._txtRoomScaleSpeed.text = string.format("%.2f", slot3)
end

function slot0._onRoomTouchSpeedChange(slot0, slot1, slot2)
	slot3 = 0.2 + 1.8 * slot2
	RoomController.instance.touchMoveSpeed = slot3
	slot0._txtRoomTouchSpeed.text = string.format("%.2f", slot3)
end

function slot0._onVisualToggleValueChange(slot0, slot1, slot2)
	if not slot0.isOpenFinish then
		return
	end

	GMController.instance:setVisualInteractive(slot2)

	if slot2 then
		GMController.instance:getVisualInteractiveMgr():start()
	else
		GMController.instance:getVisualInteractiveMgr():stop()
	end
end

function slot0._onRoomClockSelectChanged(slot0, slot1)
	if slot1 >= 1 or slot1 <= 24 then
		RoomMapController.instance:dispatchEvent(RoomEvent.OnHourReporting, slot1)
	end
end

function slot0._onClickRoomBuildingCamera(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomDebugController.instance:openBuildingCamerView()
		slot0:closeThis()
	else
		GameFacade.showToast(94, "GM需要进入小屋后使用。")
	end
end

function slot0._onClickChangeActivityBtn(slot0)
	if slot0.activityAll[slot0.activityIdList[slot0.selectActivityIndex or 1]] then
		for slot5, slot6 in pairs(slot0.activityAll[slot1]) do
			slot0:_changeActivityInfo(slot6)
		end

		return
	end

	slot0:_changeActivityInfo(slot1)
end

function slot0._changeActivityInfo(slot0, slot1)
	slot3 = slot0.selectStatusIndex or 1
	slot3 = ActivityModel.instance:getActivityInfo()[slot1]

	if ActivityHelper.getActivityStatus(slot1) == slot0.statusList[slot3] then
		return
	end

	slot3.config = slot0:copyConfig(slot3.config)

	if slot2 == ActivityEnum.ActivityStatus.Normal then
		slot3.startTime = ServerTime.now() * 1000 - 1
		slot3.endTime = TimeUtil.maxDateTimeStamp * 1000
		slot3.config.openId = 0
		slot3.online = true
	elseif slot2 == ActivityEnum.ActivityStatus.NotOpen then
		slot3.startTime = slot6
	elseif slot2 == ActivityEnum.ActivityStatus.Expired then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot3.startTime
	elseif slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot6
		slot3.config.openId = slot1
		OpenModel.instance._unlocks[slot1] = false
	elseif slot2 == ActivityEnum.ActivityStatus.NotOnLine then
		slot3.startTime = slot5 - 1
		slot3.endTime = slot6
		slot3.config.openId = 0
		slot3.online = false
	end

	ActivityController.instance:dispatchEvent(ActivityEvent.RefreshActivityState, slot1)
end

function slot0.copyConfig(slot0, slot1)
	for slot7, slot8 in pairs({
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
	}) do
		-- Nothing
	end

	return {
		[slot7] = slot1[slot7]
	}
end

function slot0._onClickResetActivityBtn(slot0)
	ActivityRpc.instance:sendGetActivityInfosRequest()
end

function slot0._onActivityDropValueChange(slot0, slot1)
	slot0.selectActivityIndex = slot1 + 1
end

function slot0._onActivityStatusDropValueChange(slot0, slot1)
	slot0.selectStatusIndex = slot1 + 1
end

function slot0._onClickResetActivityUnlockAim(slot0)
	PlayerPrefsHelper.deleteKey(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayedActUnlockAnimationKey))

	VersionActivityBaseController.instance.playedActUnlockAnimationList = nil
end

function slot0._onClickEnterActivity(slot0)
	if not slot0._activityEnterFuncMap[slot0.activityIdList[slot0.selectActivityIndex or 1]] then
		return
	end

	slot3 = slot0._activityEnterFuncParamsMap[slot1]

	slot2(slot3.obj, slot3.params)
end

function slot0.initActivityEnterFunc(slot0)
	slot0._activityEnterFuncMap = {
		[11304] = Activity1_3ChessController.openMapView
	}
	slot0._activityEnterFuncParamsMap = {
		[11304] = {
			params = 1,
			obj = Activity1_3ChessController
		}
	}
end

function slot0._onClickOnekeyFightSucc(slot0)
	slot0:closeThis()
	GMRpc.instance:sendGMRequest("set fight 1")
end

function slot0._onClickEnterDialogue(slot0)
	if not tonumber(slot0._inputDialogue:GetText()) then
		return
	end

	if lua_tip_dialog.configDict[slot1] then
		TipDialogController.instance:openTipDialogView(slot1)

		return
	end

	if not DialogueConfig.instance:getDialogueCo(slot1) then
		GameFacade.showToastString("对话id不存在，请检查配置")
	end

	DialogueController.instance:enterDialogue(slot1)
end

function slot0._onClickStartEditV1a5HoleBtn(slot0)
	if not ViewMgr.instance:getContainer(ViewName.VersionActivity1_5DungeonMapView) then
		ToastController.instance:showToastWithString("请先打开1.5副本界面")

		return
	end

	if not slot1:isOpenFinish() then
		ToastController.instance:showToastWithString("请等待1.5副本界面打开完成")

		return
	end

	slot0.holeEditView = EditorV1a5DungeonHoleView.start(slot1)

	slot0:closeThis()
end

return slot0
