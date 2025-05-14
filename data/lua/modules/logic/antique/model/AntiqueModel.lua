module("modules.logic.antique.model.AntiqueModel", package.seeall)

local var_0_0 = class("AntiqueModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._antiqueList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._antiqueList = {}
end

function var_0_0.getAntique(arg_3_0, arg_3_1)
	return arg_3_0._antiqueList[arg_3_1]
end

function var_0_0.getAntiqueList(arg_4_0)
	return arg_4_0._antiqueList
end

function var_0_0.setAntiqueInfo(arg_5_0, arg_5_1)
	arg_5_0._antiqueList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = AntiqueMo.New()

		var_5_0:init(iter_5_1)

		arg_5_0._antiqueList[tonumber(iter_5_1.antiqueId)] = var_5_0
	end
end

function var_0_0.updateAntiqueInfo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if not arg_6_0._antiqueList[iter_6_1.antiqueId] then
			local var_6_0 = AntiqueMo.New()

			var_6_0:init(iter_6_1)

			arg_6_0._antiqueList[tonumber(iter_6_1.antiqueId)] = var_6_0
		else
			arg_6_0._antiqueList[iter_6_1.antiqueId]:reset(iter_6_1)
		end
	end
end

function var_0_0.getAntiqueGetTime(arg_7_0, arg_7_1)
	return arg_7_0._antiqueList[arg_7_1] or 0
end

function var_0_0.getAntiques(arg_8_0)
	return arg_8_0._antiqueList
end

function var_0_0.isAntiqueUnlock(arg_9_0)
	return next(arg_9_0._antiqueList)
end

var_0_0.instance = var_0_0.New()

return var_0_0
