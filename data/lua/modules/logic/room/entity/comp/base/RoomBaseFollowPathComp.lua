module("modules.logic.room.entity.comp.base.RoomBaseFollowPathComp", package.seeall)

local var_0_0 = class("RoomBaseFollowPathComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._tbFollowerList = {}
	arg_1_0._tbPools = {}
	arg_1_0._isMoveing = false
end

function var_0_0.addPathPos(arg_2_0, arg_2_1)
	for iter_2_0 = #arg_2_0._tbFollowerList, 1, -1 do
		local var_2_0 = arg_2_0._tbFollowerList[iter_2_0]

		if var_2_0.follower then
			var_2_0.follower:addPathPos(arg_2_1)
		else
			arg_2_0:_push(var_2_0)
			table.remove(arg_2_0._tbFollowerList, iter_2_0)
		end
	end
end

function var_0_0.addFollower(arg_3_0, arg_3_1)
	if arg_3_0.__willDestroy or not arg_3_1 or arg_3_1:isWillDestory() then
		return
	end

	if not arg_3_0:_findIndexOf(arg_3_1) then
		local var_3_0 = arg_3_0:_pop(arg_3_1)

		table.insert(arg_3_0._tbFollowerList, var_3_0)
		arg_3_1:setFollowPath(arg_3_0)
	end
end

function var_0_0.removeFollower(arg_4_0, arg_4_1)
	if arg_4_1 and #arg_4_0._tbFollowerList > 0 then
		local var_4_0 = tabletool.indexOf(arg_4_0._tbFollowerList, arg_4_1)

		if var_4_0 then
			arg_4_0._tbFollowerList[var_4_0].follower = nil

			arg_4_1:clearFollowPath()
		end
	end
end

function var_0_0._pop(arg_5_0, arg_5_1)
	local var_5_0

	if #arg_5_0._tbPools > 0 then
		var_5_0 = arg_5_0._tbPools[#arg_5_0._tbPools]

		table.remove(arg_5_0._tbPools, #arg_5_0._tbPools)
	else
		var_5_0 = {}
	end

	var_5_0.follower = arg_5_1

	return var_5_0
end

function var_0_0._push(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_1.follower = nil

		table.insert(arg_6_0._tbPools, arg_6_1)
	end
end

function var_0_0._findIndexOf(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_0._tbFollowerList

	for iter_7_0 = 1, var_7_0 do
		if arg_7_0._tbFollowerList[iter_7_0].follower == arg_7_1 then
			return iter_7_0
		end
	end
end

function var_0_0.stopMove(arg_8_0)
	for iter_8_0 = #arg_8_0._tbFollowerList, 1, -1 do
		local var_8_0 = arg_8_0._tbFollowerList[iter_8_0]

		if var_8_0.follower then
			var_8_0.follower:stopMove()
		else
			arg_8_0:_push(var_8_0)
			table.remove(arg_8_0._tbFollowerList, iter_8_0)
		end
	end

	arg_8_0._isMoveing = false

	arg_8_0:onStopMove()
end

function var_0_0.moveByPathData(arg_9_0)
	if not arg_9_0._isMoveing then
		arg_9_0._isMoveing = true

		arg_9_0:onStartMove()
	end

	for iter_9_0 = #arg_9_0._tbFollowerList, 1, -1 do
		local var_9_0 = arg_9_0._tbFollowerList[iter_9_0]

		if var_9_0.follower then
			var_9_0.follower:moveByPathData()
		else
			arg_9_0:_push(var_9_0)
			table.remove(arg_9_0._tbFollowerList, iter_9_0)
		end
	end
end

function var_0_0.getCount(arg_10_0)
	return #arg_10_0._tbFollowerList
end

function var_0_0.onStopMove(arg_11_0)
	return
end

function var_0_0.onStartMove(arg_12_0)
	return
end

function var_0_0.isWillDestory(arg_13_0)
	return arg_13_0.__willDestroy
end

function var_0_0.beforeDestroy(arg_14_0)
	arg_14_0.__willDestroy = true

	if arg_14_0._tbFollowerList and #arg_14_0._tbFollowerList > 0 then
		local var_14_0 = arg_14_0._tbFollowerList

		arg_14_0._tbFollowerList = {}

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1.follower then
				iter_14_1.follower:clearFollowPath()
			end
		end
	end
end

return var_0_0
