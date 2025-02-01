module("modules.logic.summon.controller.SummonLuckyBagChoiceController", package.seeall)

slot0 = class("SummonLuckyBagChoiceController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2)
	SummonLuckyBagChoiceListModel.instance:initDatas(slot1, slot2)
end

function slot0.onCloseView(slot0)
end

function slot0.trySendChoice(slot0)
	if not SummonMainModel.instance:getPoolServerMO(SummonLuckyBagChoiceListModel.instance:getPoolId()) or not slot2:isOpening() then
		return false
	end

	if not SummonLuckyBagChoiceListModel.instance:getSelectId() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagNotSelect)

		return false
	end

	if slot0:isLuckyBagOpened() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagAlreadyReceive)

		return false
	end

	slot4, slot5, slot6, slot7 = slot0:getDuplicatePopUpParam(slot3)

	GameFacade.showMessageBox(slot4, MsgBoxEnum.BoxType.Yes_No, slot0.realSendChoice, nil, , slot0, nil, , slot5, slot6, slot7)
end

function slot0.realSendChoice(slot0)
	if SummonLuckyBagChoiceListModel.instance:getSelectId() and slot1 ~= 0 then
		SummonRpc.instance:sendOpenLuckyBagRequest(SummonLuckyBagChoiceListModel.instance:getLuckyBagId(), slot1)
	end
end

function slot0.getDuplicatePopUpParam(slot0, slot1)
	slot4 = MessageBoxIdDefine.SummonLuckyBagSelectChar
	slot5 = HeroConfig.instance:getHeroCO(slot1) and slot3.name or ""
	slot6 = ""
	slot7 = ""

	if HeroModel.instance:getByHeroId(slot1) and slot3 then
		slot8 = {}
		slot4 = (HeroModel.instance:isMaxExSkill(slot1, true) or MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat) and MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat2

		if slot8[1] and slot8[2] then
			slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2])
			slot6 = slot12 and slot12.name or ""
		end
	end

	return slot4, slot5, slot6, slot7
end

function slot0.isLuckyBagOpened(slot0)
	if SummonLuckyBagModel.instance:isLuckyBagOpened(SummonLuckyBagChoiceListModel.instance:getPoolId(), SummonLuckyBagChoiceListModel.instance:getLuckyBagId()) then
		return true
	end

	return false
end

function slot0.setSelect(slot0, slot1)
	SummonLuckyBagChoiceListModel.instance:setSelectId(slot1)
	SummonLuckyBagChoiceListModel.instance:onModelUpdate()
	slot0:dispatchEvent(SummonEvent.onLuckyListChanged)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
