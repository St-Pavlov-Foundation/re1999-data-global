module("modules.logic.scene.rouge.comp.RougeSceneMap", package.seeall)

slot0 = class("RougeSceneMap", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.LoadingMap)
	slot0:loadMap()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onBeforeChangeMapInfo, slot0.onBeforeChangeMapInfo, slot0)
end

function slot0.loadMap(slot0)
	if slot0.loader then
		if slot0.loader.isLoading then
			logError(string.format("exist loading rouge scene, res : %s", slot0.resPath))

			return
		end

		slot0:clearLoader()
	end

	slot1 = RougeMapModel.instance:getMapType()
	slot0.resPath = RougeMapHelper.getMapResPath(slot1)

	RougeMapModel.instance:setLoadingMap(true)

	slot0.loader = MultiAbLoader.New()

	slot0.loader:addPath(slot0.resPath)
	RougeMapHelper.addMapOtherRes(slot1, slot0.loader)

	slot0.versions = RougeModel.instance:getVersion()

	RougeMapDLCResHelper.addMapDLCRes(slot1, slot0.versions, slot0.loader)
	slot0.loader:startLoad(slot0.onLoadCallback, slot0)
end

function slot0.onLoadCallback(slot0)
	slot0:destroyOldMapGo()

	slot0.mapGo = gohelper.clone(slot0.loader:getAssetItem(slot0.resPath):GetResource(), slot0:getCurScene():getSceneContainerGO())

	gohelper.setLayer(slot0.mapGo, UnityLayer.Scene, true)

	slot0.mapComp = RougeMapHelper.createMapComp(RougeMapModel.instance:getMapType())

	slot0.mapComp:init(slot0.mapGo)
	slot0.mapComp:handleOtherRes(slot0.loader)
	slot0.mapComp:handleDLCRes(slot0.loader, slot0.versions)
	RougeMapModel.instance:setLoadingMap(false)
	logNormal(string.format("load scene success, res : %s", slot0.resPath))
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onLoadMapDone)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0.mapComp:createMap()
end

function slot0.getMapSceneGo(slot0)
	return slot0.mapGo
end

function slot0.switchMap(slot0)
	slot0:loadMap()
end

function slot0.onChangeMapInfo(slot0, slot1)
	slot0:loadMap()
end

function slot0.onBeforeChangeMapInfo(slot0)
	slot0:destroyOldMap()
end

function slot0.clearLoader(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

function slot0.destroyOldMap(slot0)
	if slot0.mapComp then
		slot0.mapComp:destroy()

		slot0.mapComp = nil
	end
end

function slot0.destroyOldMapGo(slot0)
	if slot0.mapGo then
		gohelper.destroy(slot0.mapGo)

		slot0.mapGo = nil
	end
end

function slot0.onSceneClose(slot0)
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Empty)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, slot0.onChangeMapInfo, slot0)
	slot0:clearLoader()
	slot0:destroyOldMap()
	slot0:destroyOldMapGo()
end

return slot0
