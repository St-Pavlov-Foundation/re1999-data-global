module("modules.logic.versionactivity1_6.v1a6_warmup.controller.Activity156Controller", package.seeall)

slot0 = class("Activity156Controller", BaseController)

function slot0.getAct125InfoFromServer(slot0, slot1)
	Activity156Rpc.instance:sendGetAct125InfosRequest(slot1 or ActivityEnum.Activity.Activity1_6WarmUp)
end

function slot0.onFinishActEpisode(slot0, slot1, slot2, slot3)
	Activity156Rpc.instance:sendFinishAct125EpisodeRequest(slot1, slot2, slot3)
end

slot1 = PlayerPrefsKey.FirstEnterAct125Today .. "#" .. ActivityEnum.Activity.Activity1_6WarmUp .. "#"

function slot0.isActFirstEnterToday(slot0)
	slot3 = os.date("*t", ServerTime.nowInLocal())

	if PlayerPrefsHelper.hasKey(uv0 .. tostring(PlayerModel.instance:getPlayinfo().userId)) then
		slot3.hour = 5
		slot3.min = 0
		slot3.sec = 0
		slot5 = os.time(slot3)

		if tonumber(PlayerPrefsHelper.getString(slot1, slot2)) and TimeUtil.getDiffDay(slot2, slot4) < 1 and (slot2 - slot5) * (slot4 - slot5) > 0 then
			return false
		end
	end

	return true
end

function slot0.saveEnterActDateInfo(slot0)
	PlayerPrefsHelper.setString(uv0 .. tostring(PlayerModel.instance:getPlayinfo().userId), tostring(ServerTime.nowInLocal()))
end

function slot0.setCurSelectedEpisode(slot0, slot1, slot2)
	if slot1 ~= Activity156Model.instance:getCurSelectedEpisode() then
		if Activity156Model.instance:isEpisodeUnLock(slot1) then
			Activity156Model.instance:setCurSelectedEpisode(slot1)

			if not slot2 then
				slot0:notifyUpdateView()
			end
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function slot0.tryReceiveEpisodeRewards(slot0, slot1)
	if not Activity156Model.instance:isEpisodeHasReceivedReward(Activity156Model.instance:getCurSelectedEpisode()) then
		Activity156Rpc.instance:sendFinishAct125EpisodeRequest(slot1 or ActivityEnum.Activity.Activity1_6WarmUp, slot2)
	end
end

function slot0.notifyUpdateView(slot0)
	uv0.instance:dispatchEvent(Activity156Event.DataUpdate)
end

slot0.instance = slot0.New()

return slot0
