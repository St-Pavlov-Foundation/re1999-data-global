-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_MapDialogueHelper.lua

module("modules.logic.rouge2.map.controller.Rouge2_MapDialogueHelper", package.seeall)

local Rouge2_MapDialogueHelper = class("Rouge2_MapDialogueHelper")

function Rouge2_MapDialogueHelper.init(dialogueComp, nodeMo, doneCallback, doneCallbackObj)
	if not dialogueComp or not nodeMo then
		return
	end

	dialogueComp:clear()

	local eventMo = nodeMo.eventMo
	local selectChoiceList = eventMo:getChoiceSelectList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local strList = Rouge2_MapDialogueHelper._getEventDescList(nodeMo)
	local dialogueList = Rouge2_MapDialogueHelper.strList2DialogueList(strList)

	if selectChoiceNum <= 0 then
		dialogueComp:addTweenDialogueList(dialogueList, doneCallback, doneCallbackObj)
	else
		dialogueComp:addDoneDialougeList(dialogueList, doneCallback, doneCallbackObj)
	end

	dialogueComp:play()
end

function Rouge2_MapDialogueHelper.select(dialogueComp, nodeMo, doneCallback, doneCallbackObj)
	local eventMo = nodeMo.eventMo
	local selectChoiceList = eventMo:getChoiceSelectList()
	local selectCheckResList = eventMo:getChoiceSelectCheckResList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local selectCheckResNum = selectCheckResList and #selectCheckResList or 0

	if selectChoiceNum ~= selectCheckResNum then
		if doneCallback then
			doneCallback(doneCallbackObj)
		end

		return
	end

	local lastChoiceId = selectChoiceList[selectChoiceNum]
	local lastCheckRes = selectCheckResList[selectChoiceNum]
	local list = {}

	Rouge2_MapDialogueHelper._addChoiceDesc(lastChoiceId, lastCheckRes, list)
	Rouge2_MapDialogueHelper._addThresholdDesc(nodeMo, list)

	local dialogueList = Rouge2_MapDialogueHelper.strList2DialogueList(list)
	local newDialogueNum = dialogueList and #dialogueList or 0

	dialogueComp:_initFlow()
	dialogueComp:addTweenDialogueList(dialogueList, doneCallback, doneCallbackObj)
	dialogueComp:play()

	return newDialogueNum > 0
end

function Rouge2_MapDialogueHelper._getEventDescList(nodeMo)
	if not nodeMo or not nodeMo.eventMo then
		return {}
	end

	local eventMo = nodeMo.eventMo
	local selectChoiceList = eventMo:getChoiceSelectList()
	local selectCheckResList = eventMo:getChoiceSelectCheckResList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local list = {}
	local eventCo = nodeMo:getEventCo()
	local mainDesc = eventCo and eventCo.mainDesc

	table.insert(list, mainDesc)

	for i = 1, selectChoiceNum do
		local choiceId = selectChoiceList[i]
		local checkResult = selectCheckResList[i]

		Rouge2_MapDialogueHelper._addChoiceDesc(choiceId, checkResult, list)
	end

	Rouge2_MapDialogueHelper._addThresholdDesc(nodeMo, list)

	return list
end

function Rouge2_MapDialogueHelper._addChoiceDesc(choiceId, checkResult, list)
	local dialogueStr = Rouge2_MapConfig.instance:getChoiceSelctDescByCheckResult(choiceId, checkResult)

	if not string.nilorempty(dialogueStr) then
		table.insert(list, dialogueStr)
	end
end

function Rouge2_MapDialogueHelper._addThresholdDesc(nodeMo, strList)
	local isFinish = nodeMo:isFinishEvent()
	local canChoiceList = nodeMo.eventMo:getChoiceIdList()

	if isFinish or not canChoiceList then
		return
	end

	for _, choiceId in ipairs(canChoiceList) do
		local choiceCo = Rouge2_MapConfig.instance:getChoiceConfig(choiceId)

		if choiceCo and not string.nilorempty(choiceCo.thresholdDesc) then
			table.insert(strList, choiceCo.thresholdDesc)
		end
	end
end

function Rouge2_MapDialogueHelper.strList2DialogueList(strList)
	local dialogueList = {}

	for _, str in ipairs(strList) do
		if not string.nilorempty(str) then
			local splitStrList = GameUtil.splitString2(str, true)

			tabletool.addValues(dialogueList, splitStrList)
		end
	end

	return dialogueList
end

function Rouge2_MapDialogueHelper.selectPieceDialogue(dialogueComp, pieceMo, doneCallback, doneCallbackObj)
	local selectChoiceList = pieceMo:getSelectIdList()
	local selectCheckResList = pieceMo:getSelectCheckResList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local lastChoiceId = selectChoiceList and selectChoiceList[selectChoiceNum]
	local lastCheckRes = selectCheckResList and selectCheckResList[selectChoiceNum]
	local list = {}

	Rouge2_MapDialogueHelper._addPieceChoiceDesc(lastChoiceId, lastCheckRes, list)

	local dialogueList = Rouge2_MapDialogueHelper.strList2DialogueList(list)

	dialogueComp:_initFlow()
	dialogueComp:addTweenDialogueList(dialogueList, doneCallback, doneCallbackObj)
	dialogueComp:play()
end

function Rouge2_MapDialogueHelper.initPieceDialogue(dialogueComp, pieceMo, doneCallback, doneCallbackObj)
	if not dialogueComp or not pieceMo then
		return
	end

	dialogueComp:clear()

	local selectChoiceList = pieceMo:getSelectIdList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local strList = Rouge2_MapDialogueHelper._getPieceDescList(pieceMo)
	local dialogueList = Rouge2_MapDialogueHelper.strList2DialogueList(strList)

	if selectChoiceNum <= 0 then
		dialogueComp:addTweenDialogueList(dialogueList, doneCallback, doneCallbackObj)
	else
		dialogueComp:addDoneDialougeList(dialogueList, doneCallback, doneCallbackObj)
	end

	dialogueComp:play()
end

function Rouge2_MapDialogueHelper._getPieceDescList(pieceMo)
	if not pieceMo then
		return {}
	end

	local selectChoiceList = pieceMo:getSelectIdList()
	local selectCheckResList = pieceMo:getSelectCheckResList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0
	local list = {}
	local pieceCo = pieceMo:getPieceCo()
	local talkId = pieceCo and pieceCo.talkId
	local talkCo = lua_rouge2_piece_talk.configDict[talkId]
	local mainDesc = talkCo and talkCo.content

	table.insert(list, mainDesc)

	for i = 1, selectChoiceNum do
		local choiceId = selectChoiceList[i]
		local checkResult = selectCheckResList[i]

		Rouge2_MapDialogueHelper._addPieceChoiceDesc(choiceId, checkResult, list)
	end

	return list
end

function Rouge2_MapDialogueHelper._addPieceChoiceDesc(choiceId, checkResult, list)
	local dialogueStr = Rouge2_MapConfig.instance:getPieceSelectDescByCheckResult(choiceId, checkResult)

	if not string.nilorempty(dialogueStr) then
		table.insert(list, dialogueStr)
	end
end

function Rouge2_MapDialogueHelper.hasLastSelectDesc(nodeMo)
	if not nodeMo then
		return
	end

	local eventMo = nodeMo.eventMo
	local selectChoiceList = eventMo:getChoiceSelectList()
	local selectCheckResList = eventMo:getChoiceSelectCheckResList()
	local selectChoiceNum = selectChoiceList and #selectChoiceList or 0

	if selectChoiceNum <= 0 then
		return
	end

	local lastChoiceId = selectChoiceList[selectChoiceNum]
	local lastCheckResult = selectCheckResList[selectChoiceNum]
	local dialogueStr = Rouge2_MapConfig.instance:getChoiceSelctDescByCheckResult(lastChoiceId, lastCheckResult)

	return not string.nilorempty(dialogueStr)
end

function Rouge2_MapDialogueHelper.pieceHasLastSelectDesc(pieceMo)
	if not pieceMo then
		return
	end

	local selectIdList = pieceMo:getSelectIdList()
	local checkResList = pieceMo:getSelectCheckResList()
	local selectChoiceNum = selectIdList and #selectIdList or 0

	if selectChoiceNum <= 0 then
		return
	end

	local lastChoiceId = selectIdList and selectIdList[selectChoiceNum]
	local lastCheckResult = checkResList and checkResList[selectChoiceNum]
	local dialogueStr = Rouge2_MapConfig.instance:getPieceSelctDescByCheckResult(lastChoiceId, lastCheckResult)

	return not string.nilorempty(dialogueStr)
end

return Rouge2_MapDialogueHelper
