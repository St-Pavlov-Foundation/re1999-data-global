module("modules.logic.room.model.map.RoomShowBuildingMO", package.seeall)

slot0 = pureTable("RoomShowBuildingMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id or slot1.uid
	slot0.buildingId = slot1.buildingId or slot1.defineId
	slot0.use = slot1.use
	slot0.uids = slot1.uids or {}
	slot0.levels = slot1.levels or {}
	slot0.config = RoomConfig.instance:getBuildingConfig(slot0.buildingId)
	slot0.level = slot1.level or 0
	slot0.isNeedToBuy = slot1.isNeedToBuy or false
	slot0.isBuyNoCost = slot1.isBuyNoCost or false

	if slot0.config.canLevelUp and RoomConfig.instance:getLevelGroupConfig(slot1.buildingId, slot0.level) then
		slot0.config = RoomHelper.mergeCfg(slot0.config, slot2)
	end
end

function slot0.add(slot0, slot1, slot2)
	if not tabletool.indexOf(slot0.uids, slot1) then
		table.insert(slot0.uids, slot1)
		table.insert(slot0.levels, slot2 or 0)
	end
end

function slot0.removeUId(slot0, slot1)
	if tabletool.indexOf(slot0.uids, slot1) then
		table.remove(slot0.uids, slot2)
		table.remove(slot0.levels, slot2)
	end
end

function slot0.getCount(slot0)
	return slot0.uids and #slot0.uids or 0
end

function slot0.isDecoration(slot0)
	return slot0.config and slot0.config.buildingType == RoomBuildingEnum.BuildingType.Decoration
end

function slot0.getIcon(slot0)
	if slot0.config then
		if slot0.config.canLevelUp and RoomConfig.instance:getLevelGroupConfig(slot0.buildingId, slot0.levels[1]) and not string.nilorempty(slot2.icon) then
			return slot2.icon
		end

		return slot0.config.icon
	end
end

return slot0
