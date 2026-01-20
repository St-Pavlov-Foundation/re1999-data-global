-- chunkname: @modules/logic/scene/rouge/comp/RougeSceneBgmComp.lua

module("modules.logic.scene.rouge.comp.RougeSceneBgmComp", package.seeall)

local RougeSceneBgmComp = class("RougeSceneBgmComp", BaseSceneComp)

function RougeSceneBgmComp:onScenePrepared(sceneId, levelId)
	self:changeBgm()
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, self.changeBgm, self)
end

function RougeSceneBgmComp:changeBgm()
	local layerCo = RougeMapModel.instance:getLayerCo()
	local bgmId = AudioEnum.Bgm.RougeMain

	if layerCo and layerCo.bgm ~= 0 then
		bgmId = layerCo.bgm
	end

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.RougeScene, bgmId, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
end

function RougeSceneBgmComp:onSceneClose(sceneId, levelId)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, self.changeBgm, self)
end

return RougeSceneBgmComp
