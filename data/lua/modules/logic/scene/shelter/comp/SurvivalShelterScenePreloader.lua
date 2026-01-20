-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterScenePreloader.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterScenePreloader", package.seeall)

local SurvivalShelterScenePreloader = class("SurvivalShelterScenePreloader", BaseSceneComp)

function SurvivalShelterScenePreloader:init(sceneId, levelId)
	self._loader = MultiAbLoader.New()

	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local list = tabletool.copy(mapCo.allBlockPaths)

	tabletool.addValues(list, mapCo.allBuildingPaths)
	self._loader:setPathList(list)
	self._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._loader:addPath(v)
	end

	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalShelterScenePreloader:_onPreloadFinish()
	self:dispatchEvent(SurvivalEvent.OnSurvivalPreloadFinish)
end

function SurvivalShelterScenePreloader:getRes(path)
	if not self._loader or self._loader.isLoading then
		return
	end

	local assetItem = self._loader:getAssetItem(path)

	if not assetItem then
		logError("no assetItem " .. path)

		return
	end

	return assetItem:GetResource(path)
end

function SurvivalShelterScenePreloader:getMapBlockAbPath()
	return "survival/scenes/map07"
end

function SurvivalShelterScenePreloader:onSceneClose(sceneId, levelId)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return SurvivalShelterScenePreloader
