module("modules.logic.weekwalk.config.WeekWalkConfig", package.seeall)

slot0 = class("WeekWalkConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"weekwalk",
		"weekwalk_element",
		"weekwalk_buff",
		"weekwalk_buff_pool",
		"weekwalk_level",
		"weekwalk_bonus",
		"weekwalk_element_res",
		"weekwalk_dialog",
		"weekwalk_question",
		"weekwalk_pray",
		"weekwalk_handbook",
		"weekwalk_branch",
		"weekwalk_type",
		"weekwalk_scene",
		"weekwalk_rule"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "weekwalk_dialog" then
		slot0:_initDialog()
	elseif slot1 == "weekwalk" then
		slot0:_initWeekwalk()
	end
end

function slot0.getSceneConfigByLayer(slot0, slot1)
	for slot5, slot6 in ipairs(lua_weekwalk.configList) do
		if slot6.layer == slot1 then
			return lua_weekwalk_scene.configDict[slot6.sceneId]
		end
	end
end

function slot0._initWeekwalk(slot0)
	slot0._issueList = {}

	for slot4, slot5 in ipairs(lua_weekwalk.configList) do
		if slot5.issueId > 0 then
			slot6 = slot0._issueList[slot5.issueId] or {}
			slot0._issueList[slot5.issueId] = slot6

			table.insert(slot6, slot5)
		end
	end
end

function slot0.getDeepLayer(slot0, slot1)
	return slot0._issueList[slot1]
end

function slot0._initDialog(slot0)
	slot0._dialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_weekwalk_dialog.configList) do
		if not slot0._dialogList[slot7.id] then
			slot1 = "0"
			slot0._dialogList[slot7.id] = {
				optionParamList = {}
			}
		end

		if not string.nilorempty(slot7.option_param) then
			table.insert(slot8.optionParamList, tonumber(slot7.option_param))
		end

		if slot7.type == "selector" then
			slot8[slot1] = slot8[slot7.param] or {}
			slot8[slot1].type = slot7.type
			slot8[slot1].option_param = slot7.option_param
		elseif slot7.type == "selectorend" then
			slot1 = slot2
		elseif slot7.type == "random" then
			slot8[slot9] = slot8[slot7.param] or {}
			slot8[slot9].type = slot7.type
			slot8[slot9].option_param = slot7.option_param

			table.insert(slot8[slot9], slot7)
		else
			slot8[slot1] = slot8[slot1] or {}

			table.insert(slot8[slot1], slot7)
		end
	end
end

function slot0.getDialog(slot0, slot1, slot2)
	return slot0._dialogList[slot1] and slot3[slot2]
end

function slot0.getOptionParamList(slot0, slot1)
	return slot0._dialogList[slot1] and slot2.optionParamList
end

function slot0.getMapConfig(slot0, slot1)
	return lua_weekwalk.configDict[slot1]
end

function slot0.getMapTypeConfig(slot0, slot1)
	if not slot1 then
		return nil
	end

	return lua_weekwalk_type.configDict[slot0:getMapConfig(slot1).type]
end

function slot0.getElementConfig(slot0, slot1)
	if not lua_weekwalk_element.configDict[slot1] then
		logError(string.format("getElementConfig no config id:%s", slot1))
	end

	return slot2
end

function slot0.getLevelConfig(slot0, slot1)
	return lua_weekwalk_level.configDict[slot1]
end

function slot0.getBonus(slot0, slot1, slot2)
	return lua_weekwalk_bonus.configDict[slot1][slot2].bonus
end

function slot0.getQuestionConfig(slot0, slot1)
	return lua_weekwalk_question.configDict[slot1]
end

function slot0.getMapBranchCoList(slot0, slot1)
	if slot0.mapIdToBranchCoDict then
		return slot0.mapIdToBranchCoDict[slot1]
	end

	slot0.mapIdToBranchCoDict = {}

	for slot5, slot6 in ipairs(lua_weekwalk_branch.configList) do
		if not slot0.mapIdToBranchCoDict[slot6.mapId] then
			slot0.mapIdToBranchCoDict[slot6.mapId] = {}
		end

		table.insert(slot0.mapIdToBranchCoDict[slot6.mapId], slot6)
	end

	return slot0.mapIdToBranchCoDict[slot1]
end

slot0.instance = slot0.New()

return slot0
