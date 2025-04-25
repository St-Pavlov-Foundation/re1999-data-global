module("modules.logic.scene.fight.comp.FightSceneMgrComp", package.seeall)

slot0 = class("FightSceneMgrComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0.mgr = FightPerformanceMgr.New()
end

function slot0.onScenePrepared(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	if slot0.mgr then
		slot0.mgr:disposeSelf()

		slot0.mgr = nil
	end
end

function slot0.getASFDMgr(slot0)
	if slot0.mgr then
		return slot0.mgr:getASFDMgr()
	end
end

return slot0
