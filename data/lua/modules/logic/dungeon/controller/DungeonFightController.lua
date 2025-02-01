module("modules.logic.dungeon.controller.DungeonFightController", package.seeall)

slot0 = class("DungeonFightController", BaseController)

function slot0.onInit(slot0)
	slot0._battleEpisodeType = nil
	slot0._otherBattleReqAction = nil
	slot0._otherBattleObj = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._battleEpisodeType = nil
	slot0._otherBattleReqAction = nil
	slot0._otherBattleObj = nil
end

function slot0.enterNewbieFight(slot0, slot1, slot2)
	slot0:sendStartDungeonRequest(slot1, slot2, FightController.instance:setNewBieFightParamByEpisodeId(slot2))
end

function slot0.enterFightByBattleId(slot0, slot1, slot2, slot3)
	DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)

	slot4 = FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3)

	slot4:setDungeon(slot1, slot2)
	slot4:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.enterWeekwalkFight(slot0, slot1, slot2, slot3)
	DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)

	slot4 = FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3)

	slot4:setDungeon(slot1, slot2)
	slot4:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.enterMeilanniFight(slot0, slot1, slot2, slot3)
	DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)

	slot4 = FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3)

	slot4:setDungeon(slot1, slot2)
	slot4:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.enterSeasonFight(slot0, slot1, slot2)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)

	slot3 = FightController.instance:setFightParamByEpisodeId(slot2)

	slot3:setDungeon(slot1, slot2)
	slot3:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.enterFight(slot0, slot1, slot2, slot3, slot4)
	FightModel.instance:clear()
	DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)

	slot5 = FightController.instance:setFightParamByEpisodeId(slot2)

	slot5:setDungeon(slot1, slot2, slot3)
	slot5:setPreload()
	slot5:setAdventure(slot4)
	FightController.instance:enterFightScene()
end

function slot0.sendStartDungeonRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0._otherBattleReqAction then
		slot0._otherBattleReqAction(slot0._otherBattleObj)
		slot0:setBattleRequestAction(nil, )
	else
		DungeonRpc.instance:sendStartDungeonRequest(slot1, slot2, slot3, slot4, slot5, slot6)
	end
end

function slot0.onReceiveStartDungeonReply(slot0, slot1, slot2)
	FightRpc.instance:onReceiveTestFightReply(slot1, slot2)
end

function slot0.sendEndFightRequest(slot0, slot1)
	DungeonRpc.instance:sendEndDungeonRequest(slot1)
end

function slot0.onReceiveEndDungeonReply(slot0, slot1, slot2)
	FightRpc.instance:onReceiveEndFightReply(slot1, slot2)
end

function slot0.restartStage()
	slot0 = FightModel.instance:getFightParam()
	slot0.chapterId = DungeonConfig.instance:getEpisodeCO(slot0.episodeId).chapterId

	DungeonRpc.instance:sendStartDungeonRequest(slot0.chapterId, slot0.episodeId, slot0, slot0.multiplication, nil, , true)
end

function slot0.restartSpStage()
	slot0 = GameSceneMgr.instance:getCurScene()

	slot0.entityMgr:removeAllUnits()
	slot0.director:registRespBeginFight()
	slot0.bgm:resumeBgm()

	slot1 = FightModel.instance:getFightParam()
	slot1.chapterId = DungeonConfig.instance:getEpisodeCO(slot1.episodeId).chapterId

	uv0.instance:sendStartDungeonRequest(slot1.chapterId, slot1.episodeId, slot1, slot1.multiplication)
end

function slot0.setBattleRequestAction(slot0, slot1, slot2)
	slot0._otherBattleReqAction = slot1
	slot0._otherBattleObj = slot2
end

slot0.instance = slot0.New()

return slot0
