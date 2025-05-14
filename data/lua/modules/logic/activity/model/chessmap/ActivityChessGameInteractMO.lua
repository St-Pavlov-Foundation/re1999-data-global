module("modules.logic.activity.model.chessmap.ActivityChessGameInteractMO", package.seeall)

local var_0_0 = pureTable("ActivityChessGameInteractMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.posX = arg_2_1.x
	arg_2_0.posY = arg_2_1.y
	arg_2_0.direction = arg_2_1.direction or 6

	if not string.nilorempty(arg_2_1.data) then
		arg_2_0.data = cjson.decode(arg_2_1.data)
	end
end

function var_0_0.setXY(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.posX = arg_3_1
	arg_3_0.posY = arg_3_2
end

return var_0_0
