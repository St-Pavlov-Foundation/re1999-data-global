module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteView", package.seeall)

slot0 = class("FairyLandCompleteView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickClose, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickClose(slot0)
	if slot0.canClose then
		slot0:closeThis()
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_decrypt_succeed)
	TaskDispatcher.runDelay(slot0.setCanClose, slot0, 2)

	slot1 = slot0.viewParam or {}
	slot0.callback = slot1.callback
	slot0.callbackObj = slot1.callbackObj

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_Complete/#go_Shape" .. tostring(slot1.shapeType or 1)), true)
end

function slot0.setCanClose(slot0)
	slot0.canClose = true
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.setCanClose, slot0)

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end
end

return slot0
