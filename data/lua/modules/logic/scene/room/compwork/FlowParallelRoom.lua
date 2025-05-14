module("modules.logic.scene.room.compwork.FlowParallelRoom", package.seeall)

local var_0_0 = class("FlowParallelRoom", FlowParallel)

function var_0_0.onStartInternal(arg_1_0, arg_1_1)
	if #arg_1_0._workList == 0 then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._doneCount = 0
	arg_1_0._succCount = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._workList) do
		if isTypeOf(iter_1_1, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. iter_1_1.__cname .. " " .. iter_1_1._comp.__cname, 0.001)
		elseif isTypeOf(iter_1_1, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. iter_1_1.__cname .. " " .. iter_1_1._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. iter_1_1.__cname, 0.001)
		end

		iter_1_1:onStartInternal(arg_1_1)
	end
end

function var_0_0.onWorkDone(arg_2_0, arg_2_1)
	if isTypeOf(arg_2_1, RoomSceneCommonCompWork) then
		RoomHelper.logElapse("-------- " .. arg_2_1.__cname .. " " .. arg_2_1._comp.__cname, 0.001)
	elseif isTypeOf(arg_2_1, RoomSceneWaitEventCompWork) then
		RoomHelper.logElapse("-------- " .. arg_2_1.__cname .. " " .. arg_2_1._comp.__cname, 0.001)
	else
		RoomHelper.logElapse("-------- " .. arg_2_1.__cname, 0.001)
	end

	var_0_0.super.onWorkDone(arg_2_0, arg_2_1)
end

return var_0_0
