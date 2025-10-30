module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMoSlot", package.seeall)

local var_0_0 = class("MaLiAnNaLaLevelMoSlot")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0.id = arg_1_1
	var_1_0.configId = arg_1_0

	return var_1_0
end

function var_0_0.ctor(arg_2_0)
	arg_2_0.id = 0
	arg_2_0.configId = 0
	arg_2_0.heroId = 0
	arg_2_0.posX = 0
	arg_2_0.posY = 0
end

function var_0_0.updateHeroId(arg_3_0, arg_3_1)
	arg_3_0.heroId = arg_3_1
end

function var_0_0.updatePos(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.posX = arg_4_1
	arg_4_0.posY = arg_4_2
end

function var_0_0.getPosXY(arg_5_0)
	return arg_5_0.posX, arg_5_0.posY
end

function var_0_0.getStr(arg_6_0)
	return string.format("id = %d, configId = %d, heroId = %d, posX = %d, posY = %d", arg_6_0.id, arg_6_0.configId, arg_6_0.heroId or 0, arg_6_0.posX, arg_6_0.posY)
end

return var_0_0
