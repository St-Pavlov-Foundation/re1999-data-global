module("modules.logic.guide.controller.action.impl.WaitGuideActionFightEnd", package.seeall)

slot0 = class("WaitGuideActionFightEnd", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if string.find(slot0.actionParam, ",") then
		slot0._episodeIdList = string.splitToNumber(slot0.actionParam, ",")
	else
		slot0._episodeId = tonumber(slot0.actionParam)
	end

	FightController.instance:registerCallback(FightEvent.PushEndFight, slot0._endFight, slot0)
end

function slot0._endFight(slot0)
	if slot0._episodeId then
		if DungeonModel.instance:getEpisodeInfo(slot0._episodeId) and DungeonEnum.StarType.None < slot1.star then
			slot0:onDone(true)
		end
	elseif slot0._episodeIdList then
		for slot4, slot5 in ipairs(slot0._episodeIdList) do
			if DungeonModel.instance:getEpisodeInfo(slot5) and DungeonEnum.StarType.None < slot6.star then
				slot0:onDone(true)
			end
		end
	else
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, slot0._endFight, slot0)
end

return slot0
