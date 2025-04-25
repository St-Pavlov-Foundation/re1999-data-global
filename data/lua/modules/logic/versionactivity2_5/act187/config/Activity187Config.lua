module("modules.logic.versionactivity2_5.act187.config.Activity187Config", package.seeall)

slot0 = class("Activity187Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity187_const",
		"activity187",
		"activity187_blessing"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.getAct187ConstCfg(slot0, slot1, slot2)
	if not lua_activity187_const.configDict[slot1] and slot2 then
		logError(string.format("Activity187Config:getAct187ConstCfg error, cfg is nil, constId:%s", slot1))
	end

	return slot3
end

function slot0.getAct187Const(slot0, slot1)
	slot2 = nil

	if slot0:getAct187ConstCfg(slot1, true) then
		slot2 = slot3.value
	end

	return slot2
end

function slot0.getAct187AccrueRewardCfg(slot0, slot1, slot2, slot3)
	if not (lua_activity187.configDict[slot1] and lua_activity187.configDict[slot1][slot2]) and slot3 then
		logError(string.format("Activity187Config:getAct187AccrueRewardCfg error, cfg is nil, actId:%s, accrueId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getAccrueRewardIdList(slot0, slot1)
	slot2 = {}

	if lua_activity187.configDict[slot1] then
		for slot7, slot8 in pairs(slot3) do
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getAccrueRewards(slot0, slot1, slot2)
	slot3 = {}

	if slot0:getAct187AccrueRewardCfg(slot1, slot2, true) then
		for slot9, slot10 in ipairs(GameUtil.splitString2(slot4.bonus, true)) do
			slot3[#slot3 + 1] = {
				accrueId = slot2,
				materilType = slot10[1],
				materilId = slot10[2],
				quantity = slot10[3]
			}
		end
	end

	return slot3
end

function slot0.getAct187BlessingCfg(slot0, slot1, slot2, slot3)
	if not (activity187_blessing.configDict[slot1] and activity187_blessing.configDict[slot1][slot2]) and slot3 then
		logError(string.format("Activity187Config:getAct187BlessingCfg error, cfg is nil, actId:%s, rewardId:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getLantern(slot0, slot1, slot2)
	slot3 = ""

	if slot0:getAct187BlessingCfg(slot1, slot2) then
		slot3 = slot4.lantern
	end

	return slot3
end

function slot0.getLanternRibbon(slot0, slot1, slot2)
	slot3 = ""

	if slot0:getAct187BlessingCfg(slot1, slot2) then
		slot3 = slot4.lanternRibbon
	end

	return slot3
end

function slot0.getLanternImg(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getAct187BlessingCfg(slot1, slot2) then
		slot3 = slot4.lanternImg
	end

	return slot3
end

function slot0.getLanternImgBg(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getAct187BlessingCfg(slot1, slot2) then
		slot3 = slot4.lanternImgBg
	end

	return slot3
end

function slot0.getBlessing(slot0, slot1, slot2)
	slot3 = ""

	if slot0:getAct187BlessingCfg(slot1, slot2) then
		slot3 = slot4.blessing
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
