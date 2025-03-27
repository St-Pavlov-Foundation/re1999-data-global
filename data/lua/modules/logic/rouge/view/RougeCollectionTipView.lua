module("modules.logic.rouge.view.RougeCollectionTipView", package.seeall)

slot0 = class("RougeCollectionTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_root/anim/#simage_icon")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "#go_root/anim/#txt_collectionname")
	slot0._scrollcollectiondesc = gohelper.findChildScrollRect(slot0.viewGO, "#go_root/anim/#scroll_collectiondesc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "#go_root/anim/#scroll_collectiondesc/Viewport/#go_descContent/#go_descitem")
	slot0._gotags = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_tags")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_tags/#go_tagitem")
	slot0._goextratags = gohelper.findChild(slot0.viewGO, "#go_root/anim/tags/#go_extratags")
	slot0._goextratagitem = gohelper.findChild(slot0.viewGO, "#go_root/anim/tags/#go_extratags/#go_extratagitem")
	slot0._goholetool = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_holetool")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_holetool/#go_holeitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goshapecontainer = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_shapecontainer")
	slot0._goshapecell = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_shapecontainer/#go_shapecell")
	slot0._btnunequip = gohelper.findChildButton(slot0.viewGO, "#go_root/anim/#btn_unequip")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_tips")
	slot0._gotagdescitem = gohelper.findChild(slot0.viewGO, "#go_root/anim/#go_tips/#txt_tagitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnunequip:AddClickListener(slot0._btnunequipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnunequip:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnunequipOnClick(slot0)
	RougeCollectionChessController.instance:removeCollectionFromSlotArea(slot0.viewParam and slot0.viewParam.collectionId)
	slot0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UnEquipCollection)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateCollectionEnchantInfo, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SetCollectionTipViewInteractable, slot0.setViewInteractable, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, slot0.updateCollectionAttr, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCallBack, slot0)

	slot0._cellModelTab = slot0:getUserDataTb_()
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._hooltoolCanvasGroup = gohelper.onceAddComponent(slot0._goholetool, gohelper.Type_CanvasGroup)
	slot0._rootCanvasGroup = gohelper.onceAddComponent(slot0._goroot, gohelper.Type_CanvasGroup)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_choices_open_1)
	slot0:refreshCollectionInfos()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshCollectionInfos()
end

function slot0.refreshCollectionInfos(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.collectionId
	slot2 = slot0.viewParam and slot0.viewParam.collectionCfgId
	slot3 = slot0:getViewPos()
	slot0._interactable = true
	slot0._useCloseBtn = true

	if slot0.viewParam and slot0.viewParam.interactable ~= nil then
		slot0._interactable = slot0.viewParam.interactable
	end

	if slot0.viewParam and slot0.viewParam.useCloseBtn ~= nil then
		slot0._useCloseBtn = slot0.viewParam.useCloseBtn
	end

	slot0:updateViewPosition(slot3)
	slot0:refreshCollectionTips(slot1, slot2)
	slot0:setInterable(slot0._interactable)
	slot0:setCloseBtnInteractable(slot0._useCloseBtn)
end

function slot0.getViewPos(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.viewPosition

	if (slot0.viewParam and slot0.viewParam.source) ~= RougeEnum.OpenCollectionTipSource.ChoiceView then
		return slot1
	end

	return recthelper.screenPosToAnchorPos(slot1, slot0.viewGO.transform)
end

function slot0.setCloseBtnInteractable(slot0, slot1)
	gohelper.setActive(slot0._btnclose.gameObject, slot1)
end

function slot0.setInterable(slot0, slot1)
	slot0._hooltoolCanvasGroup.interactable = slot1
	slot0._hooltoolCanvasGroup.blocksRaycasts = slot1
end

function slot0.updateViewPosition(slot0, slot1)
	recthelper.setAnchor(slot0._goroot.transform, slot1 and slot1.x or 0, slot1 and slot1.y or 0)
end

function slot0.refreshCollectionTips(slot0, slot1, slot2)
	if RougeCollectionModel.instance:getCollectionByUid(slot1) then
		slot2 = slot3.cfgId
	end

	slot4 = RougeCollectionConfig.instance:getCollectionCfg(slot2)

	slot0:refreshCollectionBaseInfo(slot3, slot4)
	slot0:refreshCollectionHoles(slot4, slot3)
	RougeCollectionHelper.loadShapeGrid(slot2, slot0._goshapecontainer, slot0._goshapecell, slot0._cellModelTab, false)

	slot5 = slot3 and slot3:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(slot2, slot5, slot0._gotags, slot0._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot2, slot5, slot0._gotips, slot0._gotagdescitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)
	gohelper.setActive(slot0._btnunequip.gameObject, RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot1) and slot0._interactable)
end

slot1 = 247
slot2 = 420

function slot0.refreshCollectionBaseInfo(slot0, slot1, slot2)
	slot4 = slot2 and slot2.id
	slot0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(slot4, slot1 and slot1:getAllEnchantCfgId())

	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot4))

	slot0._itemInstTab = slot0._itemInstTab or slot0:getUserDataTb_()

	if slot1 then
		RougeCollectionDescHelper.setCollectionDescInfos(slot1.id, slot0._godescContent, slot0._itemInstTab)
	else
		RougeCollectionDescHelper.setCollectionDescInfos2(slot4, slot3, slot0._godescContent, slot0._itemInstTab, nil, {
			isAllActive = true
		})
	end

	recthelper.setHeight(slot0._scrollcollectiondesc.transform, (slot2 and slot2.holeNum or 0) > 0 and uv0 or uv1)
end

slot3 = 3

function slot0.refreshCollectionHoles(slot0, slot1, slot2)
	gohelper.setActive(slot0._goholetool, (slot1.holeNum or 0) > 0)

	for slot7 = 1, uv0 do
		slot8 = slot0:getOrCreateHole(slot7)

		gohelper.setActive(slot8.viewGO, true)
		gohelper.setActive(slot8.golock, slot3 < slot7)
		gohelper.setActive(slot8.godisenchant, not slot0._interactable or not slot2)

		slot9 = false

		if slot2 then
			slot10, slot11 = slot2:getEnchantIdAndCfgId(slot7)

			if slot10 and slot10 > 0 then
				slot8.simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot11))
			end
		end

		gohelper.setActive(slot8.goadd, slot7 <= slot3 and not slot9 and slot0._interactable)
		gohelper.setActive(slot8.goenchant, slot7 <= slot3 and slot9)
		gohelper.setActive(slot8.btnremoveenchant.gameObject, slot7 <= slot3 and slot9 and slot0._interactable)
		gohelper.setActive(slot8.btnclick.gameObject, slot7 <= slot3)
	end
end

function slot0.getOrCreateHole(slot0, slot1)
	slot0._holeTab = slot0._holeTab or slot0:getUserDataTb_()

	if not slot0._holeTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goholeitem, "hole_" .. slot1)
		slot2.godisenchant = gohelper.findChild(slot2.viewGO, "go_disenchant")
		slot2.goadd = gohelper.findChild(slot2.viewGO, "go_add")
		slot2.golock = gohelper.findChild(slot2.viewGO, "go_lock")
		slot2.goenchant = gohelper.findChild(slot2.viewGO, "go_enchant")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot1)

		slot2.simageicon = gohelper.findChildSingleImage(slot2.viewGO, "go_enchant/simage_icon")
		slot2.btnremoveenchant = gohelper.findChildButtonWithAudio(slot2.viewGO, "go_enchant/btn_remove")

		slot2.btnremoveenchant:AddClickListener(slot0._btnRemoveEnchantOnClick, slot0, slot1)

		slot0._holeTab[slot1] = slot2
	end

	return slot2
end

function slot0._btnclickOnClick(slot0, slot1)
	if not slot0._interactable then
		return
	end

	if slot0.viewParam and slot0.viewParam.collectionId and slot2 > 0 then
		slot0._selectCollectionId = slot2
		slot0._selectHoleIndex = slot1
		slot0._waitCount = 1

		slot0._animatorPlayer:Play("switch", slot0.playSwitchAnimDoneCallBack, slot0)
	end
end

function slot0._btnRemoveEnchantOnClick(slot0, slot1)
	if not slot0._interactable then
		return
	end

	if slot0.viewParam and slot0.viewParam.collectionId and slot2 > 0 then
		RougeCollectionEnchantController.instance:removeEnchant(slot2, slot1)
	end
end

function slot0.playSwitchAnimDoneCallBack(slot0)
	slot0._waitCount = (slot0._waitCount or 0) - 1

	slot0:checkIsCouldOpenEnchantView()
end

function slot0.checkIsCouldOpenEnchantView(slot0)
	if slot0._waitCount <= 0 then
		RougeController.instance:openRougeCollectionEnchantView({
			collectionId = slot0._selectCollectionId,
			collectionIds = slot0:getCollectionIds(),
			selectHoleIndex = slot0._selectHoleIndex
		})
	end
end

function slot0.getCollectionIds(slot0)
	slot2 = {}
	slot3 = slot0.sortCollectionFunction1

	if (slot0.viewParam and slot0.viewParam.source) == RougeEnum.OpenCollectionTipSource.SlotArea then
		slot2 = RougeCollectionModel.instance:getSlotAreaCollection()
		slot3 = slot0.sortCollectionFunction1
	elseif slot1 == RougeEnum.OpenCollectionTipSource.BagArea then
		slot2 = RougeCollectionModel.instance:getBagAreaCollection()
		slot3 = slot0.sortCollectionFunction2
	end

	slot4 = {}

	if slot2 then
		for slot8, slot9 in ipairs(slot2) do
			if (RougeCollectionConfig.instance:getCollectionCfg(slot9.cfgId) and slot10.holeNum or 0) > 0 then
				table.insert(slot4, slot9.id)
			end
		end
	end

	table.sort(slot4, slot3)

	return slot4
end

function slot0.sortCollectionFunction1(slot0, slot1)
	slot3 = RougeCollectionModel.instance:getCollectionByUid(slot1)
	slot7 = RougeCollectionConfig.instance:getCollectionCfg(slot3 and slot3.cfgId)

	if (RougeCollectionConfig.instance:getCollectionCfg(RougeCollectionModel.instance:getCollectionByUid(slot0) and slot2.cfgId) and slot6.showRare or 0) ~= (slot7 and slot7.showRare or 0) then
		return slot9 < slot8
	end

	if RougeCollectionConfig.instance:getCollectionCellCount(slot2.cfgId, RougeEnum.CollectionEditorParamType.Shape) ~= RougeCollectionConfig.instance:getCollectionCellCount(slot3.cfgId, RougeEnum.CollectionEditorParamType.Shape) then
		return slot11 < slot10
	end

	return slot0 < slot1
end

function slot0.sortCollectionFunction2(slot0, slot1)
	slot3 = RougeCollectionModel.instance:getCollectionByUid(slot1)

	if RougeCollectionConfig.instance:getCollectionCfg(RougeCollectionModel.instance:getCollectionByUid(slot0) and slot2.cfgId).type ~= RougeCollectionConfig.instance:getCollectionCfg(slot3 and slot3.cfgId).type and (slot6.type == RougeEnum.CollectionType.Enchant or slot7.type == RougeEnum.CollectionType.Enchant) then
		return slot6.type == RougeEnum.CollectionType.Enchant
	end

	if (slot6 and slot6.showRare or 0) ~= (slot7 and slot7.showRare or 0) then
		return slot9 < slot8
	end

	if RougeCollectionConfig.instance:getCollectionCellCount(slot2.cfgId, RougeEnum.CollectionEditorParamType.Shape) ~= RougeCollectionConfig.instance:getCollectionCellCount(slot3.cfgId, RougeEnum.CollectionEditorParamType.Shape) then
		return slot11 < slot10
	end

	return slot0 < slot1
end

function slot0.updateCollectionEnchantInfo(slot0, slot1)
	if not slot0.viewParam or not slot0.viewParam.collectionId or slot2 ~= slot1 then
		return
	end

	slot0:refreshCollectionTips(slot1)
end

function slot0.updateCollectionAttr(slot0, slot1)
	if (slot0.viewParam and slot0.viewParam.collectionId) == slot1 then
		slot0:refreshCollectionTips(slot2)
	end
end

function slot0.removeAllHoleClicks(slot0)
	if slot0._holeTab then
		for slot4, slot5 in pairs(slot0._holeTab) do
			slot5.btnclick:RemoveClickListener()
			slot5.btnremoveenchant:RemoveClickListener()
			slot5.simageicon:UnLoadImage()
		end
	end
end

function slot0.onCloseViewCallBack(slot0, slot1)
	if slot1 == ViewName.RougeCollectionEnchantView then
		slot0._animatorPlayer:Play("back", slot0._onPlayBackAnimCallBack, slot0)
	end
end

function slot0._onPlayBackAnimCallBack(slot0)
end

function slot0.setViewInteractable(slot0, slot1)
	slot0._rootCanvasGroup.interactable = slot1
	slot0._rootCanvasGroup.blocksRaycasts = slot1
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshCollectionInfos()
end

function slot0.onClose(slot0)
	slot0:removeAllHoleClicks()
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()

	if slot0._itemAttrCallBackId then
		RougeRpc.instance:removeCallbackById(slot0._itemAttrCallBackId)

		slot0._itemAttrCallBackId = nil
	end
end

return slot0
