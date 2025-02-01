module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType9", package.seeall)

slot0 = class("FightRestartRequestType9", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
	slot0._fightParam = slot2
	slot0._episode_config = slot3
	slot0._chapter_config = slot4
end

function slot0.requestFight(slot0)
	slot0._fight_work:onDone(true)
	WeekwalkRpc.instance:sendBeforeStartWeekwalkBattleRequest(WeekWalkModel.instance:getBattleElementId(), nil, slot0._onReceiveBeforeStartWeekwalkBattleReply, slot0)
end

function slot0._onReceiveBeforeStartWeekwalkBattleReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end

	DungeonFightController.instance:restartStage()
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
