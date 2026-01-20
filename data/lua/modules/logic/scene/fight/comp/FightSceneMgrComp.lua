-- chunkname: @modules/logic/scene/fight/comp/FightSceneMgrComp.lua

module("modules.logic.scene.fight.comp.FightSceneMgrComp", package.seeall)

local FightSceneMgrComp = class("FightSceneMgrComp", BaseSceneComp)

function FightSceneMgrComp:onSceneStart(sceneId, levelId)
	self.mgr = FightPerformanceMgr.New()
end

function FightSceneMgrComp:onScenePrepared(sceneId, levelId)
	return
end

function FightSceneMgrComp:onSceneClose(sceneId, levelId)
	if self.mgr then
		self.mgr:disposeSelf()

		self.mgr = nil
	end
end

function FightSceneMgrComp:getASFDMgr()
	if self.mgr then
		return self.mgr:getASFDMgr()
	end
end

return FightSceneMgrComp
