module("modules.logic.explore.model.mo.unit.ExplorePipeBaseMO", package.seeall)

local var_0_0 = class("ExplorePipeBaseMO", ExploreBaseUnitMO)

function var_0_0.getColor(arg_1_0, arg_1_1)
	local var_1_0 = ExploreController.instance:getMapPipe()

	if not var_1_0 or not var_1_0:isInitDone() then
		return ExploreEnum.PipeColor.None
	end

	if arg_1_1 == -1 then
		return var_1_0:getCenterColor(arg_1_0.id)
	end

	return var_1_0:getDirColor(arg_1_0.id, ExploreHelper.getDir(arg_1_1 + arg_1_0.unitDir))
end

function var_0_0.getDirType(arg_2_0, arg_2_1)
	return
end

function var_0_0.canRotate(arg_3_0)
	if not arg_3_0._canRotate then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.triggerEffects) do
			if iter_3_1[1] == ExploreEnum.TriggerEvent.Rotate then
				arg_3_0._canRotate = true
			end
		end
	end

	return arg_3_0._canRotate
end

function var_0_0.isDivisive(arg_4_0)
	return false
end

function var_0_0.getPipeOutDir(arg_5_0)
	return nil
end

function var_0_0.isOutDir(arg_6_0, arg_6_1)
	return false
end

return var_0_0
