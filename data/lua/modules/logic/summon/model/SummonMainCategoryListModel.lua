module("modules.logic.summon.model.SummonMainCategoryListModel", package.seeall)

slot0 = class("SummonMainCategoryListModel", ListScrollModel)

function slot0.initCategory(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(SummonMainModel.getValidPools()) do
		table.insert(slot1, slot0:createMO(slot7, slot6))
	end

	slot0:setList(slot1)
end

function slot0.createMO(slot0, slot1, slot2)
	return {
		originConf = slot1,
		index = slot2
	}
end

function slot0.saveEnterTime(slot0)
	slot0._enterTime = Time.realtimeSinceStartup
end

function slot0.canPlayEnterAnim(slot0)
	if Time.realtimeSinceStartup - slot0._enterTime < 0.334 then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
