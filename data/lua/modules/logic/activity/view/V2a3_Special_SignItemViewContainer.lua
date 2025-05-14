module("modules.logic.activity.view.V2a3_Special_SignItemViewContainer", package.seeall)

local var_0_0 = class("V2a3_Special_SignItemViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	assert(false, "please override this function")
end

function var_0_0.view(arg_2_0)
	assert(false, "please override this function")
end

function var_0_0.actId(arg_3_0)
	return arg_3_0.viewParam.actId
end

function var_0_0.itemCo2TIQ(arg_4_0, arg_4_1)
	if string.nilorempty(arg_4_1) then
		return
	end

	local var_4_0 = string.split(arg_4_1, "#")

	assert(#var_4_0 >= 2, "[V2a3_Special_SignItemViewContainer] invalid itemCo=" .. tostring(arg_4_1))

	local var_4_1 = string.split(arg_4_1, "#")
	local var_4_2 = tonumber(var_4_1[1])
	local var_4_3 = tonumber(var_4_1[2])
	local var_4_4 = tonumber(var_4_1[3])

	return var_4_2, var_4_3, var_4_4
end

function var_0_0.getItemConfig(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = ItemConfigGetDefine.instance:getItemConfigFunc(arg_5_1)

	assert(var_5_0, "[V2a3_Special_SignItemViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(arg_5_1))

	local var_5_1 = var_5_0(arg_5_2)

	assert(var_5_1, "[V2a3_Special_SignItemViewContainer] item config not found materialType=" .. tostring(arg_5_1) .. " id=" .. tostring(arg_5_2))

	return var_5_1
end

function var_0_0.getItemIconResUrl(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return ""
	end

	local var_6_0 = ItemIconGetDefine.instance:getItemIconFunc(arg_6_1)

	assert(var_6_0, "[V2a3_Special_SignItemViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(arg_6_1))

	local var_6_1 = arg_6_0:getItemConfig(arg_6_1, arg_6_2)

	return var_6_0(var_6_1) or ""
end

return var_0_0
