-- chunkname: @modules/logic/scene/cachot/comp/CachotBGMComp.lua

module("modules.logic.scene.cachot.comp.CachotBGMComp", package.seeall)

local CachotBGMComp = class("CachotBGMComp", BaseSceneComp)

function CachotBGMComp:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._levelComp = self._scene.level

	self._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self.onLevelLoaded, self)
end

function CachotBGMComp:onLevelLoaded()
	local layer = 0
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		layer = rogueInfo.layer
	end

	local bgmId = V1a6_CachotEventConfig.instance:getBgmIdByLayer(layer)

	if bgmId then
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, bgmId)
	end
end

function CachotBGMComp:onSceneClose()
	self._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self.onLevelLoaded, self)
end

return CachotBGMComp
