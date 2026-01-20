-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActPreloader.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActPreloader", package.seeall)

local SurvivalSummaryActPreloader = class("SurvivalSummaryActPreloader", SurvivalShelterScenePreloader)

function SurvivalSummaryActPreloader:init(sceneId, levelId)
	self._loader = MultiAbLoader.New()

	local list = {}

	tabletool.addValues(list, self:getSummaryActBlock())
	self._loader:setPathList(list)
	self._loader:addPath(SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes))

	local npcList = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	for k, v in ipairs(npcList) do
		local renown = SurvivalConfig.instance:getNpcRenown(v.id)

		if renown then
			self._loader:addPath(v.co.resource)
		end
	end

	self._loader:addPath(SurvivalShelterSceneFogComp.FogResPath)

	for k, v in pairs(SurvivalShelterScenePathComp.ResPaths) do
		self._loader:addPath(v)
	end

	self._loader:startLoad(self._onPreloadFinish, self)
end

function SurvivalSummaryActPreloader:getSummaryActBlock()
	local mapId = SurvivalConfig.instance:getCurShelterMapId()
	local co = lua_survival_shelter.configDict[mapId]
	local mapCo_SummaryAct = SurvivalConfig.instance:getShelterMapCo(co.mapId)
	local blocks = tabletool.copy(mapCo_SummaryAct.allBlockPaths)

	return blocks
end

return SurvivalSummaryActPreloader
