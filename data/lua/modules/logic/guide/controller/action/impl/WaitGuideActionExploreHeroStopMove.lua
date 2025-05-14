module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreHeroStopMove", package.seeall)

local var_0_0 = class("WaitGuideActionExploreHeroStopMove", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = ExploreController.instance:getMap()

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	if not var_1_0:getHero():isMoving() then
		arg_1_0:onDone(true)

		return
	end

	GuideBlockMgr.instance:startBlock(99999999)
	ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, arg_1_0.onMoveEnd, arg_1_0)
end

function var_0_0.onMoveEnd(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	GuideBlockMgr.instance:removeBlock()
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_3_0.onMoveEnd, arg_3_0)
end

return var_0_0
