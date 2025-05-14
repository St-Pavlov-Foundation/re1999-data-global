module("modules.logic.gm.view.Checker_BaseWork", package.seeall)

local var_0_0 = class("Checker_BaseWork", BaseWork)

function var_0_0.endBlock(arg_1_0, arg_1_1)
	if not arg_1_0:isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock(arg_1_1)
end

function var_0_0.startBlock(arg_2_0, arg_2_1)
	if arg_2_0:isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock(arg_2_1)
end

function var_0_0.isBlock(arg_3_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.readAllText(arg_4_0, arg_4_1)
	local var_4_0 = io.open(arg_4_1, "r")

	if not var_4_0 then
		logError("[readAllText] file open failed: " .. arg_4_1)

		return false
	end

	local var_4_1 = var_4_0:read("*a")

	var_4_0:close()

	return true, var_4_1
end

function var_0_0.writeAllText(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = io.open(arg_5_1, "w+")

	if not var_5_0 then
		logError("[writeAllText] file open failed: " .. arg_5_1)

		return false
	end

	var_5_0:write(arg_5_2)
	var_5_0:close()

	return true
end

return var_0_0
