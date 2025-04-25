module("modules.logic.playercard.model.PlayerCardProgressModel", package.seeall)

slot0 = class("PlayerCardProgressModel", ListScrollModel)

function slot0.refreshList(slot0)
	if #slot0._scrollViews == 0 then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(PlayerCardConfig.instance:getCardProgressList()) do
		table.insert(slot1, {
			index = slot5,
			config = slot6,
			info = slot0.cardInfo
		})
	end

	table.sort(slot1, SortUtil.tableKeyLower({
		"index"
	}))
	slot0:setList(slot1)
end

function slot0.initSelectData(slot0, slot1)
	slot0.cardInfo = slot1

	slot0:initSelectList()

	slot0._lastSelectList = nil

	if not slot0._lastSelectList then
		slot0._lastSelectList = tabletool.copy(slot0.selectList)
	end

	slot0:setEmptyPosList()
end

function slot0.initSelectList(slot0)
	slot0.selectList = {}
	slot0._lastSelectList = nil

	if slot0.cardInfo:getProgressSetting() then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.selectList, slot6)
		end
	end
end

function slot0.clickItem(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:checkhasMO(slot1) then
		slot0:removeSelect(slot1)
	else
		slot0:addSelect(slot1)
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, slot0.selectList)
end

function slot0.checkhasMO(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.selectList) do
		if slot6[2] == slot1 then
			return true
		end
	end

	return false
end

function slot0.addSelect(slot0, slot1)
	if PlayerCardEnum.MaxProgressCardNum <= #slot0.selectList then
		GameFacade.showToast(ToastEnum.PlayerCardMaxSelect)

		return
	end

	slot0:addSelectMo(slot1)
	slot0:setEmptyPosList()
	slot0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function slot0.removeSelect(slot0, slot1)
	slot0:removeSelectMo(slot1)
	slot0:setEmptyPosList()
	slot0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function slot0.getSelectIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.selectList) do
		if slot6[2] == slot1 then
			return slot6[1]
		end
	end
end

function slot0.getemptypos(slot0)
	for slot4, slot5 in ipairs(slot0.emptyPosList) do
		if slot5 then
			return slot4
		end
	end
end

function slot0.setEmptyPosList(slot0)
	slot0.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	for slot4 = 1, 5 do
		for slot8, slot9 in ipairs(slot0.selectList) do
			if slot9[1] == slot4 then
				slot0.emptyPosList[slot4] = false
			end
		end
	end
end

function slot0.getEmptyPosList(slot0)
	return slot0.emptyPosList
end

function slot0.addSelectMo(slot0, slot1)
	table.insert(slot0.selectList, {
		slot0:getemptypos(),
		slot1
	})
end

function slot0.removeSelectMo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.selectList) do
		if slot6[2] == slot1 then
			table.remove(slot0.selectList, slot5)
		end
	end
end

function slot0.checkDiff(slot0)
	if #slot0._lastSelectList ~= #slot0.selectList then
		return true
	else
		for slot5 = 1, #slot0.selectList do
			if slot0._lastSelectList[slot5][2] ~= slot0.selectList[slot5][2] then
				return true
			end
		end
	end

	return false
end

function slot0.reselectData(slot0)
	slot0:initSelectList()
	slot0:refreshList()
	slot0:setEmptyPosList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshProgressView, slot0.selectList)
end

function slot0.confirmData(slot0)
	if not slot0.selectList or not slot0.cardInfo then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.selectList) do
		table.insert(slot1, table.concat(slot6, "#"))
	end

	PlayerCardRpc.instance:sendSetPlayerCardProgressSettingRequest(table.concat(slot1, "|"))

	slot0._lastSelectList = slot0.selectList
end

function slot0.getSelectNum(slot0)
	return #slot0.selectList
end

slot0.instance = slot0.New()

return slot0
