slot0 = pureTable("Activity104RetailMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.state = 0
	slot0.advancedId = 0
	slot0.star = 0
	slot0.showActivity104EquipIds = {}
	slot0.position = 0
	slot0.advancedRare = 0
	slot0.tag = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.state = slot1.state
	slot0.advancedId = slot1.advancedId
	slot0.star = slot1.star
	slot0.showActivity104EquipIds = slot0:_buildEquipList(slot1.showActivity104EquipIds)
	slot0.position = slot1.position
	slot0.advancedRare = slot1.advancedRare
	slot0.tag = slot1.tag
end

function slot0._buildEquipList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		if SeasonConfig.instance:getSeasonEquipCo(slot0).isOptional ~= SeasonConfig.instance:getSeasonEquipCo(slot1).isOptional then
			return slot3.isOptional < slot2.isOptional
		else
			return slot3.rare < slot2.rare
		end
	end)

	return slot2
end

return slot0
