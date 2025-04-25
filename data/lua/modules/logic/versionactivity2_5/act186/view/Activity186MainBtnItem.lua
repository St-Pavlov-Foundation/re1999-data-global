module("modules.logic.versionactivity2_5.act186.view.Activity186MainBtnItem", package.seeall)

slot0 = class("Activity186MainBtnItem", ActCenterItemBase)

function slot0.onAddEvent(slot0)
	gohelper.addUIClickAudio(slot0._btnitem)
	Activity186Controller.instance:registerCallback(Activity186Event.RefreshRed, slot0.refreshDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, slot0.refreshDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, slot0.refreshDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshDot, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, slot0.refreshDot, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshDot, slot0)
end

function slot0.onRemoveEvent(slot0)
	Activity186Controller.instance:unregisterCallback(Activity186Event.RefreshRed, slot0.refreshDot, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, slot0.refreshDot, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, slot0.refreshDot, slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0.refreshDot, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, slot0.refreshDot, slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshDot, slot0)
end

function slot0.onClick(slot0)
	Activity186Rpc.instance:sendGetAct186InfoRequest(slot0:onGetActId(), slot0._onReceiveGetInfosReply, slot0)
end

function slot0._onReceiveGetInfosReply(slot0, slot1, slot2)
	if slot2 == 0 then
		slot3, slot4 = slot0:onGetViewNameAndParam()

		ViewMgr.instance:openView(slot3, slot4)
	end
end

function slot0.refreshData(slot0)
	slot0:setCustomData({
		viewName = "Activity186View",
		viewParam = {
			actId = Activity186Model.instance:getActId()
		}
	})
end

function slot0.onOpen(slot0)
	slot0:refreshData()
	slot0:_addNotEventRedDot(slot0._checkRed, slot0)
end

function slot0._checkRed(slot0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a5_Act186, 0) then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	if Activity186Model.instance:getById(Activity186Model.instance:getActId()) and slot2:isCanShowAvgBtn() then
		return true
	end

	return false
end

function slot0.onRefresh(slot0)
	slot0:refreshData()

	slot3 = ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_6" or "icon_6"

	if not slot1 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot8, slot9 in ipairs(slot4.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot9) then
				gohelper.setActive(slot10, slot1)
			end
		end
	end

	slot0:_setMainSprite(slot3)
end

function slot0.onGetViewNameAndParam(slot0)
	slot1 = slot0:getCustomData()

	return slot1.viewName, slot1.viewParam
end

function slot0.onGetActId(slot0)
	return slot0:getCustomData().viewParam.actId
end

function slot0.refreshDot(slot0)
	slot0:_refreshRedDot()
end

return slot0
