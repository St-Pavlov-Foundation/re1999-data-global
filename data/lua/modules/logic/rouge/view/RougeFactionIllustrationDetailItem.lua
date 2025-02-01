module("modules.logic.rouge.view.RougeFactionIllustrationDetailItem", package.seeall)

slot0 = class("RougeFactionIllustrationDetailItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtcoin = gohelper.findChildText(slot0.viewGO, "Select/detail/coin/#txt_coin")
	slot0._txtbag = gohelper.findChildText(slot0.viewGO, "Select/detail/bag/#txt_bag")
	slot0._txtgroup = gohelper.findChildText(slot0.viewGO, "Select/detail/group/#txt_group")
	slot0._gobag = gohelper.findChild(slot0.viewGO, "Select/detail/baglayout/#go_bag")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "Select/detail/baglayout/#btn_check")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "Select/detail/beidong/#Scroll_Desc/Viewport/Content/#go_descitem")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_skills/#go_skillitem")
	slot0._godetail2 = gohelper.findChild(slot0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2")
	slot0._imageskillicon = gohelper.findChildImage(slot0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#image_skillicon")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#txt_dec2")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "Select/#go_Bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "Select/#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "Select/#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "Select/#txt_name/#txt_en")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "Select/#scroll_desc")
	slot0._txtscrollDesc = gohelper.findChildText(slot0.viewGO, "Select/#scroll_desc/viewport/content/#txt_scrollDesc")

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

function slot0._refreshAllBtnStatus(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._skillItemList) do
		slot0:_setBtnStatus(slot1 == slot5, slot6.gonormal, slot6.goselect)
	end
end

function slot0._setBtnStatus(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot2, not slot1)
	gohelper.setActive(slot3, slot1)
end

function slot0._btncheckOnClick(slot0)
	RougeController.instance:openRougeCollectionInitialView({
		collectionCfgIds = slot0._collectionCfgIds
	})
end

function slot0._editableInitView(slot0)
	slot0._skillItemList = slot0:getUserDataTb_()

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
	gohelper.setActive(slot0._godetail2, false)

	slot0._descItemList = {
		slot0:_create_RougeFactionItemSelected_DescItem(1),
		slot0:_create_RougeFactionItemSelected_DescItem(2)
	}
end

function slot0._onTouchScreenUp(slot0)
	if slot0._showTips then
		slot0._showTips = false

		return
	end

	gohelper.setActive(slot0._godetail2, false)
	slot0:_refreshAllBtnStatus()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtname.text = slot1.name
	slot0._txtcoin.text = slot1.coin
	slot0._txtbag.text = tostring(slot1.power) .. "/" .. tostring(slot1.powerLimit)
	slot0._txtgroup.text = slot1.capacity
	slot0._txtscrollDesc.text = slot1.desc

	slot0:_initSkill()
	slot0:_initOrRefreshDescItemList(slot1)
	slot0:_initOrRefreshCollectonSlot(slot1)
	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageicon, string.format("%s_light", slot0._mo.icon))

	if RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, slot0._mo.id) ~= nil then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Faction, slot0._mo.id)
	end
end

function slot0._initOrRefreshCollectonSlot(slot0, slot1)
	if not slot0._collectionSlotComp then
		slot0._collectionSlotComp = RougeCollectionSlotComp.Get(slot0._gobag, RougeCollectionHelper.StyleShowCollectionSlotParam)
	end

	slot2 = slot1.layoutId
	slot3 = RougeCollectionConfig.instance:getCollectionInitialBagSize(slot2)

	slot0._collectionSlotComp:onUpdateMO(slot3.col, slot3.row, slot0:_createInitialCollections(slot2))
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

function slot0._initSkill(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0:_getAllSkills()) do
		slot9 = slot0:_getOrCreateSkillItem(slot7)

		if not string.nilorempty(RougeOutsideModel.instance:config():getSkillCo(slot8.type, slot8.skillId) and slot10.icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagenormalicon, slot11, true)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagselecticon, slot11 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", slot8.type, slot8.skillId))
		end

		slot0["_skillDesc" .. slot7] = slot10.desc
		slot0["_skillIcon" .. slot7] = slot10.icon

		gohelper.setActive(slot9.viewGO, true)

		slot3[slot9] = true
	end

	for slot7, slot8 in ipairs(slot0._skillItemList) do
		if not slot3[slot8] then
			gohelper.setActive(slot8.viewGO, false)
		end
	end
end

function slot0._getOrCreateSkillItem(slot0, slot1)
	if not (slot0._skillItemList and slot0._skillItemList[slot1]) then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goskillitem, "item_" .. slot1)
		slot2.gonormal = gohelper.findChild(slot2.viewGO, "go_normal")
		slot2.imagenormalicon = gohelper.findChildImage(slot2.viewGO, "go_normal/image_icon")
		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.imagselecticon = gohelper.findChildImage(slot2.viewGO, "go_select/image_icon")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnskillOnClick, slot0, slot1)
		table.insert(slot0._skillItemList, slot2)
	end

	return slot2
end

function slot0._btnskillOnClick(slot0, slot1)
	slot0._showTips = true
	slot0._txtdec2.text = slot0["_skillDesc" .. slot1]

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageskillicon, slot0["_skillIcon" .. slot1], true)
	gohelper.setActive(slot0._godetail2, false)
	gohelper.setActive(slot0._godetail2, true)
	slot0:_refreshAllBtnStatus(slot1)
end

function slot0._removeAllSkillClickListener(slot0)
	if slot0._skillItemList then
		for slot4, slot5 in pairs(slot0._skillItemList) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end
end

function slot0._getAllSkills(slot0)
	for slot6, slot7 in ipairs(string.splitToNumber(slot0._mo.activeSkills, "#")) do
		table.insert({}, {
			type = RougeEnum.SkillType.Style,
			skillId = slot7
		})
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot0._mo.mapSkills, "#")) do
		table.insert(slot1, {
			type = RougeEnum.SkillType.Map,
			skillId = slot8
		})
	end

	for slot8, slot9 in ipairs(RougeDLCConfig101.instance:getStyleUnlockSkills(slot0._mo.id) or {}) do
		table.insert(slot1, {
			type = slot9.type,
			skillId = slot9.skillId
		})
	end

	return slot1
end

function slot0._createItem(slot0, slot1, slot2)
	slot4 = slot2.New(slot0)

	slot4:init(gohelper.cloneInPlace(slot1, slot2.__cname))

	return slot4
end

function slot0._create_RougeFactionItemSelected_DescItem(slot0, slot1)
	slot2 = slot0:_createItem(slot0._godescitem, RougeFactionItemSelected_DescItem)

	slot2:setIndex(slot1 or #slot0._descItemList)

	return slot2
end

function slot0._initOrRefreshDescItemList(slot0, slot1)
	for slot6, slot7 in ipairs(RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(slot1)) do
		if not slot0._descItemList[slot6] then
			slot0._descItemList[slot6] = slot0:_create_RougeFactionItemSelected_DescItem(slot6)
		end

		slot8:setData(slot7)
	end

	for slot6 = #slot2 + 1, #slot0._descItemList do
		slot0._descItemList[slot6]:setData(nil)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_descItemList")

	if slot0._collectionSlotComp then
		slot0._collectionSlotComp:destroy()

		slot0._collectionSlotComp = nil
	end

	slot0:_removeAllSkillClickListener()
end

return slot0
