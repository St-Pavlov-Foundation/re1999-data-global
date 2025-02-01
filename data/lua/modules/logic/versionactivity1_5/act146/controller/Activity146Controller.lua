module("modules.logic.versionactivity1_5.act146.controller.Activity146Controller", package.seeall)

slot0 = class("Activity146Controller", BaseController)

function slot0.getAct146InfoFromServer(slot0, slot1)
	Activity146Rpc.instance:sendGetAct146InfosRequest(slot1 or ActivityEnum.Activity.Activity1_5WarmUp)
end

function slot0.onCloseView(slot0)
	Activity146Model.instance:setCurSelectedEpisode(nil)
end

function slot0.onFinishActEpisode(slot0, slot1)
	Activity146Rpc.instance:sendFinishAct146EpisodeRequest(slot1 or ActivityEnum.Activity.Activity1_5WarmUpId, Activity146Model.instance:getCurSelectedEpisode())
end

function slot0.tryReceiveEpisodeRewards(slot0, slot1)
	Activity146Rpc.instance:sendAct146EpisodeBonusRequest(slot1 or ActivityEnum.Activity.Activity1_5WarmUpId, Activity146Model.instance:getCurSelectedEpisode())
end

slot1 = "Activity146"

function slot0.isActFirstEnterToday(slot0)
	return TimeUtil.getDayFirstLoginRed(uv0)
end

function slot0.saveEnterActDateInfo(slot0)
	TimeUtil.setDayFirstLoginRed(uv0)
end

function slot0.setCurSelectedEpisode(slot0, slot1)
	if slot1 ~= Activity146Model.instance:getCurSelectedEpisode() then
		if Activity146Model.instance:isEpisodeUnLock(slot1) then
			Activity146Model.instance:setCurSelectedEpisode(slot1)
			slot0:notifyUpdateView()
		else
			GameFacade.showToast(ToastEnum.ConditionLock)
		end
	end
end

function slot0.onActModelUpdate(slot0)
	Activity146Model.instance:setCurSelectedEpisode(slot0:computeCurNeedSelectEpisode())
	slot0:notifyUpdateView()
end

function slot0.computeCurNeedSelectEpisode(slot0)
	if Activity146Model.instance:getCurSelectedEpisode() then
		return slot1
	end

	if Activity146Config.instance:getAllEpisodeConfigs(ActivityEnum.Activity.Activity1_5WarmUp) then
		slot4 = nil

		for slot8 = 1, #slot2 do
			slot9 = slot2[slot8].id
			slot10 = Activity146Model.instance:isEpisodeFinishedButUnReceive(slot9)
			slot11 = Activity146Model.instance:isEpisodeUnLockAndUnFinish(slot9)

			if Activity146Model.instance:isEpisodeUnLock(slot9) then
				slot4 = slot9
			end

			if slot10 or slot11 then
				return slot9
			end
		end

		return slot4
	end
end

function slot0.markHasEnterEpisode(slot0)
	Activity146Model.instance:markHasEnterEpisode(Activity146Model.instance:getCurSelectedEpisode())
end

function slot0.notifyUpdateView(slot0)
	uv0.instance:dispatchEvent(Activity146Event.DataUpdate)
end

slot0.instance = slot0.New()

return slot0
