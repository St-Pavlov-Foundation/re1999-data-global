module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.base.MaLiAnNaLaLevelMoRoad", package.seeall)

local var_0_0 = class("MaLiAnNaLaLevelMoRoad")

function var_0_0.create(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0.New()

	var_1_0.id = arg_1_0

	if arg_1_1 ~= nil then
		var_1_0._roadType = arg_1_1
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0)
	arg_2_0.id = 0
	arg_2_0.beginPosX = 0
	arg_2_0.beginPosY = 0
	arg_2_0.endPosX = 0
	arg_2_0.endPosY = 0
	arg_2_0._roadType = Activity201MaLiAnNaEnum.RoadType.RailWay
	arg_2_0._beginSlotId = 0
	arg_2_0._endSlotId = 0
end

function var_0_0.updatePos(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.beginPosX = arg_3_1
	arg_3_0.beginPosY = arg_3_2
	arg_3_0.endPosX = arg_3_3
	arg_3_0.endPosY = arg_3_4
end

function var_0_0.getBeginPos(arg_4_0)
	return arg_4_0.beginPosX, arg_4_0.beginPosY
end

function var_0_0.getEndPos(arg_5_0)
	return arg_5_0.endPosX, arg_5_0.endPosY
end

function var_0_0.updateSlot(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._beginSlotId = arg_6_1
	arg_6_0._endSlotId = arg_6_2
end

function var_0_0.haveSlot(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._beginSlotId == arg_7_1 and arg_7_0._endSlotId == arg_7_2 then
		return true
	end

	if arg_7_0._beginSlotId == arg_7_2 and arg_7_0._endSlotId == arg_7_1 then
		return true
	end

	return false
end

function var_0_0.findHaveSlot(arg_8_0, arg_8_1)
	local var_8_0 = false
	local var_8_1

	if arg_8_0._beginSlotId == arg_8_1 then
		var_8_0 = true
		var_8_1 = arg_8_0._endSlotId
	end

	if arg_8_0._endSlotId == arg_8_1 then
		var_8_0 = true
		var_8_1 = arg_8_0._beginSlotId
	end

	return var_8_0, var_8_1
end

function var_0_0.getStr(arg_9_0)
	return string.format("id = %d, beginPosX = %d, beginPosY = %d, endPosX = %d, endPosY = %d, beginSlotId = %d, endSlotId = %d, roadType = %d", arg_9_0.id, arg_9_0.beginPosX, arg_9_0.beginPosY, arg_9_0.endPosX, arg_9_0.endPosY, arg_9_0._beginSlotId, arg_9_0._endSlotId, arg_9_0._roadType)
end

return var_0_0
