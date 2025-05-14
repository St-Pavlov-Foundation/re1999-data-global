module("modules.logic.chessgame.model.ChessGameInteractMo", package.seeall)

local var_0_0 = class("ChessGameInteractMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:setCo(arg_1_1)
	arg_1_0:setMo(arg_1_2)
end

function var_0_0.setCo(arg_2_0, arg_2_1)
	arg_2_0.config = arg_2_1
	arg_2_0.interactType = arg_2_1.interactType
	arg_2_0.path = arg_2_1.path
	arg_2_0.walkable = arg_2_1.walkable
	arg_2_0.show = arg_2_1.show
	arg_2_0.canMove = arg_2_1.canMove
	arg_2_0.touchTrigger = arg_2_1.touchTrigger
	arg_2_0.iconType = arg_2_1.iconType
	arg_2_0.posX = arg_2_1.x
	arg_2_0.posY = arg_2_1.y
	arg_2_0.direction = arg_2_1.dir
end

function var_0_0.setMo(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.direction = arg_3_1.direction or arg_3_1.dir or arg_3_0.config.dir
	arg_3_0.show = arg_3_1.show
	arg_3_0.triggerByClick = arg_3_1.triggerByclick
	arg_3_0.mapIndex = arg_3_1.mapIndex
	arg_3_0.posX = arg_3_1.posX or arg_3_1.x or arg_3_0.config.x
	arg_3_0.posY = arg_3_1.posY or arg_3_1.y or arg_3_0.config.y

	if arg_3_1.attrMap then
		arg_3_0:setIsFinsh(arg_3_1.attrMap)
	end

	arg_3_0:setParamStr(arg_3_1.attrData)
end

function var_0_0.isShow(arg_4_0)
	return arg_4_0.show
end

function var_0_0.getConfig(arg_5_0)
	return arg_5_0.config
end

function var_0_0.getId(arg_6_0)
	return arg_6_0.id or arg_6_0:getConfig().id
end

function var_0_0.getInteractTypeName(arg_7_0)
	return ChessGameEnum.InteractTypeToName[arg_7_0.interactType]
end

function var_0_0.setDirection(arg_8_0, arg_8_1)
	arg_8_0.direction = arg_8_1
end

function var_0_0.getDirection(arg_9_0)
	return arg_9_0.direction
end

function var_0_0.setXY(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.posX = arg_10_1
	arg_10_0.posY = arg_10_2
end

function var_0_0.getXY(arg_11_0)
	return arg_11_0.posX, arg_11_0.posY
end

function var_0_0.setParamStr(arg_12_0, arg_12_1)
	if string.nilorempty(arg_12_1) then
		return
	end

	local var_12_0 = cjson.decode(arg_12_1)

	if var_12_0 then
		arg_12_0.isFinish = var_12_0.Completed
	end
end

function var_0_0.setIsFinsh(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.isFinish = arg_13_1.Completed
	end
end

function var_0_0.CheckInteractFinish(arg_14_0)
	return arg_14_0.isFinish
end

function var_0_0.isInCurrentMap(arg_15_0)
	return arg_15_0.mapIndex == ChessGameModel.instance:getNowMapIndex()
end

function var_0_0.checkWalkable(arg_16_0)
	return arg_16_0.isWalkable and not arg_16_0.show
end

function var_0_0.getEffectType(arg_17_0)
	return arg_17_0.iconType
end

return var_0_0
