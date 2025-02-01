module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipBookView", package.seeall)

slot0 = class("Season123_2_0EquipBookView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "left/#go_target")
	slot0._goctrl = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_ctrl")
	slot0._gotargetcardpos = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "left/#go_target/#go_touch")
	slot0._txtcardname = gohelper.findChildText(slot0.viewGO, "left/#go_target/#txt_cardname")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "left/#go_target/#scroll_desc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	slot0._btncompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_compose")
	slot0._gonormalcomposebg = gohelper.findChild(slot0.viewGO, "left/#btn_compose/#go_normalComposebg")
	slot0._golockcomposebg = gohelper.findChildImage(slot0.viewGO, "left/#btn_compose/#go_lockComposeBg")
	slot0._imagecomposeCoin = gohelper.findChildImage(slot0.viewGO, "left/#btn_compose/#image_composeCoin")
	slot0._txtcomposeNum = gohelper.findChildText(slot0.viewGO, "left/#btn_compose/#txt_composeNum")
	slot0._btndecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_decompose")
	slot0._gonormaldecomposebg = gohelper.findChild(slot0.viewGO, "left/#btn_decompose/#go_normalDecomposebg")
	slot0._golockdecomposebg = gohelper.findChildImage(slot0.viewGO, "left/#btn_decompose/#go_lockDecomposeBg")
	slot0._imagedecomposeCoin = gohelper.findChildImage(slot0.viewGO, "left/#btn_decompose/#image_decomposeCoin")
	slot0._txtdecomposeNum = gohelper.findChildText(slot0.viewGO, "left/#btn_decompose/#txt_decomposeNum")
	slot0._scrollcardlist = gohelper.findChildScrollRect(slot0.viewGO, "right/mask/#scroll_cardlist")
	slot0._btnbatchDecompose = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_batchDecompose")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "right/#go_righttop")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._godecomposeEffect = gohelper.findChild(slot0.viewGO, "left/#go_target/#fengjie")
	slot0._gocomposeEffect = gohelper.findChild(slot0.viewGO, "left/#go_target/#hecheng")
	slot0._btnskipEffect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skipEffect")
	slot0._gotipPos = gohelper.findChild(slot0.viewGO, "#go_tippos")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncompose:AddClickListener(slot0._btncomposeOnClick, slot0)
	slot0._btndecompose:AddClickListener(slot0._btndecomposeOnClick, slot0)
	slot0._btnbatchDecompose:AddClickListener(slot0._btnbatchDecomposeOnClick, slot0)
	slot0._btnskipEffect:AddClickListener(slot0._btnskipEffectOnClick, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, slot0.onChangeSelectCard, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, slot0.refreshEquipBook, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, slot0.doDecompose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncompose:RemoveClickListener()
	slot0._btndecompose:RemoveClickListener()
	slot0._btnbatchDecompose:RemoveClickListener()
	slot0._btnskipEffect:RemoveClickListener()
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, slot0.onChangeSelectCard, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, slot0.refreshEquipBook, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, slot0.refreshUI, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshUI, slot0)
	slot0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, slot0.doDecompose, slot0)
end

slot0.defaultDescColor = "#cac8c5"

function slot0._btncomposeOnClick(slot0)
	if slot0:isMainCardOverCount() then
		GameFacade.showToast(ToastEnum.SeasonMainCardOverCount)
	elseif slot0:canCompose() then
		slot0.isCompose = true

		gohelper.setActive(slot0._btnskipEffect.gameObject, true)
		slot0:showComposeEffect()
		TaskDispatcher.runDelay(slot0.sendComposeRequest, slot0, 2)
	else
		GameFacade.showToast(ToastEnum.DiamondBuy, CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(slot0.actId, Activity123Enum.Const.EquipItemCoin)).name)
	end
end

function slot0.sendComposeRequest(slot0)
	Activity123Rpc.instance:sendComposeAct123EquipRequest(slot0.actId, slot0.itemId)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(slot0.actId)

	slot0.isCompose = false

	gohelper.setActive(slot0._btnskipEffect.gameObject, false)
end

function slot0._btndecomposeOnClick(slot0)
	if (slot0.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(slot0.itemId) or 0) == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.Season123_2_0DecomposeView, {
		actId = slot0.actId,
		itemId = slot0.itemId
	})
end

function slot0._btnbatchDecomposeOnClick(slot0)
	if slot0:getItemCount() == 0 then
		return
	end

	Season123EquipBookController.instance:openBatchDecomposeView(slot0.actId)
end

function slot0._btnskipEffectOnClick(slot0)
	if slot0.isCompose then
		TaskDispatcher.cancelTask(slot0.sendComposeRequest, slot0)
		slot0:sendComposeRequest()
	end

	if slot0.isDecompose then
		TaskDispatcher.cancelTask(slot0.sendDecomposeEquipRequest, slot0)
		slot0:sendDecomposeEquipRequest()
	end

	gohelper.setActive(slot0._btnskipEffect.gameObject, false)
end

function slot0._editableInitView(slot0)
	slot0._animatorCard = slot0._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	slot0._animCardEventWrap = slot0._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0._animCardEventWrap:AddEventListener("switch", slot0.onSwitchCardAnim, slot0)

	slot0.colorStr = uv0.defaultDescColor

	slot0:hideEffect()
	gohelper.setActive(slot0._btnskipEffect.gameObject, false)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)

	slot0.actId = Season123Model.instance:getCurSeasonId()
	slot0.coinId = Season123Config.instance:getEquipItemCoin(slot0.actId, Activity123Enum.Const.EquipItemCoin)

	slot0:refreshUI()
end

function slot0.onSwitchCardAnim(slot0)
	slot0:refreshUI()
end

function slot0.refreshEquipBook(slot0)
	slot0._scrollcardlist.verticalNormalizedPosition = 1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.itemId = Season123EquipBookModel.instance.curSelectItemId

	slot0:refreshCardDesc()
	slot0:refreshIcon()
	slot0:refreshBtn()
end

function slot0.refreshCardDesc(slot0)
	if not slot0.itemId then
		slot0._txtcardname.text = ""

		gohelper.setActive(slot0._scrolldesc.gameObject, false)
	else
		slot0._txtcardname.text = Season123Config.instance:getSeasonEquipCo(slot0.itemId) ~= nil and string.format("[%s]", slot1.name) or ""

		gohelper.setActive(slot0._scrolldesc.gameObject, slot1 ~= nil)
		slot0:refreshCardItem(slot1)
	end
end

function slot0.refreshCardItem(slot0, slot1)
	slot0._cardDescInfos = slot0:getUserDataTb_()

	if slot1 then
		slot2 = Season123EquipMetaUtils.getSkillEffectStrList(slot1)
		slot0.colorStr = Season123EquipMetaUtils.getCareerColorDarkBg(slot1.equipId)

		if slot1.attrId ~= 0 and GameUtil.getTabLen(Season123EquipMetaUtils.getEquipPropsStrList(slot1.attrId)) > 0 then
			tabletool.addValues(slot0._cardDescInfos, slot3)
		end

		tabletool.addValues(slot0._cardDescInfos, slot2)
		gohelper.CreateObjList(slot0, slot0.cardDescItemShow, slot0._cardDescInfos, slot0._godescContent, slot0._godescitem)
	end
end

function slot0.cardDescItemShow(slot0, slot1, slot2, slot3)
	slot1.name = "desc" .. slot3
	slot4 = gohelper.findChildText(slot1, "txt_desc")
	slot4.text = SkillHelper.addLink(HeroSkillModel.instance:skillDesToSpot(slot2))

	MonoHelper.addNoUpdateLuaComOnceToGo(slot4.gameObject, FixTmpBreakLine):refreshTmpContent(slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot4, slot0.colorStr)
	SkillHelper.addHyperLinkClick(slot4, slot0.setSkillClickCallBack, slot0)
end

function slot0.setSkillClickCallBack(slot0, slot1, slot2)
	slot3, slot4 = recthelper.getAnchor(slot0._gotipPos.transform)

	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, Vector2.New(slot3, slot4), CommonBuffTipEnum.Pivot.Left)
end

function slot0.refreshIcon(slot0)
	if not slot0._icon then
		slot0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocarditem, Season123_2_0CelebrityCardEquip)
	end

	if slot0.itemId then
		slot0._icon:updateData(slot0.itemId)
		slot0._icon:setIndexLimitShowState(true)
	end
end

function slot0.refreshBtn(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnbatchDecompose.gameObject, slot0:getItemCount() == 0)

	slot2 = nil

	if slot0.itemId then
		slot2 = Season123Config.instance:getSeasonEquipCo(slot0.itemId)
		slot3 = CurrencyConfig.instance:getCurrencyCo(slot0.coinId)
		slot0._txtdecomposeNum.text = string.format("+%s", slot2.decomposeGet)
		slot0._txtcomposeNum.text = string.format("-%s", slot2.composeCost)

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecomposeCoin, slot3.icon .. "_1")
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagedecomposeCoin, slot3.icon .. "_1")
	end

	gohelper.setActive(slot0._txtdecomposeNum.gameObject, slot0.itemId)
	gohelper.setActive(slot0._txtcomposeNum.gameObject, slot0.itemId)
	gohelper.setActive(slot0._imagecomposeCoin.gameObject, slot0.itemId)
	gohelper.setActive(slot0._imagedecomposeCoin.gameObject, slot0.itemId)

	slot3 = slot0.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(slot0.itemId) or 0

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcomposeNum, slot0:canCompose() and "#070706" or "#800015")
	gohelper.setActive(slot0._gonormaldecomposebg, slot3 > 0)
	gohelper.setActive(slot0._golockdecomposebg, slot3 == 0)
	gohelper.setActive(slot0._gonormalcomposebg, not slot0:isMainCardOverCount())
	gohelper.setActive(slot0._golockcomposebg, slot0:isMainCardOverCount())
end

function slot0.isMainCardOverCount(slot0)
	if slot0.itemId then
		if Season123Config.instance:getSeasonEquipCo(slot0.itemId).isMain == 1 and Season123EquipBookModel.instance:getEquipBookItemCount(slot0.itemId) >= 1 then
			return true
		end
	end

	return false
end

function slot0.canCompose(slot0)
	if not slot0.itemId then
		return false
	end

	slot1 = Season123Config.instance:getSeasonEquipCo(slot0.itemId)

	return slot1 and slot1.composeCost <= (CurrencyModel.instance:getCurrency(slot0.coinId) and slot2.quantity or 0)
end

function slot0.getItemCount(slot0)
	return GameUtil.getTabLen(Season123Model.instance:getAllItemMo(slot0.actId))
end

function slot0.onChangeSelectCard(slot0)
	slot0._animatorCard:Play("switch", 0, 0)
	slot0:hideEffect()
end

function slot0.doDecompose(slot0, slot1)
	slot0.decomposeList = slot1

	gohelper.setActive(slot0._btnskipEffect.gameObject, true)
	slot0:showDecomposeEffect()

	slot0.isDecompose = true

	TaskDispatcher.runDelay(slot0.sendDecomposeEquipRequest, slot0, 1.5)
end

function slot0.sendDecomposeEquipRequest(slot0)
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(slot0.actId, slot0.decomposeList)

	slot0.isDecompose = false

	gohelper.setActive(slot0._btnskipEffect.gameObject, false)
end

function slot0.showDecomposeEffect(slot0)
	gohelper.setActive(slot0._godecomposeEffect, false)
	gohelper.setActive(slot0._godecomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_qiutu_list_maintain)
end

function slot0.showComposeEffect(slot0)
	gohelper.setActive(slot0._gocomposeEffect, false)
	gohelper.setActive(slot0._gocomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_celebrity_synthesis)
end

function slot0.hideEffect(slot0)
	gohelper.setActive(slot0._godecomposeEffect, false)
	gohelper.setActive(slot0._gocomposeEffect, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.sendComposeRequest, slot0)
	TaskDispatcher.cancelTask(slot0.sendDecomposeEquipRequest, slot0)

	Season123EquipBookModel.instance._itemStartAnimTime = nil
end

function slot0.onDestroyView(slot0)
	if slot0._animCardEventWrap then
		slot0._animCardEventWrap:RemoveAllEventListener()

		slot0._animCardEventWrap = nil
	end

	if slot0._icon ~= nil then
		slot0._icon:disposeUI()

		slot0._icon = nil
	end

	Season123EquipBookController.instance:onCloseView()
end

return slot0
