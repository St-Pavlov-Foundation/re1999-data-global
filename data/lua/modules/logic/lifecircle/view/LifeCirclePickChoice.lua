module("modules.logic.lifecircle.view.LifeCirclePickChoice", package.seeall)

slot0 = class("LifeCirclePickChoice", BaseView)

function slot0.onInitView(slot0)
	slot0._simageListBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_ListBG")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._scrollrule = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule")
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	slot0._gonogain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_nogain")
	slot0._goown = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_own")
	slot0._scrollrule_simple = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule_simple")
	slot0._gostoreItem_simple = gohelper.findChild(slot0.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple")
	slot0._gosimple = gohelper.findChild(slot0.viewGO, "#scroll_rule_simple/Viewport/#go_storeItem_simple/#go_simple")
	slot0._goLifeCirclePickChoiceItem = gohelper.findChild(slot0.viewGO, "#go_LifeCirclePickChoiceItem")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "#go_LifeCirclePickChoiceItem/role/#go_exskill/#image_exskill")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_LifeCirclePickChoiceItem/select/#go_click")

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

slot1 = table.insert
slot0.Style = {
	Title = 1,
	None = 0
}

function slot2(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot0.id) ~= nil ~= (HeroModel.instance:getByHeroId(slot1.id) ~= nil) then
		return slot5
	end

	if (slot2 and slot2.exSkillLevel or -1) ~= (slot3 and slot3.exSkillLevel or -1) then
		if slot6 == 5 or slot7 == 5 then
			return slot6 ~= 5
		end

		return slot7 < slot6
	end

	return slot1.id < slot0.id
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._confirmCallback(slot0)
	if slot0.viewParam.callback then
		slot1(slot0)
	else
		slot0:closeThis()
	end
end

function slot0._btnconfirmOnClick(slot0)
	slot0:_confirmCallback()
end

function slot0._editableInitView(slot0)
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title")
	slot0._btn_confirmTxt = gohelper.findChildText(slot0.viewGO, "#btn_confirm/Text")
	slot0._goTitleNoGain = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title1")
	slot0._goTitleOwn = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title2")

	gohelper.setActive(slot0._goLifeCirclePickChoiceItem, false)

	slot0._gostoreItemTrans = slot0._gostoreItem.transform
	slot0._gostoreItem_simpleTrans = slot0._gostoreItem_simple.transform
	slot0._scrollruleGo = slot0._scrollrule.gameObject
	slot0._scrollrule_simpleGo = slot0._scrollrule_simple.gameObject
	slot0._noGainItemList = {}
	slot0._ownItemList = {}
	slot0._noGainDataList = {}
	slot0._ownDataList = {}
end

function slot0._heroIdList(slot0)
	return slot0.viewParam.heroIdList or {}
end

function slot0._title(slot0)
	return slot0.viewParam.title or ""
end

function slot0._confirmDesc(slot0)
	return slot0.viewParam.confirmDesc or ""
end

function slot0.isCustomSelect(slot0)
	return slot0.viewParam.isCustomSelect or false
end

function slot0._isTitleStyle(slot0)
	return slot0.viewParam.style == uv0.Style.None
end

function slot0.onUpdateParam(slot0)
	gohelper.setActive(slot0._scrollruleGo, false)
	gohelper.setActive(slot0._scrollrule_simpleGo, false)

	if slot0:_isTitleStyle() then
		gohelper.setActive(slot0._scrollruleGo, true)
		slot0:_refreshWithTitle()
	else
		gohelper.setActive(slot0._scrollrule_simpleGo, true)
		slot0:_refresh()
	end
end

function slot0.onOpen(slot0)
	slot0._txtTitle.text = slot0:_title()
	slot0._btn_confirmTxt.text = slot0:_confirmDesc()

	for slot4, slot5 in ipairs(slot0:_heroIdList()) do
		slot6 = SummonCustomPickChoiceMO.New()

		slot6:init(slot5)

		if slot6:hasHero() then
			uv0(slot0._ownDataList, slot6)
		else
			uv0(slot0._noGainDataList, slot6)
		end
	end

	table.sort(slot0._ownDataList, uv1)
	table.sort(slot0._noGainDataList, uv1)
	slot0:onUpdateParam()
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_noGainItemList")
	GameUtil.onDestroyViewMemberList(slot0, "_ownItemList")
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshWithTitle(slot0)
	slot0:_refreshItemListAndTitle(slot0._noGainDataList, slot0._noGainItemList, slot0._gonogain, slot0._goTitleNoGain)
	slot0:_refreshItemListAndTitle(slot0._ownDataList, slot0._ownItemList, slot0._goown, slot0._goTitleOwn)
	ZProj.UGUIHelper.RebuildLayout(slot0._gostoreItemTrans)
end

function slot0._refresh(slot0)
	slot0:_refreshItemList(slot0._noGainDataList, slot0._noGainItemList, slot0._gosimple)
	slot0:_refreshItemList(slot0._ownDataList, slot0._ownItemList, slot0._gosimple)
	ZProj.UGUIHelper.RebuildLayout(slot0._gostoreItem_simpleTrans)
end

function slot0._refreshItemListAndTitle(slot0, slot1, slot2, slot3, slot4)
	slot5 = not slot1 or #slot1 == 0

	gohelper.setActive(slot3, not slot5)
	gohelper.setActive(slot4, not slot5)

	if slot5 then
		return
	end

	slot0:_refreshItemList(slot1, slot2, slot3)
end

function slot0._refreshItemList(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1) do
		if not slot2[slot7] then
			slot2[slot7] = slot0:_create_LifeCirclePickChoiceItem(slot7, slot3)
		end

		slot9:onUpdateMO(slot8)
		slot9:setActive(true)
	end

	for slot7 = #slot1 + 1, #slot2 do
		item:setActive(false)
	end
end

function slot0._create_LifeCirclePickChoiceItem(slot0, slot1, slot2)
	slot4 = LifeCirclePickChoiceItem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot4:init(gohelper.clone(slot0._goLifeCirclePickChoiceItem, slot2))
	slot4:setIndex(slot1)

	return slot4
end

function slot0.onItemSelected(slot0, slot1, slot2)
	if slot0._lastSelectedItem then
		slot0._lastSelectedItem:setSelected(false)
	end

	slot0._lastSelectedItem = slot2 and slot1 or nil
end

function slot0.selectedHeroId(slot0)
	if not slot0._lastSelectedItem then
		return
	end

	return slot0._lastSelectedItem:heroId()
end

return slot0
