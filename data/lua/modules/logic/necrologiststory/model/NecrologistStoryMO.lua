module("modules.logic.necrologiststory.model.NecrologistStoryMO", package.seeall)

local var_0_0 = pureTable("NecrologistStoryMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.mainSection = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.config = NecrologistStoryConfig.instance:getPlotGroupCo(arg_2_1)
end

function var_0_0.initData(arg_3_0)
	arg_3_0._isAuto = false
	arg_3_0.situationValueDict = {}

	local var_3_0 = NecrologistStoryConfig.instance:getStoryListByGroupId(arg_3_0.id)

	arg_3_0._storyGroup = var_3_0
	arg_3_0._stepIndexDict = {}
	arg_3_0._skipNum = 0

	if not var_3_0 then
		return
	end

	arg_3_0:setSection(arg_3_0.mainSection)
end

function var_0_0.setSection(arg_4_0, arg_4_1)
	arg_4_0._sectionId = arg_4_1
	arg_4_0._storyList = arg_4_0._storyGroup[arg_4_0._sectionId]
	arg_4_0._stepCount = #arg_4_0._storyList
	arg_4_0._stepIndex = arg_4_0._stepIndexDict[arg_4_0._sectionId] or 0
	arg_4_0._stepIndexDict[arg_4_0._sectionId] = arg_4_0._stepIndex
end

function var_0_0.getStoryList(arg_5_0)
	return arg_5_0._storyList, arg_5_0._stepIndex
end

function var_0_0.isEmptyStory(arg_6_0)
	return arg_6_0._storyGroup == nil
end

function var_0_0.isStoryFinish(arg_7_0)
	if arg_7_0:isEmptyStory() then
		return true
	end

	if arg_7_0._sectionId ~= 0 then
		return false
	end

	return arg_7_0._stepIndex >= arg_7_0._stepCount
end

function var_0_0.isNextStepNeedDelay(arg_8_0)
	if not arg_8_0:getIsAuto() then
		return false
	end

	local var_8_0 = arg_8_0._stepIndex
	local var_8_1 = arg_8_0._stepCount
	local var_8_2 = arg_8_0._storyList
	local var_8_3 = arg_8_0._sectionId

	if var_8_1 <= var_8_0 then
		var_8_3 = arg_8_0.mainSection
		var_8_2 = arg_8_0._storyGroup[var_8_3]
		var_8_1 = #var_8_2
		var_8_0 = arg_8_0._stepIndexDict[var_8_3] or 0
	end

	local var_8_4 = var_8_0 + 1

	if var_8_3 == 0 and var_8_1 <= var_8_4 then
		return false
	end

	local var_8_5 = var_8_2[var_8_4]

	if not var_8_5 then
		return false
	end

	if var_8_5.type == "control" then
		local var_8_6 = string.splitToNumber(var_8_5.addControl, "|")

		for iter_8_0, iter_8_1 in ipairs(var_8_6) do
			if NecrologistStoryEnum.NeedDelayControlType[iter_8_1] ~= nil then
				return true
			end
		end

		return false
	end

	return NecrologistStoryEnum.NeedDelayType[var_8_5.type] ~= nil
end

function var_0_0.runNextStep(arg_9_0)
	if arg_9_0._stepIndex >= arg_9_0._stepCount then
		arg_9_0:setSection(arg_9_0.mainSection)
	end

	arg_9_0._stepIndex = arg_9_0._stepIndex + 1
	arg_9_0._stepIndexDict[arg_9_0._sectionId] = arg_9_0._stepIndex
end

function var_0_0.getCurStoryConfig(arg_10_0)
	return arg_10_0._storyList[arg_10_0._stepIndex]
end

function var_0_0.addSituationValue(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getSituationValue(arg_11_1)

	arg_11_0.situationValueDict[arg_11_1] = var_11_0 + arg_11_2
end

function var_0_0.getSituationValue(arg_12_0, arg_12_1)
	return arg_12_0.situationValueDict[arg_12_1] or 0
end

function var_0_0.saveSituation(arg_13_0)
	NecrologistStoryModel.instance:getGameMO(arg_13_0.config.storyId):setPlotSituationTab(arg_13_0.id, arg_13_0.situationValueDict)
end

function var_0_0.compareSituationValue(arg_14_0, arg_14_1)
	local var_14_0 = NecrologistStoryHelper.loadSituationFunc(arg_14_1)

	if not var_14_0 then
		return false
	end

	local var_14_1 = NecrologistStoryModel.instance:getGameMO(arg_14_0.config.storyId):getPlotSituationTab()

	setfenv(var_14_0, var_14_1)

	local var_14_2, var_14_3 = pcall(var_14_0)

	if var_14_2 then
		return var_14_3
	else
		logError("执行表达式错误" .. arg_14_1)

		return nil
	end
end

function var_0_0.getIsAuto(arg_15_0)
	return arg_15_0._isAuto
end

function var_0_0.setIsAuto(arg_16_0, arg_16_1)
	if arg_16_0._isAuto == arg_16_1 then
		return
	end

	arg_16_0._isAuto = arg_16_1

	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnAutoChange)
end

function var_0_0.onSkip(arg_17_0)
	arg_17_0._skipNum = arg_17_0._skipNum + 1
end

function var_0_0.getSkipNum(arg_18_0)
	return arg_18_0._skipNum
end

function var_0_0.getStatParam(arg_19_0, arg_19_1)
	return {
		heroStoryId = arg_19_0.config.storyId,
		plotGroup = arg_19_0.id,
		skipNum = arg_19_0:getSkipNum(),
		entrance = arg_19_1 and StatEnum.HeroStoryEntrance.Review or StatEnum.HeroStoryEntrance.Normal
	}
end

return var_0_0
