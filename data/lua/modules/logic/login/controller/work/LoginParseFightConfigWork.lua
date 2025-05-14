module("modules.logic.login.controller.work.LoginParseFightConfigWork", package.seeall)

local var_0_0 = class("LoginParseFightConfigWork", BaseWork)

function var_0_0._timeOut(arg_1_0)
	logError("解析战斗配置出错了")

	return arg_1_0:onDone(true)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	TaskDispatcher.runDelay(arg_2_0._timeOut, arg_2_0, 10)

	arg_2_0._skillCurrCardLvDict = {}
	arg_2_0._skillNextCardLvDict = {}
	arg_2_0._skillPrevCardLvDict = {}
	arg_2_0._skillHeroIdDict = {}
	arg_2_0._skillMonsterIdDict = {}
	arg_2_0.parseFlow = FlowSequence.New()

	arg_2_0.parseFlow:addWork(FunctionWork.New(arg_2_0.parseCharacterCo, arg_2_0))
	arg_2_0.parseFlow:addWork(WorkWaitSeconds.New())
	arg_2_0.parseFlow:addWork(FunctionWork.New(arg_2_0.parseSkillExLevelCo, arg_2_0))
	arg_2_0.parseFlow:addWork(WorkWaitSeconds.New())
	arg_2_0.parseFlow:addWork(LoginParseMonsterConfigWork.New(arg_2_0._skillMonsterIdDict, arg_2_0._skillCurrCardLvDict))
	arg_2_0.parseFlow:addWork(WorkWaitSeconds.New())
	arg_2_0.parseFlow:registerDoneListener(arg_2_0.parseDone, arg_2_0)
	arg_2_0.parseFlow:start()
end

function var_0_0.parseCharacterCo(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(lua_character.configList) do
		local var_3_0 = iter_3_1.skill

		if not string.nilorempty(var_3_0) then
			local var_3_1 = FightStrUtil.instance:getSplitString2Cache(var_3_0, true)

			for iter_3_2, iter_3_3 in ipairs(var_3_1) do
				local var_3_2 = iter_3_3[2]
				local var_3_3 = iter_3_3[3]
				local var_3_4 = iter_3_3[4]

				arg_3_0._skillCurrCardLvDict[var_3_2] = 1
				arg_3_0._skillCurrCardLvDict[var_3_3] = 2
				arg_3_0._skillCurrCardLvDict[var_3_4] = 3
				arg_3_0._skillNextCardLvDict[var_3_2] = var_3_3
				arg_3_0._skillNextCardLvDict[var_3_3] = var_3_4
				arg_3_0._skillPrevCardLvDict[var_3_3] = var_3_2
				arg_3_0._skillPrevCardLvDict[var_3_4] = var_3_3

				local var_3_5 = iter_3_1.id

				arg_3_0._skillHeroIdDict[var_3_2] = var_3_5
				arg_3_0._skillHeroIdDict[var_3_3] = var_3_5
				arg_3_0._skillHeroIdDict[var_3_4] = var_3_5
			end
		end
	end
end

function var_0_0.parseSkillExLevelCo(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(lua_skill_ex_level.configList) do
		local var_4_0 = iter_4_1.heroId
		local var_4_1 = iter_4_1.skillGroup1

		if not string.nilorempty(var_4_1) then
			local var_4_2 = FightStrUtil.instance:getSplitToNumberCache(var_4_1, "|")

			for iter_4_2, iter_4_3 in ipairs(var_4_2) do
				arg_4_0._skillHeroIdDict[iter_4_3] = var_4_0
				arg_4_0._skillCurrCardLvDict[iter_4_3] = iter_4_2
			end
		end

		local var_4_3 = iter_4_1.skillGroup2

		if not string.nilorempty(var_4_3) then
			local var_4_4 = FightStrUtil.instance:getSplitToNumberCache(var_4_3, "|")

			for iter_4_4, iter_4_5 in ipairs(var_4_4) do
				arg_4_0._skillHeroIdDict[iter_4_5] = var_4_0
				arg_4_0._skillCurrCardLvDict[iter_4_5] = iter_4_4
			end
		end

		local var_4_5 = iter_4_1.skillEx

		arg_4_0._skillHeroIdDict[var_4_5] = var_4_0
	end
end

function var_0_0.parseDone(arg_5_0)
	if not arg_5_0.parseFlow.isSuccess then
		logError("解析战斗配置出错了")

		return arg_5_0:onDone(true)
	end

	FightConfig.instance:setSkillDict(arg_5_0._skillCurrCardLvDict, arg_5_0._skillNextCardLvDict, arg_5_0._skillPrevCardLvDict, arg_5_0._skillHeroIdDict, arg_5_0._skillMonsterIdDict)

	return arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._timeOut, arg_6_0)

	if arg_6_0.parseFlow then
		arg_6_0.parseFlow:destroy()

		arg_6_0.parseFlow = nil
	end

	arg_6_0._skillCurrCardLvDict = nil
	arg_6_0._skillNextCardLvDict = nil
	arg_6_0._skillPrevCardLvDict = nil
	arg_6_0._skillHeroIdDict = nil
	arg_6_0._skillMonsterIdDict = nil
end

return var_0_0
