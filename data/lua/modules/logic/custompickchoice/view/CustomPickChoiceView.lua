module("modules.logic.custompickchoice.view.CustomPickChoiceView", package.seeall)

slot0 = class("CustomPickChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "mask")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "bg")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "Title")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "Tips2")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Tips2/#txt_num")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	slot0._gonogain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	slot0._goown = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0.closeThis, slot0)
	slot0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, slot0.closeThis, slot0)
end

function slot0._btnconfirmOnClick(slot0)
	CustomPickChoiceController.instance:tryChoice(slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot0._noGainHeroes = {}
	slot0._ownHeroes = {}
	slot0._goTitleNoGain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	slot0._goTitleOwn = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	slot0._transcontent = slot0._gocontent.transform

	gohelper.setActive(slot0._goitem, false)
end

function slot0.onOpen(slot0)
	logNormal("CustomPickChoiceView onOpen")
	CustomPickChoiceController.instance:onOpenView()

	slot1 = slot0.viewParam and slot0.viewParam.styleId

	if slot1 and CustomPickChoiceEnum.FixedText[slot1] then
		for slot6, slot7 in pairs(slot2) do
			if slot0[slot6] then
				slot0[slot6].text = luaLang(slot7)
			end
		end
	end

	if slot1 and CustomPickChoiceEnum.ComponentVisible[slot1] then
		for slot7, slot8 in pairs(slot3) do
			if slot0[slot7] then
				gohelper.setActive(slot0[slot7], slot8)
			end
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshSelectCount()
	slot0:refreshList()
end

function slot0.refreshSelectCount(slot0)
	slot1 = CustomPickChoiceListModel.instance:getSelectCount()
	slot2 = CustomPickChoiceListModel.instance:getMaxSelectCount()
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		slot1,
		slot2
	})

	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, slot1 ~= slot2)
end

function slot0.refreshList(slot0)
	slot0:refreshItems(CustomPickChoiceListModel.instance.noGainList, slot0._noGainHeroes, slot0._gonogain, slot0._goTitleNoGain)
	slot0:refreshItems(CustomPickChoiceListModel.instance.ownList, slot0._ownHeroes, slot0._goown, slot0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(slot0._transcontent)
end

function slot0.refreshItems(slot0, slot1, slot2, slot3, slot4)
	if slot1 and #slot1 > 0 then
		gohelper.setActive(slot3, true)
		gohelper.setActive(slot4, true)

		for slot8, slot9 in ipairs(slot1) do
			slot0:getOrCreateItem(slot8, slot2, slot3).component:onUpdateMO(slot9)
		end
	else
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot4, false)
	end
end

function slot0.getOrCreateItem(slot0, slot1, slot2, slot3)
	if not slot2[slot1] then
		slot4 = slot0:getUserDataTb_()
		slot4.go = gohelper.clone(slot0._goitem, slot3, "item" .. tostring(slot1))

		gohelper.setActive(slot4.go, true)

		slot4.component = MonoHelper.addNoUpdateLuaComOnceToGo(slot4.go, CustomPickChoiceItem)

		slot4.component:init(slot4.go)
		slot4.component:addEvents()

		slot2[slot1] = slot4
	end

	return slot4
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	CustomPickChoiceController.instance:onCloseView()
end

return slot0
