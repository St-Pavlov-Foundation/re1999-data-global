module("modules.logic.summon.controller.SummonCustomPickChoiceController", package.seeall)

slot0 = class("SummonCustomPickChoiceController", BaseController)

function slot0.onOpenView(slot0, slot1)
	SummonCustomPickChoiceListModel.instance:initDatas(slot1)
	slot0:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

function slot0.onCloseView(slot0)
end

function slot0.trySendChoice(slot0)
	if not SummonMainModel.instance:getPoolServerMO(SummonCustomPickChoiceListModel.instance:getPoolId()) or not slot2:isOpening() then
		return false
	end

	if not SummonCustomPickChoiceListModel.instance:getSelectIds() then
		return false
	end

	if SummonCustomPickChoiceListModel.instance:getMaxSelectCount() > #slot3 then
		if slot4 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		if slot4 == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoMoreSelect)
		end

		if slot4 == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreeMoreSelect)
		end

		return false
	end

	slot6, slot7 = slot0:getConfirmParam(slot3)

	GameFacade.showMessageBox(slot6, MsgBoxEnum.BoxType.Yes_No, slot0.realSendChoice, nil, , slot0, nil, , slot0:getSelectHeroNameStr(slot3), slot7)
end

function slot0.realSendChoice(slot0)
	SummonRpc.instance:sendChooseDoubleUpHeroRequest(SummonCustomPickChoiceListModel.instance:getPoolId(), SummonCustomPickChoiceListModel.instance:getSelectIds())
end

function slot0.getSelectHeroNameStr(slot0, slot1)
	slot2 = ""

	for slot6 = 1, #slot1 do
		slot7 = HeroConfig.instance:getHeroCO(slot1[slot6])
		slot2 = (slot6 ~= 1 or slot7.name) and slot7.name .. luaLang("sep_overseas") .. slot7.name
	end

	return slot2
end

function slot0.getConfirmParam(slot0, slot1)
	return MessageBoxIdDefine.SummonCustomPickConfirm, SummonConfig.instance:getSummonPool(SummonCustomPickChoiceListModel.instance:getPoolId()).nameCn
end

function slot0.setSelect(slot0, slot1)
	slot2 = SummonCustomPickChoiceListModel.instance:getSelectIds()

	if SummonCustomPickChoiceListModel.instance:getMaxSelectCount() == 1 then
		SummonCustomPickChoiceListModel.instance:clearSelectIds()
	elseif not SummonCustomPickChoiceListModel.instance:isHeroIdSelected(slot1) and slot3 <= #slot2 then
		if slot3 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOnePleaseCancel)
		end

		if slot3 == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoPleaseCancel)
		end

		if slot3 == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreePleaseCancel)
		end

		return
	end

	SummonCustomPickChoiceListModel.instance:setSelectId(slot1)
	slot0:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
