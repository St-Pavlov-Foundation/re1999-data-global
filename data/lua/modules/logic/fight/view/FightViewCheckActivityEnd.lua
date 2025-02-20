module("modules.logic.fight.view.FightViewCheckActivityEnd", package.seeall)

slot0 = class("FightViewCheckActivityEnd", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.checkIsActivityFight, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.checkIsActivityFight, slot0)
end

function slot0.checkIsActivityFight(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		return
	end

	if not DungeonConfig.instance:getChapterCO(FightModel.instance:getFightParam().chapterId) or slot4.actId ~= slot1 then
		return
	end

	if ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, uv0.yesCallback)
	end
end

function slot0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)

	if FightDataHelper.fieldMgr:isDouQuQu() then
		FightSystem.instance:dispose()
		FightModel.instance:clearRecordMO()
		FightController.instance:exitFightScene()

		return
	end

	FightRpc.instance:sendEndFightRequest(true)
end

return slot0
