module("modules.logic.explore.map.tree.ExploreMapTreeNode", package.seeall)

local var_0_0 = class("ExploreMapTreeNode")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.preloadComp = arg_1_2
	arg_1_0.bound = Bounds.New(Vector3.New(arg_1_1.bound.center[1], arg_1_1.bound.center[2], arg_1_1.bound.center[3]), Vector3.New(arg_1_1.bound.size[1], 4, arg_1_1.bound.size[3]))
	arg_1_0._drawBound = Bounds.New(Vector3.New(arg_1_1.bound.center[1], arg_1_1.bound.center[2], arg_1_1.bound.center[3]), Vector3.New(arg_1_1.bound.size[1], 2, arg_1_1.bound.size[3]))
	arg_1_0.centerX = arg_1_0.bound.center.x
	arg_1_0.centerZ = arg_1_0.bound.center.z
	arg_1_0.extentsX = arg_1_0.bound.extents.x
	arg_1_0.extentsZ = arg_1_0.bound.extents.z
	arg_1_0.childList = {}
	arg_1_0.isShow = false

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.child) do
		local var_1_0 = var_0_0.New(arg_1_1.child[iter_1_0], arg_1_2)

		table.insert(arg_1_0.childList, var_1_0)
	end

	arg_1_0.objList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.objList) do
		table.insert(arg_1_0.objList, arg_1_1.objList[iter_1_2])
	end
end

function var_0_0.triggerMove(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.isShow = true

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.objList) do
		arg_2_4[iter_2_1] = 1
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.childList) do
		if arg_2_0.childList[iter_2_2]:checkBound(arg_2_1, arg_2_2, arg_2_3) then
			arg_2_0.childList[iter_2_2]:triggerMove(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		else
			arg_2_0.childList[iter_2_2]:hide()
		end
	end
end

function var_0_0.hide(arg_3_0)
	if arg_3_0.isShow then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.childList) do
			arg_3_0.childList[iter_3_0]:hide()
		end
	end

	arg_3_0.isShow = false
end

function var_0_0.checkBound(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0:_checkRage(arg_4_1) then
		return true
	elseif arg_4_3 == ExploreEnum.SceneCheckMode.Camera then
		return arg_4_0:_checkCamera(arg_4_2)
	elseif arg_4_3 == ExploreEnum.SceneCheckMode.Planes then
		return arg_4_0:_checkInplanes(arg_4_2)
	else
		return false
	end
end

function var_0_0._checkCamera(arg_5_0, arg_5_1)
	return ZProj.ExploreHelper.CheckBoundIsInCamera(arg_5_0.bound, arg_5_1)
end

function var_0_0._checkInplanes(arg_6_0, arg_6_1)
	return ZProj.ExploreHelper.CheckBoundIsInplanes(arg_6_0.bound, arg_6_1)
end

function var_0_0._checkRage(arg_7_0, arg_7_1)
	local var_7_0 = math.abs(arg_7_0.centerX - arg_7_1.x)
	local var_7_1 = math.abs(arg_7_0.centerZ - arg_7_1.y)
	local var_7_2 = math.abs(arg_7_0.extentsX + arg_7_1.z)
	local var_7_3 = math.abs(arg_7_0.extentsZ + arg_7_1.w)

	return var_7_0 <= var_7_2 and var_7_1 <= var_7_3
end

function var_0_0.drawBound(arg_8_0)
	if arg_8_0.isShow then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.childList) do
			arg_8_0.childList[iter_8_0]:drawBound()
		end

		ZProj.ExploreHelper.DrawBound(arg_8_0._drawBound)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0.preloadComp = nil

	if arg_9_0.childList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.childList) do
			iter_9_1:onDestroy()
		end
	end

	arg_9_0.childList = nil
	arg_9_0.objList = nil
end

return var_0_0
