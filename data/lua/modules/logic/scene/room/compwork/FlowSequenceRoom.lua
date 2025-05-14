module("modules.logic.scene.room.compwork.FlowSequenceRoom", package.seeall)

local var_0_0 = class("FlowSequenceRoom", FlowSequence)

function var_0_0._runNext(arg_1_0)
	local var_1_0 = arg_1_0._workList[arg_1_0._curIndex + 1]

	if var_1_0 then
		if isTypeOf(var_1_0, RoomSceneCommonCompWork) then
			RoomHelper.logElapse("++++++ " .. var_1_0.__cname .. " " .. var_1_0._comp.__cname, 0.001)
		elseif isTypeOf(var_1_0, RoomSceneWaitEventCompWork) then
			RoomHelper.logElapse("++++++ " .. var_1_0.__cname .. " " .. var_1_0._comp.__cname, 0.001)
		else
			RoomHelper.logElapse("++++++ " .. var_1_0.__cname, 0.001)
		end
	end

	var_0_0.super._runNext(arg_1_0)
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
