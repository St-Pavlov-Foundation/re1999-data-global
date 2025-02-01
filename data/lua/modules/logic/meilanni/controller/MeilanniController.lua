module("modules.logic.meilanni.controller.MeilanniController", package.seeall)

slot0 = class("MeilanniController", BaseController)

function slot0.onInit(slot0)
	slot0._statViewTime = nil
	slot0._statViewCostAP = 0
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._statViewTime = nil
	slot0._statViewCostAP = 0
end

function slot0.activityIsEnd(slot0)
	if not ActivityModel.instance:getActMO(MeilanniEnum.activityId) then
		return false
	end

	return slot1:getRealEndTimeStamp() <= ServerTime.now()
end

function slot0.openMeilanniView(slot0, slot1, slot2)
	if not (slot1 or {}).mapId then
		FightModel.instance:clearBattleId()

		if FightModel.instance:getBattleId() then
			slot1.mapId = MeilanniModel.instance:getMapIdByBattleId(slot3)
		end

		if not slot1.mapId then
			slot1.mapId = MeilanniModel.instance:getCurMapId()
		end
	end

	if slot1.mapId then
		MeilanniModel.instance:setCurMapId(slot1.mapId)
	end

	ViewMgr.instance:openView(ViewName.MeilanniView, slot1, slot2)
	slot0:statStart()
end

function slot0.openMeilanniMainView(slot0, slot1, slot2)
	Activity108Rpc.instance:sendGet108InfosRequest(MeilanniEnum.activityId, function ()
		ViewMgr.instance:openView(ViewName.MeilanniMainView, uv0, uv1)
	end, slot0)
end

function slot0.immediateOpenMeilanniMainView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.MeilanniMainView, slot1, slot2)
end

function slot0.openMeilanniBossInfoView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.MeilanniBossInfoView, slot1, slot2)
end

function slot0.openMeilanniTaskView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.MeilanniTaskView, slot1, slot2)
end

function slot0.openMeilanniEntrustView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.MeilanniEntrustView, slot1, slot2)
end

function slot0.openMeilanniSettlementView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.MeilanniSettlementView, slot1, slot2)
end

function slot0.startBattle(slot0, slot1)
	MeilanniModel.instance:setBattleElementId(slot1)
	Activity108Rpc.instance:sendEnterFightEventRequest(MeilanniEnum.activityId, slot1)
end

function slot0.enterFight(slot0, slot1)
	slot5 = MeilanniEnum.episodeId
	DungeonModel.instance.curLookEpisodeId = slot5

	DungeonFightController.instance:enterMeilanniFight(DungeonConfig.instance:getEpisodeCO(slot5).chapterId, slot5, MeilanniModel.instance:getEventInfo(MeilanniModel.instance:getCurMapId(), slot1):getBattleId())
end

function slot0.getScoreDesc(slot0)
	if slot0 ~= 0 then
		slot1 = nil

		return (slot0 <= 0 or string.format("<#9D1111><b>[</b>%s+%s<b>]</b></color>", luaLang("meilanni_pingfen"), slot0)) and string.format("<#4E7656><b>[</b>%s%s<b>]</b></color>", luaLang("meilanni_pingfen"), slot0)
	end
end

function slot0.statStart(slot0)
	if slot0._statViewTime then
		return
	end

	if not MeilanniModel.instance:getMapInfo(MeilanniModel.instance:getCurMapId()) then
		return
	end

	slot0._statViewCostAP = slot2:getTotalCostAP()
	slot0._statViewTime = ServerTime.now()
end

function slot0.statEnd(slot0, slot1)
	if not slot0._statViewTime then
		return
	end

	slot2 = ServerTime.now() - slot0._statViewTime

	if not MeilanniModel.instance:getMapInfo(MeilanniModel.instance:getCurMapId()) then
		return
	end

	slot6 = slot4:getTotalCostAP()
	slot0._statViewTime = nil

	StatController.instance:track(StatEnum.EventName.ExitMeilanniActivity, {
		[StatEnum.EventProperties.UseTime] = slot2,
		[StatEnum.EventProperties.MapId] = tostring(slot3),
		[StatEnum.EventProperties.ChallengesNum] = slot4.totalCount,
		[StatEnum.EventProperties.ActionPoint] = slot6,
		[StatEnum.EventProperties.IncrementActionPoint] = math.max(0, slot6 - slot0._statViewCostAP),
		[StatEnum.EventProperties.Score] = slot4.score,
		[StatEnum.EventProperties.Result] = slot1 or StatEnum.Result.None
	})
end

slot0.instance = slot0.New()

return slot0
