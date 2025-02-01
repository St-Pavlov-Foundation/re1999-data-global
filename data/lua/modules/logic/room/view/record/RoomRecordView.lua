module("modules.logic.room.view.record.RoomRecordView", package.seeall)

slot0 = class("RoomRecordView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.SwitchRecordView, slot0.switchTabView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(RoomController.instance, RoomEvent.SwitchRecordView, slot0.switchTabView, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
	CritterRpc.instance:sendGetCritterBookInfoRequest()
	RoomRpc.instance:sendGetRoomLogRequest()
end

function slot0.switchTabView(slot0, slot1)
	slot0._switchView = slot1.view

	if not slot1.animName then
		return
	end

	slot0._animator.enabled = true

	slot0._animator:Play(slot2, 0, 0)
	TaskDispatcher.runDelay(slot0.switchTabViewAfterAnim, slot0, RoomRecordEnum.AnimTime)
end

function slot0.switchTabViewAfterAnim(slot0)
	TaskDispatcher.cancelTask(slot0.switchTabViewAfterAnim, slot0)

	if not slot0._switchView then
		return
	end

	if slot0._switchView == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(slot0._reallySwitchTabView, slot0)
	else
		slot0:_reallySwitchTabView()
	end
end

function slot0._reallySwitchTabView(slot0)
	slot0.viewContainer:selectTabView(slot0._switchView)

	slot0._switchView = nil
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.switchTabViewAfterAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
