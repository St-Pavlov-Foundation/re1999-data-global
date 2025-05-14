module("modules.logic.room.mgr.RoomPreloadMgr", package.seeall)

local var_0_0 = class("RoomPreloadMgr", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.startPreload(arg_4_0)
	if arg_4_0._loader then
		arg_4_0._loader:dispose()
	end

	arg_4_0._loader = SequenceAbLoader.New()

	arg_4_0:_addPreloadList(arg_4_0:_getSceneLevel())
	arg_4_0:_addPreloadList(arg_4_0:_getView())
	arg_4_0:_addPreloadList(arg_4_0:_getUIUrlList())
	arg_4_0:_addPreloadList(arg_4_0:_getGOUrlList())
	arg_4_0:_addPreloadList(arg_4_0:_getAnimUrlList())
	arg_4_0:_addPreloadList(arg_4_0:_getBuildingUrlList())
	arg_4_0._loader:setConcurrentCount(#arg_4_0._loader._pathList / 5)
	RoomHelper.logElapse("++++++++++++ RoomPreloadMgr:startPreload, count = " .. #arg_4_0._loader._pathList)
	arg_4_0._loader:setOneFinishCallback(arg_4_0._onOneFinish)
	arg_4_0._loader:startLoad(arg_4_0._onLoadFinish, arg_4_0)
end

function var_0_0._onOneFinish(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:GetResource(arg_5_2.ResPath)
end

function var_0_0._onLoadFinish(arg_6_0, arg_6_1)
	RoomHelper.logElapse("---------------- RoomPreloadMgr:preloadFinish, count = " .. #arg_6_0._loader._pathList)
end

function var_0_0._addPreloadList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0._loader:addPath(iter_7_1)
	end
end

function var_0_0._getSceneLevel(arg_8_0)
	local var_8_0 = SceneConfig.instance:getSceneLevelCOs(RoomEnum.RoomSceneId)

	if var_8_0 then
		local var_8_1 = var_8_0[1].id

		return {
			ResUrl.getSceneLevelUrl(var_8_1)
		}
	end

	return {}
end

function var_0_0._getView(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = ViewMgr.instance:getSetting(ViewName.RoomView)

	table.insert(var_9_0, var_9_1.mainRes)

	if var_9_1.otherRes then
		for iter_9_0, iter_9_1 in ipairs(var_9_1.otherRes) do
			table.insert(var_9_0, iter_9_1)
		end
	end

	if var_9_1.tabRes then
		for iter_9_2, iter_9_3 in pairs(var_9_1.tabRes) do
			for iter_9_4, iter_9_5 in pairs(iter_9_3) do
				for iter_9_6, iter_9_7 in ipairs(iter_9_5) do
					table.insert(var_9_0, iter_9_7)
				end
			end
		end
	end

	return var_9_0
end

function var_0_0._getMapBlockUrlList(arg_10_0)
	local var_10_0 = {}

	table.insert(var_10_0, ResUrl.getRoomRes("ground/water/water"))
	table.insert(var_10_0, RoomScenePreloader.DefaultLand)
	table.insert(var_10_0, RoomScenePreloader.InitLand)
	table.insert(var_10_0, RoomScenePreloader.ReplaceLand)

	for iter_10_0, iter_10_1 in pairs(RoomRiverEnum.RiverBlockType) do
		table.insert(var_10_0, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, iter_10_1))
		table.insert(var_10_0, RoomResHelper.getMapRiverFloorResPath(iter_10_1))
	end

	for iter_10_2, iter_10_3 in pairs(RoomRiverEnum.LakeBlockType) do
		table.insert(var_10_0, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, iter_10_3))
	end

	for iter_10_4, iter_10_5 in pairs(RoomRiverEnum.LakeFloorType) do
		table.insert(var_10_0, RoomResHelper.getMapRiverFloorResPath(iter_10_5))
	end

	local var_10_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_10_6, iter_10_7 in ipairs(var_10_1) do
		table.insert(var_10_0, RoomResHelper.getBuildingPath(iter_10_7.buildingId, iter_10_7.level))
	end

	return var_10_0
end

function var_0_0._getUIUrlList(arg_11_0)
	local var_11_0 = {}

	if RoomController.instance:isDebugPackageMode() then
		table.insert(var_11_0, RoomScenePreloader.ResDebugPackageUI)
	end

	table.insert(var_11_0, RoomViewConfirm.prefabPath)

	return var_11_0
end

function var_0_0._getGOUrlList(arg_12_0)
	local var_12_0 = {}

	if RoomController.instance:isEditMode() then
		table.insert(var_12_0, RoomScenePreloader.ResEffectB)
		table.insert(var_12_0, RoomScenePreloader.ResVXPlacingHere)
		table.insert(var_12_0, RoomScenePreloader.ResSmoke)
	end

	if RoomController.instance:isObMode() then
		table.insert(var_12_0, RoomScenePreloader.ResEffectE)
		table.insert(var_12_0, RoomScenePreloader.ResEffectD01)
		table.insert(var_12_0, RoomScenePreloader.ResEffectD02)
		table.insert(var_12_0, RoomScenePreloader.ResEffectD05)
		table.insert(var_12_0, RoomScenePreloader.ResVXXuXian)
		table.insert(var_12_0, RoomScenePreloader.ResCharacterClickHelper)
		table.insert(var_12_0, RoomScenePreloader.ResEffectConfirmCharacter)
		table.insert(var_12_0, RoomScenePreloader.ResEffectCharacterShadow)
		table.insert(var_12_0, RoomScenePreloader.ResEffectPressingCharacter)
		table.insert(var_12_0, RoomScenePreloader.ResEffectPlaceCharacter)
	end

	if RoomController.instance:isVisitMode() then
		table.insert(var_12_0, RoomScenePreloader.ResEffectCharacterShadow)
	end

	for iter_12_0, iter_12_1 in ipairs(RoomScenePreloader.ResEffectWaveList) do
		table.insert(var_12_0, iter_12_1)
	end

	for iter_12_2, iter_12_3 in ipairs(RoomScenePreloader.ResEffectWaveWithRiverList) do
		table.insert(var_12_0, iter_12_3)
	end

	if RoomController.instance:isDebugPackageMode() then
		for iter_12_4, iter_12_5 in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(var_12_0, iter_12_5)
		end
	end

	for iter_12_6, iter_12_7 in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(var_12_0, iter_12_7)
	end

	table.insert(var_12_0, RoomScenePreloader.ResOcean)
	table.insert(var_12_0, RoomScenePreloader.ResFogParticle)

	if BootNativeUtil.isWindows() then
		table.insert(var_12_0, RoomScenePreloader.DiffuseGI)
	end

	return var_12_0
end

function var_0_0._getAnimUrlList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(RoomScenePreloader.ResAnim) do
		table.insert(var_13_0, iter_13_1)
	end

	return var_13_0
end

function var_0_0._getBuildingUrlList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = RoomResHelper.getBuildingPath(iter_14_1.buildingId, iter_14_1.level)

		table.insert(var_14_0, var_14_2)
	end

	table.insert(var_14_0, RoomScenePreloader.ResInitBuilding)

	return var_14_0
end

function var_0_0.dispose(arg_15_0)
	RoomHelper.logElapse("---------------- RoomPreloadMgr:dispose")

	if arg_15_0._loader then
		arg_15_0._loader:dispose()

		arg_15_0._loader = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
