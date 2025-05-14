module("modules.common.utils.CommonJumpUtil", package.seeall)

local var_0_0 = _M

function var_0_0._enterMainScene(arg_1_0)
	logError("enter main scene " .. cjson.encode(arg_1_0))
end

function var_0_0._jumpSpecial(arg_2_0)
	logError("jump special " .. cjson.encode(arg_2_0))
end

function var_0_0._openSpecialView(arg_3_0)
	logError("open special view " .. cjson.encode(arg_3_0))
end

var_0_0.JumpTypeSpecialFunc = {
	special = var_0_0._jumpSpecial
}
var_0_0.JumpViewSpecialFunc = {
	["view#special"] = var_0_0._openSpecialView
}
var_0_0.JumpSceneFunc = {
	["scene#main"] = var_0_0._enterMainScene
}
var_0_0.JumpSeparator = "#"
var_0_0.JumpType = {
	View = "view",
	Scene = "scene"
}

function var_0_0.jump(arg_4_0)
	if string.nilorempty(arg_4_0) then
		return
	end

	local var_4_0 = string.split(arg_4_0, var_0_0.JumpSeparator)
	local var_4_1 = string.trim(var_4_0[1])
	local var_4_2 = var_0_0.JumpTypeSpecialFunc[var_4_1]

	if var_4_2 then
		local var_4_3 = var_0_0._deserializeParams(var_4_0, 2)

		var_4_2(var_4_3)
	elseif var_4_1 == var_0_0.JumpType.View then
		local var_4_4 = var_0_0._deserializeParams(var_4_0, 3)
		local var_4_5 = string.trim(var_4_0[2])
		local var_4_6 = var_0_0.JumpType.View .. var_0_0.JumpSeparator .. var_4_5
		local var_4_7 = var_0_0.JumpViewSpecialFunc[var_4_6]

		if var_4_7 then
			var_4_7(var_4_4)
		else
			ViewMgr.instance:openView(var_4_5, var_4_4)
		end
	elseif var_4_1 == var_0_0.JumpType.Scene then
		local var_4_8 = string.trim(var_4_0[2])
		local var_4_9 = var_0_0.JumpType.Scene .. var_0_0.JumpSeparator .. var_4_8
		local var_4_10 = var_0_0.JumpSceneFunc[var_4_9]

		if var_4_10 then
			local var_4_11 = var_0_0._deserializeParams(var_4_0, 3)

			var_4_10(var_4_11)
		else
			logError("jumpType scene invalid: " .. arg_4_0)
		end
	else
		logError("jumpType invalid: " .. arg_4_0)
	end
end

function var_0_0._deserializeParams(arg_5_0, arg_5_1)
	local var_5_0 = #arg_5_0

	if var_5_0 < arg_5_1 then
		return nil
	end

	local var_5_1 = arg_5_0[var_5_0]

	if arg_5_1 < var_5_0 then
		local var_5_2 = {}

		for iter_5_0 = arg_5_1, var_5_0 do
			table.insert(var_5_2, arg_5_0[iter_5_0])
		end

		var_5_1 = table.concat(var_5_2, var_0_0.JumpSeparator)
	end

	return cjson.decode(var_5_1)
end

return var_0_0
