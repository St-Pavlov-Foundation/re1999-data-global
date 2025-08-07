module("modules.logic.versionactivity2_3.newcultivationgift.model.VersionActivity2_3NewCultivationDestinyModel", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationDestinyModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getDestinyStoneById(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return nil
	end

	local var_3_0 = ActivityConfig.instance:getActivityCo(arg_3_1)

	if var_3_0 == nil then
		return nil
	end

	if string.nilorempty(var_3_0.param) then
		return nil
	end

	return (string.splitToNumber(var_3_0.param, "#"))
end

var_0_0.instance = var_0_0.New()

return var_0_0
