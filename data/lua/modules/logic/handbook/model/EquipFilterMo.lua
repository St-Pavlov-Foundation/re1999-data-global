module("modules.logic.handbook.model.EquipFilterMo", package.seeall)

slot0 = pureTable("EquipFilterMo")

function slot0.init(slot0, slot1)
	slot0.viewName = slot1

	slot0:reset()
end

function slot0.reset(slot0)
	slot0.obtainShowType = EquipFilterModel.ObtainEnum.All
	slot0.selectTagList = {}
	slot0.filtering = false
end

function slot0.getObtainType(slot0)
	return slot0.obtainShowType
end

function slot0.checkIsIncludeTag(slot0, slot1)
	if slot0.selectTagList and not next(slot0.selectTagList) then
		return true
	end

	for slot6, slot7 in ipairs(EquipConfig.instance:getTagList(slot1)) do
		if tabletool.indexOf(slot0.selectTagList, slot7) then
			return true
		end
	end

	return false
end

function slot0.updateIsFiltering(slot0)
	slot0.filtering = slot0.obtainShowType ~= EquipFilterModel.ObtainEnum.All or slot0.selectTagList and next(slot0.selectTagList)
end

function slot0.updateMo(slot0, slot1)
	slot0.obtainShowType = slot1.obtainShowType
	slot0.selectTagList = slot1.selectTagList

	slot0:updateIsFiltering()
end

function slot0.isFiltering(slot0)
	return slot0.filtering
end

function slot0.clone(slot0)
	slot1 = uv0.New()

	slot1:init(slot0.viewName)

	slot1.obtainShowType = slot0.obtainShowType
	slot1.selectTagList = tabletool.copy(slot0.selectTagList)
	slot1.filtering = slot0.filtering

	return slot1
end

return slot0
