module("modules.logic.prototest.model.ProtoReqListModel", package.seeall)

local var_0_0 = class("ProtoReqListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._reqList = nil
end

function var_0_0.getFilterList(arg_2_0, arg_2_1)
	arg_2_0:_checkInitReqList()

	local var_2_0 = {}

	arg_2_1 = string.lower(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._reqList) do
		if string.nilorempty(arg_2_1) or string.find(iter_2_1.cmdStr, arg_2_1) or string.find(iter_2_1.reqLower, arg_2_1) or string.find(iter_2_1.moduleLower, arg_2_1) then
			table.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_0._checkInitReqList(arg_3_0)
	if arg_3_0._reqList then
		return
	end

	arg_3_0._reqList = {}

	local var_3_0 = LuaSocketMgr.instance:getCmdSettingDict()

	if var_3_0 then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			if #iter_3_1 >= 3 then
				local var_3_1 = {
					cmd = iter_3_0,
					cmdStr = tostring(iter_3_0),
					req = iter_3_1[2],
					reqLower = string.lower(iter_3_1[2]),
					module = iter_3_1[1],
					moduleLower = string.lower(iter_3_1[1])
				}

				table.insert(arg_3_0._reqList, var_3_1)
			end
		end
	else
		logError("init cmd RequestList fail, module_cmd not exist")
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
