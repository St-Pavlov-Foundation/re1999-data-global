module("modules.logic.explore.map.unit.ExploreResetUnit", package.seeall)

local var_0_0 = class("ExploreResetUnit", ExploreBaseDisplayUnit)

function var_0_0.onRoleEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_2 then
		return
	end

	if not arg_1_3:isRole() then
		return
	end

	if arg_1_3:isMoving() then
		arg_1_3:stopMoving()
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.HeroAnim)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, arg_1_0.beginTrigger, arg_1_0)
	else
		TaskDispatcher.runDelay(arg_1_0.beginTrigger, arg_1_0, 0)
	end

	arg_1_0.animComp:playAnim(ExploreAnimEnum.AnimName.nToA)
end

function var_0_0.onRoleLeave(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_3:isRole() then
		return
	end

	arg_2_0.animComp:playAnim(ExploreAnimEnum.AnimName.aToN)
end

function var_0_0.beginTrigger(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_3_0.beginTrigger, arg_3_0)
	ExploreHeroResetFlow.instance:begin(arg_3_0.id)
end

function var_0_0.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.beginTrigger, arg_4_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_4_0.beginTrigger, arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)
end

return var_0_0
