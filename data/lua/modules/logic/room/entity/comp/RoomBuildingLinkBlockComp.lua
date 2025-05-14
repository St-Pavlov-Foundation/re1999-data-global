module("modules.logic.room.entity.comp.RoomBuildingLinkBlockComp", package.seeall)

local var_0_0 = class("RoomBuildingLinkBlockComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	local var_2_0 = arg_2_0:getMO()

	arg_2_0._linkBlockDefineIds = string.splitToNumber(var_2_0.config.linkBlock, "#") or {}
	arg_2_0._linkBlockDefineDict = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._linkBlockDefineIds) do
		arg_2_0._linkBlockDefineDict[iter_2_1] = true
	end

	arg_2_0._isLink = arg_2_0:_checkLinkBlock()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.ClientPlaceBlock, arg_3_0._onBlockChange, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.ClientCancelBlock, arg_3_0._onBlockChange, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmBackBlock, arg_3_0._onBlockChange, arg_3_0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, arg_3_0._onBlockChange, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientPlaceBlock, arg_4_0._onBlockChange, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientCancelBlock, arg_4_0._onBlockChange, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmBackBlock, arg_4_0._onBlockChange, arg_4_0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, arg_4_0._onBlockChange, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0._onBlockChange(arg_6_0)
	arg_6_0:refreshLink()
end

function var_0_0.refreshLink(arg_7_0)
	local var_7_0 = arg_7_0:_checkLinkBlock()

	if arg_7_0._isLink ~= var_7_0 then
		arg_7_0._isLink = var_7_0

		arg_7_0:_updateLink()
	end
end

function var_0_0._updateLink(arg_8_0)
	local var_8_0 = arg_8_0.entity.effect:getGameObjectsByName(arg_8_0._effectKey, RoomEnum.EntityChildKey.BuildingLinkBlockGOKey)

	if var_8_0 and #var_8_0 > 0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			gohelper.setActive(iter_8_1, arg_8_0._isLink)
		end
	end
end

function var_0_0._checkLinkBlock(arg_9_0)
	if not arg_9_0._linkBlockDefineIds or #arg_9_0._linkBlockDefineIds < 1 or arg_9_0.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	local var_9_0, var_9_1 = arg_9_0:_getOccupyDict()

	if not var_9_0 then
		return false
	end

	local var_9_2 = RoomMapBlockModel.instance
	local var_9_3 = HexPoint.directions

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		for iter_9_2 = 1, 6 do
			local var_9_4 = var_9_3[iter_9_2]
			local var_9_5 = var_9_4.x + iter_9_1.x
			local var_9_6 = var_9_4.y + iter_9_1.y

			if not var_9_0[var_9_5] or not var_9_0[var_9_5][var_9_6] then
				local var_9_7 = var_9_2:getBlockMO(var_9_5, var_9_6)

				if var_9_7 and var_9_7:isInMapBlock() then
					local var_9_8 = var_9_7:getDefineId()

					if arg_9_0._linkBlockDefineDict[var_9_8] then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0._getOccupyDict(arg_10_0)
	return arg_10_0.entity:getOccupyDict()
end

function var_0_0.getMO(arg_11_0)
	return arg_11_0.entity:getMO()
end

function var_0_0.onEffectRebuild(arg_12_0)
	local var_12_0 = arg_12_0.entity.effect

	if var_12_0:isHasEffectGOByKey(arg_12_0._effectKey) and not var_12_0:isSameResByKey(arg_12_0._effectKey, arg_12_0._effectRes) then
		arg_12_0._effectRes = var_12_0:getEffectRes(arg_12_0._effectKey)

		arg_12_0:_updateLink()
	end
end

return var_0_0
