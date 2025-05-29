module("modules.spine.roleeffect.CommonRoleEffect", package.seeall)

local var_0_0 = class("CommonRoleEffect", BaseSpineRoleEffect)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._roleEffectConfig = arg_1_1
	arg_1_0._spineGo = arg_1_0._spine._spineGo
	arg_1_0._motionList = string.split(arg_1_1.motion, "|")
	arg_1_0._nodeList = GameUtil.splitString2(arg_1_1.node, false, "|", "#")
	arg_1_0._firstShow = false
	arg_1_0._showEverEffect = false
	arg_1_0._effectVisible = false
end

function var_0_0.isShowEverEffect(arg_2_0)
	return arg_2_0._showEverEffect
end

function var_0_0.showBodyEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._effectVisible = false

	arg_3_0:_setNodeVisible(arg_3_0._index, false)

	arg_3_0._index = tabletool.indexOf(arg_3_0._motionList, arg_3_1)

	arg_3_0:_setNodeVisible(arg_3_0._index, true)

	if not arg_3_0._firstShow then
		arg_3_0._firstShow = true

		arg_3_0:showEverNodes(false)
		TaskDispatcher.cancelTask(arg_3_0._delayShowEverNodes, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._delayShowEverNodes, arg_3_0, 0.3)
	end

	if arg_3_2 and arg_3_3 then
		arg_3_2(arg_3_3, arg_3_0._effectVisible or arg_3_0._showEverEffect)
	end
end

function var_0_0._delayShowEverNodes(arg_4_0)
	arg_4_0:showEverNodes(true)
end

function var_0_0.showEverNodes(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_0._roleEffectConfig.everNode) or not arg_5_0._spineGo then
		return
	end

	local var_5_0 = arg_5_0._spine._resPath

	if var_5_0 and not string.find(var_5_0, arg_5_0._roleEffectConfig.heroResName .. ".prefab") then
		return
	end

	local var_5_1 = string.split(arg_5_0._roleEffectConfig.everNode, "#")

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = gohelper.findChild(arg_5_0._spineGo, iter_5_1)

		gohelper.setActive(var_5_2, arg_5_1)

		arg_5_0._showEverEffect = true

		if not var_5_2 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", var_5_0, iter_5_1))
		end
	end
end

function var_0_0._setNodeVisible(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_0._nodeList[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = gohelper.findChild(arg_6_0._spineGo, iter_6_1)

		gohelper.setActive(var_6_1, arg_6_2)

		if not var_6_1 and SLFramework.FrameworkSettings.IsEditor then
			logError(string.format("%s找不到特效节点：%s,请检查路径", arg_6_0._spine._resPath, iter_6_1))
		end

		if arg_6_2 then
			arg_6_0._effectVisible = true
		end
	end
end

function var_0_0.playBodyEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._spineGo = nil

	TaskDispatcher.cancelTask(arg_8_0._delayShowEverNodes, arg_8_0)
end

return var_0_0
