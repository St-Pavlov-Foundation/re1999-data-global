module("modules.logic.gm.view.rouge.GMSubViewRouge", package.seeall)

local var_0_0 = class("GMSubViewRouge", GMSubViewBase)

require("tolua.reflection")
tolua.loadassembly("UnityEngine.UI")

local var_0_1 = tolua.findtype("UnityEngine.UI.InputField+LineType")
local var_0_2 = System.Enum.Parse(var_0_1, "MultiLineNewline")

function var_0_0.ctor(arg_1_0)
	arg_1_0.tabName = "肉鸽"
end

function var_0_0.addLineIndex(arg_2_0)
	arg_2_0.lineIndex = arg_2_0.lineIndex + 1
end

function var_0_0.getLineGroup(arg_3_0)
	return "L" .. arg_3_0.lineIndex
end

function var_0_0.initViewContent(arg_4_0)
	if arg_4_0._inited then
		return
	end

	GMSubViewBase.initViewContent(arg_4_0)

	arg_4_0.lineIndex = 1

	arg_4_0:addTitleSplitLine("地图编辑")
	arg_4_0:addButton(arg_4_0:getLineGroup(), "肉鸽地图编辑", arg_4_0.onClickRougeMapEditor, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "肉鸽地图路线位置编辑", arg_4_0.onClickRougeSelectMapEditor, arg_4_0)

	arg_4_0.showClickAreaTrigger = arg_4_0:addToggle(arg_4_0:getLineGroup(), "显示节点点击区域", arg_4_0.onToggleValueChanged, arg_4_0)

	arg_4_0:addLineIndex()

	arg_4_0.allowAbortFightTrigger = arg_4_0:addToggle(arg_4_0:getLineGroup(), "允许主动退出战斗", arg_4_0.onAllowAbortFightToggleValueChanged, arg_4_0)
	arg_4_0.allowAbortFightTrigger.isOn = RougeEditorController.instance:isAllowAbortFight()
	arg_4_0.startRecordGc = arg_4_0:addButton(arg_4_0:getLineGroup(), "开始记录内存", arg_4_0.onClickStartRecordGc, arg_4_0)
	arg_4_0.endRecordGc = arg_4_0:addButton(arg_4_0:getLineGroup(), "结束记录内存", arg_4_0.onClickEndRecordGc, arg_4_0)

	arg_4_0:addTitleSplitLine("配置检查")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "事件总表配置的id在事件分表是否存在", arg_4_0.checkAllEventExistInSubEvent, arg_4_0)
	arg_4_0:addTitleSplitLine("检查id在指定表是否存在")
	arg_4_0:addLineIndex()

	arg_4_0.inputExcelName = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "表名", nil, nil, {
		w = 300
	})
	arg_4_0.inputCheckExcelFields = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "检查表excel.字段名", nil, nil, {
		w = 500,
		h = 500
	})
	arg_4_0.inputCheckExcelFields.inputField.lineType = var_0_2
	arg_4_0.mathList = {
		"默认",
		"1#(%d+).*"
	}
	arg_4_0.matchDrop = arg_4_0:addDropDown(arg_4_0:getLineGroup(), "匹配格式", arg_4_0.mathList)

	arg_4_0:addButton(arg_4_0:getLineGroup(), "开始检查", arg_4_0.startCheckExcel, arg_4_0)
	arg_4_0:addTitleSplitLine("剧情")
	arg_4_0:addLineIndex()
	arg_4_0:addButton(arg_4_0:getLineGroup(), "清空肉鸽剧情", arg_4_0._onClickClearRougeStories, arg_4_0)
	arg_4_0:addButton(arg_4_0:getLineGroup(), "完成肉鸽剧情", arg_4_0._onClickFinishRougeStories, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._inpClearStoryValue = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_4_0:addButton(arg_4_0:getLineGroup(), "重置剧情", arg_4_0._onClickClearStory, arg_4_0)
	arg_4_0:addLineIndex()

	arg_4_0._inpFinishStoryValue = arg_4_0:addInputText(arg_4_0:getLineGroup(), "", "剧情id", nil, nil, {
		w = 1000
	})

	arg_4_0:addButton(arg_4_0:getLineGroup(), "完成剧情", arg_4_0._onClickFinishStory, arg_4_0)
end

function var_0_0.onClickStartRecordGc(arg_5_0)
	RougeProfileController.instance:startRecordMemory()
end

function var_0_0.onClickEndRecordGc(arg_6_0)
	RougeProfileController.instance:endRecord()
end

function var_0_0.onClickRougeMapEditor(arg_7_0)
	RougeEditorController.instance:enterRougeMapEditor()
	arg_7_0:closeThis()
end

function var_0_0.onToggleValueChanged(arg_8_0)
	if arg_8_0.showClickAreaTrigger.isOn then
		RougeEditorController.instance:showNodeClickArea()
	else
		RougeEditorController.instance:hideNodeClickArea()
	end
end

function var_0_0.onAllowAbortFightToggleValueChanged(arg_9_0)
	RougeEditorController.instance:allowAbortFight(arg_9_0.allowAbortFightTrigger.isOn)
end

function var_0_0.onClickRougeSelectMapEditor(arg_10_0)
	RougeEditorController.instance:enterPathSelectMapEditorView()
	arg_10_0:closeThis()
end

function var_0_0.checkAllEventExistInSubEvent(arg_11_0)
	local var_11_0 = lua_rouge_event.configList

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = iter_11_1.type
		local var_11_2 = iter_11_1.id
		local var_11_3

		if RougeMapHelper.isFightEvent(var_11_1) then
			if not lua_rouge_fight_event.configDict[var_11_2] then
				logError("肉鸽战斗事件表不存在id : " .. tostring(var_11_2))
			end
		elseif RougeMapHelper.isChoiceEvent(var_11_1) then
			if not lua_rouge_choice_event.configDict[var_11_2] then
				logError("肉鸽选项事件表不存在id : " .. tostring(var_11_2))
			end
		elseif RougeMapHelper.isStoreEvent(var_11_1) then
			if not lua_rouge_shop_event.configDict[var_11_2] then
				logError("肉鸽商店事件表不存在id : " .. tostring(var_11_2))
			end
		else
			logError(string.format("事件表id : %s, 配置了未知事件类型 : %s", var_11_2, var_11_1))
		end
	end

	GameFacade.showToastString("检查完毕")
end

function var_0_0.startCheckExcel(arg_12_0)
	local var_12_0 = arg_12_0.inputExcelName:GetText()
	local var_12_1 = arg_12_0:getExcelDataDict(var_12_0)

	if not var_12_1 then
		return
	end

	local var_12_2 = arg_12_0.inputCheckExcelFields:GetText()
	local var_12_3 = string.split(var_12_2, "\n")
	local var_12_4 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_3) do
		if not string.nilorempty(iter_12_1) then
			local var_12_5
			local var_12_6
			local var_12_7 = string.split(iter_12_1, ".")
			local var_12_8 = var_12_7[1]
			local var_12_9 = string.trim(var_12_7[2])

			table.insert(var_12_4, {
				excel = var_12_8,
				fieldName = var_12_9
			})
		end
	end

	local var_12_10 = arg_12_0.matchDrop:GetValue()
	local var_12_11 = var_12_10 ~= 0 and arg_12_0.mathList[var_12_10 + 1] or nil

	for iter_12_2, iter_12_3 in ipairs(var_12_4) do
		logWarn(string.format("开始检查 excel ： %s, 字段 : %s", iter_12_3.excel, iter_12_3.fieldName))

		local var_12_12 = arg_12_0:getExcelDataList(iter_12_3.excel)

		if var_12_12 then
			for iter_12_4, iter_12_5 in ipairs(var_12_12) do
				local var_12_13 = iter_12_5[iter_12_3.fieldName]

				if var_12_13 then
					local var_12_14 = tostring(var_12_13)

					if var_12_11 then
						var_12_14 = string.match(var_12_14, var_12_11)
					end

					if not string.nilorempty(var_12_14) then
						local var_12_15 = string.splitToNumber(var_12_14, "|")

						for iter_12_6, iter_12_7 in ipairs(var_12_15) do
							if not var_12_1[iter_12_7] then
								logError(string.format("excel : %s, id : %s, 字段 : %s, 配置的id : '%s' 在 excel : '%s' 中不存在", iter_12_3.excel, iter_12_5.id, iter_12_3.fieldName, iter_12_7, var_12_0))
							end

							logNormal("check id : " .. tostring(iter_12_7))
						end
					end
				else
					logError(string.format("excel : %s, 不存在 字段 : %s, id : %s", iter_12_3.excel, iter_12_3.fieldName, iter_12_5 and iter_12_5.id or "nil"))
				end
			end
		end
	end
end

function var_0_0.getExcelDataDict(arg_13_0, arg_13_1)
	local var_13_0 = _G["lua_" .. tostring(arg_13_1)]

	if not var_13_0 then
		logError("配置表不存在 ：" .. tostring(arg_13_1))

		return
	end

	local var_13_1 = var_13_0.configDict

	if not var_13_1 then
		logError("配置表 configDict 不存在 ：" .. tostring(arg_13_1))

		return
	end

	return var_13_1
end

function var_0_0.getExcelDataList(arg_14_0, arg_14_1)
	local var_14_0 = _G["lua_" .. tostring(arg_14_1)]

	if not var_14_0 then
		logError("配置表不存在 ：" .. tostring(arg_14_1))

		return
	end

	local var_14_1 = var_14_0.configList

	if not var_14_1 then
		logError("配置表 configDict 不存在 ：" .. tostring(arg_14_1))

		return
	end

	return var_14_1
end

function var_0_0._onClickClearRougeStories(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(lua_rouge_story_list.configList) do
		local var_15_0 = string.splitToNumber(iter_15_1.storyIdList, "#")

		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_15_3))
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishRougeStories(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(lua_rouge_story_list.configList) do
		local var_16_0 = string.splitToNumber(iter_16_1.storyIdList, "#")

		for iter_16_2, iter_16_3 in ipairs(var_16_0) do
			StoryRpc.instance:sendUpdateStoryRequest(iter_16_3, -1, 0)
		end
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickClearStory(arg_17_0)
	local var_17_0 = string.splitToNumber(arg_17_0._inpClearStoryValue:GetText(), "#")

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		GMRpc.instance:sendGMRequest(string.format("delete story %s", iter_17_1))
	end

	StoryRpc.instance:sendGetStoryRequest()
end

function var_0_0._onClickFinishStory(arg_18_0)
	local var_18_0 = string.splitToNumber(arg_18_0._inpFinishStoryValue:GetText(), "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		StoryRpc.instance:sendUpdateStoryRequest(iter_18_1, -1, 0)
	end

	StoryRpc.instance:sendGetStoryRequest()
end

return var_0_0
