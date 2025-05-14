module("modules.logic.explore.controller.steps.ExploreUpdateUnitStep", package.seeall)

local var_0_0 = class("ExploreUpdateUnitStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.interact

	ExploreModel.instance:updateInteractInfo(var_1_0, nil, true)

	if ExploreHelper.getBit(var_1_0.status, ExploreEnum.InteractIndex.IsEnter) <= 0 then
		local var_1_1 = {
			stepType = ExploreEnum.StepType.DelUnit,
			interact = arg_1_0._data.interact
		}

		ExploreStepController.instance:insertClientStep(var_1_1, 1)
		arg_1_0:onDone()

		return
	end

	local var_1_2 = ExploreController.instance:getMap()
	local var_1_3 = var_1_2:getUnit(var_1_0.id, true)

	if var_1_3 then
		var_1_3:checkShowIcon()

		if (not var_1_3.nodePos or var_1_3.nodePos.x ~= var_1_0.posx or var_1_3.nodePos.y ~= var_1_0.posy) and var_1_2:getNowStatus() == ExploreEnum.MapStatus.Normal then
			var_1_3:setPosByNode({
				x = var_1_0.posx,
				y = var_1_0.posy
			})
		end

		if ExploreHeroResetFlow.instance:isReseting() then
			var_1_3.mo.unitDir = var_1_0.dir

			var_1_3:updateRotationRoot()
		end
	else
		ExploreController.instance:updateUnit(var_1_0)

		local var_1_4 = var_1_2:getUnit(var_1_0.id)

		var_1_2:checkUnitNear(var_1_4.nodePos, var_1_4)
	end

	arg_1_0:onDone()
end

return var_0_0
