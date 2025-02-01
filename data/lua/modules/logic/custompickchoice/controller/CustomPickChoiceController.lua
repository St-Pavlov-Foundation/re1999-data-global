module("modules.logic.custompickchoice.controller.CustomPickChoiceController", package.seeall)

slot0 = class("CustomPickChoiceController", BaseController)

function slot0.onInit(slot0)
	slot0._pickHandler = nil
	slot0._pickHandlerObj = nil
	slot0._showMsgBoxFunc = nil
	slot0._showMsgBoxFuncObj = nil
	slot0._tmpViewParam = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.openCustomPickChoiceView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._pickHandler = slot2
	slot0._pickHandlerObj = slot3
	slot0._showMsgBoxFunc = slot5
	slot0._showMsgBoxFuncObj = slot6

	CustomPickChoiceListModel.instance:initData(slot1, slot7)
	ViewMgr.instance:openView(ViewName.CustomPickChoiceView, slot4)
end

function slot0.openNewBiePickChoiceView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._pickHandler = slot2
	slot0._pickHandlerObj = slot3
	slot0._showMsgBoxFunc = slot5
	slot0._showMsgBoxFuncObj = slot6

	CustomPickChoiceListModel.instance:initData(slot1, slot7)
	ViewMgr.instance:openView(ViewName.NewbieCustomPickView, slot4)
end

function slot0.onOpenView(slot0)
	slot0:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function slot0.setSelect(slot0, slot1)
	slot4 = CustomPickChoiceListModel.instance:getMaxSelectCount()

	if not CustomPickChoiceListModel.instance:isHeroIdSelected(slot1) and slot4 <= CustomPickChoiceListModel.instance:getSelectCount() then
		if slot4 > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			CustomPickChoiceListModel.instance:clearAllSelect()
		end
	end

	CustomPickChoiceListModel.instance:setSelectId(slot1)
	slot0:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function slot0.tryChoice(slot0, slot1)
	slot2 = CustomPickChoiceListModel.instance:getMaxSelectCount()

	if not CustomPickChoiceListModel.instance:getSelectCount() or slot2 < slot3 then
		return false
	end

	if slot3 < slot2 then
		GameFacade.showToast(ToastEnum.CustomPickMoreSelect)

		return false
	end

	slot0._tmpViewParam = slot1

	if slot0._showMsgBoxFunc then
		if slot0._showMsgBoxFuncObj then
			slot0._showMsgBoxFunc(slot0._showMsgBoxFuncObj, slot0.realChoice, slot0)
		else
			slot0._showMsgBoxFunc(slot0.realChoice, slot0)
		end
	else
		slot4 = nil
		slot5 = false

		if CustomPickChoiceListModel.instance:getSelectIds() then
			for slot10, slot11 in ipairs(slot6) do
				if not slot5 and HeroModel.instance:getByHeroId(slot11) then
					slot5 = true
				end

				if HeroConfig.instance:getHeroCO(slot11) then
					slot14 = slot13 and slot13.name or ""
					slot4 = string.nilorempty(slot4) and slot14 or GameUtil.getSubPlaceholderLuaLang(luaLang("custompickchoice_select_heros"), {
						slot14,
						slot14
					})
				end
			end
		end

		GameFacade.showMessageBox(slot5 and MessageBoxIdDefine.CustomPickChoiceHasHero or MessageBoxIdDefine.CustomPickChoiceConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.realChoice, nil, , slot0, nil, , slot4)
	end
end

function slot0.realChoice(slot0)
	if not slot0._pickHandler then
		return
	end

	slot0._pickHandler(slot0._pickHandlerObj, slot0._tmpViewParam, CustomPickChoiceListModel.instance:getSelectIds())

	slot0._tmpViewParam = nil
end

function slot0.onCloseView(slot0)
end

slot0.instance = slot0.New()

return slot0
