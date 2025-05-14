module("modules.logic.explore.map.heroanimflow.ExploreHeroFallAnimFlow", package.seeall)

local var_0_0 = class("ExploreHeroFallAnimFlow")

function var_0_0.begin(arg_1_0, arg_1_1, arg_1_2)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroFallAnimFlow")
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)

	arg_1_0.toPos = arg_1_1
	arg_1_0.sourceUnitId = arg_1_2

	local var_1_0 = ExploreController.instance:getMap()

	var_1_0:setMapStatus(ExploreEnum.MapStatus.Normal)

	for iter_1_0, iter_1_1 in pairs(var_1_0:getAllUnit()) do
		if iter_1_1:getUnitType() == ExploreEnum.ItemType.Spike then
			iter_1_1:pauseTriggerSpike()
		end
	end

	local var_1_1 = var_1_0:getHero()

	var_1_1:stopMoving(true)
	var_1_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fall)
	var_1_1:setTrOffset(nil, var_1_1.trans.position + Vector3(0, -0.5, 0), nil, arg_1_0.onHeroFallEnd, arg_1_0)
end

function var_0_0.onHeroFallEnd(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function var_0_0.onOpenViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)

	local var_3_0 = ExploreController.instance:getMap()
	local var_3_1 = var_3_0:getHero()

	for iter_3_0, iter_3_1 in pairs(var_3_0:getAllUnit()) do
		if iter_3_1:getUnitType() == ExploreEnum.ItemType.Spike then
			iter_3_1:beginTriggerSpike()
		end
	end

	local var_3_2 = var_3_0:getUnit(arg_3_0.sourceUnitId)

	if var_3_2 then
		var_3_1.dir = var_3_2.mo.heroDir

		var_3_1:setRotate(0, var_3_2.mo.heroDir, 0)
	end

	arg_3_0.sourceUnitId = nil
	var_3_1._displayTr.localPosition = Vector3.zero

	var_3_1:setTilemapPos(arg_3_0.toPos)
	var_3_1:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)

	arg_3_0.toPos = nil

	TaskDispatcher.runDelay(arg_3_0._delayLoadObj, arg_3_0, 0.1)
end

function var_0_0._delayLoadObj(arg_4_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_4_0.onBlackEnd, arg_4_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0.onBlackEnd(arg_5_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_5_0.onBlackEnd, arg_5_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

function var_0_0.clear(arg_6_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_6_0._delayLoadObj, arg_6_0)
	UIBlockMgr.instance:endBlock("ExploreHeroFallAnimFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_6_0.onBlackEnd, arg_6_0)

	arg_6_0.toPos = nil
	arg_6_0.sourceUnitId = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_6_0.onOpenViewFinish, arg_6_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Spike)
end

var_0_0.instance = var_0_0.New()

return var_0_0
