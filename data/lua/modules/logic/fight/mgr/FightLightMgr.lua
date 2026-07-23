-- chunkname: @modules/logic/fight/mgr/FightLightMgr.lua

module("modules.logic.fight.mgr.FightLightMgr", package.seeall)

local FightLightMgr = class("FightLightMgr", FightBaseClass)

function FightLightMgr:onConstructor()
	local cameraRoot = CameraMgr.instance:getCameraRootGO()

	self.directLight = gohelper.findChildComponent(cameraRoot, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light))
	self.lightTransform = self.directLight.transform

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
end

function FightLightMgr:onLevelLoaded(levelId)
	local renderShadows = lua_fight_scene_level_camera_shadow.configDict[levelId]

	if renderShadows then
		self.setShadow = true
		self.rotationX, self.rotationY, self.rotationZ = transformhelper.getLocalRotation(self.lightTransform)

		local x = renderShadows.rotation[1] or 0
		local y = renderShadows.rotation[2] or 0
		local z = renderShadows.rotation[3] or 0

		transformhelper.setLocalRotation(self.lightTransform, x, y, z)

		self.directLight.shadows = UnityEngine.LightShadows.Soft
		self.lightShadowResolution = CameraMgr.instance:getMainLightShadowmapResolution()

		CameraMgr.instance:setMainLightShadowmapResolution(renderShadows.lightShadowResolution)

		self.shadowDepthBias = CameraMgr.instance:getShadowDepthBias()

		CameraMgr.instance:setShadowDepthBias(renderShadows.shadowDepthBias)

		self.shadowNormalBias = CameraMgr.instance:getShadowNormalBias()

		CameraMgr.instance:setShadowNormalBias(renderShadows.shadowNormalBias)
	end
end

function FightLightMgr:onDestructor()
	if self.setShadow then
		transformhelper.setLocalRotation(self.lightTransform, self.rotationX, self.rotationY, self.rotationZ)

		self.directLight.shadows = UnityEngine.LightShadows.None
	end

	if self.lightShadowResolution then
		CameraMgr.instance:setMainLightShadowmapResolution(self.lightShadowResolution)
	end

	if self.shadowDepthBias then
		CameraMgr.instance:setShadowDepthBias(self.shadowDepthBias)
	end

	if self.shadowNormalBias then
		CameraMgr.instance:setShadowNormalBias(self.shadowNormalBias)
	end
end

return FightLightMgr
