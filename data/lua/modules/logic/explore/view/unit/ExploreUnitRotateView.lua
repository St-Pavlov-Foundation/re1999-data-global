module("modules.logic.explore.view.unit.ExploreUnitRotateView", package.seeall)

local var_0_0 = class("ExploreUnitRotateView", ExploreUnitBaseView)
local var_0_1 = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1, "ui/viewres/explore/exploreunitrotate.prefab")
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._btnLeft = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_left")
	arg_2_0._btnRight = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_right")
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnLeft:AddClickListener(arg_3_0.doRotate, arg_3_0, false)
	arg_3_0._btnRight:AddClickListener(arg_3_0.doRotate, arg_3_0, true)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnLeft:RemoveClickListener()
	arg_4_0._btnRight:RemoveClickListener()
end

function var_0_0.doRotate(arg_5_0, arg_5_1)
	local var_5_0 = 0
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_0.unit.mo.triggerEffects) do
		if iter_5_1[1] == ExploreEnum.TriggerEvent.Rotate then
			var_5_0 = iter_5_0
			var_5_1 = tonumber(iter_5_1[2])

			if arg_5_1 then
				var_5_1 = -var_5_1
			end

			break
		end
	end

	if var_5_0 <= 0 then
		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(arg_5_0.unit.id, var_5_0, string.format(var_0_1, var_5_1), arg_5_0.onRotateRecv, arg_5_0)
end

function var_0_0.onRotateRecv(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	if not arg_6_0.unit then
		return
	end

	local var_6_0 = arg_6_0.unit.mo.unitDir
	local var_6_1 = string.splitToNumber(arg_6_3.params, "#")[2]

	arg_6_0.unit:doRotate(var_6_0 - var_6_1, var_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._btnLeft = nil
	arg_7_0._btnRight = nil
end

return var_0_0
