module("modules.logic.summon.view.custompick.SummonStrongOneCustomPickView", package.seeall)

slot0 = class("SummonStrongOneCustomPickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_fullbg")
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_unselected")
	slot0._simagerole3unselected = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_role3_unselected")
	slot0._simagerole4unselected = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_role4_unselected")
	slot0._simagerole2unselected = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_unselected/#simage_role2_unselected")
	slot0._goselfselect = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_unselected/#go_selfselect")
	slot0._btnselfselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/current/#go_unselected/#go_selfselect/#btn_selfselect")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	slot0._simagerole1outline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	slot0._simagerole1selected = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_selected")
	slot0._gocharacteritem1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#go_characteritem1")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/current/#go_selected/#btn_refresh")
	slot0._simagerolerefresh = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#btn_refresh/#simage_role_refresh")
	slot0._gosummonbtns = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/summon1/currency/#txt_currency1_2")
	slot0._gosummon10 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/currency/#txt_currency10_2")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10/#go_count/#txt_count")
	slot0._gosummon10normal = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal")
	slot0._btnsummon10normal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/#btn_summon10_normal")
	slot0._simagecurrency10normal = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#simage_currency10_normal")
	slot0._txtcurrency101normal = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_1_normal")
	slot0._txtcurrency102normal = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#go_selected/#go_summonbtns/#go_summon10_normal/currency/#txt_currency10_2_normal")
	slot0._simagetitle1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/title/#simage_title1")
	slot0._godisCountTip = gohelper.findChild(slot0.viewGO, "#go_ui/current/tip/#go_disCountTip")
	slot0._simagetips = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/#go_disCountTip/#simage_tips")
	slot0._gotip2bg = gohelper.findChild(slot0.viewGO, "#go_ui/current/tip/#go_disCountTip/#go_tip2bg")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_ui/current/tip/#go_disCountTip/#txt_tips")
	slot0._simagetips2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/#simage_tips2")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line3")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselfselect:AddClickListener(slot0._btnselfselectOnClick, slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
	slot0._btnsummon10normal:AddClickListener(slot0._btnsummon10normalOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselfselect:RemoveClickListener()
	slot0._btnrefresh:RemoveClickListener()
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
	slot0._btnsummon10normal:RemoveClickListener()
end

function slot0._btnsummon10normalOnClick(slot0)
	slot0:_btnsummon10OnClick()
end

function slot0._btnrefreshOnClick(slot0)
	slot0:openSelectView()
end

function slot0._btnselfselectOnClick(slot0)
	slot0:openSelectView()
end

slot0.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role1.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role3.png",
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_role4.png"
}

function slot0.openSelectView(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = slot1.id
	})
end

function slot0._btnsummon1OnClick(slot0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1.cost1)

	if not (slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount then
		-- Nothing
	end

	if slot7 then
		slot5.needTransform = false

		slot0:_summon1Confirm()

		return
	else
		slot5.needTransform = true
		slot5.cost_type = SummonMainModel.instance.costCurrencyType
		slot5.cost_id = SummonMainModel.instance.costCurrencyId
		slot5.cost_quantity = slot8
		slot5.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot2,
		id = slot3,
		quantity = slot4,
		callback = slot0._summon1Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._btnsummon10OnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1.cost10)
	slot5 = SummonMainModel.instance:getDiscountCost10(slot1.id)

	if SummonMainModel.instance:getDiscountCostId(slot1.id) == slot3 then
		slot4 = slot5 < 0 and slot4 or slot5
	end

	if not (slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount * (slot4 - slot8) then
		-- Nothing
	end

	if slot9 then
		slot7.needTransform = false

		slot0:_summon10Confirm()

		return
	else
		slot7.needTransform = true
		slot7.cost_type = SummonMainModel.instance.costCurrencyType
		slot7.cost_id = SummonMainModel.instance.costCurrencyId
		slot7.cost_quantity = slot13
		slot7.miss_quantity = slot12
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, {
		type = slot2,
		id = slot3,
		quantity = slot4,
		callback = slot0._summon10Confirm,
		callbackObj = slot0,
		notEnough = false,
		notEnough = true
	})
end

function slot0._onClickDetail(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if slot0:getPickHeroIds(slot1) and #slot2 > 0 and slot2[1] then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot3
		})
	end
end

function slot0._editableInitView(slot0)
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simageline3:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._characteritem = slot0:getUserDataTb_()
	slot0._characteritem.go = slot0._gocharacteritem1
	slot0._characteritem.imagecareer = gohelper.findChildImage(slot0._characteritem.go, "image_career")
	slot0._characteritem.txtnamecn = gohelper.findChildText(slot0._characteritem.go, "txt_namecn")
	slot0._characteritem.btndetail = gohelper.findChildButtonWithAudio(slot0._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	slot0._characteritem.gorole = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	slot0._characteritem.simagehero = slot0._simagerole1selected
	slot0._characteritem.simageheroRefresh = slot0._simagerolerefresh
	slot4 = slot0
	slot0._characteritem.rares = slot0.getUserDataTb_(slot4)

	for slot4 = 1, 6 do
		table.insert(slot0._characteritem.rares, gohelper.findChild(slot0._characteritem.go, "rare/go_rare" .. slot4))
	end

	slot0._characteritem.btndetail:AddClickListener(slot0._onClickDetail, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addAllEvents()
	slot0:playEnterAnim()
	slot0:refreshView()
end

function slot0.onClose(slot0)
	slot0:removeAllEvents()
end

function slot0.onDestroyView(slot0)
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simagecurrency10normal:UnLoadImage()
	slot0._simageline3:UnLoadImage()

	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end

	if slot0._characteritem then
		slot0._characteritem.btndetail:RemoveClickListener()
		slot0._characteritem.simagehero:UnLoadImage()
		slot0._characteritem.simageheroRefresh:UnLoadImage()
		slot0._simagerole1outline:UnLoadImage()

		slot0._characteritem = nil
	end
end

function slot0.refreshFreeSummonButton(slot0, slot1)
	slot0._compFreeButton = slot0._compFreeButton or SummonFreeSingleGacha.New(slot0._btnsummon1.gameObject, slot1.id)

	slot0._compFreeButton:refreshUI()
end

function slot0.refreshCost(slot0)
	if SummonMainModel.instance:getCurPool() then
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		slot0:refreshCost10(slot1.cost10)
	end
end

function slot0._refreshSingleCost(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.instance.getCostByConfig(slot1)

	slot2:LoadImage(SummonMainModel.instance.getSummonItemIcon(slot4, slot5))

	slot0[slot3 .. "1"].text = luaLang("multiple") .. slot6
	slot0[slot3 .. "2"].text = ""
end

function slot0.refreshCost10(slot0, slot1)
	slot2, slot3, slot11 = SummonMainModel.instance.getCostByConfig(slot1)
	slot5 = SummonMainModel.instance.getSummonItemIcon(slot2, slot3)

	slot0._simagecurrency10:LoadImage(slot5)
	slot0._simagecurrency10normal:LoadImage(slot5)

	slot6 = SummonMainModel.instance:getCurId()
	slot9 = SummonMainModel.instance:getDiscountTime10Server(slot6) > 0

	gohelper.setActive(slot0._gotip2bg, slot9)
	gohelper.setActive(slot0._txttips.gameObject, slot9)
	gohelper.setActive(slot0._gosummon10, slot9)
	gohelper.setActive(slot0._gosummon10normal, not slot9)

	slot10 = ""
	slot11 = ""

	if slot3 == SummonMainModel.instance:getDiscountCostId(slot6) then
		gohelper.setActive(slot0._gocount, slot8 > 0)

		if slot8 > 0 then
			slot12 = SummonMainModel.instance:getDiscountCost10(slot6)
			slot10 = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. slot12)
			slot0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), (slot4 - slot12) / slot4 * 100)
		else
			slot10 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. slot4)
		end
	else
		slot10 = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. slot4)

		gohelper.setActive(slot0._gocount, false)
	end

	slot0._txtcurrency101.text = slot10
	slot0._txtcurrency101normal.text = slot10
	slot0._txtcurrency102.text = slot11
	slot0._txtcurrency102normal.text = slot11
end

function slot0.getPickHeroIds(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot2.customPickMO then
		return slot2.customPickMO.pickHeroIds
	end

	return nil
end

function slot0.refreshPickHero(slot0, slot1)
	if (slot0:getPickHeroIds(slot1) and slot2[1] or nil) ~= nil and slot0._characteritem then
		slot4 = HeroConfig.instance:getHeroCO(slot3)
		slot8 = slot0._characteritem.imagecareer

		UISpriteSetMgr.instance:setCommonSprite(slot8, "lssx_" .. tostring(slot4.career))

		slot0._characteritem.txtnamecn.text = slot4.name

		for slot8 = 1, 6 do
			gohelper.setActive(slot0._characteritem.rares[slot8], slot8 <= CharacterEnum.Star[slot4.rare])
		end

		slot5, slot6, slot7 = slot0:getOffset(slot4.skinId)

		slot0._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(slot4.skinId), slot0.handleLoadedImage, {
			imgTransform = slot0._simagerole1selected.gameObject.transform,
			offsetX = slot5,
			offsetY = slot6,
			scale = slot7
		})
		slot0._simagerole1outline:LoadImage(ResUrl.getHeadIconImg(slot4.skinId), slot0.handleLoadedImage, {
			imgTransform = slot0._simagerole1outline.gameObject.transform,
			offsetX = slot5 - 5,
			offsetY = slot6 + 2,
			scale = slot7
		})
		slot0._simagerolerefresh:LoadImage(ResUrl.getHandbookheroIcon(slot4.skinId), nil)
	end
end

function slot0.getOffset(slot0, slot1)
	if not string.nilorempty(SkinConfig.instance:getSkinCo(slot1).skinViewImgOffset) then
		slot4 = string.splitToNumber(slot3, "#")

		return slot4[1], slot4[2], slot4[3]
	end

	return -150, -150, 0.6
end

function slot0.handleLoadedImage(slot0)
	slot1 = slot0.imgTransform
	slot4 = slot0.scale or 1

	ZProj.UGUIHelper.SetImageSize(slot1.gameObject)
	recthelper.setAnchor(slot1, slot0.offsetX or 0, slot0.offsetY or 0)
	transformhelper.setLocalScale(slot1, slot4, slot4, slot4)
end

function slot0.refreshView(slot0)
	slot0.summonSuccess = false

	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		gohelper.setActive(slot0._goui, false)

		return
	end

	slot0:refreshPoolUI()
end

function slot0.refreshPoolUI(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot2 = SummonCustomPickModel.instance:isCustomPickOver(slot1.id)

	slot0:refreshPickHero(slot1)
	gohelper.setActive(slot0._goselected, slot2)
	gohelper.setActive(slot0._gounselected, not slot2)

	if slot2 then
		slot0:refreshCost()
		slot0:refreshFreeSummonButton(slot1)
	end

	slot3 = SummonCustomPickModel.instance:isHaveFirstSSR(slot1.id)

	gohelper.setActive(slot0._simagetips.gameObject, not slot3)
	gohelper.setActive(slot0._simagetips2.gameObject, slot3)
	slot0:_refreshOpenTime()

	slot0._txttips.text = string.format(luaLang("summon_discount_tips"), SummonMainModel.instance:getDiscountCost10(slot1.id, 1))
end

function slot0._refreshOpenTime(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if SummonMainModel.instance:getPoolServerMO(slot1.id) ~= nil and slot2.offlineTime ~= 0 and slot2.offlineTime < TimeUtil.maxDateTimeStamp then
		slot0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(slot2.offlineTime - ServerTime.now()))
	else
		slot0._txtdeadline.text = ""
	end
end

function slot0.playEnterAnim(slot0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		slot0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		slot0:playAnim(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function slot0.playerEnterAnimFromScene(slot0)
	slot0:playAnim(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	if slot0._animRoot ~= nil then
		slot0._animRoot:Play(slot1, slot2, slot3)
	end
end

function slot0.addAllEvents(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0.removeAllEvents(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
end

function slot0._summon10Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 10, false, true)
end

function slot0._summon1Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 1, false, true)
end

function slot0.onItemChanged(slot0)
	if SummonController.instance.isWaitingSummonResult or slot0.summonSuccess then
		return
	end

	slot0:refreshCost()
end

function slot0.onSummonFailed(slot0)
	slot0.summonSuccess = false

	slot0:refreshCost()
end

function slot0.onSummonReply(slot0)
	slot0.summonSuccess = true
end

return slot0
