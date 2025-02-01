module("modules.logic.room.model.layout.RoomLayoutModel", package.seeall)

slot0 = class("RoomLayoutModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0._needRpcGetInfo = true
	slot0._visitCopyName = nil
	slot0._isPlayUnLock = nil
	slot0._canUseShareCount = 0
	slot0._canShareCount = 0
	slot0._useCount = 0
end

function slot0.isNeedRpcGet(slot0)
	return slot0._needRpcGetInfo
end

function slot0.clearNeedRpcGet(slot0)
	slot0._needRpcGetInfo = true
end

function slot0.rpcGetFinish(slot0)
	slot0._needRpcGetInfo = false
end

function slot0.setRoomPlanInfoReply(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getById(RoomEnum.LayoutUsedPlanId)

	if slot1.infos then
		for slot8 = 1, #slot4 do
			RoomLayoutMO.New():init(slot4[slot8].id)

			if slot3 and slot9.id == RoomEnum.LayoutUsedPlanId then
				slot10:updateInfo(slot3)
			end

			slot10:updateInfo(slot9)
			slot10:setEmpty(false)
			table.insert(slot2, slot10)
		end
	end

	slot0._useCount = slot1.totalUseCount or 0

	slot0:setList(slot2)
	slot0:setCanUseShareCount(slot1.canUseShareCount)
	slot0:setCanShareCount(slot1.canShareCount)
end

function slot0.getUseCount(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		slot2 = 0 + slot7:getUseCount()
	end

	return math.max(slot0._useCount, slot2)
end

function slot0.setCanShareCount(slot0, slot1)
	slot0._canShareCount = slot1 or 0
end

function slot0.getCanShareCount(slot0)
	return slot0._canShareCount
end

function slot0.setCanUseShareCount(slot0, slot1)
	slot0._canUseShareCount = slot1 or 0
end

function slot0.getCanUseShareCount(slot0)
	return slot0._canUseShareCount
end

function slot0.updateRoomPlanInfoReply(slot0, slot1)
	if not slot0:getById(slot1.id) then
		slot2 = RoomLayoutMO.New()

		slot2:init(slot1.id)
		slot0:addAtLast(slot2)
	end

	slot2:updateInfo(slot1)
	slot2:setEmpty(false)
end

function slot0.setVisitCopyName(slot0, slot1)
	slot0._visitCopyName = slot1
end

function slot0.getVisitCopyName(slot0)
	return slot0._visitCopyName
end

function slot0.getMaxPlanCount(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanMax)
end

slot1 = "room_layoutplan_default_name"

function slot0.findDefaultName(slot0)
	slot3 = ""

	for slot7, slot8 in ipairs(RoomEnum.LayoutPlanDefaultNames) do
		if not slot0:isSameName(formatLuaLang(uv0, slot8)) then
			return slot3
		end
	end

	return slot3 .. math.random(1, 10)
end

function slot0.isSameName(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.name == slot1 then
			return true
		end
	end

	return false
end

function slot0._getPlayUnLockKey(slot0)
	return string.format("RoomLayoutModel_PLAY_UNLOCK_KEY_%s", PlayerModel.instance:getPlayinfo().userId)
end

function slot0.setPlayUnLock(slot0, slot1)
	slot0._isPlayUnLock = slot1 and 1 or 0

	PlayerPrefsHelper.setNumber(slot0:_getPlayUnLockKey(), slot0._isPlayUnLock)
end

function slot0.getPlayUnLock(slot0)
	if slot0._isPlayUnLock == nil then
		slot0._isPlayUnLock = PlayerPrefsHelper.getNumber(slot0:_getPlayUnLockKey(), 0)
	end

	return slot0._isPlayUnLock == 1
end

function slot0.getLayoutCount(slot0)
	if not slot0:getList() then
		return 0
	end

	for slot6, slot7 in ipairs(slot2) do
		if not slot7:isEmpty() then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function slot0.getCurrentUsePlanName(slot0)
	if not slot0:getList() then
		return ""
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6:isUse() then
			return slot6.name
		end
	end

	return ""
end

function slot0.getCurrentPlotBagData(slot0)
	if not slot0:getList() then
		return {}
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6:isUse() then
			return slot0:getPlotBagData(slot6)
		end
	end

	return {}
end

function slot0.getPlotBagData(slot0, slot1)
	slot3, slot4 = RoomLayoutHelper.findBlockInfos(slot1.infos)

	for slot8, slot9 in pairs(slot3) do
		table.insert({}, {
			plot_name = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.BlockPackage, slot8).name,
			plot_num = slot9
		})
	end

	for slot8, slot9 in ipairs(slot4) do
		table.insert(slot2, {
			plot_num = 1,
			plot_name = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.SpecialBlock, slot9).name
		})
	end

	return slot2
end

function slot0.getSharePlanCount(slot0)
	if not slot0:getList() then
		return 0
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7:isSharing() then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
