module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameInteractMO", package.seeall)

local var_0_0 = pureTable("Va3ChessGameInteractMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2.id
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.posX = arg_2_1.x
	arg_2_0.posY = arg_2_1.y
	arg_2_0.direction = arg_2_1.direction or 6

	if arg_2_1.data and not string.nilorempty(arg_2_1.data) then
		arg_2_0.data = cjson.decode(arg_2_1.data)
	end
end

function var_0_0.setXY(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.posX = arg_3_1
	arg_3_0.posY = arg_3_2
end

function var_0_0.getXY(arg_4_0)
	return arg_4_0.posX, arg_4_0.posY
end

function var_0_0.getPosIndex(arg_5_0)
	return Va3ChessMapUtils.calPosIndex(arg_5_0.posX, arg_5_0.posY)
end

function var_0_0.getPedalStatusInDataField(arg_6_0)
	if arg_6_0.data then
		return arg_6_0.data.pedalStatus
	end
end

function var_0_0.setPedalStatus(arg_7_0, arg_7_1)
	if arg_7_0.data then
		arg_7_0.data.pedalStatus = arg_7_1
	end

	local var_7_0 = Va3ChessGameController.instance.interacts:get(arg_7_0.id)

	if var_7_0 and var_7_0:getHandler().refreshPedalStatus then
		var_7_0:getHandler():refreshPedalStatus()
	end
end

function var_0_0.setBrazierIsLight(arg_8_0, arg_8_1)
	arg_8_0._isLight = arg_8_1
end

function var_0_0.getBrazierIsLight(arg_9_0)
	return arg_9_0._isLight or false
end

function var_0_0.setDirection(arg_10_0, arg_10_1)
	arg_10_0.direction = arg_10_1
end

function var_0_0.getDirection(arg_11_0)
	return arg_11_0.direction
end

function var_0_0.setHaveBornEff(arg_12_0, arg_12_1)
	arg_12_0.haveBornEff = arg_12_1
end

function var_0_0.getHaveBornEff(arg_13_0)
	return arg_13_0.haveBornEff
end

return var_0_0
