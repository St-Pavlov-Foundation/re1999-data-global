module("modules.logic.chessgame.config.ChessGameConfig", package.seeall)

local var_0_0 = class("ChessGameConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._mapCos = {}
	arg_1_0._interactList = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return
end

function var_0_0.getMapCo(arg_3_0, arg_3_1)
	if not arg_3_0._mapCos[arg_3_1] then
		local var_3_0 = {}
		local var_3_1 = addGlobalModule("modules.configs.chessgame.lua_chessgame_group_" .. tostring(arg_3_1), "lua_chessgame_group_" .. tostring(arg_3_1))

		for iter_3_0 = 1, #var_3_1 do
			var_3_0[iter_3_0] = {}
			var_3_0[iter_3_0].path = var_3_1[iter_3_0][1]
			var_3_0[iter_3_0].interacts = {}

			for iter_3_1, iter_3_2 in ipairs(var_3_1[iter_3_0][2]) do
				var_3_0[iter_3_0].interacts[iter_3_1] = {}

				for iter_3_3, iter_3_4 in pairs(ChessGameInteractField) do
					var_3_0[iter_3_0].interacts[iter_3_1][iter_3_3] = iter_3_2[iter_3_4]
				end

				var_3_0[iter_3_0].interacts[iter_3_1].offset = {
					x = iter_3_2[8][1],
					y = iter_3_2[8][2],
					z = iter_3_2[8][3]
				}
				var_3_0[iter_3_0].interacts[iter_3_1].effects = {}

				for iter_3_5, iter_3_6 in ipairs(iter_3_2[15]) do
					var_3_0[iter_3_0].interacts[iter_3_1].effects[iter_3_5] = {
						type = iter_3_6[1],
						param = iter_3_6[2]
					}
				end

				arg_3_0._interactList[arg_3_1] = arg_3_0._interactList[arg_3_1] or {}
				arg_3_0._interactList[arg_3_1][iter_3_2[1]] = var_3_0[iter_3_0].interacts[iter_3_1]
			end

			var_3_0[iter_3_0].nodes = {}

			for iter_3_7, iter_3_8 in ipairs(var_3_1[iter_3_0][3]) do
				var_3_0[iter_3_0].nodes[iter_3_7] = {
					x = iter_3_8[1],
					y = iter_3_8[2]
				}
			end
		end

		arg_3_0._mapCos[arg_3_1] = var_3_0
	end

	return arg_3_0._mapCos[arg_3_1]
end

function var_0_0.getInteractCoById(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_0._interactList[arg_4_1][arg_4_2]
end

function var_0_0.setCurrentMapGroupId(arg_5_0, arg_5_1)
	arg_5_0._currentMapGroupId = arg_5_1
end

function var_0_0.getCurrentMapGroupId(arg_6_0)
	return arg_6_0._currentMapGroupId
end

function var_0_0.getCurrentMapCo(arg_7_0, arg_7_1)
	if not arg_7_0._currentMapGroupId then
		return
	end

	local var_7_0 = arg_7_0._mapCos[arg_7_0._currentMapGroupId]

	if not var_7_0 then
		return
	end

	if not arg_7_1 then
		return var_7_0[1]
	else
		return var_7_0[arg_7_1]
	end
end

function var_0_0.getCurrentMapCoList(arg_8_0)
	return arg_8_0._mapCos[arg_8_0._currentMapGroupId]
end

var_0_0.instance = var_0_0.New()

return var_0_0
