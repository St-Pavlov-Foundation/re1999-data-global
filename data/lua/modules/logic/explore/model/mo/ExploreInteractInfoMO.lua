module("modules.logic.explore.model.mo.ExploreInteractInfoMO", package.seeall)

local var_0_0 = pureTable("ExploreInteractInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.step = 0
	arg_1_0.status = 1
	arg_1_0.status2 = ""
	arg_1_0.statusInfo = {}
end

function var_0_0.initNO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.status
	local var_2_1 = arg_2_0.status2

	arg_2_0.id = arg_2_1.id
	arg_2_0.status = arg_2_1.status
	arg_2_0.status2 = arg_2_1.status2
	arg_2_0.type = arg_2_1.type
	arg_2_0.step = arg_2_1.step
	arg_2_0.posx = arg_2_1.posx
	arg_2_0.posy = arg_2_1.posy
	arg_2_0.dir = arg_2_1.dir

	local var_2_2 = arg_2_0.statusInfo or {}

	if string.nilorempty(arg_2_0.status2) then
		arg_2_0.statusInfo = {}
	else
		arg_2_0.statusInfo = cjson.decode(arg_2_0.status2)
	end

	if var_2_0 ~= arg_2_0.status then
		arg_2_0:onStatusChange(var_2_0, arg_2_0.status)
	end

	if var_2_1 ~= arg_2_0.status2 then
		arg_2_0:onStatus2Change(var_2_2, arg_2_0.statusInfo)
	end
end

function var_0_0.updateStatus(arg_3_0, arg_3_1)
	if arg_3_0.status ~= arg_3_1 then
		local var_3_0 = arg_3_0.status

		arg_3_0.status = arg_3_1

		arg_3_0:onStatusChange(var_3_0, arg_3_0.status)
	end
end

function var_0_0.updateStatus2(arg_4_0, arg_4_1)
	if arg_4_0.status2 ~= arg_4_1 then
		local var_4_0 = arg_4_0.status2

		arg_4_0.status2 = arg_4_1

		local var_4_1 = arg_4_0.statusInfo or {}

		if string.nilorempty(arg_4_0.status2) then
			arg_4_0.statusInfo = {}
		else
			arg_4_0.statusInfo = cjson.decode(arg_4_0.status2)
		end

		arg_4_0:onStatus2Change(var_4_1, arg_4_0.statusInfo)
	end
end

function var_0_0.getBitByIndex(arg_5_0, arg_5_1)
	local var_5_0 = ExploreHelper.getBit(arg_5_0.status, arg_5_1)

	return bit.rshift(var_5_0, arg_5_1 - 1)
end

function var_0_0.setBitByIndex(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.status

	arg_6_0.status = ExploreHelper.setBit(arg_6_0.status, arg_6_1, arg_6_2 == 1)

	if var_6_0 ~= arg_6_0.status then
		arg_6_0:onStatusChange(var_6_0, arg_6_0.status)
	end
end

function var_0_0.onStatusChange(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = bit.bxor(arg_7_1, arg_7_2)

	if var_7_0 == 0 then
		return
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatusChange, arg_7_0.id, var_7_0)
end

function var_0_0.onStatus2Change(arg_8_0, arg_8_1, arg_8_2)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitStatus2Change, arg_8_0.id, arg_8_1, arg_8_2)
end

return var_0_0
