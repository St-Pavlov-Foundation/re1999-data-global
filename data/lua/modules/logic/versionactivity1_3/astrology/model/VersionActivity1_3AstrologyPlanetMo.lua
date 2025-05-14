module("modules.logic.versionactivity1_3.astrology.model.VersionActivity1_3AstrologyPlanetMo", package.seeall)

local var_0_0 = pureTable("VersionActivity1_3AstrologyPlanetMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.angle = arg_1_1.angle
	arg_1_0.previewAngle = arg_1_1.angle
	arg_1_0.num = arg_1_1.num

	local var_1_0 = VersionActivity1_3AstrologyEnum.PlanetItem[arg_1_0.id]

	arg_1_0.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_1_0)
end

function var_0_0.updatePreviewAngle(arg_2_0, arg_2_1)
	arg_2_0.deltaAngle = arg_2_1
	arg_2_0.previewAngle = arg_2_0.previewAngle + arg_2_1

	local var_2_0 = 360

	if var_2_0 <= arg_2_0.previewAngle then
		arg_2_0.previewAngle = arg_2_0.previewAngle - var_2_0
	elseif arg_2_0.previewAngle <= -var_2_0 then
		arg_2_0.previewAngle = arg_2_0.previewAngle + var_2_0
	end
end

function var_0_0.getQuadrant(arg_3_0)
	local var_3_0 = arg_3_0.previewAngle % 360
	local var_3_1 = 45
	local var_3_2 = math.ceil(var_3_0 / var_3_1)

	if var_3_2 == 0 then
		var_3_2 = 1
	end

	return 9 - var_3_2
end

function var_0_0.getItemName(arg_4_0)
	return arg_4_0.config.name
end

function var_0_0.isFront(arg_5_0, arg_5_1)
	local var_5_0 = (arg_5_1 or arg_5_0.previewAngle) % 360

	return var_5_0 >= 0 and var_5_0 <= 180
end

function var_0_0.getRemainNum(arg_6_0)
	return arg_6_0.num - arg_6_0:getCostNum()
end

function var_0_0.getCostNum(arg_7_0)
	return arg_7_0:minDeltaAngle() / VersionActivity1_3AstrologyEnum.Angle
end

function var_0_0.minDeltaAngle(arg_8_0)
	local var_8_0 = math.abs(arg_8_0.previewAngle % 360 - arg_8_0.angle % 360)
	local var_8_1 = 360 - var_8_0

	return (math.min(var_8_0, var_8_1))
end

function var_0_0.hasAdjust(arg_9_0)
	return arg_9_0.angle % 360 ~= arg_9_0.previewAngle % 360
end

return var_0_0
