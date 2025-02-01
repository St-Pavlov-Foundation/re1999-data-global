module("modules.logic.scene.view.LoadingHeadsetView", package.seeall)

slot0 = class("LoadingHeadsetView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskDispatcher.runDelay(slot0._onShowFinished, slot0, 4.5)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 4.667)
end

function slot0._onShowFinished(slot0)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitCloseHeadsetView)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onShowFinished, slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
