module("modules.logic.explore.view.unit.ExploreRoleFixView", package.seeall)

local var_0_0 = class("ExploreRoleFixView", ExploreUnitBaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1, "ui/viewres/explore/exploreinteractiveitem.prefab")
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._goslider = gohelper.findChildImage(arg_2_0.viewGO, "#image_progress")
	arg_2_0._nowValue = 0

	TaskDispatcher.runRepeat(arg_2_0._everyFrame, arg_2_0, 0)
end

function var_0_0.setFixUnit(arg_3_0, arg_3_1)
	arg_3_0._fixUnit = arg_3_1
end

function var_0_0._everyFrame(arg_4_0)
	arg_4_0._nowValue = arg_4_0._nowValue + UnityEngine.Time.deltaTime

	local var_4_0 = arg_4_0._nowValue / (ExploreAnimEnum.RoleAnimLen[ExploreAnimEnum.RoleAnimStatus.Fix] or 1)

	arg_4_0._goslider.fillAmount = var_4_0

	if var_4_0 > 1 then
		if arg_4_0._fixUnit then
			local var_4_1, var_4_2, var_4_3, var_4_4 = ExploreConfig.instance:getUnitEffectConfig(arg_4_0._fixUnit:getResPath(), "fix_finish")

			ExploreHelper.triggerAudio(var_4_3, var_4_4, arg_4_0._fixUnit.go)
		end

		arg_4_0.unit.uiComp:removeUI(var_0_0)
	end
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._everyFrame, arg_7_0)

	arg_7_0._goslider = nil
	arg_7_0._fixUnit = nil
end

return var_0_0
