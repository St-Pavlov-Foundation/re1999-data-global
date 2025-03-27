module("modules.logic.fight.view.indicator.FightIndicatorMgrView", package.seeall)

slot0 = class("FightIndicatorMgrView", BaseView)
slot0.IndicatorId2Behaviour = {
	[FightEnum.IndicatorId.Season] = FightIndicatorView,
	[FightEnum.IndicatorId.FightSucc] = FightSuccIndicator,
	[FightEnum.IndicatorId.Season1_2] = FightIndicatorView,
	[FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips] = V1a4_BossRush_ig_ScoreTips,
	[FightEnum.IndicatorId.Id4140004] = FightIndicatorView4140004,
	[FightEnum.IndicatorId.Act1_6DungeonBoss] = VersionActivity1_6_BossFightIndicatorView,
	[FightEnum.IndicatorId.Id6181] = FightIndicatorView6181,
	[FightEnum.IndicatorId.Id6182] = FightIndicatorView6182,
	[FightEnum.IndicatorId.Id6201] = FightIndicatorView6201,
	[FightEnum.IndicatorId.Id6202] = FightIndicatorView6202
}

function slot0.onInitView(slot0)
	slot0.indicatorId2View = {}
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, slot0.onIndicatorChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnIndicatorChange, slot0.onIndicatorChange, slot0)
end

function slot0.checkNeedInitFightSuccIndicator(slot0)
	slot1 = 8
	slot3 = FightModel.instance:getFightParam() and slot2.episodeId
	slot4 = slot3 and DungeonConfig.instance:getEpisodeCO(slot3)
	slot5 = slot3 and DungeonConfig.instance:getEpisodeCondition(slot3)
	slot6 = slot5 and FightStrUtil.instance:getSplitString2Cache(slot5, false, "|", "#")

	if BossRushController.instance:isInBossRushFight() then
		slot0:createBehaviour(FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips, 0)
	elseif VersionActivity1_6DungeonBossModel.instance:isInBossFight() then
		slot0:createBehaviour(FightEnum.IndicatorId.Act1_6DungeonBoss, 0)
	end

	if slot6 then
		for slot10, slot11 in ipairs(slot6) do
			if tonumber(slot11[1]) == slot1 then
				slot0:createBehaviour(tonumber(slot11[2]), tonumber(slot11[3]) or 0)

				return
			end
		end
	end
end

function slot0.onOpen(slot0)
	slot0:checkNeedInitFightSuccIndicator()
end

function slot0.createBehaviour(slot0, slot1, slot2)
	slot4 = nil

	if uv0.IndicatorId2Behaviour[slot1] then
		slot4 = slot3.New()

		slot4:initView(slot0, slot1, slot2)
		slot4:startLoadPrefab()

		slot0.indicatorId2View[slot1] = slot4
	else
		return nil
	end

	return slot4
end

function slot0.onIndicatorChange(slot0, slot1)
	if slot0.indicatorId2View[slot1] or slot0:createBehaviour(slot1) then
		slot2:onIndicatorChange()
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.indicatorId2View) do
		slot5:onDestroy()
	end
end

return slot0
