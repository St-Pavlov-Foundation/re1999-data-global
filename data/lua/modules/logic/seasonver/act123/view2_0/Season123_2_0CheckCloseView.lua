module("modules.logic.seasonver.act123.view2_0.Season123_2_0CheckCloseView", package.seeall)

slot0 = class("Season123_2_0CheckCloseView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.actId

	if slot0:checkActNotOpen() then
		return
	end

	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.handleReceiveActChanged, slot0)
end

function slot0.onClose(slot0)
end

function slot0.handleReceiveActChanged(slot0)
	slot0:checkActNotOpen()
end

function slot0.checkActNotOpen(slot0)
	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot2:isOpen() or slot2:isExpired() then
		TaskDispatcher.runDelay(slot0.handleNoActDelayClose, slot0, 0.1)

		return true
	end

	return false
end

function slot0.handleNoActDelayClose(slot0)
	slot0:closeThis()
end

return slot0
