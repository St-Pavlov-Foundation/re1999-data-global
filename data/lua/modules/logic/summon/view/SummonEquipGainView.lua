module("modules.logic.summon.view.SummonEquipGainView", package.seeall)

slot0 = class("SummonEquipGainView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonEquipSingleFinish, slot0.onSummonSingleAnimFinish, slot0)
end

function slot0.onSummonSingleAnimFinish(slot0)
	if #SummonModel.getRewardList({
		slot0.viewParam.summonResultMo
	}) <= 0 then
		return
	end

	table.sort(slot2, SummonModel.sortRewards)

	for slot6, slot7 in ipairs(slot2) do
		if slot7.materilType == MaterialEnum.MaterialType.Currency then
			slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot7.materilType, slot7.materilId)

			GameFacade.showToastWithIcon(ToastEnum.IconId, slot9, string.format("%s\n%sX%s", luaLang("equip_duplicate_tips"), slot8.name, slot7.quantity))
		end
	end
end

return slot0
