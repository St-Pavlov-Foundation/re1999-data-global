-- chunkname: @modules/logic/partygamelobby/scene/comp/PartyGameLobbySceneGraphicsComp.lua

module("modules.logic.partygamelobby.scene.comp.PartyGameLobbySceneGraphicsComp", package.seeall)

local PartyGameLobbySceneGraphicsComp = class("PartyGameLobbySceneGraphicsComp", BaseSceneComp)

function PartyGameLobbySceneGraphicsComp:onInit()
	return
end

function PartyGameLobbySceneGraphicsComp:onScenePrepared(sceneId, levelId)
	local mainCamera = CameraMgr.instance:getMainCamera()

	self._oriFlag = mainCamera.clearFlags
	mainCamera.clearFlags = UnityEngine.CameraClearFlags.Skybox
	self._oriFarClip = mainCamera.farClipPlane
	self._oriNearClip = mainCamera.nearClipPlane
	mainCamera.nearClipPlane = 5
	mainCamera.farClipPlane = 150
end

function PartyGameLobbySceneGraphicsComp:onSceneClose()
	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.clearFlags = self._oriFlag
	mainCamera.nearClipPlane = self._oriNearClip
	mainCamera.farClipPlane = self._oriFarClip
end

return PartyGameLobbySceneGraphicsComp
