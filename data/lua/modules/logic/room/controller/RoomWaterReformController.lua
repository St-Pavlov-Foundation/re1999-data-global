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

function var_0_0.getBlockReformPermanentInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	RoomRpc.instance:sendGetBlockPermanentInfoRequest(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.onGetBlockReformPermanentInfo(arg_5_0, arg_5_1)
	RoomWaterReformModel.instance:setBlockPermanentInfo(arg_5_1)
	arg_5_0:dispatchEvent(RoomEvent.OnGetBlockReformPermanentInfo)
end

function var_0_0.onClickBlock(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return
	end

	if RoomConfig.instance:getInitBlock(arg_6_1.blockId) then
		return
	end

	local var_6_0 = arg_6_1:isInMapBlock()

	if not RoomWaterReformModel.instance:isWaterReform() or not var_6_0 then
		return
	end

	if arg_6_1:hasRiver() then
		arg_6_0:changeReformMode(RoomEnum.ReformMode.Water)
		arg_6_0:selectWater(arg_6_1, arg_6_2)
	else
		arg_6_0:changeReformMode(RoomEnum.ReformMode.Block)
		arg_6_0:selectBlock(arg_6_1, arg_6_2)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.changeReformMode(arg_7_0, arg_7_1)
	if arg_7_1 == RoomWaterReformModel.instance:getReformMode() then
		return
	end

	RoomWaterReformModel.instance:setReformMode(arg_7_1)

	if arg_7_1 ~= RoomEnum.ReformMode.Water then
		arg_7_0:clearSelectWater()
	end

	if arg_7_1 ~= RoomEnum.ReformMode.Block then
		arg_7_0:clearSelectBlock()
	end

	RoomWaterReformListModel.instance:setShowBlockList()
	arg_7_0:dispatchEvent(RoomEvent.OnChangReformMode)
end

function var_0_0.saveReform(arg_8_0)
	if RoomWaterReformModel.instance:hasChangedBlockColor() then
		local var_8_0 = {}
		local var_8_1 = RoomWaterReformModel.instance:getRecordChangeBlockColor()

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			if not var_8_0[iter_8_1] then
				if not RoomWaterReformModel.instance:isUnlockBlockColor(iter_8_1) then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, arg_8_0._resetAndExitReform, nil, nil, arg_8_0)

					return
				end

				var_8_0[iter_8_1] = true
			end
		end

		local var_8_2 = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)
		local var_8_3 = ItemModel.instance:getItemQuantity(var_8_2[1], var_8_2[2])
		local var_8_4 = RoomWaterReformModel.instance:getChangedBlockColorCount(nil, RoomWaterReformModel.InitBlockColor)

		if var_8_4 <= var_8_3 then
			local var_8_5 = var_8_4 > 0 and MessageBoxIdDefine.ConfirmChangeBlockColorCost or MessageBoxIdDefine.ConfirmChangeBlockColor

			GameFacade.showMessageBox(var_8_5, MsgBoxEnum.BoxType.Yes_No, arg_8_0._confirmBlockColorReform, nil, nil, arg_8_0, nil, nil, var_8_4)

			return
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.ChangeBlockColorCostItemNotEnough, MsgBoxEnum.BoxType.Yes_No, arg_8_0._resetAndExitReform, nil, nil, arg_8_0)

			return
		end
	else
		arg_8_0:_saveWaterReform()
	end
end

function var_0_0._confirmBlockColorReform(arg_9_0)
	local var_9_0 = RoomWaterReformModel.instance:getRecordChangeBlockColor()

	RoomRpc.instance:sendSetBlockColorRequest(var_9_0)
	arg_9_0:_saveWaterReform()
end

function var_0_0._saveWaterReform(arg_10_0)
	if RoomWaterReformModel.instance:hasChangedWaterType() then
		local var_10_0 = {}
		local var_10_1 = RoomWaterReformModel.instance:getRecordChangeWaterType()

		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			if not var_10_0[iter_10_1] then
				if not RoomWaterReformModel.instance:isUnlockWaterReform(iter_10_1) then
					GameFacade.showMessageBox(MessageBoxIdDefine.UsedLockedWaterReform, MsgBoxEnum.BoxType.Yes_No, arg_10_0._resetAndExitReform, nil, nil, arg_10_0)

					return
				end

				var_10_0[iter_10_1] = true
			end
		end

		RoomRpc.instance:sendSetWaterTypeRequest(var_10_1)
	end

	RoomMapController.instance:switchWaterReform(false)
end

function var_0_0._resetAndExitReform(arg_11_0)
	arg_11_0:resetReform()
	RoomMapController.instance:switchWaterReform(false)
end

function var_0_0.resetReform(arg_12_0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	RoomWaterReformModel.instance:resetChangeWaterType()

	local var_12_0 = arg_12_0:getAllWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(var_12_0, "refreshBlock")
	RoomWaterReformModel.instance:resetChangeBlockColor()

	local var_12_1, var_12_2 = arg_12_0:getAllBlockEntityListWithoutRiver()

	RoomBlockHelper.refreshBlockEntity(var_12_1, "refreshBlock")
	arg_12_0:refreshSelectedNearBlock(var_12_1, var_12_2)

	local var_12_3 = RoomWaterReformModel.instance:getReformMode()

	if var_12_3 == RoomEnum.ReformMode.Water then
		local var_12_4 = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

		RoomWaterReformListModel.instance:setSelectWaterType(var_12_4)
	elseif var_12_3 == RoomEnum.ReformMode.Block then
		local var_12_5 = RoomWaterReformListModel.instance:getDefaultSelectBlockColor()

		RoomWaterReformListModel.instance:setSelectBlockColor(var_12_5)
	end

	arg_12_0:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function var_0_0.refreshHighlightWaterBlock(arg_13_0)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
end

function var_0_0.selectWater(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 or not arg_14_2 then
		return
	end

	local var_14_0

	for iter_14_0 = 0, 6 do
		if arg_14_1:getResourceId(iter_14_0) == RoomResourceEnum.ResourceId.River then
			var_14_0 = iter_14_0

			break
		end
	end

	RoomResourceModel.instance:clearLightResourcePoint()

	local var_14_1 = RoomWaterReformModel.instance:getWaterAreaId(arg_14_2.x, arg_14_2.y, var_14_0)

	if var_14_1 ~= RoomWaterReformModel.instance:getSelectAreaId() then
		local var_14_2 = arg_14_0:getSelectWaterBlockEntityList()

		RoomWaterReformModel.instance:setSelectWaterArea(var_14_1)
		RoomBlockHelper.refreshBlockEntity(var_14_2, "refreshBlock")
		arg_14_0:refreshSelectWaterBlockEntity()
		arg_14_0:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
	else
		arg_14_0:clearSelectWater()
	end
end

function var_0_0.clearSelectWater(arg_15_0)
	local var_15_0 = arg_15_0:getSelectWaterBlockEntityList()

	RoomWaterReformModel.instance:setSelectWaterArea()
	RoomBlockHelper.refreshBlockEntity(var_15_0, "refreshBlock")
	arg_15_0:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
end

function var_0_0.selectWaterType(arg_16_0, arg_16_1)
	if not RoomConfig.instance:getWaterReformTypeBlockId(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_0:getSelectWaterBlockEntityList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = iter_16_1:getMO()

		if var_16_1 then
			if arg_16_1 ~= var_16_1:getTempWaterType() then
				var_16_1:setTempWaterType(arg_16_1)
				RoomWaterReformModel.instance:recordChangeWaterType(var_16_1.id, arg_16_1)
			end

			if (iter_16_1:isHasWaterGradient() and var_16_1:getWaterType() or var_16_1:getOriginalWaterType()) == arg_16_1 then
				RoomWaterReformModel.instance:clearChangeWaterRecord(var_16_1.id)
			end
		end
	end

	RoomWaterReformListModel.instance:setSelectWaterType(arg_16_1)
	arg_16_0:refreshSelectWaterBlockEntity()
	arg_16_0:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function var_0_0.refreshSelectWaterBlockEntity(arg_17_0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	local var_17_0 = arg_17_0:getSelectWaterBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(var_17_0, "refreshBlock")
end

function var_0_0.getSelectWaterBlockEntityList(arg_18_0)
	local var_18_0 = {}

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return var_18_0
	end

	if not RoomWaterReformModel.instance:hasSelectWaterArea() then
		return var_18_0
	end

	local var_18_1 = GameSceneMgr.instance:getCurScene()
	local var_18_2 = RoomWaterReformModel.instance:getSelectWaterResourcePointList()

	if not var_18_2 or not var_18_1 then
		return var_18_0
	end

	local var_18_3 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		local var_18_4 = iter_18_1.x
		local var_18_5 = iter_18_1.y

		if not var_18_3[var_18_4] or not var_18_3[var_18_4][var_18_5] then
			var_18_3[var_18_4] = var_18_3[var_18_4] or {}
			var_18_3[var_18_4][var_18_5] = true

			local var_18_6 = RoomMapBlockModel.instance:getBlockMO(var_18_4, var_18_5)
			local var_18_7 = var_18_6 and var_18_1.mapmgr:getBlockEntity(var_18_6.id, SceneTag.RoomMapBlock)

			var_18_0[#var_18_0 + 1] = var_18_7
		end
	end

	return var_18_0
end

function var_0_0.getAllWaterBlockEntityList(arg_19_0)
	local var_19_0 = {}

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return var_19_0
	end

	local var_19_1 = GameSceneMgr.instance:getCurScene()

	if not var_19_1 then
		return var_19_0
	end

	local var_19_2 = {}
	local var_19_3 = RoomWaterReformModel.instance:getWaterAreaList()

	for iter_19_0, iter_19_1 in ipairs(var_19_3) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			local var_19_4 = iter_19_3.x
			local var_19_5 = iter_19_3.y

			if not var_19_2[var_19_4] or not var_19_2[var_19_4][var_19_5] then
				var_19_2[var_19_4] = var_19_2[var_19_4] or {}
				var_19_2[var_19_4][var_19_5] = true

				local var_19_6 = RoomMapBlockModel.instance:getBlockMO(var_19_4, var_19_5)
				local var_19_7 = var_19_6 and var_19_1.mapmgr:getBlockEntity(var_19_6.id, SceneTag.RoomMapBlock)

				var_19_0[#var_19_0 + 1] = var_19_7
			end
		end
	end

	return var_19_0
end

function var_0_0.selectBlock(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = RoomWaterReformModel.instance:getBlockColorReformSelectMode()

	if not RoomWaterReformModel.instance:isBlockInSelect(arg_20_1) then
		if var_20_0 == RoomEnum.BlockColorReformSelectMode.All then
			local var_20_1 = RoomMapBlockModel.instance:getFullBlockMOList()

			for iter_20_0, iter_20_1 in ipairs(var_20_1) do
				local var_20_2 = iter_20_1.blockId
				local var_20_3 = iter_20_1:hasRiver()
				local var_20_4 = RoomConfig.instance:getInitBlock(var_20_2)

				if not var_20_3 and not var_20_4 then
					RoomWaterReformModel.instance:setBlockSelected(var_20_2, true)
				end
			end
		elseif var_20_0 == RoomEnum.BlockColorReformSelectMode.Multiple then
			local var_20_5 = {}
			local var_20_6 = {
				arg_20_1.blockId
			}

			RoomBlockHelper.getNearSameBlockTypeEntity(arg_20_1, var_20_5, var_20_6)

			local var_20_7 = arg_20_0:getSelectBlockEntityList()

			RoomWaterReformModel.instance:setBlockSelectedByList(var_20_6, true, true)
			RoomBlockHelper.refreshBlockEntity(var_20_7, "refreshBlock")
		else
			RoomWaterReformModel.instance:setBlockSelected(arg_20_1.blockId, true)
		end

		arg_20_0:refreshSelectedBlockEntity()
		arg_20_0:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
	elseif var_20_0 == RoomEnum.BlockColorReformSelectMode.Single then
		arg_20_0:clearSelectBlock(arg_20_1)
	else
		arg_20_0:clearSelectBlock()
	end
end

function var_0_0.clearSelectBlock(arg_21_0, arg_21_1)
	local var_21_0 = {}

	if arg_21_1 then
		local var_21_1 = arg_21_1.blockId

		var_21_0 = arg_21_0:getSelectBlockEntityList(var_21_1)

		RoomWaterReformModel.instance:setBlockSelected(var_21_1, false)
	else
		var_21_0 = arg_21_0:getSelectBlockEntityList()

		RoomWaterReformModel.instance:setBlockSelectedByList(nil, false, true)
	end

	RoomBlockHelper.refreshBlockEntity(var_21_0, "refreshBlock")
	arg_21_0:dispatchEvent(RoomEvent.OnReformChangeSelectedEntity)
end

function var_0_0.selectBlockColorType(arg_22_0, arg_22_1)
	if arg_22_1 ~= RoomWaterReformModel.InitBlockColor and not RoomConfig.instance:getBlockColorReformBlockId(arg_22_1) then
		return
	end

	local var_22_0 = {}
	local var_22_1 = arg_22_0:getSelectBlockEntityList()

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		local var_22_2 = iter_22_1:getMO()

		if var_22_2 then
			if arg_22_1 ~= var_22_2:getTempBlockColorType() then
				var_22_2:setTempBlockColorType(arg_22_1)
				RoomWaterReformModel.instance:recordChangeBlockColor(var_22_2.id, arg_22_1)
			end

			if var_22_2:getOriginalBlockType() == arg_22_1 then
				RoomWaterReformModel.instance:clearChangeBlockColorRecord(var_22_2.id)
			end

			local var_22_3 = var_22_2.hexPoint

			var_22_0[#var_22_0 + 1] = var_22_3
		end
	end

	RoomMapBlockModel.instance:refreshNearRiverByHexPointList(var_22_0, 1)
	RoomWaterReformListModel.instance:setSelectBlockColor(arg_22_1)
	arg_22_0:refreshSelectedBlockEntity()
	arg_22_0:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function var_0_0.refreshSelectedBlockEntity(arg_23_0)
	if not RoomWaterReformModel.instance:isWaterReform() then
		return
	end

	local var_23_0, var_23_1 = arg_23_0:getSelectBlockEntityList()

	RoomBlockHelper.refreshBlockEntity(var_23_0, "refreshBlock")
	arg_23_0:refreshSelectedNearBlock(var_23_0, var_23_1)
end

function var_0_0.refreshSelectedNearBlock(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_1 = iter_24_1:getMO()

		if var_24_1 then
			local var_24_2 = RoomBlockHelper.getNearBlockEntity(false, var_24_1.hexPoint, 1, true, false)

			for iter_24_2, iter_24_3 in ipairs(var_24_2) do
				local var_24_3 = iter_24_3:getMO()
				local var_24_4 = var_24_3.blockId

				if var_24_3 and not arg_24_2[var_24_4] and not var_24_0[var_24_4] then
					var_24_0[var_24_4] = iter_24_3
				end
			end
		end
	end

	local var_24_5 = {}

	for iter_24_4, iter_24_5 in pairs(var_24_0) do
		var_24_5[#var_24_5 + 1] = iter_24_5
	end

	RoomBlockHelper.refreshBlockEntity(var_24_5, "refreshLand")
end

function var_0_0.getSelectBlockEntityList(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = GameSceneMgr.instance:getCurSceneType()
	local var_25_3 = GameSceneMgr.instance:getCurScene()

	if var_25_2 ~= SceneType.Room or not var_25_3 then
		return var_25_0, var_25_1
	end

	if arg_25_1 then
		local var_25_4 = var_25_3.mapmgr:getBlockEntity(arg_25_1, SceneTag.RoomMapBlock)

		var_25_0[#var_25_0 + 1] = var_25_4
		var_25_1[arg_25_1] = true
	else
		local var_25_5 = RoomWaterReformModel.instance:getSelectedBlocks()

		if var_25_5 then
			for iter_25_0, iter_25_1 in pairs(var_25_5) do
				local var_25_6 = var_25_3.mapmgr:getBlockEntity(iter_25_0, SceneTag.RoomMapBlock)

				var_25_0[#var_25_0 + 1] = var_25_6
				var_25_1[iter_25_0] = true
			end
		end
	end

	return var_25_0, var_25_1
end

function var_0_0.getAllBlockEntityListWithoutRiver(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = GameSceneMgr.instance:getCurScene()
	local var_26_3 = GameSceneMgr.instance:getCurSceneType()

	if not var_26_2 or var_26_3 ~= SceneType.Room then
		return var_26_0, var_26_1
	end

	local var_26_4 = var_26_2.mapmgr:getMapBlockEntityDict()

	if var_26_4 then
		for iter_26_0, iter_26_1 in pairs(var_26_4) do
			local var_26_5 = iter_26_1:getMO()

			if not var_26_5:hasRiver() then
				var_26_0[#var_26_0 + 1] = iter_26_1
				var_26_1[var_26_5.blockId] = true
			end
		end
	end

	return var_26_0, var_26_1
end

function var_0_0.changeBlockSelectMode(arg_27_0, arg_27_1)
	local var_27_0 = RoomWaterReformModel.instance:getBlockColorReformSelectMode()

	if not arg_27_1 or var_27_0 == arg_27_1 then
		return
	end

	RoomWaterReformModel.instance:setBlockColorReformSelectMode(arg_27_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
