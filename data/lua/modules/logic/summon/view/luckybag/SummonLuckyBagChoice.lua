module("modules.logic.summon.view.luckybag.SummonLuckyBagChoice", package.seeall)

slot0 = class("SummonLuckyBagChoice", BaseView)

function slot0.onInitView(slot0)
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Tips2/#txt_num")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._scrollrule = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem/select/#go_click")
	slot0._gonogain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	slot0._goown = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	SummonLuckyBagChoiceController.instance:trySendChoice()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._noGainHeroes = {}
	slot0._ownHeroes = {}
	slot0._goTitleNoGain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	slot0._goTitleOwn = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/selfselectsixchoiceitem")
	slot0.goTips2 = gohelper.findChild(slot0.viewGO, "Tips2")
	slot0._tfcontent = slot0._gostoreItem.transform

	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0.goTips2, false)
end

function slot0.onDestroyView(slot0)
	SummonLuckyBagChoiceController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	logNormal("SummonLuckyBagChoice onOpen")
	slot0:addEventCb(SummonController.instance, SummonEvent.onLuckyBagOpened, slot0.handleLuckyBagOpened, slot0)
	slot0:addEventCb(SummonLuckyBagChoiceController.instance, SummonEvent.onLuckyListChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	SummonLuckyBagChoiceController.instance:onOpenView(slot0.viewParam.luckyBagId, slot0.viewParam.poolId)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, SummonLuckyBagChoiceController.instance:isLuckyBagOpened() or SummonLuckyBagChoiceListModel.instance:getSelectId() == nil)
	slot0:refreshList()
end

function slot0.handleLuckyBagOpened(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, SummonLuckyBagChoiceController.instance:isLuckyBagOpened() or SummonLuckyBagChoiceListModel.instance:getSelectId() == nil)
end

function slot0.refreshList(slot0)
	slot0:refreshItems(SummonLuckyBagChoiceListModel.instance.noGainList, slot0._noGainHeroes, slot0._gonogain, slot0._goTitleNoGain)
	slot0:refreshItems(SummonLuckyBagChoiceListModel.instance.ownList, slot0._ownHeroes, slot0._goown, slot0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(slot0._tfcontent)
end

function slot0.refreshItems(slot0, slot1, slot2, slot3, slot4)
	if slot1 and #slot1 > 0 then
		gohelper.setActive(slot3, true)

		slot8 = true

		gohelper.setActive(slot4, slot8)

		for slot8, slot9 in ipairs(slot1) do
			slot0:getOrCreateItem(slot8, slot2, slot3).component:onUpdateMO(slot9)
		end
	else
		gohelper.setActive(slot3, false)
		gohelper.setActive(slot4, false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CharacterGetView then
		slot0:closeThis()
	end
end

function slot0.getOrCreateItem(slot0, slot1, slot2, slot3)
	if not slot2[slot1] then
		slot4 = slot0:getUserDataTb_()
		slot4.go = gohelper.clone(slot0._goitem, slot3, "item" .. tostring(slot1))

		gohelper.setActive(slot4.go, true)

		slot4.component = MonoHelper.addNoUpdateLuaComOnceToGo(slot4.go, SummonLuckyBagChoiceItem)

		slot4.component:init(slot4.go)
		slot4.component:addEvents()

		slot2[slot1] = slot4
	end

	return slot4
end

return slot0
