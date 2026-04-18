-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneLevelComp.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneLevelComp", package.seeall)

local PartyGameSceneLevelComp = class("PartyGameSceneLevelComp", CommonSceneLevelComp)

function PartyGameSceneLevelComp:loadLevel(levelId)
	if self._isLoadingRes then
		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil

		self:releaseSceneEffectsLoader()
	end

	self._isLoadingRes = true
	self._levelId = levelId

	logNormal("PartyGameSceneLevelComp:_onLoadCallback load party game config start")
	PartyGame.Runtime.Configs.PGConfigLoader.Init(self._onLoadConfigEnd, self)
end

function PartyGameSceneLevelComp:_onLoadConfigEnd(isSuccess)
	if not isSuccess then
		logError("PartyGameSceneLevelComp:_onLoadConfig 失败")

		return
	end

	logNormal("PartyGameSceneLevelComp:LoadAsset start")
	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = PartyGameModel.instance:getCurGameResPath()

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function PartyGameSceneLevelComp:_onLoadCallback(assetItem)
	PartyGameSceneLevelComp.super._onLoadCallback(self, assetItem)

	local sceneGo = self:getSceneGo()

	if not sceneGo then
		return
	end

	local joltPhysicsWorldAdapter = sceneGo:GetComponent(typeof(PartyGame.Runtime.Games.Common.JoltPhysicsWorldAdapter))
	local curGame = PartyGameController.instance:getCurPartyGame()

	joltPhysicsWorldAdapter.connectNet = not curGame:getIsLocal()

	local mainPlayerUid = curGame:getMainPlayerUid()

	joltPhysicsWorldAdapter:Init(mainPlayerUid)
end

return PartyGameSceneLevelComp
