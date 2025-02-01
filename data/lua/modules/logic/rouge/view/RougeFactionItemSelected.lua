module("modules.logic.rouge.view.RougeFactionItemSelected", package.seeall)

slot0 = class("RougeFactionItemSelected", RougeFactionItem_Base)

function slot0.onInitView(slot0)
	slot0._txtcoin = gohelper.findChildText(slot0.viewGO, "detail/coin/#txt_coin")
	slot0._txtbag = gohelper.findChildText(slot0.viewGO, "detail/bag/#txt_bag")
	slot0._txtgroup = gohelper.findChildText(slot0.viewGO, "detail/group/#txt_group")
	slot0._gobag = gohelper.findChild(slot0.viewGO, "detail/baglayout/#go_bag")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "detail/baglayout/#btn_check")
	slot0._scrolldesc2 = gohelper.findChildScrollRect(slot0.viewGO, "detail/beidong/#scroll_desc2")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "detail/beidong/#scroll_desc2/Viewport/Content/#go_descitem")
	slot0._gobtnitem = gohelper.findChild(slot0.viewGO, "detail/zhouyu/content/#go_btnitem")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "detail/zhouyu/#go_detail")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "detail/zhouyu/#go_detail/#txt_dec")
	slot0._detailimageicon = gohelper.findChildImage(slot0.viewGO, "detail/zhouyu/#go_detail/icon")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_Bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#txt_name/#txt_en")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._txtscrollDesc = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncheck:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._txtdec.text = ""
	slot0._detailTrans = slot0._godetail.transform

	RougeFactionItem_Base._editableInitView(slot0)
	gohelper.setActive(slot0._godescitem, false)
	gohelper.setActive(slot0._gobtnitem, false)
	slot0:_onSetScrollParentGameObject(slot0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect))
	slot0:_onSetScrollParentGameObject(slot0._scrolldesc2.gameObject:GetComponent(gohelper.Type_LimitedScrollRect))

	slot0._descItemList = {
		slot0:_create_RougeFactionItemSelected_DescItem(1),
		slot0:_create_RougeFactionItemSelected_DescItem(2)
	}
	slot0._btnItemList = {
		slot0:_create_RougeFactionItemSelected_BtnItem(1),
		slot0:_create_RougeFactionItemSelected_BtnItem(2)
	}

	gohelper.setActive(slot0._godetail, true)
	slot0:_deselectAllBtnItems()
	slot0:addEventCb(RougeController.instance, RougeEvent.UpdateUnlockSkill, slot0._onUpdateUnlockSkill, slot0)
end

function slot0.onDestroyView(slot0)
	RougeFactionItem_Base.onDestroyView(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_descItemList")
	GameUtil.onDestroyViewMemberList(slot0, "_btnItemList")
	slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)

	if slot0._collectionSlotComp then
		slot0._collectionSlotComp:destroy()

		slot0._collectionSlotComp = nil
	end
end

function slot0.setData(slot0, slot1)
	RougeFactionItem_Base.setData(slot0, slot1)

	slot4 = slot1.styleCO
	slot0._txtcoin.text = slot4.coin + (slot0:staticData().startViewAllInfo[RougeEnum.StartViewEnum.coin] or 0)
	slot0._txtbag.text = tostring(slot4.power + (slot3[RougeEnum.StartViewEnum.power] or 0)) .. "/" .. tostring(slot4.powerLimit + (slot3[RougeEnum.StartViewEnum.powerLimit] or 0))
	slot0._txtgroup.text = slot4.capacity + (slot3[RougeEnum.StartViewEnum.capacity] or 0)

	slot0:_initOrRefreshDescItemList(slot1)
	slot0:_initOrRefreshBtnItemList(slot1)
	slot0:_initOrRefreshCollectonSlot(slot1)
end

function slot0._create_RougeFactionItemSelected_DescItem(slot0, slot1)
	slot2 = slot0:_createItem(slot0._godescitem, RougeFactionItemSelected_DescItem)

	slot2:setIndex(slot1 or #slot0._descItemList)

	return slot2
end

function slot0._initOrRefreshDescItemList(slot0, slot1)
	for slot7, slot8 in ipairs(RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(slot1.styleCO)) do
		if not slot0._descItemList[slot7] then
			slot0._descItemList[slot7] = slot0:_create_RougeFactionItemSelected_DescItem(slot7)
		end

		slot9:setData(slot8)
	end

	for slot7 = #slot3 + 1, #slot0._descItemList do
		slot0._descItemList[slot7]:setData(nil)
	end
end

function slot0._create_RougeFactionItemSelected_BtnItem(slot0, slot1)
	slot2 = slot0:_createItem(slot0._gobtnitem, RougeFactionItemSelected_BtnItem)

	slot2:setIndex(slot1 or #slot0._btnItemList)

	return slot2
end

function slot0._initOrRefreshBtnItemList(slot0, slot1)
	slot2 = slot1.styleCO
	slot0._skillIds = {}

	slot0:_initOrRefreshActiveSkillItemList(slot2)
	slot0:_initOrRefreshMapSkillItemList(slot2)
	slot0:_initOrRefreshUnlockSkillItemList(slot2)

	for slot7 = (slot0._skillIds and #slot0._skillIds or 0) + 1, #slot0._btnItemList do
		slot0._btnItemList[slot7]:setData(nil)
	end
end

function slot0._initOrRefreshActiveSkillItemList(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot1.activeSkills, "#")) do
		if not slot0._btnItemList[slot0:_getCanUseItemIndex()] then
			slot0._btnItemList[slot8] = slot0:_create_RougeFactionItemSelected_BtnItem(slot8)
		end

		slot9:setData(RougeEnum.SkillType.Style, slot7, true)
		table.insert(slot0._skillIds, slot7)
	end
end

function slot0._initOrRefreshMapSkillItemList(slot0, slot1)
	for slot6, slot7 in ipairs(string.splitToNumber(slot1.mapSkills, "#")) do
		if not slot0._btnItemList[slot0:_getCanUseItemIndex()] then
			slot0._btnItemList[slot8] = slot0:_create_RougeFactionItemSelected_BtnItem(slot8)
		end

		slot9:setData(RougeEnum.SkillType.Map, slot7, true)
		table.insert(slot0._skillIds, slot7)
	end
end

function slot0._initOrRefreshUnlockSkillItemList(slot0, slot1)
	slot2 = RougeOutsideModel.instance:getRougeGameRecord()

	for slot7, slot8 in ipairs(RougeDLCConfig101.instance:getStyleUnlockSkills(slot1.id) or {}) do
		if RougeDLCHelper.isCurrentUsingContent(slot8.version) then
			if not slot0._btnItemList[slot0:_getCanUseItemIndex()] then
				slot0._btnItemList[slot10] = slot0:_create_RougeFactionItemSelected_BtnItem(slot10)
			end

			slot11:setData(slot8.type, slot8.skillId, slot2:isSkillUnlock(slot8.type, slot8.skillId))
			table.insert(slot0._skillIds, slot8.skillId)
		end
	end
end

function slot0._getCanUseItemIndex(slot0)
	return slot0._skillIds and #slot0._skillIds + 1 or 0
end

function slot0._initOrRefreshCollectonSlot(slot0, slot1)
	if not slot0._collectionSlotComp then
		slot0._collectionSlotComp = RougeCollectionSlotComp.Get(slot0._gobag, RougeCollectionHelper.StyleCollectionSlotParam)
		slot3 = slot1.styleCO.layoutId
		slot4 = RougeCollectionConfig.instance:getCollectionInitialBagSize(slot3)

		slot0._collectionSlotComp:onUpdateMO(slot4.col, slot4.row, slot0:_createInitialCollections(slot3))
	end
end

function slot0._createInitialCollections(slot0, slot1)
	if not RougeCollectionConfig.instance:getStyleInitialCollections(slot1) then
		return
	end

	slot3 = {}
	slot0._collectionCfgIds = {}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = RougeCollectionSlotMO.New()

		slot9:init({
			item = {
				id = slot7,
				itemId = slot8.cfgId
			},
			rotation = slot8.rotation,
			pos = slot8.pos
		})
		table.insert(slot3, slot9)
		table.insert(slot0._collectionCfgIds, slot8.cfgId)
	end

	return slot3
end

function slot0._createItem(slot0, slot1, slot2)
	slot4 = slot2.New(slot0)

	slot4:init(gohelper.cloneInPlace(slot1, slot2.__cname))

	return slot4
end

function slot0._btnItemOnSelectIndex(slot0, slot1, slot2)
	slot0._btnItemList[slot1]:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	slot0._btnItemLastSelectIndex = slot1

	if not slot2 then
		RougeDLCController101.instance:openRougeFactionLockedTips({
			skillId = slot0._skillIds[slot1]
		})

		return
	end

	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	slot0:_setActiveDetail(true)
end

function slot0._onTouchScreen(slot0)
	slot0:_deselectAllBtnItems()
end

function slot0._setActiveDetail(slot0, slot1)
	GameUtil.setActive01(slot0._detailTrans, slot1)

	if slot1 then
		slot0:_resetDetailPos()
	end
end

function slot0._deselectAllBtnItems(slot0)
	slot0:_setActiveDetail(false)

	if slot0._btnItemLastSelectIndex then
		if slot0._btnItemList[slot0._btnItemLastSelectIndex] then
			slot1:setSelected(false)
		end

		slot0._btnItemLastSelectIndex = nil

		return
	end

	for slot4, slot5 in ipairs(slot0._btnItemList) do
		slot5:setSelected(false)
	end
end

function slot0._btncheckOnClick(slot0)
	RougeController.instance:openRougeCollectionInitialView({
		collectionCfgIds = slot0._collectionCfgIds
	})
end

slot1 = 303

function slot0._resetDetailPos(slot0)
	if not slot0._btnItemList[#slot0._btnItemList] then
		return
	end

	if not slot1:transform() then
		return
	end

	slot3 = recthelper.rectToRelativeAnchorPos(slot2.position, slot0._detailTrans.parent)
	slot0._detailTrans.localPosition = Vector3.New(slot3.x + uv0, slot3.y - 57, 0)
end

function slot0._onUpdateUnlockSkill(slot0, slot1, slot2)
	if not tabletool.indexOf(slot0._skillIds, slot2) then
		return
	end

	if slot0._btnItemList[slot3] then
		slot4:onUnlocked()
	end
end

return slot0
