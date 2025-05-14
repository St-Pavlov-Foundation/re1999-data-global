module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameInteractMO", package.seeall)

local var_0_0 = pureTable("YaXianGameInteractMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1

	arg_1_0:updateMO(arg_1_2)
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id

	arg_2_0:setXY(arg_2_1.x, arg_2_1.y)
	arg_2_0:setDirection(arg_2_1.direction)

	arg_2_0.config = YaXianConfig.instance:getInteractObjectCo(arg_2_0.actId, arg_2_0.id)

	arg_2_0:updateDataByJsonData(arg_2_1.data)
end

function var_0_0.updateDataByJsonData(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.data = cjson.decode(arg_3_1)
	else
		arg_3_0.data = nil
	end

	arg_3_0:updateAlertArea()
	arg_3_0:updateNextPos()
end

function var_0_0.updateDataByTableData(arg_4_0, arg_4_1)
	arg_4_0.data = arg_4_1

	arg_4_0:updateAlertArea()
	arg_4_0:updateNextPos()
end

function var_0_0.updateAlertArea(arg_5_0)
	if not arg_5_0.data then
		arg_5_0.alertPosList = nil

		return
	end

	if not arg_5_0.data.alertArea then
		arg_5_0.alertPosList = nil

		return
	end

	arg_5_0.alertPosList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.data.alertArea) do
		table.insert(arg_5_0.alertPosList, {
			posX = iter_5_1.x,
			posY = iter_5_1.y
		})
	end
end

function var_0_0.updateNextPos(arg_6_0)
	if not arg_6_0.data then
		arg_6_0.nextPos = nil

		return
	end

	if not arg_6_0.data.nextPoint then
		arg_6_0.nextPos = nil

		return
	end

	arg_6_0.nextPos = {
		posX = arg_6_0.data.nextPoint.x,
		posY = arg_6_0.data.nextPoint.y
	}
end

function var_0_0.setXY(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.prePosX = arg_7_0.posX
	arg_7_0.prePosY = arg_7_0.posY
	arg_7_0.posX = arg_7_1
	arg_7_0.posY = arg_7_2
end

function var_0_0.setDirection(arg_8_0, arg_8_1)
	arg_8_0.preDirection = arg_8_0.direction
	arg_8_0.direction = arg_8_1
end

return var_0_0
