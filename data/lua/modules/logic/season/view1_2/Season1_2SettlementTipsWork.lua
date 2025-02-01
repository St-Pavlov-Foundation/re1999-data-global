module("modules.logic.season.view1_2.Season1_2SettlementTipsWork", package.seeall)

slot0 = class("Season1_2SettlementTipsWork", BaseWork)

function slot0.onStart(slot0, slot1)
	slot0._context = slot1

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	if PopupController.instance:getPopupCount() > 0 then
		PopupController.instance:setPause("fightsuccess", false)

		slot0._showPopupView = true
	else
		slot0:_showEquipGet()
	end
end

function slot0._showEquipGet(slot0)
	PopupController.instance:setPause("fightsuccess", false)

	slot1 = {}

	tabletool.addValues(slot1, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(slot1, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(slot1, FightResultModel.instance:getMaterialDataList())

	slot2 = {}

	for slot6 = #slot1, 1, -1 do
		if slot1[slot6].materilType == MaterialEnum.MaterialType.EquipCard then
			table.insert(slot2, table.remove(slot1, slot6).materilId)
		end
	end

	slot0._showEquipCard = {}
	slot0._choiceCards = {}
	slot3 = slot0._context.onlyShowNewCard

	for slot7, slot8 in ipairs(slot2) do
		if SeasonConfig.instance:getEquipIsOptional(slot8) then
			table.insert(slot0._choiceCards, slot8)
		elseif slot3 then
			if Activity104Model.instance:isNew104Equip(slot8) then
				table.insert(slot0._showEquipCard, slot8)
			end
		else
			table.insert(slot0._showEquipCard, slot8)
		end
	end

	slot4 = slot0._context.delayTime

	if #slot0._showEquipCard > 0 then
		for slot9 = #slot0._showEquipCard, 1, -1 do
			if ({})[slot0._showEquipCard[slot9]] then
				table.remove(slot0._showEquipCard, slot9)
			else
				slot5[slot10] = true
			end
		end

		TaskDispatcher.runDelay(slot0._showGetCardView, slot0, slot4)
	elseif #slot0._choiceCards > 0 then
		TaskDispatcher.runDelay(slot0._showChoiceCardView, slot0, slot4)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot0._showPopupView then
		if PopupController.instance:getPopupCount() == 0 then
			slot0._showPopupView = nil

			slot0:_showEquipGet()
		end
	elseif slot1 == SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView) then
		if slot0:_showChoiceCardView() then
			return
		end

		slot0:onDone(true)
	end
end

function slot0._showGetCardView(slot0)
	Activity104Controller.instance:openSeasonCelebrityCardGetlView({
		is_item_id = true,
		data = slot0._showEquipCard
	})
end

function slot0._showChoiceCardView(slot0)
	if slot0._choiceCards and #slot0._choiceCards > 0 and Activity104Model.instance:getItemEquipUid(table.remove(slot0._choiceCards, 1)) then
		Activity104Controller.instance:openSeasonEquipSelectChoiceView({
			actId = Activity104Model.instance:getCurSeasonId(),
			costItemUid = slot2
		})

		return true
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
