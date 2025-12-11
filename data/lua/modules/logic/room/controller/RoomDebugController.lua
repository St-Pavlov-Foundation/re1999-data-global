module("modules.logic.room.controller.RoomDebugController", package.seeall)

local var_0_0 = class("RoomDebugController", BaseController)
local var_0_1 = {
	[16] = 1
}

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._isDebugPlaceListShow = false
	arg_3_0._isDebugPackageListShow = false
	arg_3_0._isDebugBuildingListShow = false
	arg_3_0._tempInitConfig = nil
	arg_3_0._tempPackageConfig = nil
	arg_3_0._editPackageOrder = false
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.setEditPackageOrder(arg_5_0, arg_5_1)
	arg_5_0._editPackageOrder = arg_5_1

	arg_5_0:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function var_0_0.isEditPackageOrder(arg_6_0)
	return arg_6_0._editPackageOrder
end

function var_0_0.getTempInitConfig(arg_7_0)
	return arg_7_0._tempInitConfig
end

function var_0_0.getTempPackageConfig(arg_8_0)
	return arg_8_0._tempPackageConfig
end

function var_0_0.getUseCountByDefineId(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getTempPackageConfig()
	local var_9_1 = 0

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			for iter_9_2, iter_9_3 in ipairs(iter_9_1.infos) do
				if iter_9_3.defineId == arg_9_1 then
					var_9_1 = var_9_1 + 1
				end
			end
		end
	end

	return var_9_1
end

function var_0_0.openBuildingAreaView(arg_10_0)
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingAreaView)
end

function var_0_0.openBuildingCamerView(arg_11_0)
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingCameraView)
end

function var_0_0.setDebugPlaceListShow(arg_12_0, arg_12_1)
	arg_12_0._isDebugPlaceListShow = arg_12_1

	arg_12_0:dispatchEvent(RoomEvent.DebugPlaceListShowChanged, arg_12_1)
end

function var_0_0.isDebugPlaceListShow(arg_13_0)
	return arg_13_0._isDebugPlaceListShow
end

function var_0_0.setDebugPackageListShow(arg_14_0, arg_14_1)
	arg_14_0._isDebugPackageListShow = arg_14_1

	arg_14_0:dispatchEvent(RoomEvent.DebugPackageListShowChanged, arg_14_1)
end

function var_0_0.isDebugPackageListShow(arg_15_0)
	return arg_15_0._isDebugPackageListShow
end

function var_0_0.setDebugBuildingListShow(arg_16_0, arg_16_1)
	arg_16_0._isDebugBuildingListShow = arg_16_1

	arg_16_0:dispatchEvent(RoomEvent.DebugBuildingListShowChanged, arg_16_1)
end

function var_0_0.isDebugBuildingListShow(arg_17_0)
	return arg_17_0._isDebugBuildingListShow
end

function var_0_0._getNextPackageOrder(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = 0

	if arg_18_0._tempPackageConfig then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._tempPackageConfig) do
			for iter_18_2, iter_18_3 in ipairs(iter_18_1.infos) do
				if iter_18_3.packageId == arg_18_1 and var_18_0 < iter_18_3.packageOrder and iter_18_3.blockId ~= arg_18_2 then
					var_18_0 = iter_18_3.packageOrder
				end
			end
		end
	end

	return var_18_0 + 1
end

function var_0_0._getNextBlockId(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = 0
	local var_19_1 = RoomMapBlockModel.instance:getFullBlockMOList()

	if arg_19_1 then
		var_19_0 = arg_19_2 * 1000 + 1

		local var_19_2 = {}

		if arg_19_0._tempPackageConfig then
			for iter_19_0, iter_19_1 in ipairs(arg_19_0._tempPackageConfig) do
				if iter_19_1.packageMapId ~= arg_19_2 then
					for iter_19_2, iter_19_3 in ipairs(iter_19_1.infos) do
						var_19_2[iter_19_3.blockId] = true
					end
				end
			end
		end

		for iter_19_4, iter_19_5 in ipairs(var_19_1) do
			var_19_2[iter_19_5.blockId] = true
		end

		while var_19_2[var_19_0] do
			var_19_0 = var_19_0 + 1
		end

		return var_19_0
	else
		for iter_19_6, iter_19_7 in ipairs(var_19_1) do
			if var_19_0 > iter_19_7.blockId then
				var_19_0 = iter_19_7.blockId
			end
		end

		return var_19_0 - 1
	end
end

function var_0_0._getNextBuildingUid(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if var_20_0 < iter_20_1.id then
			var_20_0 = iter_20_1.id
		end
	end

	return var_20_0 + 1
end

function var_0_0.debugPlaceBlock(arg_21_0, arg_21_1)
	local var_21_0 = RoomDebugPlaceListModel.instance:getSelect()

	if not var_21_0 or var_21_0 == 0 then
		return
	end

	arg_21_0:_debugPlaceBlock(arg_21_1, var_21_0)
end

function var_0_0._debugPlaceBlock(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = RoomController.instance:isDebugPackageMode()
	local var_22_1 = RoomModel.instance:getDebugParam()
	local var_22_2 = arg_22_0:_getNextBlockId(var_22_0, var_22_0 and var_22_1 and var_22_1.packageMapId)
	local var_22_3 = {}

	for iter_22_0 = 1, 6 do
		table.insert(var_22_3, RoomResourceEnum.ResourceId.None)
	end

	local var_22_4 = {
		rotate = 0,
		blockId = var_22_2,
		defineId = arg_22_2,
		mainRes = RoomResourceEnum.ResourceId.None,
		blockState = RoomBlockEnum.BlockState.Map,
		x = arg_22_1.x,
		y = arg_22_1.y
	}
	local var_22_5, var_22_6 = RoomMapBlockModel.instance:debugConfirmPlaceBlock(arg_22_1, var_22_4)

	RoomMapBlockModel.instance:refreshNearRiver(arg_22_1, 1)
	arg_22_0:dispatchEvent(RoomEvent.DebugConfirmPlaceBlock, arg_22_1, var_22_5, var_22_6)
	arg_22_0:saveDebugMapParam()
	GameFacade.closeInputBox()
end

function var_0_0.debugRotateBlock(arg_23_0, arg_23_1)
	local var_23_0 = RoomMapBlockModel.instance:getBlockMO(arg_23_1.x, arg_23_1.y)

	if var_23_0.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	var_23_0.rotate = RoomRotateHelper.rotateRotate(var_23_0.rotate, 1)

	RoomMapBlockModel.instance:refreshNearRiver(arg_23_1, 1)
	arg_23_0:dispatchEvent(RoomEvent.DebugRotateBlock, arg_23_1, var_23_0)
	arg_23_0:saveDebugMapParam()
end

function var_0_0.debugRootOutBlock(arg_24_0, arg_24_1)
	if arg_24_1.x == 0 and arg_24_1.y == 0 then
		return
	end

	local var_24_0 = RoomMapBlockModel.instance:getBlockMO(arg_24_1.x, arg_24_1.y)

	if var_24_0.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	local var_24_1 = RoomMapBlockModel.instance:debugRootOutBlock(arg_24_1)

	RoomMapBlockModel.instance:refreshNearRiver(arg_24_1, 1)
	arg_24_0:dispatchEvent(RoomEvent.DebugRootOutBlock, arg_24_1, var_24_0, var_24_1)
	arg_24_0:saveDebugMapParam()
end

function var_0_0.debugReplaceBlock(arg_25_0, arg_25_1)
	local var_25_0 = RoomMapBlockModel.instance:getBlockMO(arg_25_1.x, arg_25_1.y)

	if var_25_0.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	local var_25_1 = RoomDebugPlaceListModel.instance:getSelect()

	if not var_25_1 or var_25_1 == 0 then
		return
	end

	if var_25_1 == var_25_0.defineId then
		return
	end

	arg_25_0:_debugReplaceBlock(arg_25_1, var_25_1)
end

function var_0_0._debugReplaceBlock(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = RoomMapBlockModel.instance:getBlockMO(arg_26_1.x, arg_26_1.y)

	if var_26_0.blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	var_26_0.defineId = arg_26_2

	arg_26_0:dispatchEvent(RoomEvent.DebugReplaceBlock, arg_26_1, var_26_0)
	GameFacade.closeInputBox()
end

function var_0_0.debugSetPackage(arg_27_0, arg_27_1)
	local var_27_0 = RoomDebugPackageListModel.instance:getFilterPackageId()

	if not var_27_0 or var_27_0 == 0 then
		return
	end

	arg_27_0:debugSetPackageId(arg_27_1, var_27_0)
end

function var_0_0.debugSetPackageId(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0:getBlockInfoOrBlockMO(arg_28_1)

	if not var_28_0 then
		return
	end

	local var_28_1 = RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty

	if arg_28_2 == 0 then
		var_28_0.packageOrder = 0
		var_28_0.mainRes = RoomResourceEnum.ResourceId.Empty
	else
		var_28_0.packageOrder = var_28_0.packageId == arg_28_2 and var_28_0.packageOrder or arg_28_0:_getNextPackageOrder(arg_28_2, var_28_0.blockId)
		var_28_0.mainRes = var_28_1
	end

	var_28_0.packageId = arg_28_2

	arg_28_0:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()

	local var_28_2 = RoomMapBlockModel.instance:getFullBlockMOById(arg_28_1)

	arg_28_0:dispatchEvent(RoomEvent.DebugSetPackage, var_28_2 and var_28_2.hexPoint, var_28_2)
	GameFacade.closeInputBox()
end

function var_0_0.debugSetMainRes(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getBlockInfoOrBlockMO(arg_29_1)

	if not var_29_0 then
		return
	end

	GameFacade.openInputBox({
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置分类",
		cancelBtnName = "取消",
		defaultInput = tostring(var_29_0.mainRes or -1),
		sureCallback = function(arg_30_0)
			arg_29_0:_debugSetMainRes(arg_29_1, tonumber(arg_30_0))
		end
	})
end

function var_0_0._debugSetMainRes(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getBlockInfoOrBlockMO(arg_31_1)

	if not var_31_0 then
		return
	end

	if not arg_31_2 then
		return
	end

	var_31_0.mainRes = arg_31_2

	var_0_0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	var_0_0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function var_0_0.debugSetPackageOrder(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getBlockInfoOrBlockMO(arg_32_1)

	if not var_32_0 then
		return
	end

	GameFacade.openInputBox({
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置排序",
		cancelBtnName = "取消",
		defaultInput = tostring(var_32_0.packageOrder or 0),
		sureCallback = function(arg_33_0)
			arg_32_0:_debugSetPackageOrder(arg_32_1, tonumber(arg_33_0))
		end
	})
end

function var_0_0.debugSetPackageLastOrder(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getBlockInfoOrBlockMO(arg_34_1)

	if not var_34_0 then
		return
	end

	if var_34_0.packageId == 0 then
		return
	end

	local var_34_1 = arg_34_0:_getNextPackageOrder(var_34_0.packageId, arg_34_1)

	arg_34_0:_debugSetPackageOrder(arg_34_1, var_34_1)
end

function var_0_0._debugSetPackageOrder(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getBlockInfoOrBlockMO(arg_35_1)

	if not var_35_0 then
		return
	end

	if not arg_35_2 then
		return
	end

	var_35_0.packageOrder = arg_35_2

	var_0_0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	var_0_0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function var_0_0.exchangeOrder(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_0:getBlockInfoOrBlockMO(arg_36_1)
	local var_36_1 = arg_36_0:getBlockInfoOrBlockMO(arg_36_2)

	var_36_0.packageOrder, var_36_1.packageOrder = var_36_1.packageOrder, var_36_0.packageOrder

	var_0_0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	var_0_0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function var_0_0.getBlockInfoOrBlockMO(arg_37_0, arg_37_1)
	local var_37_0 = RoomMapBlockModel.instance:getFullBlockMOById(arg_37_1)

	if var_37_0 then
		return var_37_0
	end

	if not arg_37_0._tempPackageConfig then
		return nil
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_0._tempPackageConfig) do
		for iter_37_2, iter_37_3 in ipairs(iter_37_1.infos) do
			if iter_37_3.blockId == arg_37_1 then
				return iter_37_3
			end
		end
	end
end

function var_0_0.debugPlaceBuilding(arg_38_0, arg_38_1)
	local var_38_0 = RoomDebugBuildingListModel.instance:getSelect()

	if not var_38_0 then
		return
	end

	arg_38_0:_debugPlaceBuilding(arg_38_1, var_38_0)
end

function var_0_0._debugPlaceBuilding(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = RoomMapBuildingModel.instance:getBuildingMO(arg_39_1.x, arg_39_1.y)

	if var_39_0 then
		if var_39_0.buildingId == arg_39_2 then
			return
		else
			var_0_0.instance:debugRootOutBuilding(arg_39_1)
		end
	end

	if not (arg_39_2 and RoomConfig.instance:getBuildingConfig(arg_39_2)) then
		return
	end

	GameFacade.closeInputBox()

	local var_39_1 = arg_39_0:_getNextBuildingUid()
	local var_39_2 = RoomMapModel.instance:getBuildingConfigParam(arg_39_2).levelGroups
	local var_39_3 = {}

	for iter_39_0, iter_39_1 in ipairs(var_39_2) do
		local var_39_4 = RoomConfig.instance:getLevelGroupMaxLevel(iter_39_1)

		table.insert(var_39_3, var_39_4)
	end

	local var_39_5 = {
		resAreaDirection = 0,
		rotate = 0,
		uid = var_39_1,
		buildingId = arg_39_2,
		levels = var_39_3,
		buildingState = RoomBuildingEnum.BuildingState.Map,
		x = arg_39_1.x,
		y = arg_39_1.y
	}
	local var_39_6 = RoomMapBuildingModel.instance:debugPlaceBuilding(arg_39_1, var_39_5)

	RoomMapBuildingModel.instance:clearAllOccupyDict()
	arg_39_0:dispatchEvent(RoomEvent.DebugPlaceBuilding, arg_39_1, var_39_6)
	arg_39_0:saveDebugMapParam()
end

function var_0_0.debugRotateBuilding(arg_40_0, arg_40_1)
	local var_40_0 = RoomMapBuildingModel.instance:getBuildingMO(arg_40_1.x, arg_40_1.y)

	if not var_40_0 then
		return
	end

	local var_40_1 = var_40_0.rotate

	var_40_0.rotate = RoomRotateHelper.rotateRotate(var_40_0.rotate, 1)

	RoomMapBuildingModel.instance:clearAllOccupyDict()
	arg_40_0:dispatchEvent(RoomEvent.DebugRotateBuilding, arg_40_1, var_40_0, var_40_1)
	arg_40_0:saveDebugMapParam()
end

function var_0_0.debugRootOutBuilding(arg_41_0, arg_41_1)
	local var_41_0 = RoomMapBuildingModel.instance:getBuildingMO(arg_41_1.x, arg_41_1.y)

	if not var_41_0 then
		return
	end

	RoomMapBuildingModel.instance:debugRootOutBuilding(arg_41_1)
	RoomMapBuildingModel.instance:clearAllOccupyDict()
	arg_41_0:dispatchEvent(RoomEvent.DebugRootOutBuilding, arg_41_1, var_41_0)
	arg_41_0:saveDebugMapParam()
end

function var_0_0.getEmptyMapInfo(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0:_getNextBlockId(arg_42_1, arg_42_2)

	return {
		infos = {
			{
				packageId = 0,
				rotate = 0,
				packageOrder = 0,
				x = 0,
				y = 0,
				blockId = var_42_0,
				defineId = RoomResourceEnum.EmptyDefineId,
				mainRes = RoomResourceEnum.ResourceId.Empty
			}
		}
	}
end

function var_0_0.getEmptyInitInfo(arg_43_0)
	return {
		infos = arg_43_0:getEmptyMapInfo().infos
	}
end

function var_0_0.getEmptyPackageInfo(arg_44_0)
	return {}
end

function var_0_0.generateMapInfo(arg_45_0, arg_45_1, arg_45_2)
	arg_45_1 = arg_45_1 or RoomMapBlockModel.instance:getFullBlockMOList()
	arg_45_2 = arg_45_2 or RoomMapBuildingModel.instance:getBuildingMOList()

	local var_45_0 = {
		infos = {}
	}
	local var_45_1 = #arg_45_1
	local var_45_2 = RoomController.instance:isDebugPackageMode()

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		if iter_45_1.blockState == RoomBlockEnum.BlockState.Map then
			local var_45_3 = {
				blockId = iter_45_1.blockId,
				defineId = iter_45_1.defineId,
				mainRes = iter_45_1.mainRes
			}

			var_45_3.x, var_45_3.y = iter_45_1.hexPoint.x, iter_45_1.hexPoint.y
			var_45_3.rotate = iter_45_1.rotate

			if var_45_2 then
				var_45_3.packageId = iter_45_1.packageId or 0
				var_45_3.packageOrder = iter_45_1.packageOrder or iter_45_1.blockId
			end

			table.insert(var_45_0.infos, var_45_3)
		end
	end

	var_45_0.buildingInfos = {}

	for iter_45_2, iter_45_3 in ipairs(arg_45_2) do
		local var_45_4 = {
			uid = iter_45_2,
			defineId = iter_45_3.buildingId
		}

		var_45_4.use = true
		var_45_4.x = iter_45_3.hexPoint.x
		var_45_4.y = iter_45_3.hexPoint.y
		var_45_4.rotate = iter_45_3.rotate
		var_45_4.resAreaDirection = iter_45_3.resAreaDirection

		table.insert(var_45_0.buildingInfos, var_45_4)
	end

	return var_45_0
end

function var_0_0.getDebugMapInfo(arg_46_0)
	local var_46_0
	local var_46_1 = PlayerPrefsHelper.getString(PlayerPrefsKey.RoomDebugMapParam, "")

	if string.nilorempty(var_46_1) then
		var_46_0 = arg_46_0:getEmptyMapInfo()
	else
		var_46_0 = cjson.decode(var_46_1)
	end

	var_46_0.remainBlock = 0

	return var_46_0
end

function var_0_0.saveDebugMapParam(arg_47_0)
	if not RoomController.instance:isDebugNormalMode() then
		return
	end

	local var_47_0 = arg_47_0:generateMapInfo()

	if #var_47_0.infos > 0 then
		local var_47_1 = cjson.encode(var_47_0)

		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, var_47_1)
	end
end

function var_0_0.getDebugInitInfo(arg_48_0, arg_48_1, arg_48_2)
	if arg_48_0._tempInitConfig then
		if arg_48_1 then
			if arg_48_2 then
				arg_48_1(arg_48_2, arg_48_0._tempInitConfig)
			else
				arg_48_1(arg_48_0._tempInitConfig)
			end
		end

		return
	end

	loadAbAsset(RoomEnum.InitMapConfigPathEditor, false, function(arg_49_0)
		local var_49_0

		if arg_49_0.IsLoadSuccess then
			local var_49_1 = arg_49_0:GetResource(RoomEnum.InitMapConfigPathEditor).text

			var_49_0 = cjson.decode(var_49_1)
		else
			var_49_0 = arg_48_0:getEmptyInitInfo()
		end

		arg_48_0._tempInitConfig = var_49_0

		if arg_48_1 then
			if arg_48_2 then
				arg_48_1(arg_48_2, var_49_0)
			else
				arg_48_1(var_49_0)
			end
		end
	end)
end

function var_0_0.getDebugInitMapInfo(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	arg_50_0:getDebugInitInfo(function(arg_51_0)
		local var_51_0 = {
			infos = arg_51_0.infos
		}

		if not var_51_0.infos then
			var_51_0 = arg_50_0:getEmptyMapInfo()
		end

		if arg_50_2 then
			if arg_50_3 then
				arg_50_2(arg_50_3, var_51_0)
			else
				arg_50_2(var_51_0)
			end
		end
	end)
end

function var_0_0.outputInitJson(arg_52_0, arg_52_1)
	arg_52_0:getDebugInitInfo(function(arg_53_0)
		local var_53_0 = arg_52_0:generateMapInfo()

		var_53_0.buildingInfos = nil
		arg_53_0.infos = var_53_0.infos

		arg_52_0:saveInitMapParam(arg_53_0, arg_52_1)
	end)
end

function var_0_0.resetInitJson(arg_54_0)
	arg_54_0:getDebugInitInfo(function(arg_55_0)
		arg_55_0.infos = arg_54_0:getEmptyMapInfo().infos

		arg_54_0:saveInitMapParam(arg_55_0)
	end)
end

function var_0_0.saveInitMapParam(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0._tempInitConfig = arg_56_1

	if arg_56_2 then
		return
	end

	local var_56_0 = cjson.encode(arg_56_1)
	local var_56_1 = arg_56_0:_wrapClientConfigParam(arg_56_1, "block_init")

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	local var_56_2 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPathEditor)
	local var_56_3 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPath)
	local var_56_4 = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_init.json")

	SLFramework.FileHelper.WriteTextToPath(var_56_2, var_56_0)
	SLFramework.FileHelper.WriteTextToPath(var_56_3, var_56_1)
	SLFramework.FileHelper.WriteTextToPath(var_56_4, var_56_0)
	arg_56_0:assetDatabaseRefresh()
	logNormal("导出完成 记得提交前后端配置文件")
end

function var_0_0.getDebugPackageInfo(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	if arg_57_0._tempPackageConfig then
		if arg_57_1 then
			if arg_57_2 then
				arg_57_1(arg_57_2, arg_57_0._tempPackageConfig, arg_57_3)
			else
				arg_57_1(arg_57_0._tempPackageConfig, arg_57_3)
			end
		end

		return
	end

	local var_57_0 = MultiAbLoader.New()

	var_57_0:addPath(RoomEnum.BlockPackageMapPath)

	if SLFramework.FrameworkSettings.IsEditor then
		var_57_0:addPath(RoomEnum.BlockPackageDataPath)
	end

	var_57_0:startLoad(function()
		local var_58_0 = var_57_0:getAssetItemDict()
		local var_58_1 = var_58_0[RoomEnum.BlockPackageMapPath]:GetResource(RoomEnum.BlockPackageMapPath).text
		local var_58_2 = cjson.decode(var_58_1)

		if SLFramework.FrameworkSettings.IsEditor then
			local var_58_3 = var_58_0[RoomEnum.BlockPackageDataPath]:GetResource(RoomEnum.BlockPackageDataPath).text
			local var_58_4 = cjson.decode(var_58_3)[2]

			arg_57_0:_injectPackageInfo(var_58_2, var_58_4)
		end

		arg_57_0:_refreshPackageOrder(var_58_2)

		arg_57_0._tempPackageConfig = var_58_2

		if arg_57_1 then
			if arg_57_2 then
				arg_57_1(arg_57_2, var_58_2, arg_57_3)
			else
				arg_57_1(var_58_2, arg_57_3)
			end
		end

		var_57_0:dispose()
	end)
end

function var_0_0._injectPackageInfo(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_2) do
		local var_59_1 = iter_59_1.id

		for iter_59_2, iter_59_3 in ipairs(iter_59_1.infos) do
			var_59_0[iter_59_3.blockId] = {
				packageId = var_59_1,
				packageOrder = iter_59_2
			}
		end
	end

	for iter_59_4, iter_59_5 in ipairs(arg_59_1) do
		for iter_59_6, iter_59_7 in ipairs(iter_59_5.infos) do
			local var_59_2 = var_59_0[iter_59_7.blockId]

			iter_59_7.packageId = var_59_2 and var_59_2.packageId or 0
			iter_59_7.packageOrder = var_59_2 and var_59_2.packageOrder or 0
		end
	end
end

function var_0_0.getDebugPackageMapInfo(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = arg_60_1 and arg_60_1.packageMapId

	arg_60_0:getDebugPackageInfo(function(arg_61_0)
		local var_61_0 = {}

		for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
			if iter_61_1.packageMapId == var_60_0 then
				var_61_0.infos = iter_61_1.infos
				var_61_0.buildingInfos = iter_61_1.buildingInfos
				var_61_0.packageName = iter_61_1.packageName

				break
			end
		end

		if not var_61_0.infos then
			var_61_0 = arg_60_0:getEmptyMapInfo(true, var_60_0)
		end

		if arg_60_2 then
			if arg_60_3 then
				arg_60_2(arg_60_3, var_61_0)
			else
				arg_60_2(var_61_0)
			end
		end
	end)
end

function var_0_0.outputPackageJson(arg_62_0, arg_62_1, arg_62_2)
	arg_62_0:getDebugPackageMapInfo({
		packageMapId = arg_62_1
	}, function(arg_63_0)
		local var_63_0 = arg_62_0:generateMapInfo()

		arg_63_0.infos = var_63_0.infos
		arg_63_0.buildingInfos = var_63_0.buildingInfos

		arg_62_0:savePackageMapParam(arg_62_1, arg_63_0, arg_62_2)
	end)
end

function var_0_0.resetPackageJson(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = {
		infos = arg_64_0:getEmptyMapInfo(true, arg_64_1).infos,
		buildingInfos = {},
		packageName = arg_64_2
	}

	arg_64_0:savePackageMapParam(arg_64_1, var_64_0)
end

function var_0_0.copyPackageJson(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:getDebugPackageInfo(function(arg_66_0)
		local var_66_0

		for iter_66_0, iter_66_1 in ipairs(arg_66_0) do
			if iter_66_1.packageMapId == arg_65_3 then
				var_66_0 = LuaUtil.deepCopyNoMeta(iter_66_1)

				break
			end
		end

		if not var_66_0 then
			return
		end

		var_66_0.packageName = arg_65_2

		local var_66_1 = arg_65_0:_getNextBlockId(true, arg_65_1)

		for iter_66_2, iter_66_3 in ipairs(var_66_0.infos) do
			iter_66_3.mainRes = -1
			iter_66_3.packageId = 0
			iter_66_3.packageOrder = 0
			iter_66_3.blockId = var_66_1
			var_66_1 = var_66_1 + 1
		end

		arg_65_0:savePackageMapParam(arg_65_1, var_66_0)
	end)
end

function var_0_0.deletePackageJson(arg_67_0, arg_67_1)
	arg_67_0:getDebugPackageInfo(function(arg_68_0)
		for iter_68_0, iter_68_1 in ipairs(arg_68_0) do
			if iter_68_1.packageMapId == arg_67_1 then
				table.remove(arg_68_0, iter_68_0)

				break
			end
		end

		arg_67_0:_refreshPackageOrder(arg_68_0)

		arg_67_0._tempPackageConfig = arg_68_0

		local var_68_0 = LuaUtil.deepCopyNoMeta(arg_68_0)

		arg_67_0:_clearPackageInfo(var_68_0)

		local var_68_1, var_68_2 = arg_67_0:_getAllInfo(var_68_0)
		local var_68_3 = arg_67_0:_jsonEncode(var_68_0)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		local var_68_4 = arg_67_0:_replaceInfoStr(var_68_3, var_68_1, var_68_2)
		local var_68_5 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath)

		SLFramework.FileHelper.WriteTextToPath(var_68_5, var_68_4)
		arg_67_0:savePackageDataParam(arg_68_0)
		arg_67_0:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function var_0_0.renamePackageJson(arg_69_0, arg_69_1, arg_69_2)
	arg_69_0:getDebugPackageInfo(function(arg_70_0)
		local var_70_0

		for iter_70_0, iter_70_1 in ipairs(arg_70_0) do
			if iter_70_1.packageMapId == arg_69_1 then
				iter_70_1.packageName = arg_69_2
				var_70_0 = iter_70_1

				break
			end
		end

		if var_70_0 then
			arg_69_0:savePackageMapParam(arg_69_1, var_70_0)
		end
	end)
end

function var_0_0.changePackageMapIdJson(arg_71_0, arg_71_1, arg_71_2)
	arg_71_0:getDebugPackageInfo(function(arg_72_0)
		local var_72_0

		for iter_72_0, iter_72_1 in ipairs(arg_72_0) do
			if iter_72_1.packageMapId == arg_71_1 then
				iter_72_1.packageMapId = arg_71_2
				var_72_0 = iter_72_1

				local var_72_1 = arg_71_0:_getNextBlockId(true, arg_71_2)

				for iter_72_2, iter_72_3 in ipairs(var_72_0.infos) do
					iter_72_3.blockId = var_72_1
					var_72_1 = var_72_1 + 1
				end

				break
			end
		end

		if var_72_0 then
			arg_71_0:savePackageMapParam(arg_71_2, var_72_0)
		end
	end)
end

function var_0_0.savePackageMapParam(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	arg_73_0:getDebugPackageInfo(function(arg_74_0)
		local var_74_0 = false

		for iter_74_0, iter_74_1 in ipairs(arg_74_0) do
			if iter_74_1.packageMapId == arg_73_1 then
				iter_74_1.infos = arg_73_2.infos
				iter_74_1.buildingInfos = arg_73_2.buildingInfos
				iter_74_1.packageName = arg_73_2.packageName
				var_74_0 = true

				break
			end
		end

		if not var_74_0 then
			table.insert(arg_74_0, {
				packageMapId = arg_73_1,
				infos = arg_73_2.infos,
				buildingInfos = arg_73_2.buildingInfos,
				packageName = arg_73_2.packageName
			})
		end

		arg_73_0:_refreshPackageOrder(arg_74_0)

		arg_73_0._tempPackageConfig = arg_74_0

		if arg_73_3 then
			return
		end

		local var_74_1 = LuaUtil.deepCopyNoMeta(arg_74_0)

		arg_73_0:_clearPackageInfo(var_74_1)

		local var_74_2, var_74_3 = arg_73_0:_getAllInfo(var_74_1)
		local var_74_4 = arg_73_0:_jsonEncode(var_74_1)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		local var_74_5 = arg_73_0:_replaceInfoStr(var_74_4, var_74_2, var_74_3)
		local var_74_6 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath)

		SLFramework.FileHelper.WriteTextToPath(var_74_6, var_74_5)
		arg_73_0:savePackageDataParam(arg_74_0)
		arg_73_0:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function var_0_0._getAllInfo(arg_75_0, arg_75_1)
	local var_75_0 = {}
	local var_75_1 = {}

	for iter_75_0, iter_75_1 in ipairs(arg_75_1) do
		local var_75_2 = {}

		for iter_75_2, iter_75_3 in ipairs(iter_75_1.infos) do
			var_75_2[iter_75_2] = arg_75_0:_jsonEncodeOrdered(iter_75_3, {
				"defineId",
				"mainRes",
				"x",
				"y",
				"rotate",
				"blockId"
			})
		end

		var_75_0[iter_75_0] = table.concat(var_75_2, ",\n")

		local var_75_3 = {}

		if iter_75_1.buildingInfos then
			for iter_75_4, iter_75_5 in ipairs(iter_75_1.buildingInfos) do
				var_75_3[iter_75_4] = arg_75_0:_jsonEncodeOrdered(iter_75_5, {
					"uid",
					"defineId",
					"use",
					"x",
					"y",
					"rotate",
					"resAreaDirection"
				})
			end
		end

		var_75_1[iter_75_0] = table.concat(var_75_3, ",\n")
	end

	return var_75_0, var_75_1
end

function var_0_0._replaceInfoStr(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	local var_76_0 = arg_76_1

	if arg_76_2 then
		local var_76_1 = 0

		var_76_0 = var_76_0:gsub("\"infos\":%b[]", function()
			var_76_1 = var_76_1 + 1

			return "\"infos\":[" .. arg_76_2[var_76_1] .. "]"
		end)
	end

	if arg_76_3 then
		local var_76_2 = 0

		var_76_0 = var_76_0:gsub("\"buildingInfos\":%b{}", "\"buildingInfos\":[]")
		var_76_0 = var_76_0:gsub("\"buildingInfos\":%b[]", function()
			var_76_2 = var_76_2 + 1

			return "\"buildingInfos\":[" .. arg_76_3[var_76_2] .. "]"
		end)
		var_76_0 = var_76_0:gsub("\"buildingInfos\":%[%]", "\"buildingInfos\":{}")
	end

	return var_76_0
end

function var_0_0._clearPackageInfo(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in ipairs(arg_79_1) do
		for iter_79_2, iter_79_3 in ipairs(iter_79_1.infos) do
			iter_79_3.packageId = nil
			iter_79_3.packageOrder = nil
		end

		table.sort(iter_79_1.infos, function(arg_80_0, arg_80_1)
			if arg_80_0.blockId ~= arg_80_1.blockId then
				return arg_80_0.blockId < arg_80_1.blockId
			end
		end)
	end

	table.sort(arg_79_1, function(arg_81_0, arg_81_1)
		if arg_81_0.packageMapId ~= arg_81_1.packageMapId then
			return arg_81_0.packageMapId < arg_81_1.packageMapId
		end
	end)
end

function var_0_0._refreshPackageOrder(arg_82_0, arg_82_1)
	local var_82_0 = {}

	for iter_82_0, iter_82_1 in ipairs(arg_82_1) do
		for iter_82_2, iter_82_3 in ipairs(iter_82_1.infos) do
			if iter_82_3.packageId and iter_82_3.packageId > 0 then
				var_82_0[iter_82_3.packageId] = var_82_0[iter_82_3.packageId] or {}
				var_82_0[iter_82_3.packageId][iter_82_3.mainRes] = var_82_0[iter_82_3.packageId][iter_82_3.mainRes] or {}

				table.insert(var_82_0[iter_82_3.packageId][iter_82_3.mainRes], iter_82_3)
			end
		end
	end

	for iter_82_4, iter_82_5 in pairs(var_82_0) do
		for iter_82_6, iter_82_7 in pairs(iter_82_5) do
			table.sort(iter_82_7, function(arg_83_0, arg_83_1)
				return arg_83_0.packageOrder < arg_83_1.packageOrder
			end)
		end
	end

	for iter_82_8, iter_82_9 in pairs(var_82_0) do
		for iter_82_10, iter_82_11 in pairs(iter_82_9) do
			for iter_82_12, iter_82_13 in ipairs(iter_82_11) do
				iter_82_13.packageOrder = iter_82_12

				local var_82_1 = RoomMapBlockModel.instance:getFullBlockMOById(iter_82_13.blockId)

				if var_82_1 then
					var_82_1.packageOrder = iter_82_13.packageOrder
				end
			end
		end
	end
end

function var_0_0.savePackageDataParam(arg_84_0, arg_84_1)
	local var_84_0 = {}

	for iter_84_0, iter_84_1 in ipairs(arg_84_1) do
		for iter_84_2, iter_84_3 in ipairs(iter_84_1.infos) do
			if iter_84_3.packageId and iter_84_3.packageId ~= 0 then
				local var_84_1

				for iter_84_4, iter_84_5 in ipairs(var_84_0) do
					if iter_84_5.id == iter_84_3.packageId then
						var_84_1 = iter_84_5

						break
					end
				end

				if not var_84_1 then
					var_84_1 = {
						id = iter_84_3.packageId,
						infos = {}
					}

					JsonUtil.markAsArray(var_84_1.infos)
					table.insert(var_84_0, var_84_1)
				end

				if iter_84_3.mainRes and iter_84_3.mainRes >= 0 then
					table.insert(var_84_1.infos, {
						blockId = iter_84_3.blockId,
						defineId = iter_84_3.defineId,
						mainRes = iter_84_3.mainRes,
						packageOrder = iter_84_3.packageOrder,
						ownType = var_0_1[iter_84_3.packageId] or 0
					})
				end
			end
		end
	end

	for iter_84_6, iter_84_7 in ipairs(var_84_0) do
		table.sort(iter_84_7.infos, function(arg_85_0, arg_85_1)
			if arg_85_0.packageOrder ~= arg_85_1.packageOrder then
				return arg_85_0.packageOrder < arg_85_1.packageOrder
			end

			return arg_85_0.blockId < arg_85_1.blockId
		end)

		for iter_84_8, iter_84_9 in ipairs(iter_84_7.infos) do
			iter_84_9.packageOrder = nil
		end
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	JsonUtil.markAsArray(var_84_0)

	local var_84_2 = arg_84_0:_jsonEncode(var_84_0)
	local var_84_3 = arg_84_0:_wrapClientConfigParam(var_84_0, "block_package_data")
	local var_84_4 = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_package_data.json")
	local var_84_5 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageDataPath)

	SLFramework.FileHelper.WriteTextToPath(var_84_4, var_84_2)
	SLFramework.FileHelper.WriteTextToPath(var_84_5, var_84_3)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		local var_84_6 = GameSceneMgr.instance:getCurScene()
		local var_84_7 = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block.json")

		loadAbAsset(RoomEnum.BlockPath, false, function(arg_86_0)
			if arg_86_0.IsLoadSuccess then
				local var_86_0 = arg_86_0:GetResource(RoomEnum.BlockPath)
				local var_86_1 = cjson.decode(var_86_0.text)[2]
				local var_86_2 = {}

				for iter_86_0, iter_86_1 in ipairs(var_86_1) do
					table.insert(var_86_2, {
						defineId = iter_86_1.defineId,
						resourceIds = iter_86_1.resourceIds,
						category = iter_86_1.category,
						prefabPath = iter_86_1.prefabPath
					})
				end

				SLFramework.FileHelper.WriteTextToPath(var_84_7, arg_84_0:_jsonEncode(var_86_2))
			end
		end)
	end

	arg_84_0:_saveBlockPrefabExcelData(var_84_0)
end

function var_0_0._saveBlockPrefabExcelData(arg_87_0, arg_87_1)
	local var_87_0 = "blockId resName packageId"

	for iter_87_0, iter_87_1 in ipairs(arg_87_1) do
		if var_0_1[iter_87_1.id] and iter_87_1.infos then
			for iter_87_2, iter_87_3 in ipairs(iter_87_1.infos) do
				local var_87_1 = RoomConfig.instance:getBlockDefineConfig(iter_87_3.defineId)

				if var_87_1 then
					var_87_0 = string.format("%s\n%s %s %s", var_87_0, iter_87_3.blockId, RoomHelper.getBlockPrefabName(var_87_1.prefabPath), iter_87_1.id)
				end
			end
		end
	end

	local var_87_2 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, "../../roomTempData/blockPrefabPath.txt")

	SLFramework.FileHelper.WriteTextToPath(var_87_2, var_87_0)
	logNormal("生成excel格式独立地块的id和资源名字的数据,导入excel方式：数据->从文本/CSV。\n文件路径：" .. var_87_2)
end

function var_0_0.debugMoveAllMap(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = RoomCameraController.instance:getRoomScene()

	if not var_88_0 or not arg_88_1 or not arg_88_2 then
		return
	end

	RoomMapBuildingModel.instance:debugMoveAllBuilding(arg_88_1, arg_88_2)
	var_88_0.buildingmgr:refreshAllBlockEntity()
	RoomMapBlockModel.instance:debugMoveAllBlock(arg_88_1, arg_88_2)
	var_88_0.mapmgr:refreshAllBlockEntity(SceneTag.RoomMapBlock)
	var_88_0.mapmgr:refreshAllBlockEntity(SceneTag.RoomEmptyBlock)
end

function var_0_0.assetDatabaseRefresh(arg_89_0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("UnityEditor")

	local var_89_0 = tolua.gettypemethod(typeof("UnityEditor.AssetDatabase"), "Refresh", System.Array.CreateInstance(typeof("System.Type"), 0))

	var_89_0:Call()
	var_89_0:Destroy()
end

function var_0_0.output(arg_90_0, arg_90_1)
	if RoomController.instance:isDebugInitMode() then
		local var_90_0 = RoomModel.instance:getDebugParam()

		arg_90_0:outputInitJson(arg_90_1)
	elseif RoomController.instance:isDebugPackageMode() then
		local var_90_1 = RoomModel.instance:getDebugParam()

		arg_90_0:outputPackageJson(var_90_1.packageMapId, arg_90_1)
	end
end

function var_0_0.outputFishing(arg_91_0)
	local var_91_0 = FishingEnum.Const.DefaultMapId
	local var_91_1 = {}
	local var_91_2 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_91_0, iter_91_1 in ipairs(var_91_2) do
		if iter_91_1.blockState == RoomBlockEnum.BlockState.Map then
			local var_91_3 = {
				mapId = var_91_0,
				fishingBlockId = iter_91_1.blockId,
				defineId = iter_91_1.defineId,
				mainRes = iter_91_1.mainRes,
				x = iter_91_1.hexPoint.x,
				y = iter_91_1.hexPoint.y,
				rotate = iter_91_1.rotate
			}
			local var_91_4 = arg_91_0:_jsonEncodeOrdered(var_91_3, {
				"mapId",
				"fishingBlockId",
				"defineId",
				"mainRes",
				"x",
				"y",
				"rotate"
			})

			table.insert(var_91_1, var_91_4)
		end
	end

	local var_91_5 = table.concat(var_91_1, ",\n")
	local var_91_6 = "[\"fishing_map_block\",[\n" .. var_91_5 .. "\n]]"
	local var_91_7 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.FishingMapBlockPath)

	SLFramework.FileHelper.WriteTextToPath(var_91_7, var_91_6)

	local var_91_8 = {}
	local var_91_9 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_91_2, iter_91_3 in ipairs(var_91_9) do
		if iter_91_3.config and iter_91_3.config.buildingType ~= RoomBuildingEnum.BuildingType.Fishing then
			local var_91_10 = {
				use = true,
				mapId = var_91_0,
				uid = iter_91_2,
				defineId = iter_91_3.buildingId,
				x = iter_91_3.hexPoint.x,
				y = iter_91_3.hexPoint.y,
				rotate = iter_91_3.rotate,
				resAreaDirection = iter_91_3.resAreaDirection
			}
			local var_91_11 = arg_91_0:_jsonEncodeOrdered(var_91_10, {
				"mapId",
				"uid",
				"defineId",
				"use",
				"x",
				"y",
				"rotate",
				"resAreaDirection"
			})

			table.insert(var_91_8, var_91_11)
		end
	end

	local var_91_12 = table.concat(var_91_8, ",\n")
	local var_91_13 = "[\"fishing_map_building\",[\n" .. var_91_12 .. "\n]]"
	local var_91_14 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.FishingMapBuildingPath)

	SLFramework.FileHelper.WriteTextToPath(var_91_14, var_91_13)
	arg_91_0:output()
end

function var_0_0._wrapClientConfigParam(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = {}

	JsonUtil.markAsArray(var_92_0)
	table.insert(var_92_0, arg_92_2)
	table.insert(var_92_0, arg_92_1)

	return arg_92_0:_jsonEncode(var_92_0)
end

function var_0_0._jsonEncode(arg_93_0, arg_93_1)
	local var_93_0 = JsonUtil.encode(arg_93_1)

	return (string.gsub(var_93_0, "},{", "},\n{"))
end

function var_0_0._jsonEncodeOrdered(arg_94_0, arg_94_1, arg_94_2)
	local var_94_0 = {}
	local var_94_1 = {}

	for iter_94_0, iter_94_1 in ipairs(arg_94_2) do
		if arg_94_1[iter_94_1] ~= nil then
			table.insert(var_94_0, string.format("%q:%s", iter_94_1, cjson.encode(arg_94_1[iter_94_1])))
		end

		var_94_1[iter_94_1] = true
	end

	for iter_94_2, iter_94_3 in pairs(arg_94_1) do
		if not var_94_1[iter_94_2] then
			logError(string.format("RoomDebugController:_jsonEncodeOrdered error, no specific key order, key:%s", iter_94_2))
		end
	end

	return "{" .. table.concat(var_94_0, ",") .. "}"
end

var_0_0.instance = var_0_0.New()

return var_0_0
