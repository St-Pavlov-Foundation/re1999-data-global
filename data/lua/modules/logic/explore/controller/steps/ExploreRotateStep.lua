module("modules.logic.explore.controller.steps.ExploreRotateStep", package.seeall)

local var_0_0 = class("ExploreRotateStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.RotateUnit)

	if not var_1_0 then
		arg_1_0:onDone()

		return
	end

	var_1_0:rotateByServer(arg_1_0._data.interactId, arg_1_0._data.newDir, arg_1_0.onDone, arg_1_0)
end

return var_0_0
