module("modules.logic.room.model.transport.RoomTransportPathModel", package.seeall)

local var_0_0 = class("RoomTransportPathModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.initPath(arg_5_0, arg_5_1)
	RoomTransportHelper.initTransportPathModel(arg_5_0, arg_5_1)
end

function var_0_0.removeByIds(arg_6_0, arg_6_1)
	if arg_6_1 and #arg_6_1 > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			local var_6_0 = arg_6_0:getById(iter_6_1)

			arg_6_0:remove(var_6_0)
		end
	end
end

function var_0_0.updateInofoById(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getById(arg_7_1)

	if var_7_0 and arg_7_2 then
		var_7_0:updateInfo(arg_7_2)
	end
end

function var_0_0.getTransportPathMO(arg_8_0, arg_8_1)
	return arg_8_0:getById(arg_8_1)
end

function var_0_0.getTransportPathMOList(arg_9_0)
	return arg_9_0:getList()
end

function var_0_0.setIsJumpTransportSite(arg_10_0, arg_10_1)
	arg_10_0._isJumpTransportSite = arg_10_1
end

function var_0_0.getisJumpTransportSite(arg_11_0)
	return arg_11_0._isJumpTransportSite
end

var_0_0.instance = var_0_0.New()

return var_0_0
