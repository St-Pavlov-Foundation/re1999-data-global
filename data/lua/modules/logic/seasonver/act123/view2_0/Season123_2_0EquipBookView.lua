module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipBookView", package.seeall)

local var_0_0 = class("Season123_2_0EquipBookView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "left/#go_target")
	arg_1_0._goctrl = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_ctrl")
	arg_1_0._gotargetcardpos = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos")
	arg_1_0._gocarditem = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_ctrl/#go_targetcardpos/#go_carditem")
	arg_1_0._gotouch = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#go_touch")
	arg_1_0._txtcardname = gohelper.findChildText(arg_1_0.viewGO, "left/#go_target/#txt_cardname")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#go_target/#scroll_desc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	arg_1_0._btncompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_compose")
	arg_1_0._gonormalcomposebg = gohelper.findChild(arg_1_0.viewGO, "left/#btn_compose/#go_normalComposebg")
	arg_1_0._golockcomposebg = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_compose/#go_lockComposeBg")
	arg_1_0._imagecomposeCoin = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_compose/#image_composeCoin")
	arg_1_0._txtcomposeNum = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_compose/#txt_composeNum")
	arg_1_0._btndecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_decompose")
	arg_1_0._gonormaldecomposebg = gohelper.findChild(arg_1_0.viewGO, "left/#btn_decompose/#go_normalDecomposebg")
	arg_1_0._golockdecomposebg = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_decompose/#go_lockDecomposeBg")
	arg_1_0._imagedecomposeCoin = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_decompose/#image_decomposeCoin")
	arg_1_0._txtdecomposeNum = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_decompose/#txt_decomposeNum")
	arg_1_0._scrollcardlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/mask/#scroll_cardlist")
	arg_1_0._btnbatchDecompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_batchDecompose")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "right/#go_righttop")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._godecomposeEffect = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#fengjie")
	arg_1_0._gocomposeEffect = gohelper.findChild(arg_1_0.viewGO, "left/#go_target/#hecheng")
	arg_1_0._btnskipEffect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skipEffect")
	arg_1_0._gotipPos = gohelper.findChild(arg_1_0.viewGO, "#go_tippos")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncompose:AddClickListener(arg_2_0._btncomposeOnClick, arg_2_0)
	arg_2_0._btndecompose:AddClickListener(arg_2_0._btndecomposeOnClick, arg_2_0)
	arg_2_0._btnbatchDecompose:AddClickListener(arg_2_0._btnbatchDecomposeOnClick, arg_2_0)
	arg_2_0._btnskipEffect:AddClickListener(arg_2_0._btnskipEffectOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, arg_2_0.onChangeSelectCard, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, arg_2_0.refreshEquipBook, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, arg_2_0.doDecompose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncompose:RemoveClickListener()
	arg_3_0._btndecompose:RemoveClickListener()
	arg_3_0._btnbatchDecompose:RemoveClickListener()
	arg_3_0._btnskipEffect:RemoveClickListener()
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnEquipBookItemChangeSelect, arg_3_0.onChangeSelectCard, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnRefleshEquipBookView, arg_3_0.refreshEquipBook, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnItemChange, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Season123EquipBookController.instance, Season123Event.OnDecomposeEffectPlay, arg_3_0.doDecompose, arg_3_0)
end

var_0_0.defaultDescColor = "#cac8c5"

function var_0_0._btncomposeOnClick(arg_4_0)
	if arg_4_0:isMainCardOverCount() then
		GameFacade.showToast(ToastEnum.SeasonMainCardOverCount)
	elseif arg_4_0:canCompose() then
		arg_4_0.isCompose = true

		gohelper.setActive(arg_4_0._btnskipEffect.gameObject, true)
		arg_4_0:showComposeEffect()
		TaskDispatcher.runDelay(arg_4_0.sendComposeRequest, arg_4_0, 2)
	else
		local var_4_0 = CurrencyConfig.instance:getCurrencyCo(Season123Config.instance:getEquipItemCoin(arg_4_0.actId, Activity123Enum.Const.EquipItemCoin))

		GameFacade.showToast(ToastEnum.DiamondBuy, var_4_0.name)
	end
end

function var_0_0.sendComposeRequest(arg_5_0)
	Activity123Rpc.instance:sendComposeAct123EquipRequest(arg_5_0.actId, arg_5_0.itemId)
	Activity123Rpc.instance:sendGetUnlockAct123EquipIdsRequest(arg_5_0.actId)

	arg_5_0.isCompose = false

	gohelper.setActive(arg_5_0._btnskipEffect.gameObject, false)
end

function var_0_0._btndecomposeOnClick(arg_6_0)
	if (arg_6_0.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(arg_6_0.itemId) or 0) == 0 then
		return
	end

	local var_6_0 = {
		actId = arg_6_0.actId,
		itemId = arg_6_0.itemId
	}

	ViewMgr.instance:openView(ViewName.Season123_2_0DecomposeView, var_6_0)
end

function var_0_0._btnbatchDecomposeOnClick(arg_7_0)
	if arg_7_0:getItemCount() == 0 then
		return
	end

	Season123EquipBookController.instance:openBatchDecomposeView(arg_7_0.actId)
end

function var_0_0._btnskipEffectOnClick(arg_8_0)
	if arg_8_0.isCompose then
		TaskDispatcher.cancelTask(arg_8_0.sendComposeRequest, arg_8_0)
		arg_8_0:sendComposeRequest()
	end

	if arg_8_0.isDecompose then
		TaskDispatcher.cancelTask(arg_8_0.sendDecomposeEquipRequest, arg_8_0)
		arg_8_0:sendDecomposeEquipRequest()
	end

	gohelper.setActive(arg_8_0._btnskipEffect.gameObject, false)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animatorCard = arg_9_0._gotargetcardpos:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._animCardEventWrap = arg_9_0._animatorCard:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_9_0._animCardEventWrap:AddEventListener("switch", arg_9_0.onSwitchCardAnim, arg_9_0)

	arg_9_0.colorStr = var_0_0.defaultDescColor

	arg_9_0:hideEffect()
	gohelper.setActive(arg_9_0._btnskipEffect.gameObject, false)
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)

	arg_10_0.actId = Season123Model.instance:getCurSeasonId()
	arg_10_0.coinId = Season123Config.instance:getEquipItemCoin(arg_10_0.actId, Activity123Enum.Const.EquipItemCoin)

	arg_10_0:refreshUI()
end

function var_0_0.onSwitchCardAnim(arg_11_0)
	arg_11_0:refreshUI()
end

function var_0_0.refreshEquipBook(arg_12_0)
	arg_12_0._scrollcardlist.verticalNormalizedPosition = 1

	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.itemId = Season123EquipBookModel.instance.curSelectItemId

	arg_13_0:refreshCardDesc()
	arg_13_0:refreshIcon()
	arg_13_0:refreshBtn()
end

function var_0_0.refreshCardDesc(arg_14_0)
	if not arg_14_0.itemId then
		arg_14_0._txtcardname.text = ""

		gohelper.setActive(arg_14_0._scrolldesc.gameObject, false)
	else
		local var_14_0 = Season123Config.instance:getSeasonEquipCo(arg_14_0.itemId)

		arg_14_0._txtcardname.text = var_14_0 ~= nil and string.format("[%s]", var_14_0.name) or ""

		gohelper.setActive(arg_14_0._scrolldesc.gameObject, var_14_0 ~= nil)
		arg_14_0:refreshCardItem(var_14_0)
	end
end

function var_0_0.refreshCardItem(arg_15_0, arg_15_1)
	arg_15_0._cardDescInfos = arg_15_0:getUserDataTb_()

	if arg_15_1 then
		local var_15_0 = Season123EquipMetaUtils.getSkillEffectStrList(arg_15_1)

		arg_15_0.colorStr = Season123EquipMetaUtils.getCareerColorDarkBg(arg_15_1.equipId)

		if arg_15_1.attrId ~= 0 then
			local var_15_1 = Season123EquipMetaUtils.getEquipPropsStrList(arg_15_1.attrId)

			if GameUtil.getTabLen(var_15_1) > 0 then
				tabletool.addValues(arg_15_0._cardDescInfos, var_15_1)
			end
		end

		tabletool.addValues(arg_15_0._cardDescInfos, var_15_0)
		gohelper.CreateObjList(arg_15_0, arg_15_0.cardDescItemShow, arg_15_0._cardDescInfos, arg_15_0._godescContent, arg_15_0._godescitem)
	end
end

function var_0_0.cardDescItemShow(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1.name = "desc" .. arg_16_3

	local var_16_0 = gohelper.findChildText(arg_16_1, "txt_desc")
	local var_16_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_0.gameObject, FixTmpBreakLine)

	arg_16_2 = HeroSkillModel.instance:skillDesToSpot(arg_16_2)
	var_16_0.text = SkillHelper.addLink(arg_16_2)

	var_16_1:refreshTmpContent(var_16_0)
	SLFramework.UGUI.GuiHelper.SetColor(var_16_0, arg_16_0.colorStr)
	SkillHelper.addHyperLinkClick(var_16_0, arg_16_0.setSkillClickCallBack, arg_16_0)
end

function var_0_0.setSkillClickCallBack(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = recthelper.getAnchor(arg_17_0._gotipPos.transform)
	local var_17_2 = Vector2.New(var_17_0, var_17_1)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_17_1, var_17_2, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0.refreshIcon(arg_18_0)
	if not arg_18_0._icon then
		local var_18_0 = arg_18_0._gocarditem

		arg_18_0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_0, Season123_2_0CelebrityCardEquip)
	end

	if arg_18_0.itemId then
		arg_18_0._icon:updateData(arg_18_0.itemId)
		arg_18_0._icon:setIndexLimitShowState(true)
	end
end

function var_0_0.refreshBtn(arg_19_0)
	local var_19_0 = arg_19_0:getItemCount()

	ZProj.UGUIHelper.SetGrayscale(arg_19_0._btnbatchDecompose.gameObject, var_19_0 == 0)

	local var_19_1

	if arg_19_0.itemId then
		local var_19_2 = Season123Config.instance:getSeasonEquipCo(arg_19_0.itemId)
		local var_19_3 = CurrencyConfig.instance:getCurrencyCo(arg_19_0.coinId)

		arg_19_0._txtdecomposeNum.text = string.format("+%s", var_19_2.decomposeGet)
		arg_19_0._txtcomposeNum.text = string.format("-%s", var_19_2.composeCost)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imagecomposeCoin, var_19_3.icon .. "_1")
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imagedecomposeCoin, var_19_3.icon .. "_1")
	end

	gohelper.setActive(arg_19_0._txtdecomposeNum.gameObject, arg_19_0.itemId)
	gohelper.setActive(arg_19_0._txtcomposeNum.gameObject, arg_19_0.itemId)
	gohelper.setActive(arg_19_0._imagecomposeCoin.gameObject, arg_19_0.itemId)
	gohelper.setActive(arg_19_0._imagedecomposeCoin.gameObject, arg_19_0.itemId)

	local var_19_4 = arg_19_0.itemId and Season123EquipBookModel.instance:getEquipBookItemCount(arg_19_0.itemId) or 0

	SLFramework.UGUI.GuiHelper.SetColor(arg_19_0._txtcomposeNum, arg_19_0:canCompose() and "#070706" or "#800015")
	gohelper.setActive(arg_19_0._gonormaldecomposebg, var_19_4 > 0)
	gohelper.setActive(arg_19_0._golockdecomposebg, var_19_4 == 0)
	gohelper.setActive(arg_19_0._gonormalcomposebg, not arg_19_0:isMainCardOverCount())
	gohelper.setActive(arg_19_0._golockcomposebg, arg_19_0:isMainCardOverCount())
end

function var_0_0.isMainCardOverCount(arg_20_0)
	if arg_20_0.itemId then
		local var_20_0 = Season123EquipBookModel.instance:getEquipBookItemCount(arg_20_0.itemId)

		if Season123Config.instance:getSeasonEquipCo(arg_20_0.itemId).isMain == 1 and var_20_0 >= 1 then
			return true
		end
	end

	return false
end

function var_0_0.canCompose(arg_21_0)
	if not arg_21_0.itemId then
		return false
	end

	local var_21_0 = Season123Config.instance:getSeasonEquipCo(arg_21_0.itemId)
	local var_21_1 = CurrencyModel.instance:getCurrency(arg_21_0.coinId)
	local var_21_2 = var_21_1 and var_21_1.quantity or 0

	return var_21_0 and var_21_2 >= var_21_0.composeCost
end

function var_0_0.getItemCount(arg_22_0)
	local var_22_0 = Season123Model.instance:getAllItemMo(arg_22_0.actId)

	return GameUtil.getTabLen(var_22_0)
end

function var_0_0.onChangeSelectCard(arg_23_0)
	arg_23_0._animatorCard:Play("switch", 0, 0)
	arg_23_0:hideEffect()
end

function var_0_0.doDecompose(arg_24_0, arg_24_1)
	arg_24_0.decomposeList = arg_24_1

	gohelper.setActive(arg_24_0._btnskipEffect.gameObject, true)
	arg_24_0:showDecomposeEffect()

	arg_24_0.isDecompose = true

	TaskDispatcher.runDelay(arg_24_0.sendDecomposeEquipRequest, arg_24_0, 1.5)
end

function var_0_0.sendDecomposeEquipRequest(arg_25_0)
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(arg_25_0.actId, arg_25_0.decomposeList)

	arg_25_0.isDecompose = false

	gohelper.setActive(arg_25_0._btnskipEffect.gameObject, false)
end

function var_0_0.showDecomposeEffect(arg_26_0)
	gohelper.setActive(arg_26_0._godecomposeEffect, false)
	gohelper.setActive(arg_26_0._godecomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_qiutu_list_maintain)
end

function var_0_0.showComposeEffect(arg_27_0)
	gohelper.setActive(arg_27_0._gocomposeEffect, false)
	gohelper.setActive(arg_27_0._gocomposeEffect, true)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_celebrity_synthesis)
end

function var_0_0.hideEffect(arg_28_0)
	gohelper.setActive(arg_28_0._godecomposeEffect, false)
	gohelper.setActive(arg_28_0._gocomposeEffect, false)
end

function var_0_0.onClose(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.sendComposeRequest, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.sendDecomposeEquipRequest, arg_29_0)

	Season123EquipBookModel.instance._itemStartAnimTime = nil
end

function var_0_0.onDestroyView(arg_30_0)
	if arg_30_0._animCardEventWrap then
		arg_30_0._animCardEventWrap:RemoveAllEventListener()

		arg_30_0._animCardEventWrap = nil
	end

	if arg_30_0._icon ~= nil then
		arg_30_0._icon:disposeUI()

		arg_30_0._icon = nil
	end

	Season123EquipBookController.instance:onCloseView()
end

return var_0_0
