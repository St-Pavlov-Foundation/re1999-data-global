module("modules.logic.act189.config.ShortenActConfig", package.seeall)

slot0 = string.format
slot1 = table.insert
slot2 = class("ShortenActConfig", BaseConfig)

function slot2.reqConfigNames(slot0)
	return {
		"activity189_shortenact",
		"activity189_shortenact_style"
	}
end

function slot2.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity189_shortenact" then
		slot0:__init_activity189_shortenact(slot2)
	end
end

function slot2.__init_activity189_shortenact(slot0, slot1)
	slot2 = nil

	if isDebugBuild then
		slot2 = ConfigsCheckerMgr.instance:createStrBuf(uv0("[logError] 189_运营改版活动.xlsx.xlsx - export_版本缩期活动_设置"))
	end

	for slot7, slot8 in ipairs(slot1.configList) do
		if slot8.version == GameBranchMgr.instance:VHyphenA() then
			slot0._setting = slot8

			return
		end
	end

	if isDebugBuild then
		slot2:appendLine(uv0("%s版本未上线版本缩期运营活动", slot3))
		slot2:logWarnIfGot()
	end

	slot0._setting = {
		activityId = 12607,
		style = 1
	}
end

function slot2.getSettingId(slot0)
	return slot0._setting.settingId
end

function slot2.getSettingCO(slot0)
	return Activity189Config.instance:getSettingCO(slot0:getSettingId())
end

function slot2.getActivityId(slot0)
	if slot0._setting.activityId then
		return slot1
	end

	return slot0:getSettingCO().activityId
end

function slot2.getStyleCO(slot0)
	return lua_activity189_shortenact_style.configDict[slot0._setting.style]
end

function slot2.getBonusList(slot0)
	return Activity189Config.instance:getBonusList(slot0:getSettingId())
end

function slot2.getTaskCO_ReadTask(slot0)
	return Activity189Config.instance:getTaskCO_ReadTask(slot0:getActivityId())
end

function slot2.getTaskCO_ReadTask_Tag(slot0, slot1)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(slot0:getActivityId(), slot1)
end

function slot2.getTaskCO_ReadTask_Tag_TaskId(slot0, slot1, slot2)
	return Activity189Config.instance:getTaskCO_ReadTask_Tag(slot0:getActivityId(), slot1, slot2)
end

slot2.instance = slot2.New()

return slot2
