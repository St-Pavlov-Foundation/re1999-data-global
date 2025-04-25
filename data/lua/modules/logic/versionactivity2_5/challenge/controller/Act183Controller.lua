module("modules.logic.versionactivity2_5.challenge.controller.Act183Controller", package.seeall)

slot0 = class("Act183Controller", BaseController)

function slot0.openAct183MainView(slot0, slot1, slot2, slot3)
	if not Act183Model.instance:getActivityId() then
		logError("挑战玩法活动id为空!!!先设置活动id再请求数据")

		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function ()
	end)
	Activity183Rpc.instance:sendAct183GetInfoRequest(slot4, function (slot0, slot1)
		if slot1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183MainView, uv0)

		if uv1 then
			uv1(uv2)
		end
	end)
end

function slot0.openAct183DungeonView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act183DungeonView, slot1)
end

function slot0.openAct183TaskView(slot0, slot1)
	if not Act183Model.instance:isInitDone() and ActivityHelper.getActivityStatus(Act183Model.instance:getActivityId()) == ActivityEnum.ActivityStatus.Normal then
		Activity183Rpc.instance:sendAct183GetInfoRequest(slot2)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity183
	}, function ()
		ViewMgr.instance:openView(ViewName.Act183TaskView, uv0)
	end)
end

function slot0.openAct183BadgeView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act183BadgeView, slot1)
end

function slot0.openAct183ReportView(slot0, slot1)
	Activity183Rpc.instance:sendAct183GetRecordRequest(Act183Model.instance:getActivityId(), function (slot0, slot1)
		if slot1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.Act183ReportView, uv0)
	end)
end

function slot0.openAct183FinishView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act183FinishView, slot1)
end

function slot0.openAct183SettlementView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act183SettlementView, slot1)
end

function slot0.openAct183RepressView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.Act183RepressView, slot1)
end

function slot0.resetGroupEpisode(slot0, slot1, slot2)
	if slot1 and slot1 ~= 0 and slot2 and slot2 ~= 0 then
		slot0:_clearGroupEpisodeRefreshAnimRecord(slot2)
		Activity183Rpc.instance:sendAct183ResetGroupRequest(slot1, slot2)
	end
end

function slot0.updateResetGroupEpisodeInfo(slot0, slot1, slot2)
	Act183Model.instance:getActInfo():updateGroupMo(slot2)
	slot0:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function slot0.resetEpisode(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot0:_clearGroupEpisodeRefreshAnimRecord(Act183Model.instance:getEpisodeMoById(slot2) and slot3:getGroupId())
	Activity183Rpc.instance:sendAct183ResetEpisodeRequest(slot1, slot2)
end

function slot0._clearGroupEpisodeRefreshAnimRecord(slot0, slot1)
	for slot8, slot9 in ipairs(Act183Model.instance:getGroupEpisodeMo(slot1) and slot2:getEpisodeListByPassOrder() or {}) do
		Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(slot9:getEpisodeId(), {})
	end
end

function slot0.updateResetEpisodeInfo(slot0, slot1)
	Act183Model.instance:getActInfo():updateGroupMo(slot1)
	slot0:dispatchEvent(Act183Event.OnUpdateGroupInfo)
end

function slot0.tryChooseRepress(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	Activity183Rpc.instance:sendAct183ChooseRepressRequest(slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.updateChooseRepressInfo(slot0, slot1, slot2)
	if not Act183Model.instance:getActInfo() then
		return
	end

	slot6 = slot3:getGroupEpisodeMo(Act183Config.instance:getEpisodeCo(slot1).groupId):getEpisodeMo(slot1)

	slot6:updateRepressMo(slot2)
	Act183Model.instance:recordLastRepressEpisodeId(slot1)
	uv0.instance:dispatchEvent(Act183Event.OnUpdateRepressInfo, slot1, slot6)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
