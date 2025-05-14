module("modules.logic.scene.rouge.comp.RougeSceneMap", package.seeall)

local var_0_0 = class("RougeSceneMap", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.LoadingMap)
	arg_1_0:loadMap()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, arg_1_0.onChangeMapInfo, arg_1_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeChangeMapInfo, arg_1_0.onBeforeChangeMapInfo, arg_1_0)
end

function var_0_0.loadMap(arg_2_0)
	if arg_2_0.loader then
		if arg_2_0.loader.isLoading then
			logError(string.format("exist loading rouge scene, res : %s", arg_2_0.resPath))

			return
		end

		arg_2_0:clearLoader()
	end

	local var_2_0 = RougeMapModel.instance:getMapType()

	arg_2_0.resPath = RougeMapHelper.getMapResPath(var_2_0)

	RougeMapModel.instance:setLoadingMap(true)

	arg_2_0.loader = MultiAbLoader.New()

	arg_2_0.loader:addPath(arg_2_0.resPath)
	RougeMapHelper.addMapOtherRes(var_2_0, arg_2_0.loader)

	arg_2_0.versions = RougeModel.instance:getVersion()

	RougeMapDLCResHelper.addMapDLCRes(var_2_0, arg_2_0.versions, arg_2_0.loader)
	arg_2_0.loader:startLoad(arg_2_0.onLoadCallback, arg_2_0)
end

function var_0_0.onLoadCallback(arg_3_0)
	arg_3_0:destroyOldMapGo()

	local var_3_0 = arg_3_0:getCurScene():getSceneContainerGO()
	local var_3_1 = arg_3_0.loader:getAssetItem(arg_3_0.resPath)

	arg_3_0.mapGo = gohelper.clone(var_3_1:GetResource(), var_3_0)

	gohelper.setLayer(arg_3_0.mapGo, UnityLayer.Scene, true)

	local var_3_2 = RougeMapModel.instance:getMapType()

	arg_3_0.mapComp = RougeMapHelper.createMapComp(var_3_2)

	arg_3_0.mapComp:init(arg_3_0.mapGo)
	arg_3_0.mapComp:handleOtherRes(arg_3_0.loader)
	arg_3_0.mapComp:handleDLCRes(arg_3_0.loader, arg_3_0.versions)
	RougeMapModel.instance:setLoadingMap(false)
	logNormal(string.format("load scene success, res : %s", arg_3_0.resPath))
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onLoadMapDone)
end

function var_0_0.onScenePrepared(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.mapComp:createMap()
end

function var_0_0.getMapSceneGo(arg_5_0)
	return arg_5_0.mapGo
end

function var_0_0.switchMap(arg_6_0)
	arg_6_0:loadMap()
end

function var_0_0.onChangeMapInfo(arg_7_0, arg_7_1)
	arg_7_0:loadMap()
end

function var_0_0.onBeforeChangeMapInfo(arg_8_0)
	arg_8_0:destroyOldMap()
end

function var_0_0.clearLoader(arg_9_0)
	if arg_9_0.loader then
		arg_9_0.loader:dispose()

		arg_9_0.loader = nil
	end
end

function var_0_0.destroyOldMap(arg_10_0)
	if arg_10_0.mapComp then
		arg_10_0.mapComp:destroy()

		arg_10_0.mapComp = nil
	end
end

function var_0_0.destroyOldMapGo(arg_11_0)
	if arg_11_0.mapGo then
		gohelper.destroy(arg_11_0.mapGo)

		arg_11_0.mapGo = nil
	end
end

function var_0_0.onSceneClose(arg_12_0)
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Empty)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, arg_12_0.onChangeMapInfo, arg_12_0)
	arg_12_0:clearLoader()
	arg_12_0:destroyOldMap()
	arg_12_0:destroyOldMapGo()
end

return var_0_0
