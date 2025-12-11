module("modules.logic.unlockvoucher.config.UnlockVoucherConfig", package.seeall)

local var_0_0 = class("UnlockVoucherConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"room_color_const",
		"unlock_voucher"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getRoomColorConstCfg(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = lua_room_color_const.configDict[arg_4_1]

	if not var_4_0 and arg_4_2 then
		logError(string.format("UnlockVoucherConfig:getRoomColorConstCfg error, cfg is nil, constId:%s", arg_4_1))
	end

	return var_4_0
end

function var_0_0.getRoomColorConst(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0
	local var_5_1 = arg_5_0:getRoomColorConstCfg(arg_5_1, true)

	if var_5_1 then
		var_5_0 = var_5_1.value

		if not string.nilorempty(arg_5_2) then
			if arg_5_3 then
				var_5_0 = string.splitToNumber(var_5_0, arg_5_2)
			else
				var_5_0 = string.split(var_5_0, arg_5_2)
			end
		elseif arg_5_3 then
			var_5_0 = tonumber(var_5_0)
		end
	end

	return var_5_0
end

function var_0_0.getUnlockVoucherCfg(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_unlock_voucher.configDict[arg_6_1]

	if not var_6_0 and arg_6_2 then
		logError(string.format("UnlockVoucherConfig:getUnlockVoucherCfg error, cfg is nil, voucherId:%s", arg_6_1))
	end

	return var_6_0
end

function var_0_0.getVoucherRare(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getRoomColorConst(UnlockVoucherEnum.ConstId.UseGetVoucherItem, "#", true)
	local var_7_1, var_7_2 = ItemModel.instance:getItemConfigAndIcon(var_7_0[1], var_7_0[2])

	return var_7_1 and var_7_1.rare
end

var_0_0.instance = var_0_0.New()

return var_0_0
