module("modules.logic.gm.view.GMAudioBankViewItem", package.seeall)

slot0 = class("GMAudioBankViewItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._guideCO = nil
	slot0._txtAudioId = gohelper.findChildText(slot1, "txtAudioID")
	slot0._txtEventName = gohelper.findChildText(slot1, "txtEventName")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot1, "btnShow")

	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._audioCO = slot1
	slot0._configId = slot1.id
	slot0._txtAudioId.text = slot0._configId
	slot0._txtEventName.text = slot0._audioCO.eventName
end

function slot0._onClickShow(slot0)
	AudioMgr.instance:trigger(3000031)
	AudioMgr.instance:trigger(slot0._configId)
end

function slot0.onDestroy(slot0)
	slot0._btnShow:RemoveClickListener()
end

return slot0
