module("modules.logic.guide.view.GuideHoleEffect", package.seeall)

local var_0_0 = class("GuideHoleEffect", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	arg_1_0.showMask = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._transform = arg_2_1.transform
	arg_2_0._animator = arg_2_1:GetComponent(typeof(UnityEngine.Animator))

	if arg_2_0._animator then
		arg_2_0._animator.enabled = false
	end

	arg_2_0._childList = arg_2_0:getUserDataTb_()

	local var_2_0 = arg_2_1.transform
	local var_2_1 = var_2_0.childCount

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0 - 1)

		table.insert(arg_2_0._childList, var_2_2)
	end
end

function var_0_0.setSize(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0._width == arg_3_1 and arg_3_0._height == arg_3_2 then
		return
	end

	arg_3_0:setVisible(true)
	arg_3_0:_playEffect(arg_3_3)

	arg_3_0._width = arg_3_1
	arg_3_0._height = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._childList) do
		recthelper.setSize(iter_3_1, arg_3_1, arg_3_2)
	end
end

function var_0_0._playEffect(arg_4_0, arg_4_1)
	TaskDispatcher.cancelTask(arg_4_0._playLoop, arg_4_0)

	if not arg_4_0.showMask or arg_4_1 then
		arg_4_0:_playLoop()
	else
		if not arg_4_0._animator then
			return
		end

		arg_4_0._animator.enabled = true

		arg_4_0._animator:Play("edge_once")
	end
end

function var_0_0._playLoop(arg_5_0)
	if not arg_5_0._animator then
		return
	end

	arg_5_0._animator.enabled = true

	arg_5_0._animator:Play("edge_loop")
end

function var_0_0.setVisible(arg_6_0, arg_6_1)
	if not arg_6_1 then
		arg_6_0._width = nil
		arg_6_0._height = nil
	end

	gohelper.setActive(arg_6_0.go, arg_6_1)
end

function var_0_0.addToParent(arg_7_0, arg_7_1)
	gohelper.addChild(arg_7_1, arg_7_0.go)
	gohelper.setAsFirstSibling(arg_7_0.go)
	recthelper.setAnchor(arg_7_0._transform, 0, 0)
end

function var_0_0.addEventListeners(arg_8_0)
	return
end

function var_0_0.removeEventListeners(arg_9_0)
	return
end

function var_0_0.onStart(arg_10_0)
	return
end

function var_0_0.onDestroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playLoop, arg_11_0)
end

return var_0_0
