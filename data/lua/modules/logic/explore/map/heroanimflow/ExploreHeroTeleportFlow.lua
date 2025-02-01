module("modules.logic.explore.map.heroanimflow.ExploreHeroTeleportFlow", package.seeall)

slot0 = class("ExploreHeroTeleportFlow")

function slot0.begin(slot0, slot1)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroTeleportFlow")

	slot0.toPos = slot1

	ViewMgr.instance:openView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():stopMoving(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot2 = ExploreController.instance:getMap():getHero()

	slot2:stopMoving(true)
	slot2:setTilemapPos(slot0.toPos)
	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0.onBlackEnd(slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)

	slot0.toPos = nil
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")

	slot0.toPos = nil

	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
end

function slot0.isInFlow(slot0)
	return slot0.toPos and true or false
end

slot0.instance = slot0.New()

return slot0
