module("modules.logic.versionactivity2_4.pinball.model.PinballUnitCo", package.seeall)

local var_0_0 = pureTable("PinballUnitCo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.unitType = arg_1_1[1]
	arg_1_0.posX = arg_1_1[2]
	arg_1_0.posY = arg_1_1[3]
	arg_1_0.specialData = arg_1_1[4]
	arg_1_0.angle = arg_1_1[5] or 0
	arg_1_0.spriteName = arg_1_1[6] or ""
	arg_1_0.size = arg_1_1[7] and Vector2(arg_1_1[7][1], arg_1_1[7][2]) or Vector2()
	arg_1_0.shape = arg_1_1[8] or PinballEnum.Shape.Rect
	arg_1_0.scale = arg_1_1[9] or 1
	arg_1_0.resType = arg_1_1[10] or PinballEnum.ResType.Food
	arg_1_0.speed = arg_1_1[11] and Vector2(arg_1_1[11][1], arg_1_1[11][2]) or Vector2()
end

return var_0_0
