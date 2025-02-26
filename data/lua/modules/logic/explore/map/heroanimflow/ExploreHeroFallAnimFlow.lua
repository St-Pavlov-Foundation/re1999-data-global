module("modules.logic.explore.map.heroanimflow.ExploreHeroFallAnimFlow", package.seeall)

slot0 = class("ExploreHeroFallAnimFlow")

function slot0.begin(slot0, slot1, slot2)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroFallAnimFlow")
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)

	slot0.toPos = slot1
	slot0.sourceUnitId = slot2
	slot3 = ExploreController.instance:getMap()

	slot3:setMapStatus(ExploreEnum.MapStatus.Normal)

	for slot7, slot8 in pairs(slot3:getAllUnit()) do
		if slot8:getUnitType() == ExploreEnum.ItemType.Spike then
			slot8:pauseTriggerSpike()
		end
	end

	slot4 = slot3:getHero()

	slot4:stopMoving(true)
	slot4:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fall)
	slot4:setTrOffset(nil, slot4.trans.position + Vector3(0, -0.5, 0), nil, slot0.onHeroFallEnd, slot0)
end

function slot0.onHeroFallEnd(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot2 = ExploreController.instance:getMap()
	slot3 = slot2:getHero()

	for slot7, slot8 in pairs(slot2:getAllUnit()) do
		if slot8:getUnitType() == ExploreEnum.ItemType.Spike then
			slot8:beginTriggerSpike()
		end
	end

	if slot2:getUnit(slot0.sourceUnitId) then
		slot3.dir = slot4.mo.heroDir

		slot3:setRotate(0, slot4.mo.heroDir, 0)
	end

	slot0.sourceUnitId = nil
	slot3._displayTr.localPosition = Vector3.zero

	slot3:setTilemapPos(slot0.toPos)
	slot3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

	slot0.toPos = nil

	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0.onBlackEnd(slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

function slot0.clear(slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onBlackEnd, slot0)

	slot0.toPos = nil
	slot0.sourceUnitId = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

slot0.instance = slot0.New()

return slot0
