module("modules.logic.room.controller.RoomDebugController", package.seeall)

slot0 = class("RoomDebugController", BaseController)
slot1 = {
	[16.0] = 1
}

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0._isDebugPlaceListShow = false
	slot0._isDebugPackageListShow = false
	slot0._isDebugBuildingListShow = false
	slot0._tempInitConfig = nil
	slot0._tempPackageConfig = nil
	slot0._editPackageOrder = false
end

function slot0.addConstEvents(slot0)
end

function slot0.setEditPackageOrder(slot0, slot1)
	slot0._editPackageOrder = slot1

	slot0:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function slot0.isEditPackageOrder(slot0)
	return slot0._editPackageOrder
end

function slot0.getTempInitConfig(slot0)
	return slot0._tempInitConfig
end

function slot0.getTempPackageConfig(slot0)
	return slot0._tempPackageConfig
end

function slot0.getUseCountByDefineId(slot0, slot1)
	slot3 = 0

	if slot0:getTempPackageConfig() then
		for slot7, slot8 in ipairs(slot2) do
			for slot12, slot13 in ipairs(slot8.infos) do
				if slot13.defineId == slot1 then
					slot3 = slot3 + 1
				end
			end
		end
	end

	return slot3
end

function slot0.openBuildingAreaView(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingAreaView)
end

function slot0.openBuildingCamerView(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugBuildingCameraView)
end

function slot0.setDebugPlaceListShow(slot0, slot1)
	slot0._isDebugPlaceListShow = slot1

	slot0:dispatchEvent(RoomEvent.DebugPlaceListShowChanged, slot1)
end

function slot0.isDebugPlaceListShow(slot0)
	return slot0._isDebugPlaceListShow
end

function slot0.setDebugPackageListShow(slot0, slot1)
	slot0._isDebugPackageListShow = slot1

	slot0:dispatchEvent(RoomEvent.DebugPackageListShowChanged, slot1)
end

function slot0.isDebugPackageListShow(slot0)
	return slot0._isDebugPackageListShow
end

function slot0.setDebugBuildingListShow(slot0, slot1)
	slot0._isDebugBuildingListShow = slot1

	slot0:dispatchEvent(RoomEvent.DebugBuildingListShowChanged, slot1)
end

function slot0.isDebugBuildingListShow(slot0)
	return slot0._isDebugBuildingListShow
end

function slot0._getNextPackageOrder(slot0, slot1, slot2)
	slot3 = 0

	if slot0._tempPackageConfig then
		for slot7, slot8 in ipairs(slot0._tempPackageConfig) do
			for slot12, slot13 in ipairs(slot8.infos) do
				if slot13.packageId == slot1 and slot3 < slot13.packageOrder and slot13.blockId ~= slot2 then
					slot3 = slot13.packageOrder
				end
			end
		end
	end

	return slot3 + 1
end

function slot0._getNextBlockId(slot0, slot1, slot2)
	slot3 = 0
	slot4 = RoomMapBlockModel.instance:getFullBlockMOList()

	if slot1 then
		slot3 = slot2 * 1000

		if slot0._tempPackageConfig then
			for slot8, slot9 in ipairs(slot0._tempPackageConfig) do
				if slot9.packageMapId ~= slot2 then
					for slot13, slot14 in ipairs(slot9.infos) do
						if slot3 < slot14.blockId then
							slot3 = slot14.blockId
						end
					end
				end
			end
		end

		for slot8, slot9 in ipairs(slot4) do
			if slot3 < slot9.blockId then
				slot3 = slot9.blockId
			end
		end

		return slot3 + 1
	else
		for slot8, slot9 in ipairs(slot4) do
			if slot9.blockId < slot3 then
				slot3 = slot9.blockId
			end
		end

		return slot3 - 1
	end
end

function slot0._getNextBuildingUid(slot0)
	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if 0 < slot7.id then
			slot1 = slot7.id
		end
	end

	return slot1 + 1
end

function slot0.debugPlaceBlock(slot0, slot1)
	if not RoomDebugPlaceListModel.instance:getSelect() or slot2 == 0 then
		return
	end

	slot0:_debugPlaceBlock(slot1, slot2)
end

function slot0._debugPlaceBlock(slot0, slot1, slot2)
	slot3 = RoomController.instance:isDebugPackageMode()
	slot4 = RoomModel.instance:getDebugParam()
	slot5 = slot0:_getNextBlockId(slot3, slot3 and slot4 and slot4.packageMapId)

	for slot10 = 1, 6 do
		table.insert({}, RoomResourceEnum.ResourceId.None)
	end

	slot8, slot9 = RoomMapBlockModel.instance:debugConfirmPlaceBlock(slot1, {
		rotate = 0,
		blockId = slot5,
		defineId = slot2,
		mainRes = RoomResourceEnum.ResourceId.None,
		blockState = RoomBlockEnum.BlockState.Map,
		x = slot1.x,
		y = slot1.y
	})

	RoomMapBlockModel.instance:refreshNearRiver(slot1, 1)
	slot0:dispatchEvent(RoomEvent.DebugConfirmPlaceBlock, slot1, slot8, slot9)
	slot0:saveDebugMapParam()
	GameFacade.closeInputBox()
end

function slot0.debugRotateBlock(slot0, slot1)
	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y).blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	slot2.rotate = RoomRotateHelper.rotateRotate(slot2.rotate, 1)

	RoomMapBlockModel.instance:refreshNearRiver(slot1, 1)
	slot0:dispatchEvent(RoomEvent.DebugRotateBlock, slot1, slot2)
	slot0:saveDebugMapParam()
end

function slot0.debugRootOutBlock(slot0, slot1)
	if slot1.x == 0 and slot1.y == 0 then
		return
	end

	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y).blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	RoomMapBlockModel.instance:refreshNearRiver(slot1, 1)
	slot0:dispatchEvent(RoomEvent.DebugRootOutBlock, slot1, slot2, RoomMapBlockModel.instance:debugRootOutBlock(slot1))
	slot0:saveDebugMapParam()
end

function slot0.debugReplaceBlock(slot0, slot1)
	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y).blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	if not RoomDebugPlaceListModel.instance:getSelect() or slot3 == 0 then
		return
	end

	if slot3 == slot2.defineId then
		return
	end

	slot0:_debugReplaceBlock(slot1, slot3)
end

function slot0._debugReplaceBlock(slot0, slot1, slot2)
	if RoomMapBlockModel.instance:getBlockMO(slot1.x, slot1.y).blockState ~= RoomBlockEnum.BlockState.Map then
		return
	end

	slot3.defineId = slot2

	slot0:dispatchEvent(RoomEvent.DebugReplaceBlock, slot1, slot3)
	GameFacade.closeInputBox()
end

function slot0.debugSetPackage(slot0, slot1)
	if not RoomDebugPackageListModel.instance:getFilterPackageId() or slot2 == 0 then
		return
	end

	slot0:debugSetPackageId(slot1, slot2)
end

function slot0.debugSetPackageId(slot0, slot1, slot2)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	slot4 = RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty

	if slot2 == 0 then
		slot3.packageOrder = 0
		slot3.mainRes = RoomResourceEnum.ResourceId.Empty
	else
		slot3.packageOrder = slot3.packageId == slot2 and slot3.packageOrder or slot0:_getNextPackageOrder(slot2, slot3.blockId)
		slot3.mainRes = slot4
	end

	slot3.packageId = slot2

	slot0:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	slot0:dispatchEvent(RoomEvent.DebugSetPackage, RoomMapBlockModel.instance:getFullBlockMOById(slot1) and slot5.hexPoint, slot5)
	GameFacade.closeInputBox()
end

function slot0.debugSetMainRes(slot0, slot1)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	GameFacade.openInputBox({
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置分类",
		cancelBtnName = "取消",
		defaultInput = tostring(slot2.mainRes or -1),
		sureCallback = function (slot0)
			uv0:_debugSetMainRes(uv1, tonumber(slot0))
		end
	})
end

function slot0._debugSetMainRes(slot0, slot1, slot2)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	if not slot2 then
		return
	end

	slot3.mainRes = slot2

	uv0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	uv0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function slot0.debugSetPackageOrder(slot0, slot1)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	GameFacade.openInputBox({
		characterLimit = 100,
		sureBtnName = "确定",
		title = "设置排序",
		cancelBtnName = "取消",
		defaultInput = tostring(slot2.packageOrder or 0),
		sureCallback = function (slot0)
			uv0:_debugSetPackageOrder(uv1, tonumber(slot0))
		end
	})
end

function slot0.debugSetPackageLastOrder(slot0, slot1)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	if slot2.packageId == 0 then
		return
	end

	slot0:_debugSetPackageOrder(slot1, slot0:_getNextPackageOrder(slot2.packageId, slot1))
end

function slot0._debugSetPackageOrder(slot0, slot1, slot2)
	if not slot0:getBlockInfoOrBlockMO(slot1) then
		return
	end

	if not slot2 then
		return
	end

	slot3.packageOrder = slot2

	uv0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	GameFacade.closeInputBox()
	uv0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function slot0.exchangeOrder(slot0, slot1, slot2)
	slot3 = slot0:getBlockInfoOrBlockMO(slot1)
	slot4 = slot0:getBlockInfoOrBlockMO(slot2)
	slot4.packageOrder = slot3.packageOrder
	slot3.packageOrder = slot4.packageOrder

	uv0.instance:output(true)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	uv0.instance:dispatchEvent(RoomEvent.DebugPackageOrderChanged)
end

function slot0.getBlockInfoOrBlockMO(slot0, slot1)
	if RoomMapBlockModel.instance:getFullBlockMOById(slot1) then
		return slot2
	end

	if not slot0._tempPackageConfig then
		return nil
	end

	for slot6, slot7 in ipairs(slot0._tempPackageConfig) do
		for slot11, slot12 in ipairs(slot7.infos) do
			if slot12.blockId == slot1 then
				return slot12
			end
		end
	end
end

function slot0.debugPlaceBuilding(slot0, slot1)
	if not RoomDebugBuildingListModel.instance:getSelect() then
		return
	end

	slot0:_debugPlaceBuilding(slot1, slot2)
end

function slot0._debugPlaceBuilding(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getBuildingMO(slot1.x, slot1.y) then
		if slot3.buildingId == slot2 then
			return
		else
			uv0.instance:debugRootOutBuilding(slot1)
		end
	end

	if not (slot2 and RoomConfig.instance:getBuildingConfig(slot2)) then
		return
	end

	GameFacade.closeInputBox()

	slot5 = slot0:_getNextBuildingUid()
	slot8 = {}

	for slot12, slot13 in ipairs(RoomMapModel.instance:getBuildingConfigParam(slot2).levelGroups) do
		table.insert(slot8, RoomConfig.instance:getLevelGroupMaxLevel(slot13))
	end

	RoomMapBuildingModel.instance:clearAllOccupyDict()
	slot0:dispatchEvent(RoomEvent.DebugPlaceBuilding, slot1, RoomMapBuildingModel.instance:debugPlaceBuilding(slot1, {
		resAreaDirection = 0,
		rotate = 0,
		uid = slot5,
		buildingId = slot2,
		levels = slot8,
		buildingState = RoomBuildingEnum.BuildingState.Map,
		x = slot1.x,
		y = slot1.y
	}))
	slot0:saveDebugMapParam()
end

function slot0.debugRotateBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMO(slot1.x, slot1.y) then
		return
	end

	slot2.rotate = RoomRotateHelper.rotateRotate(slot2.rotate, 1)

	RoomMapBuildingModel.instance:clearAllOccupyDict()
	slot0:dispatchEvent(RoomEvent.DebugRotateBuilding, slot1, slot2, slot2.rotate)
	slot0:saveDebugMapParam()
end

function slot0.debugRootOutBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMO(slot1.x, slot1.y) then
		return
	end

	RoomMapBuildingModel.instance:debugRootOutBuilding(slot1)
	RoomMapBuildingModel.instance:clearAllOccupyDict()
	slot0:dispatchEvent(RoomEvent.DebugRootOutBuilding, slot1, slot2)
	slot0:saveDebugMapParam()
end

function slot0.getEmptyMapInfo(slot0, slot1, slot2)
	return {
		infos = {
			{
				packageId = 0,
				rotate = 0,
				packageOrder = 0,
				x = 0,
				y = 0,
				blockId = slot0:_getNextBlockId(slot1, slot2),
				defineId = RoomResourceEnum.EmptyDefineId,
				mainRes = RoomResourceEnum.ResourceId.Empty
			}
		}
	}
end

function slot0.getEmptyInitInfo(slot0)
	return {
		infos = slot0:getEmptyMapInfo().infos
	}
end

function slot0.getEmptyPackageInfo(slot0)
	return {}
end

function slot0.generateMapInfo(slot0, slot1, slot2)
	slot2 = slot2 or RoomMapBuildingModel.instance:getBuildingMOList()
	slot3 = {
		infos = {}
	}
	slot4 = #(slot1 or RoomMapBlockModel.instance:getFullBlockMOList())

	for slot9, slot10 in ipairs(slot1) do
		if slot10.blockState == RoomBlockEnum.BlockState.Map then
			if RoomController.instance:isDebugPackageMode() then
				-- Nothing
			end

			table.insert(slot3.infos, {
				blockId = slot10.blockId,
				defineId = slot10.defineId,
				mainRes = slot10.mainRes,
				y = slot10.hexPoint.y,
				x = slot10.hexPoint.x,
				rotate = slot10.rotate,
				packageId = slot10.packageId or 0,
				packageOrder = slot10.packageOrder or slot10.blockId
			})
		end
	end

	slot3.buildingInfos = {}

	for slot9, slot10 in ipairs(slot2) do
		table.insert(slot3.buildingInfos, {
			uid = slot9,
			defineId = slot10.buildingId,
			use = true,
			x = slot10.hexPoint.x,
			y = slot10.hexPoint.y,
			rotate = slot10.rotate,
			resAreaDirection = slot10.resAreaDirection
		})
	end

	return slot3
end

function slot0.getDebugMapInfo(slot0)
	slot1 = nil
	slot1 = (not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.RoomDebugMapParam, "")) or slot0:getEmptyMapInfo()) and cjson.decode(slot2)
	slot1.remainBlock = 0

	return slot1
end

function slot0.saveDebugMapParam(slot0)
	if not RoomController.instance:isDebugNormalMode() then
		return
	end

	if #slot0:generateMapInfo().infos > 0 then
		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, cjson.encode(slot1))
	end
end

function slot0.getDebugInitInfo(slot0, slot1, slot2)
	if slot0._tempInitConfig then
		if slot1 then
			if slot2 then
				slot1(slot2, slot0._tempInitConfig)
			else
				slot1(slot0._tempInitConfig)
			end
		end

		return
	end

	loadAbAsset(RoomEnum.InitMapConfigPathEditor, false, function (slot0)
		slot1 = nil
		uv0._tempInitConfig = (not slot0.IsLoadSuccess or cjson.decode(slot0:GetResource(RoomEnum.InitMapConfigPathEditor).text)) and uv0:getEmptyInitInfo()

		if uv1 then
			if uv2 then
				uv1(uv2, slot1)
			else
				uv1(slot1)
			end
		end
	end)
end

function slot0.getDebugInitMapInfo(slot0, slot1, slot2, slot3)
	slot0:getDebugInitInfo(function (slot0)
		if not ({
			infos = slot0.infos
		}).infos then
			slot1 = uv0:getEmptyMapInfo()
		end

		if uv1 then
			if uv2 then
				uv1(uv2, slot1)
			else
				uv1(slot1)
			end
		end
	end)
end

function slot0.outputInitJson(slot0, slot1)
	slot0:getDebugInitInfo(function (slot0)
		slot1 = uv0:generateMapInfo()
		slot1.buildingInfos = nil
		slot0.infos = slot1.infos

		uv0:saveInitMapParam(slot0, uv1)
	end)
end

function slot0.resetInitJson(slot0)
	slot0:getDebugInitInfo(function (slot0)
		slot0.infos = uv0:getEmptyMapInfo().infos

		uv0:saveInitMapParam(slot0)
	end)
end

function slot0.saveInitMapParam(slot0, slot1, slot2)
	slot0._tempInitConfig = slot1

	if slot2 then
		return
	end

	slot3 = cjson.encode(slot1)
	slot4 = slot0:_wrapClientConfigParam(slot1, "block_init")

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPathEditor), slot3)
	SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.InitMapConfigPath), slot4)
	SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_init.json"), slot3)
	slot0:assetDatabaseRefresh()
	logNormal("导出完成 记得提交前后端配置文件")
end

function slot0.getDebugPackageInfo(slot0, slot1, slot2)
	if slot0._tempPackageConfig then
		if slot1 then
			if slot2 then
				slot1(slot2, slot0._tempPackageConfig)
			else
				slot1(slot0._tempPackageConfig)
			end
		end

		return
	end

	MultiAbLoader.New():addPath(RoomEnum.BlockPackageMapPath)

	if SLFramework.FrameworkSettings.IsEditor then
		slot3:addPath(RoomEnum.BlockPackageDataPath)
	end

	slot3:startLoad(function ()
		slot4 = cjson.decode(uv0:getAssetItemDict()[RoomEnum.BlockPackageMapPath]:GetResource(RoomEnum.BlockPackageMapPath).text)

		if SLFramework.FrameworkSettings.IsEditor then
			uv1:_injectPackageInfo(slot4, cjson.decode(slot0[RoomEnum.BlockPackageDataPath]:GetResource(RoomEnum.BlockPackageDataPath).text)[2])
		end

		uv1:_refreshPackageOrder(slot4)

		uv1._tempPackageConfig = slot4

		if uv2 then
			if uv3 then
				uv2(uv3, slot4)
			else
				uv2(slot4)
			end
		end

		uv0:dispose()
	end)
end

function slot0._injectPackageInfo(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		for slot13, slot14 in ipairs(slot8.infos) do
			slot3[slot14.blockId] = {
				packageId = slot8.id,
				packageOrder = slot13
			}
		end
	end

	for slot7, slot8 in ipairs(slot1) do
		for slot12, slot13 in ipairs(slot8.infos) do
			slot13.packageId = slot3[slot13.blockId] and slot14.packageId or 0
			slot13.packageOrder = slot14 and slot14.packageOrder or 0
		end
	end
end

function slot0.getDebugPackageMapInfo(slot0, slot1, slot2, slot3)
	slot4 = slot1 and slot1.packageMapId

	slot0:getDebugPackageInfo(function (slot0)
		for slot5, slot6 in ipairs(slot0) do
			if slot6.packageMapId == uv0 then
				break
			end
		end

		if not ({
			infos = slot6.infos,
			buildingInfos = slot6.buildingInfos,
			packageName = slot6.packageName
		}).infos then
			slot1 = uv1:getEmptyMapInfo(true, uv0)
		end

		if uv2 then
			if uv3 then
				uv2(uv3, slot1)
			else
				uv2(slot1)
			end
		end
	end)
end

function slot0.outputPackageJson(slot0, slot1, slot2)
	slot0:getDebugPackageMapInfo({
		packageMapId = slot1
	}, function (slot0)
		slot1 = uv0:generateMapInfo()
		slot0.infos = slot1.infos
		slot0.buildingInfos = slot1.buildingInfos

		uv0:savePackageMapParam(uv1, slot0, uv2)
	end)
end

function slot0.resetPackageJson(slot0, slot1, slot2)
	slot0:savePackageMapParam(slot1, {
		infos = slot0:getEmptyMapInfo(true, slot1).infos,
		buildingInfos = nil,
		packageName = slot2
	})
end

function slot0.copyPackageJson(slot0, slot1, slot2, slot3)
	slot0:getDebugPackageInfo(function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(slot0) do
			if slot6.packageMapId == uv0 then
				slot1 = LuaUtil.deepCopyNoMeta(slot6)

				break
			end
		end

		if not slot1 then
			return
		end

		slot1.packageName = uv1
		slot6 = uv3
		slot2 = uv2:_getNextBlockId(true, slot6)

		for slot6, slot7 in ipairs(slot1.infos) do
			slot7.mainRes = -1
			slot7.packageId = 0
			slot7.packageOrder = 0
			slot7.blockId = slot2
			slot2 = slot2 + 1
		end

		uv2:savePackageMapParam(uv3, slot1)
	end)
end

function slot0.deletePackageJson(slot0, slot1)
	slot0:getDebugPackageInfo(function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if slot5.packageMapId == uv0 then
				table.remove(slot0, slot4)

				break
			end
		end

		uv1:_refreshPackageOrder(slot0)

		uv1._tempPackageConfig = slot0
		slot1 = LuaUtil.deepCopyNoMeta(slot0)

		uv1:_clearPackageInfo(slot1)

		slot2 = uv1:_jsonEncode(slot1)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath), slot2)
		uv1:savePackageDataParam(slot0)
		uv1:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function slot0.renamePackageJson(slot0, slot1, slot2)
	slot0:getDebugPackageInfo(function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(slot0) do
			if slot6.packageMapId == uv0 then
				slot6.packageName = uv1
				slot1 = slot6

				break
			end
		end

		if slot1 then
			uv2:savePackageMapParam(uv0, slot1)
		end
	end)
end

function slot0.savePackageMapParam(slot0, slot1, slot2, slot3)
	slot0:getDebugPackageInfo(function (slot0)
		slot1 = false

		for slot5, slot6 in ipairs(slot0) do
			if slot6.packageMapId == uv0 then
				slot6.infos = uv1.infos
				slot6.buildingInfos = uv1.buildingInfos
				slot6.packageName = uv1.packageName
				slot1 = true

				break
			end
		end

		if not slot1 then
			table.insert(slot0, {
				packageMapId = uv0,
				infos = uv1.infos,
				buildingInfos = uv1.buildingInfos,
				packageName = uv1.packageName
			})
		end

		uv2:_refreshPackageOrder(slot0)

		uv2._tempPackageConfig = slot0

		if uv3 then
			return
		end

		slot2 = LuaUtil.deepCopyNoMeta(slot0)

		uv2:_clearPackageInfo(slot2)

		slot3 = uv2:_jsonEncode(slot2)

		if not SLFramework.FrameworkSettings.IsEditor then
			return
		end

		SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageMapPath), slot3)
		uv2:savePackageDataParam(slot0)
		uv2:assetDatabaseRefresh()
		logNormal("导出完成 记得提交前后端配置文件")
	end)
end

function slot0._clearPackageInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		for slot10, slot11 in ipairs(slot6.infos) do
			slot11.packageId = nil
			slot11.packageOrder = nil
		end

		table.sort(slot6.infos, function (slot0, slot1)
			if slot0.blockId ~= slot1.blockId then
				return slot0.blockId < slot1.blockId
			end
		end)
	end

	table.sort(slot1, function (slot0, slot1)
		if slot0.packageMapId ~= slot1.packageMapId then
			return slot0.packageMapId < slot1.packageMapId
		end
	end)
end

function slot0._refreshPackageOrder(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot7.infos) do
			if slot12.packageId and slot12.packageId > 0 then
				slot2[slot12.packageId] = slot2[slot12.packageId] or {}
				slot2[slot12.packageId][slot12.mainRes] = slot2[slot12.packageId][slot12.mainRes] or {}

				table.insert(slot2[slot12.packageId][slot12.mainRes], slot12)
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			table.sort(slot12, function (slot0, slot1)
				return slot0.packageOrder < slot1.packageOrder
			end)
		end
	end

	for slot6, slot7 in pairs(slot2) do
		for slot11, slot12 in pairs(slot7) do
			for slot16, slot17 in ipairs(slot12) do
				slot17.packageOrder = slot16

				if RoomMapBlockModel.instance:getFullBlockMOById(slot17.blockId) then
					slot18.packageOrder = slot17.packageOrder
				end
			end
		end
	end
end

function slot0.savePackageDataParam(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot7.infos) do
			if slot12.packageId and slot12.packageId ~= 0 then
				slot13 = nil

				for slot17, slot18 in ipairs(slot2) do
					if slot18.id == slot12.packageId then
						slot13 = slot18

						break
					end
				end

				if not slot13 then
					slot13 = {
						id = slot12.packageId,
						infos = {}
					}

					JsonUtil.markAsArray(slot13.infos)
					table.insert(slot2, slot13)
				end

				if slot12.mainRes and slot12.mainRes >= 0 then
					table.insert(slot13.infos, {
						blockId = slot12.blockId,
						defineId = slot12.defineId,
						mainRes = slot12.mainRes,
						packageOrder = slot12.packageOrder,
						ownType = uv0[slot12.packageId] or 0
					})
				end
			end
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		function slot11(slot0, slot1)
			if slot0.packageOrder ~= slot1.packageOrder then
				return slot0.packageOrder < slot1.packageOrder
			end

			return slot0.blockId < slot1.blockId
		end

		table.sort(slot7.infos, slot11)

		for slot11, slot12 in ipairs(slot7.infos) do
			slot12.packageOrder = nil
		end
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	JsonUtil.markAsArray(slot2)
	SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block_package_data.json"), slot0:_jsonEncode(slot2))
	SLFramework.FileHelper.WriteTextToPath(System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, RoomEnum.BlockPackageDataPath), slot0:_wrapClientConfigParam(slot2, "block_package_data"))

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		slot8 = GameSceneMgr.instance:getCurScene()
		slot9 = System.IO.Path.Combine(UnityEngine.Application.dataPath, "../../../projm-server/projM-server-config/resources/T_block.json")

		loadAbAsset(RoomEnum.BlockPath, false, function (slot0)
			if slot0.IsLoadSuccess then
				slot3 = {}

				for slot7, slot8 in ipairs(cjson.decode(slot0:GetResource(RoomEnum.BlockPath).text)[2]) do
					table.insert(slot3, {
						defineId = slot8.defineId,
						resourceIds = slot8.resourceIds,
						category = slot8.category,
						prefabPath = slot8.prefabPath
					})
				end

				SLFramework.FileHelper.WriteTextToPath(uv0, uv1:_jsonEncode(slot3))
			end
		end)
	end

	slot0:_saveBlockPrefabExcelData(slot2)
end

function slot0._saveBlockPrefabExcelData(slot0, slot1)
	slot2 = "blockId resName packageId"

	for slot6, slot7 in ipairs(slot1) do
		if uv0[slot7.id] and slot7.infos then
			for slot11, slot12 in ipairs(slot7.infos) do
				if RoomConfig.instance:getBlockDefineConfig(slot12.defineId) then
					slot2 = string.format("%s\n%s %s %s", slot2, slot12.blockId, RoomHelper.getBlockPrefabName(slot13.prefabPath), slot7.id)
				end
			end
		end
	end

	slot3 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, "../../roomTempData/blockPrefabPath.txt")

	SLFramework.FileHelper.WriteTextToPath(slot3, slot2)
	logNormal("生成excel格式独立地块的id和资源名字的数据,导入excel方式：数据->从文本/CSV。\n文件路径：" .. slot3)
end

function slot0.assetDatabaseRefresh(slot0)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	require("tolua.reflection")
	tolua.loadassembly("UnityEditor")

	slot1 = tolua.gettypemethod(typeof("UnityEditor.AssetDatabase"), "Refresh", System.Array.CreateInstance(typeof("System.Type"), 0))

	slot1:Call()
	slot1:Destroy()
end

function slot0.output(slot0, slot1)
	if RoomController.instance:isDebugInitMode() then
		slot2 = RoomModel.instance:getDebugParam()

		slot0:outputInitJson(slot1)
	elseif RoomController.instance:isDebugPackageMode() then
		slot0:outputPackageJson(RoomModel.instance:getDebugParam().packageMapId, slot1)
	end
end

function slot0._wrapClientConfigParam(slot0, slot1, slot2)
	slot3 = {}

	JsonUtil.markAsArray(slot3)
	table.insert(slot3, slot2)
	table.insert(slot3, slot1)

	return slot0:_jsonEncode(slot3)
end

function slot0._jsonEncode(slot0, slot1)
	return string.gsub(JsonUtil.encode(slot1), "},{", "},\n{")
end

slot0.instance = slot0.New()

return slot0
