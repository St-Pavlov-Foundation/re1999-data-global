module("modules.logic.explore.controller.trigger.ExploreTriggerHeroPlayAnim", package.seeall)

local var_0_0 = class("ExploreTriggerHeroPlayAnim", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.splitToNumber(arg_1_1, "#")

	arg_1_0._state = var_1_0[1]
	arg_1_0._dis = var_1_0[2]
	arg_1_0._time = var_1_0[3]

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.PlayTriggerAnim)

	local var_1_1 = ExploreController.instance:getMap():getHero()

	if arg_1_0._dis then
		var_1_1:setMoveSpeed(arg_1_0._time)

		arg_1_0._moveDir = ExploreHelper.xyToDir(arg_1_2.mo.nodePos.x - var_1_1.nodePos.x, arg_1_2.mo.nodePos.y - var_1_1.nodePos.y)

		local var_1_2 = (arg_1_2:getPos() - var_1_1:getPos()):SetNormalize():Mul(arg_1_0._dis):Add(var_1_1:getPos())

		var_1_1:setTrOffset(arg_1_0._moveDir, var_1_2, arg_1_0._time, arg_1_0.onRoleMoveEnd, arg_1_0)
	else
		arg_1_0:onRoleMoveEnd()
	end
end

function var_0_0.onRoleMoveEnd(arg_2_0)
	local var_2_0 = ExploreController.instance:getMap():getHero()

	var_2_0:setMoveSpeed(0)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, arg_2_0.onHeroStateAnimEnd, arg_2_0)
	var_2_0:setHeroStatus(arg_2_0._state, true, true)
end

function var_0_0.onHeroStateAnimEnd(arg_3_0)
	local var_3_0 = ExploreController.instance:getMap():getHero()

	if arg_3_0._dis then
		var_3_0:setMoveSpeed(arg_3_0._time)
		var_3_0:setTrOffset(arg_3_0._moveDir, var_3_0:getPos(), arg_3_0._time, arg_3_0.onRoleMoveBackEnd, arg_3_0)
	else
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
	end

	arg_3_0:onDone(true)
end

function var_0_0.onRoleMoveBackEnd(arg_4_0)
	ExploreController.instance:getMap():getHero():setMoveSpeed(0)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.PlayTriggerAnim)
end

function var_0_0.clearWork(arg_5_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, arg_5_0.onHeroStateAnimEnd, arg_5_0)
end

return var_0_0
