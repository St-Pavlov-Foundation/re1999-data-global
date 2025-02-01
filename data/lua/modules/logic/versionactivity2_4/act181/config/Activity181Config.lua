module("modules.logic.versionactivity2_4.act181.config.Activity181Config", package.seeall)

slot0 = class("Activity181Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity181_box",
		"activity181_boxlist"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity181_box" then
		slot0.activity181Config = slot2
	elseif slot1 == "activity181_boxlist" then
		slot0.activity181BonusConfig = slot2

		slot0:initBoxListConfig()
	end
end

function slot0.getBoxConfig(slot0, slot1)
	if not slot0.activity181Config then
		return nil
	end

	return slot0.activity181Config.configDict[slot1]
end

function slot0.initBoxListConfig(slot0)
	slot0._activityBoxListDic = {}

	for slot4, slot5 in ipairs(slot0.activity181BonusConfig.configList) do
		if not slot0._activityBoxListDic[slot5.activityId] then
			slot0._activityBoxListDic[slot5.activityId] = {}
		end

		table.insert(slot6, slot5.id)
	end
end

function slot0.getBoxListConfig(slot0, slot1, slot2)
	if slot0.activity181BonusConfig.configDict[slot1] then
		return slot0.activity181BonusConfig.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getBoxListByActivityId(slot0, slot1)
	return slot0._activityBoxListDic[slot1]
end

slot0.instance = slot0.New()

return slot0
