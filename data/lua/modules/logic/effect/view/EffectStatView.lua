module("modules.logic.effect.view.EffectStatView", package.seeall)

slot0 = class("EffectStatView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnOpen = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnOpen")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._contentViewGO = gohelper.findChild(slot0.viewGO, "view")

	gohelper.setActive(slot0._btnOpen.gameObject, true)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	gohelper.setActive(slot0._contentViewGO.gameObject, false)
	EffectStatModel.instance:setCameraRootActive()
end

function slot0.addEvents(slot0)
	slot0._btnOpen:AddClickListener(slot0._onClickOpen, slot0)
	slot0._btnClose:AddClickListener(slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnOpen:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0._onClickOpen(slot0)
	gohelper.setActive(slot0._btnOpen.gameObject, false)
	gohelper.setActive(slot0._btnClose.gameObject, true)
	gohelper.setActive(slot0._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.01)
end

function slot0._onClickClose(slot0)
	gohelper.setActive(slot0._btnOpen.gameObject, true)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	gohelper.setActive(slot0._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0._onFrame(slot0)
	EffectStatModel.instance:statistic()
end

return slot0
