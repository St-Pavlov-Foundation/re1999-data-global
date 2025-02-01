module("modules.logic.playercard.model.PlayerCardShowModel", package.seeall)

slot0 = class("PlayerCardShowModel", ListScrollModel)

function slot0.refreshList(slot0)
	if #slot0._scrollViews == 0 then
		return
	end

	slot2 = {}

	if PlayerCardConfig.instance:getCardList() then
		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, {
				id = slot7.id,
				info = slot0.cardInfo,
				config = slot7
			})
		end
	end

	table.sort(slot2, SortUtil.tableKeyLower({
		"id"
	}))
	slot0:setList(slot2)
end

function slot0.initSelectData(slot0, slot1)
	slot0.cardInfo = slot1
	slot0.selectList = {}

	if slot1:getCardData() then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0.selectList, slot7)
		end
	end
end

function slot0.clickItem(slot0, slot1)
	if not slot1 then
		return
	end

	if tabletool.indexOf(slot0.selectList, slot1) then
		slot0:removeSelect(slot1)
	else
		slot0:addSelect(slot1)
	end
end

function slot0.addSelect(slot0, slot1)
	if PlayerCardEnum.MaxCardNum <= #slot0.selectList then
		GameFacade.showToast(ToastEnum.PlayerCardMaxSelect)

		return
	end

	table.insert(slot0.selectList, slot1)
	slot0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function slot0.removeSelect(slot0, slot1)
	if slot1 == PlayerCardEnum.CardKey.CreateTime then
		GameFacade.showToast(ToastEnum.PlayerCardCancelSelect)

		return
	end

	tabletool.removeValue(slot0.selectList, slot1)
	slot0:refreshList()
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SelectNumChange)
end

function slot0.getSelectIndex(slot0, slot1)
	return tabletool.indexOf(slot0.selectList, slot1)
end

function slot0.confirmData(slot0)
	if not slot0.selectList or not slot0.cardInfo then
		return
	end

	PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(slot0.cardInfo:getSetting({
		[PlayerCardEnum.SettingKey.CardShow] = table.concat(slot0.selectList, "#")
	}))
end

function slot0.getSelectNum(slot0)
	return #slot0.selectList
end

slot0.instance = slot0.New()

return slot0
