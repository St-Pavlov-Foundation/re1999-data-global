module("modules.logic.room.model.layout.RoomLayoutMO", package.seeall)

slot0 = pureTable("RoomLayoutMO")

function slot0.init(slot0, slot1)
	if slot0.id ~= slot1 then
		slot0:clear()
	end

	slot0.id = slot1
end

function slot0.clear(slot0)
	slot0.blockCount = 0
	slot0.coverId = 1
	slot0.name = nil
	slot0.buildingDegree = 0
	slot0.infos = nil
	slot0.buildingInfo = nil
	slot0._isEmpty = nil
	slot0.shareCode = nil
	slot0.useCount = 0
	slot0.roomSkinInfo = {}
end

function slot0.updateInfo(slot0, slot1)
	if slot1.name then
		slot0:setName(slot1.name)
	end

	if slot1.coverId then
		slot0:setCoverId(slot1.coverId)
	end

	if slot1.buildingDegree then
		slot0:setBuildingDegree(slot1.buildingDegree)
	end

	if slot1.blockCount then
		slot0:setBlockCount(slot1.blockCount)
	end

	if slot1.infos then
		slot0:setBlockInfos(slot1.infos)
	end

	if slot1.buildingInfos then
		slot0:setBuildingInfos(slot1.buildingInfos)
	end

	if slot1.shareCode then
		slot0:setShareCode(slot1.shareCode)
	end

	if slot1.useCount then
		slot0:setUseCount(slot1.useCount)
	end

	if slot1.skins then
		slot0:setSkinInfo(slot1.skins)
	end

	if string.nilorempty(slot0.name) then
		slot0:setName(formatLuaLang("room_layoutplan_default_name", ""))
	end
end

function slot0.setBlockCount(slot0, slot1)
	slot0.blockCount = slot1 or 0
end

function slot0.setBuildingDegree(slot0, slot1)
	slot0.buildingDegree = slot1 or 0
end

function slot0.setName(slot0, slot1)
	slot0.name = slot1
end

function slot0.setCoverId(slot0, slot1)
	slot0.coverId = slot1 or 1
end

function slot0.setBlockInfos(slot0, slot1)
	slot0.infos = slot1 or {}
end

function slot0.setBuildingInfos(slot0, slot1)
	slot0.buildingInfos = slot1 or {}
end

function slot0.setEmpty(slot0, slot1)
	slot0._isEmpty = slot1
end

function slot0.setShareCode(slot0, slot1)
	slot0.shareCode = slot1
end

function slot0.setUseCount(slot0, slot1)
	slot0.useCount = slot1
end

function slot0.setSkinInfo(slot0, slot1)
	slot0.skinInfo = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0.skinInfo[slot6.id] = slot6.skinId
	end
end

function slot0.isSharing(slot0)
	if string.nilorempty(slot0.shareCode) then
		return false
	end

	return true
end

function slot0.getShareCode(slot0)
	return slot0.shareCode
end

function slot0.getUseCount(slot0)
	return slot0.useCount or 0
end

function slot0.isHasBlockBuildingInfo(slot0)
	if slot0.infos == nil or slot0.buildingInfos == nil then
		return false
	end

	if #slot0.infos ~= slot0.blockCount then
		return false
	end

	return true
end

function slot0.getName(slot0)
	return slot0.name
end

function slot0.getCoverResPath(slot0)
	if RoomConfig.instance:getPlanCoverConfig(slot0.coverId) then
		return slot1.coverResPath
	end

	return nil
end

function slot0.getCoverId(slot0)
	return slot0.coverId
end

function slot0.isUse(slot0)
	return slot0.id == 0
end

function slot0.isEmpty(slot0)
	if slot0.id == 0 then
		return false
	end

	if slot0._isEmpty ~= nil then
		return slot0._isEmpty
	end

	return slot0.blockCount <= 0
end

function slot0.haveEdited(slot0)
	slot1 = false

	if slot0.blockCount then
		slot1 = slot0.blockCount > 0
	end

	return slot1
end

return slot0
