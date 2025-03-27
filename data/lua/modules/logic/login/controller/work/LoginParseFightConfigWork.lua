module("modules.logic.login.controller.work.LoginParseFightConfigWork", package.seeall)

slot0 = class("LoginParseFightConfigWork", BaseWork)

function slot0._timeOut(slot0)
	logError("解析战斗配置出错了")

	return slot0:onDone(true)
end

function slot0.onStart(slot0, slot1)
	TaskDispatcher.runDelay(slot0._timeOut, slot0, 10)

	slot0._skillCurrCardLvDict = {}
	slot0._skillNextCardLvDict = {}
	slot0._skillPrevCardLvDict = {}
	slot0._skillHeroIdDict = {}
	slot0._skillMonsterIdDict = {}
	slot0.parseFlow = FlowSequence.New()

	slot0.parseFlow:addWork(FunctionWork.New(slot0.parseCharacterCo, slot0))
	slot0.parseFlow:addWork(WorkWaitSeconds.New())
	slot0.parseFlow:addWork(FunctionWork.New(slot0.parseSkillExLevelCo, slot0))
	slot0.parseFlow:addWork(WorkWaitSeconds.New())
	slot0.parseFlow:addWork(LoginParseMonsterConfigWork.New(slot0._skillMonsterIdDict, slot0._skillCurrCardLvDict))
	slot0.parseFlow:addWork(WorkWaitSeconds.New())
	slot0.parseFlow:registerDoneListener(slot0.parseDone, slot0)
	slot0.parseFlow:start()
end

function slot0.parseCharacterCo(slot0)
	for slot4, slot5 in ipairs(lua_character.configList) do
		if not string.nilorempty(slot5.skill) then
			for slot11, slot12 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot6, true)) do
				slot13 = slot12[2]
				slot14 = slot12[3]
				slot15 = slot12[4]
				slot0._skillCurrCardLvDict[slot13] = 1
				slot0._skillCurrCardLvDict[slot14] = 2
				slot0._skillCurrCardLvDict[slot15] = 3
				slot0._skillNextCardLvDict[slot13] = slot14
				slot0._skillNextCardLvDict[slot14] = slot15
				slot0._skillPrevCardLvDict[slot14] = slot13
				slot0._skillPrevCardLvDict[slot15] = slot14
				slot16 = slot5.id
				slot0._skillHeroIdDict[slot13] = slot16
				slot0._skillHeroIdDict[slot14] = slot16
				slot0._skillHeroIdDict[slot15] = slot16
			end
		end
	end
end

function slot0.parseSkillExLevelCo(slot0)
	for slot4, slot5 in ipairs(lua_skill_ex_level.configList) do
		slot6 = slot5.heroId

		if not string.nilorempty(slot5.skillGroup1) then
			for slot12, slot13 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot7, "|")) do
				slot0._skillHeroIdDict[slot13] = slot6
				slot0._skillCurrCardLvDict[slot13] = slot12
			end
		end

		if not string.nilorempty(slot5.skillGroup2) then
			for slot13, slot14 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot8, "|")) do
				slot0._skillHeroIdDict[slot14] = slot6
				slot0._skillCurrCardLvDict[slot14] = slot13
			end
		end

		slot0._skillHeroIdDict[slot5.skillEx] = slot6
	end
end

function slot0.parseDone(slot0)
	if not slot0.parseFlow.isSuccess then
		logError("解析战斗配置出错了")

		return slot0:onDone(true)
	end

	FightConfig.instance:setSkillDict(slot0._skillCurrCardLvDict, slot0._skillNextCardLvDict, slot0._skillPrevCardLvDict, slot0._skillHeroIdDict, slot0._skillMonsterIdDict)

	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._timeOut, slot0)

	if slot0.parseFlow then
		slot0.parseFlow:destroy()

		slot0.parseFlow = nil
	end

	slot0._skillCurrCardLvDict = nil
	slot0._skillNextCardLvDict = nil
	slot0._skillPrevCardLvDict = nil
	slot0._skillHeroIdDict = nil
	slot0._skillMonsterIdDict = nil
end

return slot0
