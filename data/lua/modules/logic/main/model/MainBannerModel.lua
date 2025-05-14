module("modules.logic.main.model.MainBannerModel", package.seeall)

local var_0_0 = class("MainBannerModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._notShowIds = {}

	local var_1_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.BannersNotShow, "")
	local var_1_1 = string.split(var_1_0, "#")

	for iter_1_0, iter_1_1 in pairs(var_1_1) do
		if iter_1_1 ~= nil and iter_1_1 ~= "" then
			table.insert(arg_1_0._notShowIds, tonumber(iter_1_1))
		end
	end
end

function var_0_0.addNotShowid(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in pairs(arg_2_0._notShowIds) do
		if iter_2_1 == arg_2_1 then
			return
		end
	end

	table.insert(arg_2_0._notShowIds, arg_2_1)

	local var_2_0 = table.concat(arg_2_0._notShowIds, "#")

	PlayerPrefsHelper.setString(PlayerPrefsKey.BannersNotShow, var_2_0)
end

function var_0_0.getBannerInfo(arg_3_0)
	return arg_3_0._notShowIds
end

var_0_0.instance = var_0_0.New()

return var_0_0
