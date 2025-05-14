module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTransferFinish", package.seeall)

local var_0_0 = class("WaitGuideActionExploreTransferFinish", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	ExploreController.instance:registerCallback(ExploreEvent.HeroStatuEnd, arg_1_0._onHeroStatuEnd, arg_1_0)
end

function var_0_0._onHeroStatuEnd(arg_2_0, arg_2_1)
	if arg_2_1 == ExploreAnimEnum.RoleAnimStatus.Entry then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroStatuEnd, arg_3_0._onHeroStatuEnd, arg_3_0)
end

return var_0_0
