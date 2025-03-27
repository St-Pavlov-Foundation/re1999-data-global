module("modules.logic.turnback.view.new.view.TurnbackNewSignInView", package.seeall)

slot0 = class("TurnbackNewSignInView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	TurnbackController.instance:registerCallback(TurnbackEvent.RefreshView, slot0.refreshItem, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.refreshItem, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	TurnbackController.instance:unregisterCallback(TurnbackEvent.RefreshView, slot0.refreshItem, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.refreshItem, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0._editableInitView(slot0)
	slot0._signItems = {}

	for slot4 = 1, 7 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gocontent, "node" .. slot4)
		slot5.cls = MonoHelper.addNoUpdateLuaComOnceToGo(slot5.go, TurnbackNewSignInItem)

		table.insert(slot0._signItems, slot5)
		slot5.cls:initItem(slot4)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_04)
end

function slot0.refreshItem(slot0)
	for slot4, slot5 in ipairs(slot0._signItems) do
		slot5.cls:initItem(slot4)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView and TurnbackModel.instance:getLastGetSigninReward() then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = slot2
		})
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
