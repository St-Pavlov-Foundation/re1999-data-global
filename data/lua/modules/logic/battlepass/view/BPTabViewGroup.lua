module("modules.logic.battlepass.view.BPTabViewGroup", package.seeall)

local var_0_0 = class("BPTabViewGroup", TabViewGroup)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0.isInClosingTween = false
	arg_1_0._tabAnims = {}
	arg_1_0._closeViewIndex = nil
	arg_1_0._openId = nil
end

function var_0_0._openTabView(arg_2_0, arg_2_1)
	if arg_2_0._curTabId == arg_2_1 then
		return
	end

	var_0_0.super._openTabView(arg_2_0, arg_2_1)
end

function var_0_0._setVisible(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._tabViews[arg_3_1].viewGO
	local var_3_1 = arg_3_0._tabAnims[arg_3_1]
	local var_3_2 = false

	if var_3_1 == nil then
		var_3_1 = var_3_0:GetComponent(typeof(UnityEngine.Animator)) and ZProj.ProjAnimatorPlayer.Get(var_3_0) or false
		arg_3_0._tabAnims[arg_3_1] = var_3_1
		var_3_2 = true
	end

	if arg_3_2 then
		if arg_3_0.isInClosingTween then
			arg_3_0._openId = arg_3_1

			if arg_3_0._closeViewIndex ~= arg_3_1 then
				if var_3_2 then
					var_3_0:GetComponent(typeof(UnityEngine.Animator)).enabled = false
				end

				var_0_0.super._setVisible(arg_3_0, arg_3_1, false)
			end

			return
		end

		var_3_0:GetComponent(typeof(UnityEngine.Animator)).enabled = true

		var_0_0.super._setVisible(arg_3_0, arg_3_1, true)

		if var_3_1 then
			var_3_1:Play(UIAnimationName.Open)
		end

		arg_3_0.viewContainer:dispatchEvent(BpEvent.TapViewOpenAnimBegin, arg_3_1)
	else
		if arg_3_0.isInClosingTween then
			return
		end

		if arg_3_0._openId == arg_3_1 then
			arg_3_0._openId = nil
		end

		if var_3_1 then
			arg_3_0.isInClosingTween = true
			arg_3_0._closeViewIndex = arg_3_1

			arg_3_0.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimBegin, arg_3_1)
			var_3_1:Play(UIAnimationName.Close, arg_3_0.onCloseTweenFinish, arg_3_0)
		else
			var_0_0.super._setVisible(arg_3_0, arg_3_1, false)
		end
	end
end

function var_0_0.onCloseTweenFinish(arg_4_0)
	if not arg_4_0._closeViewIndex then
		return
	end

	local var_4_0 = arg_4_0._closeViewIndex

	var_0_0.super._setVisible(arg_4_0, arg_4_0._closeViewIndex, false)

	arg_4_0._closeViewIndex = nil
	arg_4_0.isInClosingTween = false

	if arg_4_0._openId then
		arg_4_0:_setVisible(arg_4_0._openId, true)

		arg_4_0._openId = nil
	end

	arg_4_0.viewContainer:dispatchEvent(BpEvent.TapViewCloseAnimEnd, var_4_0)
end

function var_0_0.onDestroyView(arg_5_0, ...)
	arg_5_0.isInClosingTween = nil
	arg_5_0._tabAnims = nil
	arg_5_0._closeViewIndex = nil
	arg_5_0._openId = nil

	var_0_0.super.onDestroyView(arg_5_0, ...)
end

return var_0_0
