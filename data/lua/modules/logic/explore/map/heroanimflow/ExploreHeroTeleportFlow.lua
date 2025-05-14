module("modules.logic.explore.map.heroanimflow.ExploreHeroTeleportFlow", package.seeall)

local var_0_0 = class("ExploreHeroTeleportFlow")

function var_0_0.begin(arg_1_0, arg_1_1)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroTeleportFlow")

	arg_1_0.toPos = arg_1_1

	ViewMgr.instance:openView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():stopMoving(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)

	local var_2_0 = ExploreController.instance:getMap():getHero()

	var_2_0:stopMoving(true)
	var_2_0:setTilemapPos(arg_2_0.toPos)
	TaskDispatcher.runDelay(arg_2_0._delayLoadObj, arg_2_0, 0.1)
end

function var_0_0._delayLoadObj(arg_3_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_3_0.onBlackEnd, arg_3_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0.onBlackEnd(arg_4_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_4_0.onBlackEnd, arg_4_0)

	arg_4_0.toPos = nil
end

function var_0_0.clear(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayLoadObj, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0.onOpenViewFinish, arg_5_0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Teleport)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgr.instance:endBlock("ExploreHeroTeleportFlow")

	arg_5_0.toPos = nil

	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_5_0.onBlackEnd, arg_5_0)
end

function var_0_0.isInFlow(arg_6_0)
	return arg_6_0.toPos and true or false
end

var_0_0.instance = var_0_0.New()

return var_0_0
