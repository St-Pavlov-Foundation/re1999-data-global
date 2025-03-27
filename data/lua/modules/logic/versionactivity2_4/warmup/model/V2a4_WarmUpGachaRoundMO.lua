module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpGachaRoundMO", package.seeall)

slot0 = class("V2a4_WarmUpGachaRoundMO")
slot1 = string.format
slot2 = table.insert

function slot0.ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._index = slot2
	slot0._waveMO = slot1
	slot0._CO = slot3
	slot0._ansIsYes = not slot4
	slot0._ansIndex = slot5
	slot0._yesOrNoDialogId = slot3[slot0:yesOrNoFieldName()]
end

function slot0.index(slot0)
	return slot0._index
end

function slot0.yesOrNoFieldName(slot0)
	return (slot0._ansIsYes and "yes" or "no") .. slot0._ansIndex
end

function slot0.srcloc(slot0)
	if slot0:type() == V2a4_WarmUpEnum.AskType.Text then
		return uv0("[logError]2 .4预热活动_接听电话.xlsx - export_文字型题库集（路人）: id=%s, level=%s, %s=%s", slot0:cfgId(), slot0:level(), slot0:yesOrNoFieldName(), slot0._yesOrNoDialogId)
	elseif slot1 == V2a4_WarmUpEnum.AskType.Photo then
		return uv0("[logError] 2.4预热活动_接听电话.xlsx - export_图片型题库集: id=%s, level=%s, %s=%s", slot0:cfgId(), slot0:level(), slot0:yesOrNoFieldName(), slot0._yesOrNoDialogId)
	else
		return "[Unknown]"
	end
end

function slot0.getDialogCOList(slot0, slot1)
	slot2 = {}

	slot0:appendDialogCOList(slot2, slot1)

	return slot2
end

function slot0.appendDialogCOList(slot0, slot1, slot2)
	if isDebugBuild then
		V2a4_WarmUpConfig.instance:appendDialogCOList(slot1, slot0:srcloc(), slot2)
	else
		V2a4_WarmUpConfig.instance:appendDialogCOList(slot1, nil, slot2)
	end
end

function slot0.getDialogCOList_yesorno(slot0)
	return slot0:getDialogCOList(slot0._yesOrNoDialogId)
end

function slot0.getDialogCOList_preTalk(slot0)
	return slot0:getDialogCOList(slot0._CO.preTalk)
end

function slot0.getDialogCOList_passTalk(slot0)
	return slot0:getDialogCOList(slot0._CO.passTalk)
end

function slot0.getDialogCOList_failTalk(slot0)
	return slot0:getDialogCOList(slot0._CO.failTalk)
end

function slot0.getDialogCOList_passTalkAllYes(slot0)
	return slot0:getDialogCOList(slot0._CO.passTalkAllYes)
end

function slot0.getDialogCOList_prefaceAndPreTalk(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(V2a4_WarmUpConfig.instance:prefaceDialogListCO() or {}) do
		uv0(slot1, slot7)
	end

	slot0:appendDialogCOList(slot1, slot0._CO.preTalk)

	return slot1
end

function slot0.type(slot0)
	return slot0._waveMO:type()
end

function slot0.ansIsYes(slot0)
	return slot0._ansIsYes
end

function slot0.ansIndex(slot0)
	return slot0._ansIndex
end

function slot0.cfgId(slot0)
	return slot0._CO.id
end

function slot0.level(slot0)
	return slot0._CO.level
end

function slot0.imgName(slot0)
	return slot0._CO.imgName
end

function slot0.s_type(slot0)
	for slot4, slot5 in pairs(V2a4_WarmUpEnum.AskType) do
		if slot0 == slot5 then
			return slot4
		end
	end

	return "[V2a4_WarmUpBattleWaveMO - s_type] error !"
end

function slot0.dump(slot0, slot1, slot2)
	slot3 = string.rep("\t", slot2 or 0)

	uv0(slot1, slot3 .. uv1("index = %s", slot0._index))
	uv0(slot1, slot3 .. uv1("issue id = %s", slot0:cfgId()))
	uv0(slot1, slot3 .. uv1("level = %s", slot0:level()))
	uv0(slot1, slot3 .. uv1("ansIsYes? %s", slot0:ansIsYes()))
	uv0(slot1, slot3 .. uv1("type = %s", uv2.s_type(slot0:type())))
	uv0(slot1, slot3 .. uv1("whichAns? %s(%s)", slot0:yesOrNoFieldName(), slot0._yesOrNoDialogId))
	uv0(slot1, slot3 .. uv1("preTalk(%s), passTalk(%s), failTalk(%s)", slot0._CO.preTalk, slot0._CO.passTalk, slot0._CO.failTalk))
end

return slot0
