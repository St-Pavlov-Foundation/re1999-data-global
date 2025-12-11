module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoBattleTrackMO", package.seeall)

local var_0_0 = class("GaoSiNiaoBattleTrackMO")
local var_0_1

local function var_0_2()
	if var_0_1 then
		return
	end

	var_0_1 = {}

	for iter_1_0, iter_1_1 in pairs(GaoSiNiaoEnum.PathType) do
		var_0_1[iter_1_1] = iter_1_0
	end
end

function var_0_0.ctor(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0.used_times = -1
	arg_3_0._startTs = 0
end

function var_0_0.onGameStart(arg_4_0)
	arg_4_0.used_times = 0
	arg_4_0._startTs = os.time()
end

function var_0_0.onGameReset(arg_5_0)
	arg_5_0:_addResetTimes()
end

function var_0_0._addResetTimes(arg_6_0)
	arg_6_0.used_times = arg_6_0.used_times + 1
end

function var_0_0.track_act210_operation(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.used_times == -1 then
		return
	end

	var_0_2()

	local var_7_0 = arg_7_1:mapId()
	local var_7_1 = os.time() - arg_7_0._startTs
	local var_7_2 = {}

	arg_7_1:foreachGrid(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = arg_8_0:_getPlacedBagItem()

		if var_8_0 then
			local var_8_1 = var_8_0.type
			local var_8_2 = var_0_1[var_8_1]

			table.insert(var_7_2, {
				id = var_8_2 or "[Unknown]",
				x = arg_8_2,
				y = arg_8_3
			})
		end
	end)
	SDKDataTrackMgr.instance:track_act210_operation(var_7_0, arg_7_2, var_7_2, arg_7_0.used_times, var_7_1)
end

return var_0_0
