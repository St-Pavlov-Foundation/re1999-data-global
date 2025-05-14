module("modules.spine.roleeffect.RoleEffect307904_6", package.seeall)

local var_0_0 = class("RoleEffect307904_6", CommonRoleEffect)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._idleIndex = tabletool.indexOf(arg_1_0._motionList, "b_idle")
	arg_1_0._lightBodyList = {
		"b_idle",
		"b_diantou",
		"b_yaotou",
		"b_taishou"
	}
end

function var_0_0.showBodyEffect(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._effectVisible = false

	if arg_2_0._index == arg_2_0._idleIndex then
		if not tabletool.indexOf(arg_2_0._lightBodyList, arg_2_1) then
			arg_2_0:_setNodeVisible(arg_2_0._index, false)
		end
	else
		arg_2_0:_setNodeVisible(arg_2_0._index, false)
	end

	arg_2_0._index = tabletool.indexOf(arg_2_0._motionList, arg_2_1)

	arg_2_0:_setNodeVisible(arg_2_0._index, true)

	if tabletool.indexOf(arg_2_0._lightBodyList, arg_2_1) then
		arg_2_0:_setNodeVisible(arg_2_0._idleIndex, true)
	end

	if not arg_2_0._firstShow then
		arg_2_0._firstShow = true

		arg_2_0:showEverNodes(false)
		TaskDispatcher.cancelTask(arg_2_0._delayShowEverNodes, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._delayShowEverNodes, arg_2_0, 0.3)
	end

	if arg_2_2 and arg_2_3 then
		arg_2_2(arg_2_3, arg_2_0._effectVisible or arg_2_0._showEverEffect)
	end
end

return var_0_0
