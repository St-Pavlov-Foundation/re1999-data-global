module("modules.logic.fight.controller.FightFailRecommendController", package.seeall)

slot0 = class("FightFailRecommendController", BaseController)
slot1 = 2

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._pushEndFight, slot0)
end

function slot0.onClickRecommend(slot0)
	PlayerPrefsHelper.deleteKey(slot0:_getKey())
end

function slot0.needShowRecommend(slot0, slot1)
	if not string.splitToNumber(PlayerPrefsHelper.getString(slot0:_getKey(), ""), "#") or not slot4[1] or slot5 ~= slot1 then
		return false
	end

	slot6 = slot4 and slot4[2]

	return slot6 and uv0 <= slot6
end

function slot0._respBeginFight(slot0)
	slot0._isReplay = FightModel.instance:getFightParam() and slot1.isReplay

	if slot0._isReplay then
		return
	end

	if string.splitToNumber(PlayerPrefsHelper.getString(slot0:_getKey(), ""), "#") and slot5[1] and (slot1 and slot1.episodeId) ~= slot6 then
		PlayerPrefsHelper.deleteKey(slot3)
	end
end

function slot0._pushEndFight(slot0)
	slot0._isReplay = FightModel.instance:getFightParam() and slot1.isReplay

	if slot0._isReplay then
		slot0._isReplay = nil

		return
	end

	slot4 = slot0:_getKey()

	if FightModel.instance:getRecordMO() and slot2.fightResult ~= FightEnum.FightResult.Succ then
		slot5 = nil

		if not (FightModel.instance:getFightParam() and slot6.episodeId) and not (FightModel.instance:getFightReason() and slot7.episodeId) then
			return
		end

		slot10 = slot8 and slot8[2]

		if string.splitToNumber(PlayerPrefsHelper.getString(slot4, ""), "#") and slot8[1] and slot9 == slot5 then
			slot10 = slot10 and slot10 + 1 or 1
		else
			slot9 = slot5
			slot10 = 1
		end

		if slot9 then
			PlayerPrefsHelper.setString(slot4, slot9 .. "#" .. slot10)
		end
	else
		PlayerPrefsHelper.deleteKey(slot4)
	end
end

function slot0._getKey(slot0)
	return PlayerModel.instance:getMyUserId() .. "_" .. PlayerPrefsKey.FightFailEpisode
end

slot0.instance = slot0.New()

return slot0
