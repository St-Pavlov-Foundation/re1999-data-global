module("modules.logic.login.controller.work.LoginParseMonsterConfigWork", package.seeall)

slot0 = class("LoginParseMonsterConfigWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._skillMonsterIdDict = slot1
	slot0._skillCurrCardLvDict = slot2
end

function slot0._timeOut(slot0)
	logError("解析战斗Monster配置出错了")

	return slot0:onDone(false)
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._timeOut, slot0, 10)

	slot0.curIndex = 0

	TaskDispatcher.runRepeat(slot0.parseMonsterCo, slot0, 0.0001)
end

slot0.Interval = 160

function slot0.parseMonsterCo(slot0)
	for slot5 = 1, uv0.Interval do
		slot0.curIndex = slot0.curIndex + 1

		if not lua_monster.configList[slot0.curIndex] then
			TaskDispatcher.cancelTask(slot0.parseMonsterCo, slot0)

			return slot0:onDone(true)
		end

		slot7 = slot6.id

		if FightStrUtil.instance:getSplitString2Cache(slot6.activeSkill, true, "|", "#") then
			for slot12, slot13 in ipairs(slot8) do
				slot14 = 1

				for slot18, slot19 in ipairs(slot13) do
					if lua_skill.configDict[slot19] then
						slot0._skillMonsterIdDict[slot19] = slot7
						slot0._skillCurrCardLvDict[slot19] = slot14
						slot14 = slot14 + 1
					end
				end
			end
		end

		if slot6.uniqueSkill and #slot9 > 0 then
			for slot13, slot14 in ipairs(slot9) do
				slot0._skillMonsterIdDict[slot14] = slot7
			end
		end
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._timeOut, slot0)
	TaskDispatcher.cancelTask(slot0.parseMonsterCo, slot0)
end

return slot0
