module("modules.logic.explore.model.mo.unit.ExploreMapAreaMO", package.seeall)

slot0 = pureTable("ExploreMapAreaMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1[1]
	slot0._unitData = slot1[2]
	slot0.isCanReset = slot1[3]
	slot0.visible = ExploreModel.instance:isAreaShow(slot0.id)
	slot0.unitList = {}

	for slot5, slot6 in ipairs(slot0._unitData) do
		if ExploreModel.instance:hasInteractInfo(slot6[1]) and ExploreMapModel.instance:createUnitMO(slot6) then
			table.insert(slot0.unitList, slot8)
		end
	end
end

return slot0
