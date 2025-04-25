module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentView", package.seeall)

slot0 = class("V2a5DecalogPresentView", V1a9DecalogPresentView)

function slot0._editableInitView(slot0)
	slot0.btnMask = gohelper.findChildButton(slot0.viewGO, "Mask")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0.btnMask:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0.btnMask:RemoveClickListener()
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = ActivityModel.instance:getActMO(DecalogPresentModel.instance:getDecalogPresentActId()):getRemainTimeStr3(false, true)
end

function slot0.onOpen(slot0)
	slot0:refreshReceiveStatus()
	slot0:refreshRemainTime()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_1)
end

return slot0
