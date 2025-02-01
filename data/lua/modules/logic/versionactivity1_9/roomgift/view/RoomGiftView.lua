module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftView", package.seeall)

slot0 = class("RoomGiftView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")

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
	if slot0.viewParam.parent then
		gohelper.addChild(slot1, slot0.viewGO)
	end

	slot0:_refreshTimeTick()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, TimeUtil.OneMinuteSecond)
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.RoomGift)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
