module("modules.logic.gm.view.GMAudioTool", package.seeall)

local var_0_0 = class("GMAudioTool", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._inpAudio = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/playAudioById/inpAudioId")
	arg_1_0._btnAudioPlay = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/playAudioById/btnPlay"))
	arg_1_0._btnAudioStop = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/playAudioById/btnStop"))
	arg_1_0._autoStopToggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/audioTool/autoStopAudioToggle")
	arg_1_0._showLogToggle = gohelper.findChildToggle(arg_1_0.viewGO, "viewport/content/audioTool/showLogToggle")
	arg_1_0._inpEvent = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/playAudioByEventName/inpAudioEventName")
	arg_1_0._inpBank = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/playAudioByEventName/inpAudioBankName")
	arg_1_0._btnPlayEvent = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/playAudioByEventName/btnPlay"))
	arg_1_0._btnStopEvent = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/playAudioByEventName/btnStop"))
	arg_1_0._langDrop = gohelper.findChildDropdown(arg_1_0.viewGO, "viewport/content/audioLanguage/audioLanguageDropdown")
	arg_1_0._inpRtpcName = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/rtpcItem/inpRtpcName")
	arg_1_0._inpRtpcValue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/rtpcItem/inpRtpcValue")
	arg_1_0._btnSetRtpc = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/rtpcItem/btnSetRtpc"))
	arg_1_0._inpSwitchName = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/switchItem/inpSwitchGroup")
	arg_1_0._inpSwitchValue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "viewport/content/switchItem/inpSwitchValue")
	arg_1_0._btnSwitch = gohelper.getClick(gohelper.findChild(arg_1_0.viewGO, "viewport/content/switchItem/btnSetSwitch"))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAudioPlay:AddClickListener(arg_2_0._onClickAudioPlay, arg_2_0)
	arg_2_0._btnAudioStop:AddClickListener(arg_2_0._onClickAudioStop, arg_2_0)
	arg_2_0._btnPlayEvent:AddClickListener(arg_2_0._onClickEventPlay, arg_2_0)
	arg_2_0._btnStopEvent:AddClickListener(arg_2_0._onClickEventStop, arg_2_0)
	arg_2_0._btnSetRtpc:AddClickListener(arg_2_0._onClickSetRtpc, arg_2_0)
	arg_2_0._btnSwitch:AddClickListener(arg_2_0._onClickSwitch, arg_2_0)
	arg_2_0._autoStopToggle:AddOnValueChanged(arg_2_0._onAutoStopChange, arg_2_0)
	arg_2_0._showLogToggle:AddOnValueChanged(arg_2_0._onShowLogChange, arg_2_0)
	arg_2_0._langDrop:AddOnValueChanged(arg_2_0._onLangDropChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAudioPlay:RemoveClickListener()
	arg_3_0._btnAudioStop:RemoveClickListener()
	arg_3_0._btnPlayEvent:RemoveClickListener()
	arg_3_0._btnStopEvent:RemoveClickListener()
	arg_3_0._btnSetRtpc:RemoveClickListener()
	arg_3_0._btnSwitch:RemoveClickListener()
	arg_3_0._autoStopToggle:RemoveOnValueChanged()
	arg_3_0._showLogToggle:RemoveOnValueChanged()
	arg_3_0._langDrop:RemoveOnValueChanged()
end

function var_0_0.initLangDrop(arg_4_0)
	arg_4_0.langList = {}

	local var_4_0 = GameConfig:GetSupportedVoiceShortcuts()
	local var_4_1 = var_4_0.Length
	local var_4_2 = 0

	for iter_4_0 = 0, var_4_1 - 1 do
		local var_4_3 = var_4_0[iter_4_0]

		table.insert(arg_4_0.langList, var_4_3)

		if var_4_3 == arg_4_0.curLang then
			var_4_2 = iter_4_0
		end
	end

	arg_4_0._langDrop:ClearOptions()
	arg_4_0._langDrop:AddOptions(arg_4_0.langList)
	arg_4_0._langDrop:SetValue(var_4_2)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.autoStopPrePlayingId = true
	arg_5_0.prePlayingId = 0
	arg_5_0.curLang = GameConfig:GetCurVoiceShortcut()
	arg_5_0._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	arg_5_0._autoStopToggle.isOn = arg_5_0.autoStopPrePlayingId

	arg_5_0:initLangDrop()
end

function var_0_0._onClickAudioPlay(arg_6_0)
	local var_6_0 = arg_6_0._inpAudio:GetText()

	if not string.nilorempty(var_6_0) then
		local var_6_1 = tonumber(var_6_0)

		if var_6_1 then
			if arg_6_0.autoStopPrePlayingId then
				arg_6_0:stopPlayingID()
			end

			arg_6_0.prePlayingId = AudioMgr.instance:trigger(var_6_1) or 0
		end
	end
end

function var_0_0._onClickAudioStop(arg_7_0)
	arg_7_0:stopPlayingID()
end

function var_0_0._onClickEventPlay(arg_8_0)
	local var_8_0 = arg_8_0._inpEvent:GetText()
	local var_8_1 = arg_8_0._inpBank:GetText()

	if string.nilorempty(var_8_0) then
		return
	end

	if string.nilorempty(var_8_1) then
		return
	end

	arg_8_0:initAudioEditorTool()

	if arg_8_0.autoStopPrePlayingId then
		arg_8_0:stopPlayingID()
	end

	arg_8_0.prePlayingId = arg_8_0.audioTool:PlayEvent(var_8_0, var_8_1)
end

function var_0_0._onClickEventStop(arg_9_0)
	arg_9_0:stopPlayingID()
end

function var_0_0._onAutoStopChange(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.autoStopPrePlayingId = arg_10_2
end

function var_0_0._onShowLogChange(arg_11_0, arg_11_1, arg_11_2)
	if GMController.instance:getShowAudioLog() == arg_11_2 then
		return
	end

	AudioMgr.GMOpenLog = arg_11_2
	ZProj.AudioManager.Instance.gmOpenLog = arg_11_2

	GMController.instance:setShowAudioLog(arg_11_2)
end

function var_0_0._onLangDropChange(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.langList[arg_12_1 + 1]

	if var_12_0 == arg_12_0.curLang then
		return
	end

	arg_12_0.curLang = var_12_0

	arg_12_0:stopPlayingID()
	arg_12_0:initAudioEditorTool()
	arg_12_0.audioTool:SetLanguage(arg_12_0.curLang)
end

function var_0_0._onClickSetRtpc(arg_13_0)
	local var_13_0 = arg_13_0._inpRtpcName:GetText()
	local var_13_1 = arg_13_0._inpRtpcValue:GetText()

	if string.nilorempty(var_13_0) then
		return
	end

	if string.nilorempty(var_13_1) then
		return
	end

	local var_13_2 = tonumber(var_13_1)

	if not var_13_2 then
		return
	end

	arg_13_0:initAudioEditorTool()
	arg_13_0.audioTool:SetRtpc(var_13_0, var_13_2)
end

function var_0_0._onClickSwitch(arg_14_0)
	local var_14_0 = arg_14_0._inpSwitchName:GetText()
	local var_14_1 = arg_14_0._inpSwitchValue:GetText()

	if string.nilorempty(var_14_0) then
		return
	end

	if string.nilorempty(var_14_1) then
		return
	end

	arg_14_0:initAudioEditorTool()
	arg_14_0.audioTool:SetSwitch(var_14_0, var_14_1)
end

function var_0_0.stopPlayingID(arg_15_0)
	AudioMgr.instance:stopPlayingID(arg_15_0.prePlayingId)
end

function var_0_0.initAudioEditorTool(arg_16_0)
	if not arg_16_0.audioTool then
		arg_16_0.audioTool = ZProj.AudioEditorTool.Instance
	end
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:stopPlayingID()
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.audioTool = nil
end

return var_0_0
