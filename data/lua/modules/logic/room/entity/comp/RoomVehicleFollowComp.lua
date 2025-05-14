module("modules.logic.room.entity.comp.RoomVehicleFollowComp", package.seeall)

local var_0_0 = class("RoomVehicleFollowComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._followerList = {}
	arg_1_0._forwardList = {}
	arg_1_0._backwardList = {}
	arg_1_0._initPosList = {}
	arg_1_0._isForward = true
	arg_1_0._pathData = RoomVehicleFollowPathData.New()
	arg_1_0._isNight = RoomWeatherModel.instance:getIsNight()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.targetTrs = arg_2_0.go.transform

	arg_2_0:_initPathList()
end

function var_0_0._initPathList(arg_3_0)
	arg_3_0._initPosList = {}
	arg_3_0._lookAtPos = nil

	local var_3_0 = arg_3_0.entity:getVehicleMO()

	if not var_3_0 then
		return
	end

	local var_3_1 = {}

	tabletool.addValues(var_3_1, var_3_0:getInitAreaNode())

	if #var_3_1 < 2 then
		return
	end

	table.insert(arg_3_0._initPosList, arg_3_0:_getPostionByNode(var_3_1[1], 0))

	for iter_3_0 = 2, #var_3_1 do
		local var_3_2 = var_3_1[iter_3_0 - 1]
		local var_3_3 = var_3_1[iter_3_0]
		local var_3_4, var_3_5 = arg_3_0:_findConnectDirection(var_3_2, var_3_3)

		if var_3_2 then
			if iter_3_0 == 2 and var_3_5 then
				arg_3_0._lookAtPos = arg_3_0:_getPostionByNode(var_3_2, var_3_5)
			end

			table.insert(arg_3_0._initPosList, arg_3_0:_getPostionByNode(var_3_2, var_3_4 or 0))
		end

		if var_3_3 then
			table.insert(arg_3_0._initPosList, arg_3_0:_getPostionByNode(var_3_3, var_3_5 or 0))

			if iter_3_0 == #var_3_1 and var_3_4 then
				table.insert(arg_3_0._initPosList, arg_3_0:_getPostionByNode(var_3_3, var_3_4 or 0))
			end
		end
	end
end

function var_0_0._findConnectDirection(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.hexPoint.x - arg_4_1.hexPoint.x
	local var_4_1 = arg_4_2.hexPoint.y - arg_4_1.hexPoint.y

	for iter_4_0 = 1, 6 do
		local var_4_2 = HexPoint.directions[iter_4_0]

		if var_4_2.x == var_4_0 and var_4_2.y == var_4_1 then
			local var_4_3 = arg_4_1:getConnectDirection(iter_4_0)

			return iter_4_0, var_4_3
		end
	end
end

function var_0_0._getPostionByNode(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0

	if not arg_5_2 or arg_5_2 == 0 then
		var_5_0 = HexMath.hexToPosition(arg_5_1.hexPoint, RoomBlockEnum.BlockSize)
	else
		var_5_0 = HexMath.resourcePointToPosition(ResourcePoint.New(arg_5_1.hexPoint, arg_5_2), RoomBlockEnum.BlockSize, arg_5_3 or 0.4)
	end

	return Vector3(var_5_0.x, RoomBuildingEnum.VehicleInitOffestY, var_5_0.y)
end

function var_0_0.addEventListeners(arg_6_0)
	RoomMapController.instance:registerCallback(RoomEvent.MapEntityNightLight, arg_6_0._onNightLight, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.MapEntityNightLight, arg_7_0._onNightLight, arg_7_0)
end

function var_0_0.stop(arg_8_0)
	return
end

function var_0_0._onNightLight(arg_9_0, arg_9_1)
	if arg_9_1 ~= nil and arg_9_0._isNight ~= arg_9_1 then
		arg_9_0._isNight = arg_9_1

		arg_9_0:updateNight(arg_9_1)
	end
end

function var_0_0.updateNight(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0._followerList do
		arg_10_0._followerList[iter_10_0]:nightLight(arg_10_1)
	end
end

function var_0_0.restart(arg_11_0)
	if #arg_11_0._followerList < 2 then
		return
	end

	arg_11_0._pathData:clear()

	if arg_11_0._lookAtPos then
		arg_11_0.targetTrs:LookAt(arg_11_0._lookAtPos)
	end

	for iter_11_0 = #arg_11_0._initPosList, 1, -1 do
		arg_11_0._pathData:addPathPos(arg_11_0._initPosList[iter_11_0])
	end

	for iter_11_1 = 1, #arg_11_0._followerList do
		arg_11_0._followerList[iter_11_1]:moveByPathData()
	end
end

function var_0_0.getVehicleMO(arg_12_0)
	return arg_12_0.entity:getVehicleMO()
end

function var_0_0.getSeeker(arg_13_0)
	return arg_13_0._seeker
end

function var_0_0.beforeDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._followerRebuild, arg_14_0)

	if #arg_14_0._followerList > 0 then
		for iter_14_0 = 1, #arg_14_0._followerList do
			gohelper.destroy(arg_14_0._followerList[iter_14_0].go)
			arg_14_0._followerList[iter_14_0]:dispose()
		end

		arg_14_0._followerList = {}
	end
end

function var_0_0._initFollower(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 or string.nilorempty(arg_15_1.followNodePathStr) or gohelper.isNil(arg_15_2) then
		return
	end

	local var_15_0 = string.split(arg_15_1.followNodePathStr, "#")
	local var_15_1 = string.splitToNumber(arg_15_1.followRadiusStr, "#")
	local var_15_2 = string.splitToNumber(arg_15_1.followRotateStr, "#")

	if not var_15_0 or #var_15_0 < 2 then
		return
	end

	local var_15_3 = 0

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_4 = gohelper.findChild(arg_15_2, iter_15_1)

		if not gohelper.isNil(var_15_4) then
			local var_15_5 = RoomVehicleFollower.New(arg_15_0)
			local var_15_6 = gohelper.create3d(arg_15_0.go, iter_15_1)

			var_15_5:init(var_15_6, var_15_1[iter_15_0], var_15_3, iter_15_1, var_15_2[iter_15_0])
			table.insert(arg_15_0._followerList, var_15_5)
		end
	end

	arg_15_0:_refreshFollowDistance()
	tabletool.addValues(arg_15_0._forwardList, arg_15_0._followerList)

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._followerList) do
		table.insert(arg_15_0._backwardList, 1, iter_15_3)
	end

	arg_15_0:restart()
end

function var_0_0.addFollerPathPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if #arg_16_0._followerList > 0 then
		local var_16_0 = Vector3(arg_16_1, arg_16_2, arg_16_3)

		arg_16_0._pathData:addPathPos(var_16_0)
	end
end

function var_0_0._addFollerPathPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if #arg_17_0._followerList > 0 then
		local var_17_0 = Vector3(arg_17_1, arg_17_2, arg_17_3)

		for iter_17_0 = 2, #arg_17_0._followerList do
			arg_17_0._followerList[iter_17_0]:addPathPos(var_17_0)
		end
	end
end

function var_0_0.updateFollower(arg_18_0)
	if #arg_18_0._followerList > 0 then
		for iter_18_0 = 2, #arg_18_0._followerList do
			arg_18_0._followerList[iter_18_0]:moveByPathData()
		end

		if arg_18_0._isNeedUpdateForward then
			arg_18_0._isNeedUpdateForward = false

			for iter_18_1 = 1, #arg_18_0._followerList do
				arg_18_0._followerList[iter_18_1]:setVehiceForward(arg_18_0._isForward)
			end
		end
	end
end

function var_0_0.getPathData(arg_19_0)
	return arg_19_0._pathData
end

function var_0_0._followerRebuild(arg_20_0)
	if not arg_20_0._initCloneFollowerFinish and arg_20_0.entity.effect:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) then
		arg_20_0._initCloneFollowerFinish = true

		local var_20_0 = arg_20_0:getVehicleMO()
		local var_20_1 = var_20_0 and var_20_0:getReplaceDefideCfg()
		local var_20_2 = arg_20_0.entity.effect:getEffectGO(RoomEnum.EffectKey.VehicleGOKey)

		arg_20_0:_initFollower(var_20_1, var_20_2)

		for iter_20_0, iter_20_1 in ipairs(arg_20_0._followerList) do
			iter_20_1:onEffectRebuild()
		end

		arg_20_0.entity.effect:setActiveByKey(RoomEnum.EffectKey.VehicleGOKey, #arg_20_0._followerList < 1)
		arg_20_0:updateNight(arg_20_0._isNight)
	end
end

function var_0_0.setShow(arg_21_0, arg_21_1)
	if #arg_21_0._followerList > 0 then
		for iter_21_0 = 1, #arg_21_0._followerList do
			gohelper.setActive(arg_21_0._followerList[iter_21_0].go, arg_21_1)
		end
	end
end

function var_0_0.turnAround(arg_22_0)
	if #arg_22_0._followerList < 2 then
		return
	end

	arg_22_0._isForward = arg_22_0._isForward ~= true
	arg_22_0._isNeedUpdateForward = true

	local var_22_0 = arg_22_0.entity:getVehicleMO()

	if var_22_0 then
		local var_22_1 = {}

		tabletool.addValues(var_22_1, var_22_0:getAreaNode())

		local var_22_2, var_22_3, var_22_4 = transformhelper.getPos(arg_22_0._followerList[#arg_22_0._followerList].goTrs)
		local var_22_5, var_22_6 = HexMath.positionToRoundHex(Vector2(var_22_2, var_22_4), RoomBlockEnum.BlockSize)
		local var_22_7 = var_22_0.pathPlanMO:getNode(var_22_5)

		if var_22_7 and not tabletool.indexOf(var_22_1, var_22_7) then
			table.insert(var_22_1, var_22_7)
		end

		if #var_22_1 > 1 then
			for iter_22_0 = 2, #var_22_1 do
				local var_22_8 = var_22_1[iter_22_0 - 1]
				local var_22_9 = var_22_1[iter_22_0]

				for iter_22_1 = 1, 6 do
					if var_22_9:getConnctNode(iter_22_1) == var_22_8 then
						var_22_0:moveToNode(var_22_9, iter_22_1)

						break
					end
				end
			end
		end
	end

	arg_22_0._pathData:clear()

	local var_22_10 = #arg_22_0._followerList
	local var_22_11 = arg_22_0.targetTrs.parent

	for iter_22_2 = 1, var_22_10 do
		local var_22_12 = arg_22_0._followerList[iter_22_2]
		local var_22_13, var_22_14, var_22_15 = transformhelper.getPos(var_22_12.goTrs)

		arg_22_0._pathData:addPathPos(Vector3(var_22_13, var_22_14, var_22_15))
		var_22_12.goTrs:SetParent(var_22_11)

		if iter_22_2 == var_22_10 then
			transformhelper.setPos(arg_22_0.targetTrs, var_22_13, var_22_14, var_22_15)

			arg_22_0.targetTrs.rotation = var_22_12.goTrs.rotation

			var_22_12.goTrs:SetParent(arg_22_0.targetTrs)
		end
	end

	arg_22_0._followerList = arg_22_0._isForward and arg_22_0._forwardList or arg_22_0._backwardList

	arg_22_0:_refreshFollowDistance()

	return true
end

function var_0_0._refreshFollowDistance(arg_23_0)
	local var_23_0 = 0

	for iter_23_0 = 1, #arg_23_0._followerList do
		local var_23_1 = arg_23_0._followerList[iter_23_0]

		if iter_23_0 > 1 then
			var_23_0 = var_23_0 + arg_23_0._followerList[iter_23_0 - 1].radius + var_23_1.radius
		end

		var_23_1.followDistance = var_23_0
	end
end

function var_0_0.onEffectRebuild(arg_24_0)
	if not arg_24_0._initCloneFollowerFinish then
		TaskDispatcher.cancelTask(arg_24_0._followerRebuild, arg_24_0)
		TaskDispatcher.runDelay(arg_24_0._followerRebuild, arg_24_0, 0.1)
	end
end

return var_0_0
