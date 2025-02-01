module("modules.logic.ressplit.work.ResSplitSeasonWork", package.seeall)

slot0 = class("ResSplitSeasonWork", BaseWork)

function slot0.onStart(slot0, slot1)
	for slot5, slot6 in pairs(ResSplitModel.instance.includeSeasonDic) do
		slot8 = SeasonConfig.instance:getSeasonRetailCos(slot5)
		slot9 = SeasonConfig.instance:getSeasonSpecialCos(slot5)
		slot10 = {
			[slot15.episodeId] = true
		}

		for slot14, slot15 in pairs(SeasonConfig.instance:getSeasonEpisodeCos(slot5)) do
			ResSplitModel.instance:addIncludeStory(slot15.afterStoryId)
		end

		for slot14, slot15 in pairs(slot8) do
			for slot20, slot21 in pairs(string.splitToNumber(slot15.retailEpisodeIdPool, "#")) do
				slot10[slot21] = true
			end
		end

		for slot14, slot15 in pairs(slot9) do
			slot10[slot15.episodeId] = true
		end

		for slot14, slot15 in pairs(slot10) do
			ResSplitHelper.addEpisodeRes(slot14)
		end

		for slot15, slot16 in ipairs(SeasonConfig.instance:getStoryIds(slot5)) do
			ResSplitModel.instance:addIncludeStory(slot16)
		end
	end

	slot0:onDone(true)
end

return slot0
