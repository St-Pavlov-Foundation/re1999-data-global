module("modules.logic.critter.model.CritterFilterMO", package.seeall)

slot0 = pureTable("CritterFilterMO")

function slot0.init(slot0, slot1)
	slot0.viewName = slot1

	slot0:reset()
end

function slot0.updateMo(slot0, slot1)
	slot0._isFiltering = false
	slot0.filterCategoryDict = slot1.filterCategoryDict

	for slot5, slot6 in pairs(slot0.filterCategoryDict) do
		if #slot6 > 0 then
			slot0._isFiltering = true
		end
	end
end

function slot0.isPassedFilter(slot0, slot1)
	if not slot1 then
		return false
	end

	return slot0:_checkRace(slot1:getDefineId()) and slot0:_checkSkill(slot1:getSkillInfo())
end

function slot0._checkRace(slot0, slot1)
	return slot0:checkRaceByCatalogueId(CritterConfig.instance:getCritterCatalogue(slot1))
end

function slot0.checkRaceByCatalogueId(slot0, slot1)
	if not slot0.filterCategoryDict[CritterEnum.FilterType.Race] or #slot2 <= 0 then
		return true
	end

	for slot7, slot8 in ipairs(slot2) do
		if slot8 == slot1 or CritterConfig.instance:isHasCatalogueChildId(slot8, slot1) then
			return true
		end
	end

	return false
end

function slot0._checkSkill(slot0, slot1)
	if not slot0.filterCategoryDict[CritterEnum.FilterType.SkillTag] or #slot2 <= 0 then
		return true
	end

	if not slot1 then
		return false
	end

	slot3 = false

	for slot7, slot8 in pairs(slot1) do
		for slot14, slot15 in ipairs(string.splitToNumber(CritterConfig.instance:getCritterTagCfg(slot8) and slot9.filterTag, "#")) do
			if tabletool.indexOf(slot2, slot15) then
				slot3 = true

				break
			end
		end
	end

	return slot3
end

function slot0.isFiltering(slot0)
	return slot0._isFiltering
end

function slot0.isSelectedTag(slot0, slot1, slot2)
	slot3 = false

	if slot0.filterCategoryDict[slot1] and #slot4 > 0 then
		slot3 = tabletool.indexOf(slot4, slot2)
	end

	return slot3
end

function slot0.selectedTag(slot0, slot1, slot2)
	if not slot0.filterCategoryDict[slot1] then
		slot0.filterCategoryDict[slot1] = {}
	end

	table.insert(slot0.filterCategoryDict[slot1], slot2)
end

function slot0.unselectedTag(slot0, slot1, slot2)
	if slot0.filterCategoryDict[slot1] then
		tabletool.removeValue(slot0.filterCategoryDict[slot1], slot2)
	end
end

function slot0.getFilterCategoryDict(slot0)
	return slot0.filterCategoryDict
end

function slot0.clone(slot0)
	slot1 = uv0.New()

	slot1:init(slot0.viewName)

	slot1.filterCategoryDict = LuaUtil.deepCopySimple(slot0.filterCategoryDict)
	slot1._isFiltering = slot0._isFiltering

	return slot1
end

function slot0.reset(slot0)
	slot0.filterCategoryDict = {}
	slot0._isFiltering = false
end

return slot0
