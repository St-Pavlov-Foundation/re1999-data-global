module("modules.logic.explore.map.unit.ExploreRockUnit", package.seeall)

local var_0_0 = class("ExploreRockUnit", ExploreItemUnit)

function var_0_0.needInteractAnim(arg_1_0)
	return true
end

function var_0_0.setExitCallback(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._displayTr and arg_2_0:isInFOV() and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Spike) and ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.Teleport) then
		arg_2_0._exitCallback = arg_2_1
		arg_2_0._exitCallbackObj = arg_2_2
	else
		arg_2_1(arg_2_2)
	end
end

function var_0_0._releaseDisplayGo(arg_3_0)
	if arg_3_0._exitCallback then
		arg_3_0._exitCallback(arg_3_0._exitCallbackObj)
	end

	arg_3_0._exitCallback = nil
	arg_3_0._exitCallbackObj = nil

	var_0_0.super._releaseDisplayGo(arg_3_0)
end

function var_0_0.onAnimEnd(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ExploreAnimEnum.AnimName.exit then
		if arg_4_0._exitCallback then
			arg_4_0._exitCallback(arg_4_0._exitCallbackObj)
		end

		arg_4_0._exitCallback = nil
		arg_4_0._exitCallbackObj = nil
	end

	var_0_0.super.onAnimEnd(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0._exitCallback = nil
	arg_5_0._exitCallbackObj = nil

	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
