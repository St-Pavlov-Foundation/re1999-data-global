module("modules.logic.gm.view.GMAudioTool", package.seeall)

slot0 = class("GMAudioTool", BaseView)

function slot0.onInitView(slot0)
	slot0._inpAudio = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/playAudioById/inpAudioId")
	slot0._btnAudioPlay = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/playAudioById/btnPlay"))
	slot0._btnAudioStop = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/playAudioById/btnStop"))
	slot0._autoStopToggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/audioTool/autoStopAudioToggle")
	slot0._showLogToggle = gohelper.findChildToggle(slot0.viewGO, "viewport/content/audioTool/showLogToggle")
	slot0._inpEvent = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/playAudioByEventName/inpAudioEventName")
	slot0._inpBank = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/playAudioByEventName/inpAudioBankName")
	slot0._btnPlayEvent = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/playAudioByEventName/btnPlay"))
	slot0._btnStopEvent = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/playAudioByEventName/btnStop"))
	slot0._langDrop = gohelper.findChildDropdown(slot0.viewGO, "viewport/content/audioLanguage/audioLanguageDropdown")
	slot0._inpRtpcName = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/rtpcItem/inpRtpcName")
	slot0._inpRtpcValue = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/rtpcItem/inpRtpcValue")
	slot0._btnSetRtpc = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/rtpcItem/btnSetRtpc"))
	slot0._inpSwitchName = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/switchItem/inpSwitchGroup")
	slot0._inpSwitchValue = gohelper.findChildTextMeshInputField(slot0.viewGO, "viewport/content/switchItem/inpSwitchValue")
	slot0._btnSwitch = gohelper.getClick(gohelper.findChild(slot0.viewGO, "viewport/content/switchItem/btnSetSwitch"))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnAudioPlay:AddClickListener(slot0._onClickAudioPlay, slot0)
	slot0._btnAudioStop:AddClickListener(slot0._onClickAudioStop, slot0)
	slot0._btnPlayEvent:AddClickListener(slot0._onClickEventPlay, slot0)
	slot0._btnStopEvent:AddClickListener(slot0._onClickEventStop, slot0)
	slot0._btnSetRtpc:AddClickListener(slot0._onClickSetRtpc, slot0)
	slot0._btnSwitch:AddClickListener(slot0._onClickSwitch, slot0)
	slot0._autoStopToggle:AddOnValueChanged(slot0._onAutoStopChange, slot0)
	slot0._showLogToggle:AddOnValueChanged(slot0._onShowLogChange, slot0)
	slot0._langDrop:AddOnValueChanged(slot0._onLangDropChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAudioPlay:RemoveClickListener()
	slot0._btnAudioStop:RemoveClickListener()
	slot0._btnPlayEvent:RemoveClickListener()
	slot0._btnStopEvent:RemoveClickListener()
	slot0._btnSetRtpc:RemoveClickListener()
	slot0._btnSwitch:RemoveClickListener()
	slot0._autoStopToggle:RemoveOnValueChanged()
	slot0._showLogToggle:RemoveOnValueChanged()
	slot0._langDrop:RemoveOnValueChanged()
end

function slot0.initLangDrop(slot0)
	slot0.langList = {}
	slot3 = 0

	for slot7 = 0, GameConfig:GetSupportedVoiceShortcuts().Length - 1 do
		slot8 = slot1[slot7]

		table.insert(slot0.langList, slot8)

		if slot8 == slot0.curLang then
			slot3 = slot7
		end
	end

	slot0._langDrop:ClearOptions()
	slot0._langDrop:AddOptions(slot0.langList)
	slot0._langDrop:SetValue(slot3)
end

function slot0._editableInitView(slot0)
	slot0.autoStopPrePlayingId = true
	slot0.prePlayingId = 0
	slot0.curLang = GameConfig:GetCurVoiceShortcut()
	slot0._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	slot0._autoStopToggle.isOn = slot0.autoStopPrePlayingId

	slot0:initLangDrop()
end

function slot0._onClickAudioPlay(slot0)
	if not string.nilorempty(slot0._inpAudio:GetText()) and tonumber(slot1) then
		if slot0.autoStopPrePlayingId then
			slot0:stopPlayingID()
		end

		slot0.prePlayingId = AudioMgr.instance:trigger(slot2) or 0
	end
end

function slot0._onClickAudioStop(slot0)
	slot0:stopPlayingID()
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

function slot0.stopPlayingID(slot0)
	AudioMgr.instance:stopPlayingID(slot0.prePlayingId)
end

function slot0.initAudioEditorTool(slot0)
	if not slot0.audioTool then
		slot0.audioTool = ZProj.AudioEditorTool.Instance
	end
end

function slot0.onClose(slot0)
	slot0:stopPlayingID()
end

function slot0.onDestroyView(slot0)
	slot0.audioTool = nil
end

return slot0
