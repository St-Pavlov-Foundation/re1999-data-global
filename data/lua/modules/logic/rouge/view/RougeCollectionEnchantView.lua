module("modules.logic.rouge.view.RougeCollectionEnchantView", package.seeall)

slot0 = class("RougeCollectionEnchantView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotips = gohelper.findChild(slot0.viewGO, "left/#go_tips")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "left/#go_tips/#simage_icon")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "left/#go_tips/#txt_collectionname")
	slot0._gocollectiondesccontent = gohelper.findChild(slot0.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent")
	slot0._gocollectiondescitem = gohelper.findChild(slot0.viewGO, "left/#go_tips/#scroll_collectiondesc/Viewport/#go_collectiondesccontent/#go_collectiondescitem")
	slot0._gotags = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_tags")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_tags/#go_tagitem")
	slot0._goholetool = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_holetool")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_holetool/#go_holeitem")
	slot0._btnlast = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_tips/#btn_last")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_tips/#btn_next")
	slot0._goshapecontainer = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_shapecontainer")
	slot0._goshapecell = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_shapecontainer/#go_shapecell")
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "middle/#go_unselected")
	slot0._goenchantempty = gohelper.findChild(slot0.viewGO, "right/#go_enchantempty")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "middle/#scroll_desc")
	slot0._simageenchanticon = gohelper.findChildSingleImage(slot0.viewGO, "middle/#simage_enchanticon")
	slot0._goenchantcontent = gohelper.findChild(slot0.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent")
	slot0._txtenchantdesc = gohelper.findChildText(slot0.viewGO, "middle/#scroll_desc/Viewport/#go_enchantcontent/#txt_enchantdesc")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "middle/#txt_name")
	slot0._gotagcontents = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_tagcontents")
	slot0._gotagnameitem = gohelper.findChild(slot0.viewGO, "left/#go_tips/#go_tagcontents/#go_tagnameitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlast:AddClickListener(slot0._btnlastOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlast:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
end

slot1 = 0.3
slot2 = 1

function slot0._btnlastOnClick(slot0)
	RougeCollectionEnchantController.instance:switchCollection(false)
	slot0:updateSwitchBtnState()
	slot0:delay2RefreshInfo(uv0.DelayRefreshInfoTime)
	slot0._tipAnimator:Play("switch", 0, 0)
end

function slot0._btnnextOnClick(slot0)
	RougeCollectionEnchantController.instance:switchCollection(true)
	slot0:updateSwitchBtnState()
	slot0:delay2RefreshInfo(uv0.DelayRefreshInfoTime)
	slot0._tipAnimator:Play("switch", 0, 0)
end

function slot0.updateSwitchBtnState(slot0)
	slot3 = gohelper.onceAddComponent(slot0._btnlast, typeof(UnityEngine.CanvasGroup))
	slot4 = RougeCollectionUnEnchantListModel.instance:getCurSelectIndex() <= 1
	slot3.alpha = slot4 and uv0 or uv1
	slot3.interactable = not slot4
	slot3.blocksRaycasts = not slot4
	slot5 = gohelper.onceAddComponent(slot0._btnnext, typeof(UnityEngine.CanvasGroup))
	slot6 = RougeCollectionUnEnchantListModel.instance:getCount() <= slot1
	slot5.alpha = slot6 and uv0 or uv1
	slot5.interactable = not slot6
	slot5.blocksRaycasts = not slot6
end

function slot0._btndetailsOnClick(slot0)
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, slot0.updateCollectionEnchantInfo, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)

	slot0._cellModelTab = slot0:getUserDataTb_()
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._tipAnimator = gohelper.onceAddComponent(slot0._gotips, gohelper.Type_Animator)
	slot0._itemInstTab = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	RougeCollectionEnchantController.instance:onOpenView(slot0.viewParam and slot0.viewParam.collectionId, slot0.viewParam and slot0.viewParam.collectionIds, slot0.viewParam and slot0.viewParam.selectHoleIndex)
	slot0:refreshCollectionTips()
	slot0:updateSwitchBtnState()
end

function slot0.refreshCollectionTips(slot0)
	slot0:refresh(RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId())
end

function slot0.refresh(slot0, slot1)
	if not RougeCollectionModel.instance:getCollectionByUid(slot1 or RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId()) then
		logError("cannot find collection, id = " .. tostring(slot1))

		return
	end

	slot3 = slot2.cfgId

	slot0:refreshCollectionBaseInfo(slot2)

	slot5 = slot2:getAllEnchantCfgId()

	RougeCollectionHelper.loadCollectionAndEnchantTags(slot3, slot5, slot0._gotags, slot0._gotagitem)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot3, slot5, slot0._gotagcontents, slot0._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack, RougeCollectionHelper)
	RougeCollectionHelper.loadShapeGrid(slot2.cfgId, slot0._goshapecontainer, slot0._goshapecell, slot0._cellModelTab, false)
	slot0:refreshCollectionHoles(RougeCollectionConfig.instance:getCollectionCfg(slot3), slot2)
	slot0:checkIsSelectEnchant()
end

function slot0.refreshCollectionBaseInfo(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(slot1.cfgId, slot1:getAllEnchantCfgId())

	RougeCollectionDescHelper.setCollectionDescInfos(slot1.id, slot0._gocollectiondesccontent, slot0._itemInstTab)
	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot1.cfgId))
end

slot3 = 3

function slot0.refreshCollectionHoles(slot0, slot1, slot2)
	gohelper.setActive(slot0._goholetool, (slot1.holeNum or 0) > 0)

	for slot8 = 1, uv0 do
		slot9 = slot0:getOrCreateHole(slot8)
		slot10, slot11 = slot2:getEnchantIdAndCfgId(slot8)
		slot12 = slot10 and slot10 > 0

		gohelper.setActive(slot9.viewGO, true)
		gohelper.setActive(slot9.golock, slot3 < slot8)
		gohelper.setActive(slot9.goenchant, slot8 <= slot3 and slot12)
		gohelper.setActive(slot9.goselect, slot8 == RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex())
		gohelper.setActive(slot9.btnclick.gameObject, slot8 <= slot3)
		gohelper.setActive(slot9.goadd, slot8 <= slot3 and not slot12)

		if slot12 then
			slot9.icon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot11))
		end
	end
end

function slot0.getOrCreateHole(slot0, slot1)
	slot0._holeTab = slot0._holeTab or slot0:getUserDataTb_()

	if not slot0._holeTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goholeitem, "hole_" .. slot1)
		slot2.golock = gohelper.findChild(slot2.viewGO, "go_lock")
		slot2.goenchant = gohelper.findChild(slot2.viewGO, "go_enchant")
		slot2.btnremove = gohelper.findChildButtonWithAudio(slot2.viewGO, "go_enchant/btn_remove")

		slot2.btnremove:AddClickListener(slot0._btnremoveEnchantOnClick, slot0, slot1)

		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.goadd = gohelper.findChild(slot2.viewGO, "go_add")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnclickHoleOnClick, slot0, slot1)

		slot2.icon = gohelper.findChildSingleImage(slot2.viewGO, "go_enchant/simage_icon")
		slot0._holeTab[slot1] = slot2
	end

	return slot2
end

function slot0._btnremoveEnchantOnClick(slot0, slot1)
	RougeCollectionEnchantController.instance:removeEnchant(RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId(), slot1)
end

function slot0._btnclickHoleOnClick(slot0, slot1)
	if slot0._holeTab and slot0._holeTab[slot1] then
		for slot6, slot7 in pairs(slot0._holeTab) do
			gohelper.setActive(slot7.goselect, slot6 == slot1)
		end

		RougeCollectionEnchantController.instance:onSelectHoleGrid(slot1)
	end
end

function slot0.updateCollectionEnchantInfo(slot0, slot1)
	RougeCollectionEnchantListModel.instance:onInitData(false)
	RougeCollectionEnchantListModel.instance:onModelUpdate()

	if slot1 ~= RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId() then
		return
	end

	if slot0._isInitDone then
		slot0._animator:Play("switch", 0, 0)
		slot0:delay2RefreshInfo(uv0.DelayRefreshInfoTime)
	else
		slot0:refresh()

		slot0._isInitDone = true
	end
end

slot0.DelayRefreshInfoTime = 0.16

function slot0.delay2RefreshInfo(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
	TaskDispatcher.runDelay(slot0.refresh, slot0, slot1 or 0)
end

function slot0.checkIsSelectEnchant(slot0)
	slot4 = RougeCollectionEnchantListModel.instance:getById(RougeCollectionEnchantListModel.instance:getCurSelectEnchantId()) ~= nil

	gohelper.setActive(slot0._gounselected, not slot4)
	gohelper.setActive(slot0._scrolldesc.gameObject, slot4)
	gohelper.setActive(slot0._simageenchanticon.gameObject, slot4)
	gohelper.setActive(slot0._txtname.gameObject, slot4)
	gohelper.setActive(slot0._goenchantempty, RougeCollectionEnchantListModel.instance:getCount() <= 0)

	if slot4 and RougeCollectionConfig.instance:getCollectionCfg(slot3 and slot3.cfgId) then
		slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot5)

		slot0._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot5))
		RougeCollectionDescHelper.setCollectionDescInfos3(slot5, nil, slot0._txtenchantdesc, RougeCollectionDescHelper.getShowDescTypesWithoutText())
	end
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshCollectionTips()
end

function slot0.removeAllHoleClicks(slot0)
	if slot0._holeTab then
		for slot4, slot5 in pairs(slot0._holeTab) do
			slot5.btnremove:RemoveClickListener()
			slot5.btnclick:RemoveClickListener()
			slot5.icon:UnLoadImage()
		end
	end
end

function slot0.onClose(slot0)
	slot0:removeAllHoleClicks()
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simageenchanticon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.refresh, slot0)
end

return slot0
