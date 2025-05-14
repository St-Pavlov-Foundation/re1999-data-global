module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreLoaded", package.seeall)

local var_0_0 = class("WaitGuideActionExploreLoaded", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if ExploreModel.instance.isRoleInitDone and not arg_1_0:_checkIsNoDone() then
		return
	end

	ExploreController.instance:registerCallback(ExploreEvent.HeroResInitDone, arg_1_0.onHeroInitDone, arg_1_0)
end

function var_0_0.onHeroInitDone(arg_2_0)
	if not arg_2_0:_checkIsNoDone() then
		return
	end

	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, arg_2_0.onHeroInitDone, arg_2_0)
end

function var_0_0._checkIsNoDone(arg_3_0)
	local var_3_0 = ExploreModel.instance:getMapId()

	if not string.nilorempty(arg_3_0.actionParam) and var_3_0 ~= tonumber(arg_3_0.actionParam) then
		return true
	end

	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.HeroResInitDone, arg_4_0.onHeroInitDone, arg_4_0)
end

return var_0_0
