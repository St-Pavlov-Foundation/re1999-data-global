module("modules.common.ShaderKeyWordMgr", package.seeall)

local var_0_0 = class("ShaderKeyWordMgr")

var_0_0.CLIPALPHA = "_CLIPALPHA_ON"

function var_0_0.init()
	if not var_0_0.enableKeyWordDict then
		var_0_0.enableKeyWordDict = {}
		var_0_0.disableList = {}
		var_0_0.updateHandle = UpdateBeat:CreateListener(var_0_0._onFrame)

		UpdateBeat:AddListener(var_0_0.updateHandle)
	end
end

function var_0_0._onFrame()
	local var_2_0 = var_0_0.enableKeyWordDict
	local var_2_1 = var_0_0.disableList

	tabletool.clear(var_2_1)

	local var_2_2 = Time.time

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if iter_2_1 < var_2_2 then
			table.insert(var_2_1, iter_2_0)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(var_2_1) do
		var_0_0.disableKeyWord(iter_2_3)
	end
end

function var_0_0.enableKeyWordAutoDisable(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or 0

	if arg_3_1 < 0 then
		return
	end

	if not arg_3_0 then
		return
	end

	var_0_0.init()

	local var_3_0 = var_0_0.enableKeyWordDict
	local var_3_1 = Time.time + arg_3_1

	if not var_3_0[arg_3_0] then
		var_3_0[arg_3_0] = var_3_1

		UnityEngine.Shader.EnableKeyword(arg_3_0)
	elseif var_3_1 > var_3_0[arg_3_0] then
		var_3_0[arg_3_0] = var_3_1
	end
end

function var_0_0.enableKeyWorkNotDisable(arg_4_0)
	UnityEngine.Shader.EnableKeyword(arg_4_0)

	var_0_0.enableKeyWordDict[arg_4_0] = nil
end

function var_0_0.disableKeyWord(arg_5_0)
	if var_0_0.enableKeyWordDict then
		var_0_0.enableKeyWordDict[arg_5_0] = nil
	end

	UnityEngine.Shader.DisableKeyword(arg_5_0)
end

function var_0_0.clear()
	var_0_0.enableKeyWordDict = nil
	var_0_0.disableList = nil

	if var_0_0.updateHandle then
		UpdateBeat:RemoveListener(var_0_0.updateHandle)
	end
end

return var_0_0
