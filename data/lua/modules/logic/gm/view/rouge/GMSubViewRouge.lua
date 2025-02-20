module("modules.logic.gm.view.rouge.GMSubViewRouge", package.seeall)

slot0 = class("GMSubViewRouge", GMSubViewBase)

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

slot2 = System.Enum.Parse(tolua.findtype("UnityEngine.UI.InputField+LineType"), "MultiLineNewline")

function slot0.ctor(slot0)
	slot0.tabName = "肉鸽"
end

function slot0.addLineIndex(slot0)
	slot0.lineIndex = slot0.lineIndex + 1
end

function slot0.getLineGroup(slot0)
	return "L" .. slot0.lineIndex
end

function slot0.initViewContent(slot0)
	if slot0._inited then
		return
	end

	GMSubViewBase.initViewContent(slot0)

	slot0.lineIndex = 1

	slot0:addTitleSplitLine("地图编辑")
	slot0:addButton(slot0:getLineGroup(), "肉鸽地图编辑", slot0.onClickRougeMapEditor, slot0)
	slot0:addButton(slot0:getLineGroup(), "肉鸽地图路线位置编辑", slot0.onClickRougeSelectMapEditor, slot0)

	slot0.showClickAreaTrigger = slot0:addToggle(slot0:getLineGroup(), "显示节点点击区域", slot0.onToggleValueChanged, slot0)

	slot0:addLineIndex()

	slot0.allowAbortFightTrigger = slot0:addToggle(slot0:getLineGroup(), "允许主动退出战斗", slot0.onAllowAbortFightToggleValueChanged, slot0)
	slot0.allowAbortFightTrigger.isOn = RougeEditorController.instance:isAllowAbortFight()
	slot0.startRecordGc = slot0:addButton(slot0:getLineGroup(), "开始记录内存", slot0.onClickStartRecordGc, slot0)
	slot0.endRecordGc = slot0:addButton(slot0:getLineGroup(), "结束记录内存", slot0.onClickEndRecordGc, slot0)

	slot0:addTitleSplitLine("配置检查")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "事件总表配置的id在事件分表是否存在", slot0.checkAllEventExistInSubEvent, slot0)
	slot0:addTitleSplitLine("检查id在指定表是否存在")
	slot0:addLineIndex()

	slot0.inputExcelName = slot0:addInputText(slot0:getLineGroup(), "", "表名", nil, , {
		w = 300
	})
	slot0.inputCheckExcelFields = slot0:addInputText(slot0:getLineGroup(), "", "检查表excel.字段名", nil, , {
		w = 500,
		h = 500
	})
	slot0.inputCheckExcelFields.inputField.lineType = uv0
	slot0.mathList = {
		"默认",
		"1#(%d+).*"
	}
	slot0.matchDrop = slot0:addDropDown(slot0:getLineGroup(), "匹配格式", slot0.mathList)

	slot0:addButton(slot0:getLineGroup(), "开始检查", slot0.startCheckExcel, slot0)
	slot0:addTitleSplitLine("剧情")
	slot0:addLineIndex()
	slot0:addButton(slot0:getLineGroup(), "清空肉鸽剧情", slot0._onClickClearRougeStories, slot0)
	slot0:addButton(slot0:getLineGroup(), "完成肉鸽剧情", slot0._onClickFinishRougeStories, slot0)
	slot0:addLineIndex()

	slot0._inpClearStoryValue = slot0:addInputText(slot0:getLineGroup(), "", "剧情id", nil, , {
		w = 1000
	})

	slot0:addButton(slot0:getLineGroup(), "重置剧情", slot0._onClickClearStory, slot0)
	slot0:addLineIndex()

	slot0._inpFinishStoryValue = slot0:addInputText(slot0:getLineGroup(), "", "剧情id", nil, , {
		w = 1000
	})

	slot0:addButton(slot0:getLineGroup(), "完成剧情", slot0._onClickFinishStory, slot0)
end

function slot0.onClickStartRecordGc(slot0)
	RougeProfileController.instance:startRecordMemory()
end

function slot0.onClickEndRecordGc(slot0)
	RougeProfileController.instance:endRecord()
end

function slot0.onClickRougeMapEditor(slot0)
	RougeEditorController.instance:enterRougeMapEditor()
	slot0:closeThis()
end

function slot0.onToggleValueChanged(slot0)
	if slot0.showClickAreaTrigger.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function slot0.onAllowAbortFightToggleValueChanged(slot0)
	RougeEditorController.instance:allowAbortFight(slot0.allowAbortFightTrigger.isOn)
end

function slot0.onClickRougeSelectMapEditor(slot0)
	RougeEditorController.instance:enterPathSelectMapEditorView()
	slot0:closeThis()
end

function slot0.checkAllEventExistInSubEvent(slot0)
	for slot5, slot6 in ipairs(lua_rouge_event.configList) do
		slot8 = slot6.id
		slot9 = nil

		if RougeMapHelper.isFightEvent(slot6.type) then
			if not lua_rouge_fight_event.configDict[slot8] then
				logError("肉鸽战斗事件表不存在id : " .. tostring(slot8))
			end
		elseif RougeMapHelper.isChoiceEvent(slot7) then
			if not lua_rouge_choice_event.configDict[slot8] then
				logError("肉鸽选项事件表不存在id : " .. tostring(slot8))
			end
		elseif RougeMapHelper.isStoreEvent(slot7) then
			if not lua_rouge_shop_event.configDict[slot8] then
				logError("肉鸽商店事件表不存在id : " .. tostring(slot8))
			end
		else
			logError(string.format("事件表id : %s, 配置了未知事件类型 : %s", slot8, slot7))
		end
	end

	GameFacade.showToastString("检查完毕")
end

function slot0.startCheckExcel(slot0)
	if not slot0:getExcelDataDict(slot0.inputExcelName:GetText()) then
		return
	end

	slot5 = {}

	for slot9, slot10 in ipairs(string.split(slot0.inputCheckExcelFields:GetText(), "\n")) do
		if not string.nilorempty(slot10) then
			slot11, slot12 = nil
			slot13 = string.split(slot10, ".")

			table.insert(slot5, {
				excel = slot13[1],
				fieldName = string.trim(slot13[2])
			})
		end
	end

	slot7 = slot0.matchDrop:GetValue() ~= 0 and slot0.mathList[slot6 + 1] or nil

	for slot11, slot12 in ipairs(slot5) do
		logWarn(string.format("开始检查 excel ： %s, 字段 : %s", slot12.excel, slot12.fieldName))

		if slot0:getExcelDataList(slot12.excel) then
			for slot17, slot18 in ipairs(slot13) do
				if slot18[slot12.fieldName] then
					if slot7 then
						slot19 = string.match(tostring(slot19), slot7)
					end

					if not string.nilorempty(slot19) then
						for slot24, slot25 in ipairs(string.splitToNumber(slot19, "|")) do
							if not slot2[slot25] then
								logError(string.format("excel : %s, id : %s, 字段 : %s, 配置的id : '%s' 在 excel : '%s' 中不存在", slot12.excel, slot18.id, slot12.fieldName, slot25, slot1))
							end

							logNormal("check id : " .. tostring(slot25))
						end
					end
				else
					logError(string.format("excel : %s, 不存在 字段 : %s, id : %s", slot12.excel, slot12.fieldName, slot18 and slot18.id or "nil"))
				end
			end
		end
	end
end

function slot0.getExcelDataDict(slot0, slot1)
	if not _G["lua_" .. tostring(slot1)] then
		logError("配置表不存在 ：" .. tostring(slot1))

		return
	end

	if not slot2.configDict then
		logError("配置表 configDict 不存在 ：" .. tostring(slot1))

		return
	end

	return slot3
end

function slot0.getExcelDataList(slot0, slot1)
	if not _G["lua_" .. tostring(slot1)] then
		logError("配置表不存在 ：" .. tostring(slot1))

		return
	end

	if not slot2.configList then
		logError("配置表 configDict 不存在 ：" .. tostring(slot1))

		return
	end

	return slot3
end

function slot0._onClickClearRougeStories(slot0)
	for slot4, slot5 in ipairs(lua_rouge_story_list.configList) do
		for slot10, slot11 in ipairs(string.splitToNumber(slot5.storyIdList, "#")) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", slot11))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickFinishRougeStories(slot0)
	for slot4, slot5 in ipairs(lua_rouge_story_list.configList) do
		for slot10, slot11 in ipairs(string.splitToNumber(slot5.storyIdList, "#")) do
			StoryRpc.instance:sendUpdateStoryRequest(slot11, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickClearStory(slot0)
	slot3 = slot0._inpClearStoryValue
	slot5 = slot3

	for slot5, slot6 in ipairs(string.splitToNumber(slot3.GetText(slot5), "#")) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", slot6))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function slot0._onClickFinishStory(slot0)
	slot3 = slot0._inpFinishStoryValue
	slot5 = slot3

	for slot5, slot6 in ipairs(string.splitToNumber(slot3.GetText(slot5), "#")) do
		StoryRpc.instance:sendUpdateStoryRequest(slot6, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

return slot0
