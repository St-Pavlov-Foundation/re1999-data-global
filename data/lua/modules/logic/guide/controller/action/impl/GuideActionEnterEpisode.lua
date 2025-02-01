module("modules.logic.guide.controller.action.impl.GuideActionEnterEpisode", package.seeall)

slot0 = class("GuideActionEnterEpisode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot4 = slot2[2]

	if slot2[1] and lua_episode.configDict[slot3] then
		if DungeonConfig.instance:getChapterCO(slot5.chapterId).type == DungeonEnum.ChapterType.Newbie then
			DungeonFightController.instance:enterNewbieFight(slot5.chapterId, slot3)
		else
			DungeonFightController.instance:enterFight(slot5.chapterId, slot3, nil)
		end

		if slot4 == 0 then
			FightModel.instance:getFightParam():setShowSettlement(false)
		end

		slot0:onDone(true)
	else
		logError("Guide episode id nil, guide_" .. slot0.guideId .. "_" .. slot0.stepId)
		slot0:onDone(false)
	end
end

return slot0
