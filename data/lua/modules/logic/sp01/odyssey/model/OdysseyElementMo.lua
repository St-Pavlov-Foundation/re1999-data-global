module("modules.logic.sp01.odyssey.model.OdysseyElementMo", package.seeall)

local var_0_0 = pureTable("OdysseyElementMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = OdysseyConfig.instance:getElementConfig(arg_1_1)

	if not arg_1_0.config then
		logError(arg_1_0.id .. "的配置为空")
	end

	arg_1_0.optionEleData = {}
	arg_1_0.religionEleData = {}
	arg_1_0.conquestEleData = {}
	arg_1_0.mythicEleData = {}
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.status = arg_2_1.status

	if arg_2_0:isFinish() then
		OdysseyDungeonModel.instance:setFinishElementMap(arg_2_0.id)
	end

	arg_2_0.optionEleData.optionId = arg_2_1.optionEle and arg_2_1.optionEle.result
	arg_2_0.religionEleData.religionId = arg_2_1.religionEle and arg_2_1.religionEle.religionId
	arg_2_0.conquestEleData.highWave = arg_2_1.conquestEle and arg_2_1.conquestEle.highWave
	arg_2_0.mythicEleData.evaluation = arg_2_1.mythicEle and arg_2_1.mythicEle.evaluation
end

function var_0_0.getOptionEleData(arg_3_0)
	return arg_3_0.optionEleData
end

function var_0_0.getReligionEleData(arg_4_0)
	return arg_4_0.religionEleData
end

function var_0_0.getConquestEleData(arg_5_0)
	return arg_5_0.conquestEleData
end

function var_0_0.getMythicEleData(arg_6_0)
	return arg_6_0.mythicEleData
end

function var_0_0.isFinish(arg_7_0)
	return arg_7_0.status == OdysseyEnum.ElementStatus.Finish
end

return var_0_0
