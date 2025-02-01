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

slot0.instance = slot0.New()

return slot0
