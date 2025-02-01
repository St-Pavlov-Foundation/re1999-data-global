module("modules.logic.battlepass.view.BPSPFaceView", package.seeall)

slot0 = class("BPSPFaceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnSkin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skin")
	slot0._btnGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_get")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnSkin:AddClickListener(slot0._openSkinPreview, slot0)
	slot0._btnGet:AddClickListener(slot0._openSpView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnSkin:RemoveClickListener()
	slot0._btnGet:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_youyu_liuxing_give)
end

function slot0._openSkinPreview(slot0)
	ViewMgr.instance:openView(ViewName.BpBonusSelectView)
end

function slot0._openSpView(slot0)
	BpModel.instance.firstShowSp = false

	BpRpc.instance:sendBpMarkFirstShowRequest(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onViewClose, slot0)
	BpController.instance:openBattlePassView(true, {
		isFirst = true
	})
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.BpSPView then
		slot0:closeThis()
	end
end

return slot0
