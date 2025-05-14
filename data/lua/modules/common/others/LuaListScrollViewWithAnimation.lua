module("modules.common.others.LuaListScrollViewWithAnimation", package.seeall)

local var_0_0 = class("LuaListScrollViewWithAnimation", LuaListScrollView)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._animationDelayTimes = arg_1_3
	arg_1_0._animationHasPlayed = {}
end

function var_0_0._onUpdateCell(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super._onUpdateCell(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = gohelper.findChild(arg_2_1, LuaListScrollView.PrefabInstName)

	if not var_2_0 then
		return
	end

	local var_2_1 = MonoHelper.getLuaComFromGo(var_2_0, arg_2_0._param.cellClass)

	if not (arg_2_0._animationDelayTimes and arg_2_0._animationDelayTimes[var_2_1._index]) then
		return
	end

	if arg_2_0._animationHasPlayed[var_2_1._index] then
		return
	end

	if var_2_1.getAnimation then
		local var_2_2, var_2_3 = var_2_1:getAnimation()

		if var_2_2 and not string.nilorempty(var_2_3) then
			local var_2_4 = var_2_1.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

			if var_2_4 then
				var_2_4.alpha = 0
			end
		end
	end
end

function var_0_0.onUpdateFinish(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._cellCompDict) do
		local var_3_0 = arg_3_0._animationDelayTimes and arg_3_0._animationDelayTimes[iter_3_0._index]

		if var_3_0 and not arg_3_0._animationHasPlayed[iter_3_0._index] then
			TaskDispatcher.runDelay(var_0_0._delayPlayOpenAnimation, iter_3_0, var_3_0)

			arg_3_0._animationHasPlayed[iter_3_0._index] = true
		end
	end
end

function var_0_0._delayPlayOpenAnimation(arg_4_0)
	if arg_4_0.getAnimation then
		local var_4_0, var_4_1 = arg_4_0:getAnimation()

		if var_4_0 and not string.nilorempty(var_4_1) then
			var_4_0:Play(var_4_1)
		end
	end
end

function var_0_0.onClose(arg_5_0)
	var_0_0.super.onClose(arg_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._cellCompDict) do
		TaskDispatcher.cancelTask(var_0_0._delayPlayOpenAnimation, iter_5_0)
	end
end

return var_0_0
