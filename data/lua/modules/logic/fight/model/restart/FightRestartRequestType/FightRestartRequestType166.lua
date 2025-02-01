module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType166", package.seeall)

slot0 = class("FightRestartRequestType166", FightRestartRequestType1)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
	slot0._fightParam = slot2
	slot0._episode_config = slot3
	slot0._chapter_config = slot4
end

function slot0.requestFight(slot0)
	slot1 = FightModel.instance:getFightParam()
	slot2 = Season166Model.instance:getBattleContext()

	Activity166Rpc.instance:sendStartAct166BattleRequest(slot2.actId, slot2.episodeType, Season166HeroGroupModel.instance:getEpisodeConfigId(slot1.episodeId), slot2.talentId, slot1.chapterId, slot1.episodeId, slot1, 1, nil, , true, slot0._onReceiveBeforeStartBattleReply, slot0)
	slot0._fight_work:onDone(true)
end

function slot0._onReceiveBeforeStartBattleReply(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
