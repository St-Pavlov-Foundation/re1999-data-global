-- chunkname: @modules/logic/scene/fight/FightScene.lua

module("modules.logic.scene.fight.FightScene", package.seeall)

local FightScene = class("FightScene", BaseScene)

function FightScene:_createAllComps()
	self:_addComp("director", FightSceneDirector)
	self:_addComp("level", FightSceneLevelComp)
	self:_addComp("camera", FightSceneCameraComp)
	self:_addComp("view", FightSceneViewComp)
	self:_addComp("entityMgr", FightSceneEntityMgr)
	self:_addComp("preloader", FightScenePreloader)
	self:_addComp("cardCamera", FightSceneCardCameraComp)
	self:_addComp("mgr", FightSceneMgrComp)
	self:addLowPhoneMemoryComp()
end

function FightScene:addLowPhoneMemoryComp()
	if not SLFramework.FrameworkSettings.IsIOSPlayer() then
		return
	end

	local memo_G = UnityEngine.SystemInfo.systemMemorySize / 1024

	if memo_G > 3.6 then
		return
	end

	FightScene.ios3GBMemory = true

	logNormal(string.format("add FightSceneLowPhoneMemoryComp, memory : %G", memo_G))
	self:_addComp("lowPhoneMemoryMgr", FightSceneLowPhoneMemoryComp)
end

function FightScene:onClose()
	FightGameHelper.disposeGameMgr()
	self.mgr:onSceneClose()
	FightScene.super.onClose(self)
	FightTLEventPool.dispose()
	FightSkillBehaviorMgr.instance:dispose()
	FightRenderOrderMgr.instance:dispose()
	FightNameMgr.instance:dispose()
	FightFloatMgr.instance:dispose()
	FightAudioMgr.instance:dispose()
	FightVideoMgr.instance:dispose()
	FightSkillMgr.instance:dispose()
	FightResultModel.instance:clear()
	FightCardDissolveEffect.clear()
	ZProj.GameHelper.ClearFloorReflect()
	FightStrUtil.instance:dispose()
end

return FightScene
