module("modules.logic.versionactivity2_4.pinball.entity.PinballResFoodEntity", package.seeall)

local var_0_0 = class("PinballResFoodEntity", PinballResEntity)

function var_0_0.onHitCount(arg_1_0)
	local var_1_0 = math.random(0, 360)
	local var_1_1 = 360 / arg_1_0.divNum

	for iter_1_0 = 1, arg_1_0.divNum do
		local var_1_2 = var_1_0 + var_1_1 * iter_1_0
		local var_1_3 = PinballEntityMgr.instance:addEntity(PinballEnum.UnitType.ResSmallFood)

		var_1_3:initByCo(arg_1_0.unitCo)

		local var_1_4, var_1_5 = PinballHelper.rotateAngle(var_1_3.width * arg_1_0.childScale * 0.5 + arg_1_0.width * 0.5, var_1_3.height * arg_1_0.childScale * 0.5 + arg_1_0.height * 0.5, var_1_2)

		var_1_3.x = var_1_4 + arg_1_0.x
		var_1_3.y = var_1_5 + arg_1_0.y
		var_1_3.resNum = arg_1_0.resNum
		var_1_3.scale = arg_1_0.childScale * arg_1_0.scale
		var_1_3.width = var_1_3.width * arg_1_0.childScale
		var_1_3.height = var_1_3.height * arg_1_0.childScale

		var_1_3:loadRes()
		var_1_3:tick(0)
		var_1_3:playAnim("clone")
	end

	PinballEntityMgr.instance:removeEntity(arg_1_0.id)
end

function var_0_0.onInitByCo(arg_2_0)
	local var_2_0 = string.splitToNumber(arg_2_0.spData, "#") or {}

	arg_2_0.resNum = var_2_0[1] or 0
	arg_2_0.divNum = var_2_0[2] or 0
	arg_2_0.childScale = (var_2_0[3] or 1000) / 1000
end

return var_0_0
