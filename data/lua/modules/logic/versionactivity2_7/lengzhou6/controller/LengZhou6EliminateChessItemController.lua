module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6EliminateChessItemController", package.seeall)

local var_0_0 = class("LengZhou6EliminateChessItemController", EliminateChessItemController)

function var_0_0.InitChess(arg_1_0)
	local var_1_0 = LocalEliminateChessModel.instance:getAllCell()

	if var_1_0 == nil then
		return
	end

	for iter_1_0 = 1, #var_1_0 do
		if arg_1_0._chess[iter_1_0] == nil then
			arg_1_0._chess[iter_1_0] = {}
		end

		local var_1_1 = var_1_0[iter_1_0]

		for iter_1_1 = 1, #var_1_1 do
			local var_1_2 = var_1_1[iter_1_1]
			local var_1_3 = arg_1_0:createChess(iter_1_0, iter_1_1)

			var_1_3:initData(var_1_2)

			arg_1_0._chess[iter_1_0][iter_1_1] = var_1_3
		end
	end
end

function var_0_0.createChess(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:getChessItemGo(string.format("chess_%d_%d", arg_2_1, arg_2_2), arg_2_1, arg_2_2)
	local var_2_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_0, EliminateChessItem2_7, arg_2_0)

	var_2_1:init(var_2_0)

	return var_2_1
end

function var_0_0.tempClearAllChess(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._chess) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_3 ~= nil then
				iter_3_3:onDestroy()
			end
		end
	end

	tabletool.clear(arg_3_0._chess)
end

var_0_0.instance = var_0_0.New()

return var_0_0
