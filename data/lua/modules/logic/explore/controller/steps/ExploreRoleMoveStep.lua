module("modules.logic.explore.controller.steps.ExploreRoleMoveStep", package.seeall)

local var_0_0 = class("ExploreRoleMoveStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = ExploreController.instance:getMap():getHero()

	if ExploreModel.instance.isReseting then
		var_1_0:setPosByNode(arg_1_0._data, false)
		arg_1_0:onDone()

		return
	end

	if var_1_0:isMoving() and ExploreHelper.getDistance(var_1_0.nodePos, arg_1_0._data) == 1 then
		ExploreController.instance:registerCallback(ExploreEvent.OnCharacterNodeChange, arg_1_0._onCharacterNodeChange, arg_1_0)
		ExploreController.instance:registerCallback(ExploreEvent.OnHeroMoveEnd, arg_1_0._onCharacterNodeChange, arg_1_0)
	else
		arg_1_0:onDone()
	end
end

function var_0_0._onCharacterNodeChange(arg_2_0)
	arg_2_0:onDone()
end

function var_0_0.onDestory(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterNodeChange, arg_3_0._onCharacterNodeChange, arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnHeroMoveEnd, arg_3_0._onCharacterNodeChange, arg_3_0)
	var_0_0.super.onDestory(arg_3_0)
end

return var_0_0
