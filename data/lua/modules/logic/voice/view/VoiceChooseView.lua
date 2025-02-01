module("modules.logic.voice.view.VoiceChooseView", package.seeall)

slot0 = class("VoiceChooseView", BaseView)
slot1 = "BootVoiceDownload"

function slot0.onInitView(slot0)
	slot0._btnConfirm = gohelper.findChildButton(slot0.viewGO, "#btn_confirm")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_leftbg")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_rightbg")

	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.addEvents(slot0)
	slot0._btnConfirm:AddClickListener(slot0._onClickConfirm, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnConfirm:RemoveClickListener()
end

function slot0._onClickConfirm(slot0)
	slot1 = VoiceChooseModel.instance:getChoose()

	PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, slot1)
	logNormal("selectLang = " .. slot1)
	SettingsVoicePackageController.instance:switchVoiceType(slot1, "after_download")
	slot0:closeThis()

	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end
end

function slot0.onOpen(slot0)
	slot0._callback = slot0.viewParam.callback
	slot0._callbackObj = slot0.viewParam.callbackObj

	UpdateBeat:Add(slot0._onFrame, slot0)
end

function slot0.onClose(slot0)
	UpdateBeat:Remove(slot0._onFrame, slot0)
end

function slot0._onFrame(slot0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
