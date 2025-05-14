module("modules.logic.room.model.layout.RoomLayoutMO", package.seeall)

local var_0_0 = pureTable("RoomLayoutMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if arg_1_0.id ~= arg_1_1 then
		arg_1_0:clear()
	end

	arg_1_0.id = arg_1_1
end

function var_0_0.clear(arg_2_0)
	arg_2_0.blockCount = 0
	arg_2_0.coverId = 1
	arg_2_0.name = nil
	arg_2_0.buildingDegree = 0
	arg_2_0.infos = nil
	arg_2_0.buildingInfo = nil
	arg_2_0._isEmpty = nil
	arg_2_0.shareCode = nil
	arg_2_0.useCount = 0
	arg_2_0.roomSkinInfo = {}
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	if arg_3_1.name then
		arg_3_0:setName(arg_3_1.name)
	end

	if arg_3_1.coverId then
		arg_3_0:setCoverId(arg_3_1.coverId)
	end

	if arg_3_1.buildingDegree then
		arg_3_0:setBuildingDegree(arg_3_1.buildingDegree)
	end

	if arg_3_1.blockCount then
		arg_3_0:setBlockCount(arg_3_1.blockCount)
	end

	if arg_3_1.infos then
		arg_3_0:setBlockInfos(arg_3_1.infos)
	end

	if arg_3_1.buildingInfos then
		arg_3_0:setBuildingInfos(arg_3_1.buildingInfos)
	end

	if arg_3_1.shareCode then
		arg_3_0:setShareCode(arg_3_1.shareCode)
	end

	if arg_3_1.useCount then
		arg_3_0:setUseCount(arg_3_1.useCount)
	end

	if arg_3_1.skins then
		arg_3_0:setSkinInfo(arg_3_1.skins)
	end

	if string.nilorempty(arg_3_0.name) then
		arg_3_0:setName(formatLuaLang("room_layoutplan_default_name", ""))
	end
end

function var_0_0.setBlockCount(arg_4_0, arg_4_1)
	arg_4_0.blockCount = arg_4_1 or 0
end

function var_0_0.setBuildingDegree(arg_5_0, arg_5_1)
	arg_5_0.buildingDegree = arg_5_1 or 0
end

function var_0_0.setName(arg_6_0, arg_6_1)
	arg_6_0.name = arg_6_1
end

function var_0_0.setCoverId(arg_7_0, arg_7_1)
	arg_7_0.coverId = arg_7_1 or 1
end

function var_0_0.setBlockInfos(arg_8_0, arg_8_1)
	arg_8_0.infos = arg_8_1 or {}
end

function var_0_0.setBuildingInfos(arg_9_0, arg_9_1)
	arg_9_0.buildingInfos = arg_9_1 or {}
end

function var_0_0.setEmpty(arg_10_0, arg_10_1)
	arg_10_0._isEmpty = arg_10_1
end

function var_0_0.setShareCode(arg_11_0, arg_11_1)
	arg_11_0.shareCode = arg_11_1
end

function var_0_0.setUseCount(arg_12_0, arg_12_1)
	arg_12_0.useCount = arg_12_1
end

function var_0_0.setSkinInfo(arg_13_0, arg_13_1)
	arg_13_0.skinInfo = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		arg_13_0.skinInfo[iter_13_1.id] = iter_13_1.skinId
	end
end

function var_0_0.isSharing(arg_14_0)
	if string.nilorempty(arg_14_0.shareCode) then
		return false
	end

	return true
end

function var_0_0.getShareCode(arg_15_0)
	return arg_15_0.shareCode
end

function var_0_0.getUseCount(arg_16_0)
	return arg_16_0.useCount or 0
end

function var_0_0.isHasBlockBuildingInfo(arg_17_0)
	if arg_17_0.infos == nil or arg_17_0.buildingInfos == nil then
		return false
	end

	if #arg_17_0.infos ~= arg_17_0.blockCount then
		return false
	end

	return true
end

function var_0_0.getName(arg_18_0)
	return arg_18_0.name
end

function var_0_0.getCoverResPath(arg_19_0)
	local var_19_0 = RoomConfig.instance:getPlanCoverConfig(arg_19_0.coverId)

	if var_19_0 then
		return var_19_0.coverResPath
	end

	return nil
end

function var_0_0.getCoverId(arg_20_0)
	return arg_20_0.coverId
end

function var_0_0.isUse(arg_21_0)
	return arg_21_0.id == 0
end

function var_0_0.isEmpty(arg_22_0)
	if arg_22_0.id == 0 then
		return false
	end

	if arg_22_0._isEmpty ~= nil then
		return arg_22_0._isEmpty
	end

	return arg_22_0.blockCount <= 0
end

function var_0_0.haveEdited(arg_23_0)
	local var_23_0 = false

	if arg_23_0.blockCount then
		var_23_0 = arg_23_0.blockCount > 0
	end

	return var_23_0
end

return var_0_0
