module("modules.logic.versionactivity1_5.aizila.model.AiZiLaStoryListModel", package.seeall)

slot0 = class("AiZiLaStoryListModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot4 = {}
	slot0._episodeId = slot2

	if AiZiLaConfig.instance:getStoryList(slot1) then
		for slot8, slot9 in ipairs(slot3) do
			if AiZiLaEnum.AllStoryEpisodeId == slot2 or slot9.episodeId == slot2 then
				slot10 = AiZiLaStoryMO.New()

				slot10:init(slot8, slot9)
				table.insert(slot4, slot10)
			end
		end
	end

	if #slot4 > 1 then
		table.sort(slot4, uv0.sortMO)
	end

	for slot8, slot9 in ipairs(slot4) do
		slot9.index = slot8
	end

	slot0:setList(slot4)
end

function slot0.sortMO(slot0, slot1)
	if slot0.config.order ~= slot1.config.order then
		return slot2 < slot3
	end
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

slot0.instance = slot0.New()

return slot0
