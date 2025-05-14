module("modules.logic.room.model.common.RoomSkinModel", package.seeall)

local var_0_0 = class("RoomSkinModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	arg_3_0:_clearData()
	var_0_0.super.clear(arg_3_0)
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._isInitSkinMoList = false
	arg_4_0._otherPlayerRoomSkinDict = nil

	arg_4_0:setIsShowRoomSkinList(false)
end

function var_0_0.initSkinMoList(arg_5_0)
	local var_5_0 = RoomConfig.instance:getAllSkinIdList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if not arg_5_0:getById(iter_5_1) then
			local var_5_1 = RoomSkinMO.New()

			var_5_1:init(iter_5_1)
			arg_5_0:addAtLast(var_5_1)
		end
	end

	arg_5_0._isInitSkinMoList = true
end

function var_0_0.updateRoomSkinInfo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			arg_6_0:setRoomSkinEquipped(iter_6_1.id, iter_6_1.skinId)

			var_6_0[iter_6_1.id] = true
		end
	end

	if arg_6_2 then
		for iter_6_2, iter_6_3 in pairs(RoomInitBuildingEnum.InitBuildingId) do
			if not var_6_0[iter_6_3] then
				arg_6_0:setRoomSkinEquipped(iter_6_3, RoomInitBuildingEnum.InitRoomSkinId[iter_6_3])
			end
		end
	end
end

function var_0_0.setRoomSkinEquipped(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 or not arg_7_2 then
		return
	end

	local var_7_0 = arg_7_0:getRoomSkinMO(arg_7_2, true)

	if not var_7_0 then
		return
	end

	local var_7_1 = arg_7_0:getEquipRoomSkin(arg_7_1)
	local var_7_2 = var_7_1 and arg_7_0:getRoomSkinMO(var_7_1, true)

	if var_7_2 then
		var_7_2:setIsEquipped(false)
	end

	var_7_0:setIsEquipped(true)
end

function var_0_0.setIsShowRoomSkinList(arg_8_0, arg_8_1)
	arg_8_0._isShowRoomSkinList = arg_8_1
end

function var_0_0.setOtherPlayerRoomSkinDict(arg_9_0, arg_9_1)
	arg_9_0._otherPlayerRoomSkinDict = {}

	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0._otherPlayerRoomSkinDict[iter_9_1.id] = iter_9_1.skinId
	end
end

function var_0_0.getRoomSkinMO(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._isInitSkinMoList then
		arg_10_0:initSkinMoList()
	end

	local var_10_0 = arg_10_1 and arg_10_0:getById(arg_10_1)

	if not var_10_0 and arg_10_2 then
		logError(string.format("RoomSkinModel:getRoomSkinMO error, skinMO is nil, skinId:%s", arg_10_1))
	end

	return var_10_0
end

function var_0_0.getIsShowRoomSkinList(arg_11_0)
	return arg_11_0._isShowRoomSkinList
end

function var_0_0.getShowSkin(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0

	if RoomController.instance:isVisitMode() then
		local var_12_1 = arg_12_0:getOtherPlayerRoomSkinDict()

		var_12_0 = var_12_1 and var_12_1[arg_12_1]

		if not var_12_0 or var_12_0 == 0 then
			var_12_0 = RoomInitBuildingEnum.InitRoomSkinId[arg_12_1]
		end
	else
		local var_12_2 = RoomSkinListModel.instance:getCurPreviewSkinId()
		local var_12_3 = var_12_2 and RoomConfig.instance:getBelongPart(var_12_2)

		if var_12_3 and var_12_3 == arg_12_1 then
			var_12_0 = var_12_2
		else
			var_12_0 = arg_12_0:getEquipRoomSkin(arg_12_1)
		end
	end

	if not var_12_0 then
		logError(string.format("RoomSkinModel:getShowSkin error, show skin is nil, partId:%s", arg_12_1))

		var_12_0 = RoomInitBuildingEnum.InitRoomSkinId[arg_12_1]
	end

	return var_12_0
end

function var_0_0.getEquipRoomSkin(arg_13_0, arg_13_1)
	local var_13_0

	if not arg_13_1 then
		return var_13_0
	end

	local var_13_1 = RoomConfig.instance:getSkinIdList(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if arg_13_0:isEquipRoomSkin(iter_13_1) then
			var_13_0 = iter_13_1

			break
		end
	end

	return var_13_0
end

function var_0_0.isUnlockRoomSkin(arg_14_0, arg_14_1)
	local var_14_0 = false

	if not arg_14_1 then
		return var_14_0
	end

	local var_14_1 = arg_14_0:getRoomSkinMO(arg_14_1)

	return var_14_1 and var_14_1:isUnlock()
end

function var_0_0.isNewRoomSkin(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return false
	end

	return (RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomNewSkinItem, arg_15_1))
end

function var_0_0.isHasNewRoomSkin(arg_16_0, arg_16_1)
	local var_16_0 = false

	if not arg_16_1 then
		return var_16_0
	end

	local var_16_1 = RoomConfig.instance:getSkinIdList(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if arg_16_0:isNewRoomSkin(iter_16_1) then
			var_16_0 = true

			break
		end
	end

	return var_16_0
end

function var_0_0.isEquipRoomSkin(arg_17_0, arg_17_1)
	local var_17_0 = false
	local var_17_1 = arg_17_0:getRoomSkinMO(arg_17_1, true)

	if var_17_1 then
		var_17_0 = var_17_1:isEquipped()
	end

	return var_17_0
end

function var_0_0.isDefaultRoomSkin(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = false

	if not arg_18_1 or not arg_18_2 then
		return var_18_0
	end

	return arg_18_2 == RoomInitBuildingEnum.InitRoomSkinId[arg_18_1]
end

function var_0_0.getOtherPlayerRoomSkinDict(arg_19_0)
	return arg_19_0._otherPlayerRoomSkinDict
end

var_0_0.instance = var_0_0.New()

return var_0_0
