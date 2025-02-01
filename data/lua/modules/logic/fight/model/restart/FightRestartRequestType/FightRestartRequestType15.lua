module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType15", package.seeall)

slot0 = class("FightRestartRequestType15", FightRestartRequestType1)

function slot0.requestFight(slot0)
	slot3 = Activity104Model.instance:getCurSeasonId()
	slot4 = Activity104Model.instance:getBattleFinishLayer()

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.SeasonRetail then
		slot4 = 0
	end

	slot5 = FightModel.instance:getFightParam()

	Activity104Rpc.instance:sendStartAct104BattleRequest({
		isRestart = true,
		chapterId = slot5.chapterId,
		episodeId = slot1,
		fightParam = slot5,
		multiplication = slot5.multiplication
	}, slot3, slot4, slot1, slot0.enterFightAgainRpcCallback, slot0)
end

function slot0.enterFightAgainRpcCallback(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end

	slot0._fight_work:onDone(true)
end

return slot0
