module("modules.logic.explore.map.unit.ExploreCurrencyUnit", package.seeall)

slot0 = class("ExploreCurrencyUnit", ExploreBaseDisplayUnit)

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if slot3:isRole() then
		slot0:tryTrigger()
	end
end

function slot0.processMapIcon(slot0, slot1)
	return string.split(slot1, "#")[tonumber(slot0.mo.specialDatas[1])]
end

return slot0
