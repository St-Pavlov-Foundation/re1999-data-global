module("modules.logic.summon.model.SummonFlagSubModel", package.seeall)

local var_0_0 = class("SummonFlagSubModel", BaseModel)

function var_0_0.init(arg_1_0)
	arg_1_0._isNew = false
	arg_1_0._newFlagDict = {}

	arg_1_0:initLocalSave()
end

function var_0_0.initLocalSave(arg_2_0)
	arg_2_0._lastDict = {}

	local var_2_0 = PlayerPrefsHelper.getString(arg_2_0:getLocalKey(), "")

	if not string.nilorempty(var_2_0) then
		local var_2_1 = cjson.decode(var_2_0)

		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			arg_2_0._lastDict[iter_2_1] = 1
		end
	end
end

function var_0_0.compareRecord(arg_3_0, arg_3_1)
	arg_3_0._newFlagDict = {}

	local var_3_0 = {}

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_1 = arg_3_1[iter_3_0]

		if not arg_3_0._lastDict[var_3_1.id] then
			arg_3_0._newFlagDict[var_3_1.id] = 1
		end

		var_3_0[var_3_1.id] = 1
	end

	local var_3_2 = false

	for iter_3_1, iter_3_2 in pairs(arg_3_0._lastDict) do
		if not var_3_0[iter_3_1] then
			arg_3_0._lastDict[iter_3_1] = nil
			var_3_2 = true
		end
	end

	if var_3_2 then
		arg_3_0:flush()
	end

	SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
end

function var_0_0.cleanFlag(arg_4_0, arg_4_1)
	if arg_4_0._newFlagDict[arg_4_1] then
		arg_4_0._newFlagDict[arg_4_1] = nil
		arg_4_0._lastDict[arg_4_1] = 1

		arg_4_0:flush()
		SummonController.instance:dispatchEvent(SummonEvent.onNewPoolChanged)
	end
end

function var_0_0.hasNew(arg_5_0)
	if arg_5_0._newFlagDict and next(arg_5_0._newFlagDict) then
		return true
	end

	return false
end

function var_0_0.isNew(arg_6_0, arg_6_1)
	if arg_6_0._newFlagDict and arg_6_0._newFlagDict[arg_6_1] then
		return true
	end

	return false
end

function var_0_0.flush(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._lastDict) do
		table.insert(var_7_0, iter_7_0)
	end

	PlayerPrefsHelper.setString(arg_7_0:getLocalKey(), cjson.encode(var_7_0))
end

function var_0_0.getLocalKey(arg_8_0)
	return "SummonFlagSubModel#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

return var_0_0
