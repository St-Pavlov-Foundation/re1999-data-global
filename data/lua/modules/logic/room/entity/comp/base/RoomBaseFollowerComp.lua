module("modules.logic.room.entity.comp.base.RoomBaseFollowerComp", package.seeall)

local var_0_0 = class("RoomBaseFollowerComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._isMoveing = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	return
end

function var_0_0.getFollowPathData(arg_3_0)
	if not arg_3_0._followPathData then
		arg_3_0._followPathData = RoomVehicleFollowPathData.New()
	end

	return arg_3_0._followPathData
end

function var_0_0.setFollowPath(arg_4_0, arg_4_1)
	if arg_4_0._followPathComp == arg_4_1 then
		return
	end

	if arg_4_0._followPathComp then
		arg_4_0._followPathComp:removeFollower(arg_4_0)

		arg_4_0._followPathComp = nil
	end

	if arg_4_1 then
		arg_4_1:addFollower(arg_4_0)

		arg_4_0._followPathComp = arg_4_1
	end

	arg_4_0:stopMove()
end

function var_0_0.clearFollowPath(arg_5_0)
	arg_5_0:setFollowPath(nil)
end

function var_0_0.stopMove(arg_6_0)
	if arg_6_0._isMoveing then
		arg_6_0._isMoveing = false

		arg_6_0:onStopMove()
	end
end

function var_0_0.moveByPathData(arg_7_0)
	if arg_7_0.__willDestroy or not arg_7_0._followPathComp or arg_7_0._followPathComp:isWillDestory() then
		return
	end

	if not arg_7_0._isMoveing then
		arg_7_0._isMoveing = true

		arg_7_0:onStartMove()
	end

	arg_7_0:onMoveByPathData(arg_7_0:getFollowPathData())
end

function var_0_0.addPathPos(arg_8_0, arg_8_1)
	if not arg_8_0.__willDestroy then
		arg_8_0:getFollowPathData():addPathPos(arg_8_1)
	end
end

function var_0_0.onMoveByPathData(arg_9_0, arg_9_1)
	return
end

function var_0_0.onStopMove(arg_10_0)
	return
end

function var_0_0.onStartMove(arg_11_0)
	return
end

function var_0_0.isWillDestory(arg_12_0)
	return arg_12_0.__willDestroy
end

function var_0_0.beforeDestroy(arg_13_0)
	arg_13_0.__willDestroy = true

	arg_13_0:clearFollowPath()
end

return var_0_0
