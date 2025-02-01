module("modules.common.global.gamestate.GameTimeMgr", package.seeall)

slot0 = class("GameTimeMgr")
slot0.TimeScaleType = {
	GM = "GM",
	FightKillEnemy = "FightKillEnemy",
	FightTLEventSpeed = "FightTLEventSpeed"
}

function slot0.ctor(slot0)
	slot0._timeScaleDict = {}
end

function slot0.init(slot0)
	slot0._timeScaleDict = {}
end

function slot0.setTimeScale(slot0, slot1, slot2)
	if uv0.TimeScaleType[slot1] then
		slot0._timeScaleDict[slot1] = slot2 or 1
	else
		logError("没有定义时间缩放类型, timeScaleType: " .. tostring(slot1))
	end

	for slot7, slot8 in pairs(slot0._timeScaleDict) do
		slot3 = 1 * slot8
	end

	if math.abs(Time.timeScale - slot3) > 0.01 then
		logNormal("游戏速度变更: " .. tostring(slot3))
	end

	Time.timeScale = slot3

	return slot3
end

function slot0.getTimeScale(slot0, slot1)
	return slot0._timeScaleDict[slot1] or 1
end

slot0.instance = slot0.New()

return slot0
