module("modules.logic.seasonver.act123.view1_9.Season123_1_9SettlementTipsWork", package.seeall)

slot0 = class("Season123_1_9SettlementTipsWork", BaseWork)

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
		if slot1[slot6].materilType == MaterialEnum.MaterialType.Season123EquipCard then
			table.insert(slot2, table.remove(slot1, slot6).materilId)
		end
	end

	slot0._showEquipCard = {}

	for slot7, slot8 in ipairs(slot2) do
		if slot0._context.onlyShowNewCard then
			if Season123Model.instance:isNewEquipBookCard(slot8) then
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
	elseif slot1 == ViewName.Season123_1_9CelebrityCardGetView then
		slot0:onDone(true)
	end
end

function slot0._showGetCardView(slot0)
	Season123Controller.instance:openSeasonCelebrityCardGetView({
		is_item_id = true,
		data = slot0._showEquipCard
	})
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

return slot0
