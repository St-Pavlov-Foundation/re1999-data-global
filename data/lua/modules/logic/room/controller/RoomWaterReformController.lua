module("modules.logic.room.controller.RoomWaterReformController", package.seeall)

local var_0_0 = class("RoomWaterReformController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.selectWater(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 or not arg_4_2 then
		return
	end

	local var_4_0 = arg_4_1:isInMapBlock()
	local var_4_1 = arg_4_1:hasRiver()

	if var_4_0 and var_4_1 then
		local var_4_2

		for iter_4_0 = 0, 6 do
			if arg_4_1:getResourceId(iter_4_0) == RoomResourceEnum.ResourceId.River then
				var_4_2 = iter_4_0

				break
			end
		end

		RoomResourceModel.instance:clearLightResourcePoint()

		local var_4_3 = RoomWaterReformModel.instance:getWaterAreaId(arg_4_2.x, arg_4_2.y, var_4_2)

		if var_4_3 ~= RoomWaterReformModel.instance:getSelectAreaId() then
			local var_4_4 = arg_4_0:getSelectWaterBlockEntityList()

			RoomWaterReformModel.instance:setSelectWaterArea(var_4_3)
			RoomBlockHelper.refreshBlockEntity(var_4_4, "refreshBlock")
			arg_4_0:refreshSelectWaterBlockEntity()
			arg_4_0:dispatchEvent(RoomEvent.WaterReformSelectWaterChange)
		else
			arg_4_0:clearSelectWater()
		end
	end
end

function var_0_0.clearSelectWater(arg_5_0)
	local var_5_0 = arg_5_0:getSelectWaterBlockEntityList()

	RoomWaterReformModel.instance:setSelectWaterArea()
	RoomBlockHelper.refreshBlockEntity(var_5_0, "refreshBlock")
	arg_5_0:dispatchEvent(RoomEvent.WaterReformSelectWaterChange)
end

function var_0_0.selectWaterType(arg_6_0, arg_6_1)
	if not RoomConfig.instance:getWaterReformTypeBlockId(arg_6_1) then
		return
	end

	local var_6_0 = arg_6_0:getSelectWaterBlockEntityList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1:getMO()

		if var_6_1 then
			if arg_6_1 ~= var_6_1:getTempWaterType() then
				var_6_1:setTempWaterType(arg_6_1)
				RoomWaterReformModel.instance:recordChangeWaterType(var_6_1.id, arg_6_1)
			end

			if (iter_6_1:isHasWaterGradient() and var_6_1:getWaterType() or var_6_1:getOriginalWaterType()) == arg_6_1 then
				RoomWaterReformModel.instance:clearChangeWaterRecord(var_6_1.id)
			end
		end
	end

	RoomWaterReformListModel.instance:setSelectWaterType(arg_6_1)
	arg_6_0:refreshSelectWaterBlockEntity()
	arg_6_0:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function var_0_0.saveReform(arg_7_0)
	if RoomWaterReformModel.instance:hasChangedWaterType() then
		local var_7_0 = RoomWaterReformModel.instance:getRecordChangeWaterType()

		if not var_7_0 then
			return
		end

		local var_7_1 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if not var_7_1[iter_7_1] then
				if not RoomWaterReformModel.instance:isUnlockWaterReform(iter_7_1) then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, arg_7_0._usedLockWaterReformConfirmReset, nil, nil, arg_7_0)

					return
				end

				var_7_1[iter_7_1] = true
			end
		end

		RoomRpc.instance:sendSetWaterTypeRequest(var_7_0)
	end

	RoomMapController.instance:switchWaterReform(false)
end

function var_0_0._usedLockWaterReformConfirmReset(arg_8_0)
	arg_8_0:resetReform()
	RoomMapController.instance:switchWaterReform(false)
end

function var_0_0.resetReform(arg_9_0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	RoomWaterReformModel.instance:resetChangeWaterType()

	local var_9_0 = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

	RoomWaterReformListModel.instance:setSelectWaterType(var_9_0)

	local var_9_1 = arg_9_0:getAllWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(var_9_1, "refreshBlock")
	arg_9_0:dispatchEvent(RoomEvent.WaterReformChangeWaterType)
end

function var_0_0.refreshHighlightWaterBlock(arg_10_0)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
end

function var_0_0.refreshSelectWaterBlockEntity(arg_11_0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	local var_11_0 = arg_11_0:getSelectWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(var_11_0, "refreshBlock")
end

function var_0_0.getSelectWaterBlockEntityList(arg_12_0)
	local var_12_0 = {}

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return var_12_0
	end

	if not RoomWaterReformModel.instance:hasSelectWaterArea() then
		return var_12_0
	end

	local var_12_1 = GameSceneMgr.instance:getCurScene()
	local var_12_2 = RoomWaterReformModel.instance:getSelectWaterResourcePointList()

	if not var_12_2 or not var_12_1 then
		return var_12_0
	end

	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_2) do
		local var_12_4 = iter_12_1.x
		local var_12_5 = iter_12_1.y

		if not var_12_3[var_12_4] or not var_12_3[var_12_4][var_12_5] then
			var_12_3[var_12_4] = var_12_3[var_12_4] or {}
			var_12_3[var_12_4][var_12_5] = true

			local var_12_6 = RoomMapBlockModel.instance:getBlockMO(var_12_4, var_12_5)
			local var_12_7 = var_12_6 and var_12_1.mapmgr:getBlockEntity(var_12_6.id, SceneTag.RoomMapBlock)

			var_12_0[#var_12_0 + 1] = var_12_7
		end
	end

	return var_12_0
end

function var_0_0.getAllWaterBlockEntityList(arg_13_0)
	local var_13_0 = {}

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return var_13_0
	end

	local var_13_1 = GameSceneMgr.instance:getCurScene()

	if not var_13_1 then
		return var_13_0
	end

	local var_13_2 = {}
	local var_13_3 = RoomWaterReformModel.instance:getWaterAreaList()

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			local var_13_4 = iter_13_3.x
			local var_13_5 = iter_13_3.y

			if not var_13_2[var_13_4] or not var_13_2[var_13_4][var_13_5] then
				var_13_2[var_13_4] = var_13_2[var_13_4] or {}
				var_13_2[var_13_4][var_13_5] = true

				local var_13_6 = RoomMapBlockModel.instance:getBlockMO(var_13_4, var_13_5)
				local var_13_7 = var_13_6 and var_13_1.mapmgr:getBlockEntity(var_13_6.id, SceneTag.RoomMapBlock)

				var_13_0[#var_13_0 + 1] = var_13_7
			end
		end
	end

	return var_13_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
