module("modules.logic.seasonver.act166.model.Season166TeachModel", package.seeall)

slot0 = class("Season166TeachModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:cleanData()
end

function slot0.cleanData(slot0)
	slot0.curTeachId = 0
	slot0.curTeachConfig = nil
	slot0.curEpisodeId = nil
end

function slot0.initTeachData(slot0, slot1, slot2)
	slot0.actId = slot1
	slot0.curTeachId = slot2
	slot0.curTeachConfig = Season166Config.instance:getSeasonTeachCos(slot2)
	slot0.curEpisodeId = slot0.curBaseSpotConfig and slot0.curBaseSpotConfig.episodeId
end

function slot0.checkIsAllTeachFinish(slot0, slot1)
	slot4 = true

	for slot8, slot9 in ipairs(Season166Config.instance:getAllSeasonTeachCos()) do
		if not Season166Model.instance:getActInfo(slot1).teachInfoMap[slot9.teachId] or slot10.passCount == 0 then
			slot4 = false

			break
		end
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
