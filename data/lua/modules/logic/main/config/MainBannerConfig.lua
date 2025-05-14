module("modules.logic.main.config.MainBannerConfig", package.seeall)

local var_0_0 = class("MainBannerConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.bannerconfig = nil
	arg_1_0.nowbanner = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"main_banner"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "main_banner" then
		arg_3_0.bannerconfig = arg_3_2
	end
end

function var_0_0.getbannerCO(arg_4_0, arg_4_1)
	return arg_4_0.bannerconfig.configDict[arg_4_1]
end

function var_0_0.getBannersCo(arg_5_0)
	return arg_5_0.bannerconfig.configDict
end

function var_0_0.getNowBanner(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.bannerconfig.configDict) do
		if iter_6_1.startEnd ~= "" then
			local var_6_1 = {}
			local var_6_2 = string.split(iter_6_1.startEnd, "#")

			for iter_6_2, iter_6_3 in pairs(var_6_2) do
				local var_6_3 = TimeUtil.stringToTimestamp(iter_6_3)

				table.insert(var_6_1, var_6_3)
			end

			if arg_6_1 > var_6_1[1] and arg_6_1 < var_6_1[2] then
				table.insert(var_6_0, iter_6_1.id)
			end
		else
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	local var_6_4 = arg_6_0:_cleckCondition(var_6_0)
	local var_6_5 = arg_6_0:_checkid(var_6_4)

	table.sort(var_6_5, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_6_0.bannerconfig.configDict[arg_7_0].sortId
		local var_7_1 = arg_6_0.bannerconfig.configDict[arg_7_1].sortId

		if var_7_0 == var_7_1 then
			return arg_7_0 < arg_7_1
		else
			return var_7_0 < var_7_1
		end
	end)

	local var_6_6 = {}

	for iter_6_4, iter_6_5 in pairs(var_6_5) do
		if iter_6_4 <= 3 then
			table.insert(var_6_6, iter_6_5)
		end
	end

	arg_6_0.nowbanner = var_6_6

	return var_6_6
end

function var_0_0._cleckCondition(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		local var_8_1 = arg_8_0.bannerconfig.configDict[iter_8_1].appearanceRole

		if var_8_1 ~= "" then
			local var_8_2 = string.split(var_8_1, "#")

			if var_8_2[1] == "1" then
				local var_8_3 = PlayerModel.instance:getPlayinfo().lastEpisodeId

				if tonumber(var_8_3) > tonumber(var_8_2[2]) then
					table.insert(var_8_0, iter_8_1)
				end
			end
		else
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0._checkid(arg_9_0, arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if not arg_9_0:_clecknum(iter_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0._clecknum(arg_10_0, arg_10_1)
	local var_10_0 = MainBannerModel.instance:getBannerInfo()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end
end

function var_0_0.getNearTime(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_2) do
		if arg_11_0.bannerconfig.configDict[iter_11_1].startEnd ~= "" then
			local var_11_1 = string.split(arg_11_0.bannerconfig.configDict[iter_11_1].startEnd, "#")
			local var_11_2 = TimeUtil.stringToTimestamp(var_11_1[2])

			if arg_11_1 <= var_11_2 then
				local var_11_3 = {
					time = var_11_2,
					id = iter_11_1
				}

				table.insert(var_11_0, var_11_3)
			end
		end
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0.time < arg_12_1.time
	end)

	return var_11_0[1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
