module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMo", package.seeall)

local var_0_0 = class("MaLiAnNaLaLevelMo")

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0.id = arg_1_0

	return var_1_0
end

function var_0_0.ctor(arg_2_0)
	arg_2_0.id = 0
	arg_2_0.slots = {}
	arg_2_0.roads = {}
end

function var_0_0.init(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return
	end

	arg_3_0.id = arg_3_1.id

	arg_3_0:_initSlot(arg_3_1)
	arg_3_0:_initRoad(arg_3_1)
end

function var_0_0._initSlot(arg_4_0, arg_4_1)
	if arg_4_1.slots ~= nil then
		for iter_4_0, iter_4_1 in pairs(arg_4_1.slots) do
			local var_4_0 = MaLiAnNaLaLevelMoSlot.create(iter_4_1.configId, iter_4_1.id)

			var_4_0:updateHeroId(iter_4_1.heroId)
			var_4_0:updatePos(iter_4_1.posX, iter_4_1.posY)
			table.insert(arg_4_0.slots, var_4_0)
		end
	end
end

function var_0_0._initRoad(arg_5_0, arg_5_1)
	if arg_5_1.roads ~= nil then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.roads) do
			local var_5_0 = MaLiAnNaLaLevelMoRoad.create(iter_5_1.id, iter_5_1.roadType)

			var_5_0:updatePos(iter_5_1.beginPosX, iter_5_1.beginPosY, iter_5_1.endPosX, iter_5_1.endPosY)
			var_5_0:updateSlot(iter_5_1.beginSlotId, iter_5_1.endSlotId)
			table.insert(arg_5_0.roads, var_5_0)
		end
	end
end

function var_0_0.getStr(arg_6_0)
	local var_6_0 = string.format("id = %d ,", arg_6_0.id)

	if arg_6_0.slots ~= nil then
		var_6_0 = var_6_0 .. "slots = { "

		for iter_6_0, iter_6_1 in pairs(arg_6_0.slots) do
			var_6_0 = var_6_0 .. "{ " .. iter_6_1:getStr() .. " }, "
		end

		var_6_0 = var_6_0 .. "}, "
	end

	if arg_6_0.roads ~= nil then
		var_6_0 = var_6_0 .. "roads = { "

		for iter_6_2, iter_6_3 in pairs(arg_6_0.roads) do
			var_6_0 = var_6_0 .. "{ " .. iter_6_3:getStr() .. " }, "
		end

		var_6_0 = var_6_0 .. "}, "
	end

	return var_6_0
end

return var_0_0
