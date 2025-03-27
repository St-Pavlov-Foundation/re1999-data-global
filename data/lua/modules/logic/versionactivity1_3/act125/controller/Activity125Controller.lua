module("modules.logic.versionactivity1_3.act125.controller.Activity125Controller", package.seeall)

slot0 = class("Activity125Controller", BaseController)

function slot0.getAct125InfoFromServer(slot0, slot1)
	if ActivityModel.instance:isActOnLine(slot1 or ActivityEnum.Activity.VersionActivity1_3Radio) and ActivityModel.instance:getRemainTimeSec(slot1) and slot2 > 0 then
		Activity125Rpc.instance:sendGetAct125InfosRequest(slot1)
	end
end

function slot0.onFinishActEpisode(slot0, slot1, slot2, slot3)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(slot1, slot2, slot3)
end

function slot0.isActFirstEnterToday(slot0, slot1)
	return PlayerPrefsHelper.getString(string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, slot1, PlayerModel.instance:getPlayinfo().userId)) ~= TimeUtil.timestampToString1(ServerTime.now() - 18000)
end

function slot0.saveEnterActDateInfo(slot0, slot1)
	PlayerPrefsHelper.setString(string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, slot1, PlayerModel.instance:getPlayinfo().userId), TimeUtil.timestampToString1(ServerTime.now() - 18000))
end

function slot0.checkActRed(slot0, slot1)
	return not Activity125Model.instance:isAllEpisodeFinish(slot1) and (slot0:isActFirstEnterToday(slot1) or Activity125Model.instance:isHasEpisodeCanReceiveReward(slot1))
end

function slot0.checkActRed1(slot0, slot1)
	return Activity125Model.instance:hasEpisodeCanCheck(slot1) or Activity125Model.instance:hasEpisodeCanGetReward(slot1)
end

function slot0.checkActRed2(slot0, slot1)
	return Activity125Model.instance:hasRedDot(slot1)
end

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity125
	}, slot1, slot2)
end

function slot0.sendFinishAllTaskRequest(slot0, slot1, slot2, slot3)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity125, nil, , slot2, slot3, slot1)
end

slot1 = PlayerEnum.SimpleProperty.V2a4_WarmUp_sum_help_npc

function slot0.set_V2a4_WarmUp_sum_help_npc(slot0, slot1)
	slot2 = tostring(slot1 or 0)

	PlayerModel.instance:forceSetSimpleProperty(uv0, slot2)
	PlayerRpc.instance:sendSetSimplePropertyRequest(uv0, slot2)
end

function slot0.get_V2a4_WarmUp_sum_help_npc(slot0, slot1)
	return tonumber(PlayerModel.instance:getSimpleProperty(uv0)) or (slot1 or 0)
end

function slot0.checkRed_Task(slot0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity125Task, 0)
end

function slot0.checkActRed3(slot0, slot1)
	if ActivityBeginnerController.instance:checkRedDot(slot1) then
		return true
	end

	if slot0:checkActRed2(slot1) then
		return true
	end

	return slot0:checkRed_Task()
end

slot0.instance = slot0.New()

return slot0
