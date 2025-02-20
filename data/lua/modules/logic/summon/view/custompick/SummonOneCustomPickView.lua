module("modules.logic.summon.view.custompick.SummonOneCustomPickView", package.seeall)

slot0 = class("SummonOneCustomPickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simageunselect = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_unselect")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	slot0._simagerole1outline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1_outline")
	slot0._simagerole1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1/#simage_role1")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg")
	slot0._gocharacteritem = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem")
	slot0._simagetitle1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/title/#simage_title1")
	slot0._simagetips = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/tip/#simage_tips")
	slot0._gotip2bg = gohelper.findChild(slot0.viewGO, "#go_ui/current/tip/#go_tip2bg")
	slot0._txttips2 = gohelper.findChildText(slot0.viewGO, "#go_ui/current/tip/#go_tip2bg/#txt_tips2")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_tips")
	slot0._goselfselect = gohelper.findChild(slot0.viewGO, "#go_ui/#go_selfselect")
	slot0._btnselfselect = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_selfselect/#btn_selfselect")
	slot0._gosummonbtns = gohelper.findChild(slot0.viewGO, "#go_ui/#go_summonbtns")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon1/currency/#txt_currency1_2")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_ui/#go_summonbtns/summon10/#go_count/#txt_count")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnselfselect:AddClickListener(slot0._btnselfselectOnClick, slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnselfselect:RemoveClickListener()
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
end

slot0.preloadList = {
	"singlebg/summon/heroversion_1_9/selfselectsix/v1a9_selfselectsix_summon_fullbg.png",
	"singlebg/summon/heroversion_1_9/selfselectsix/v1a9_selfselectsix_summon_unselect.png",
	"singlebg/summon/heroversion_1_9/selfselectsix/v1a9_selfselectsix_summon_frontbg.png"
}

function slot0._btnselfselectOnClick(slot0)
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

	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._characteritem = slot0:getUserDataTb_()
	slot0._characteritem.go = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem")
	slot0._characteritem.imagecareer = gohelper.findChildImage(slot0._characteritem.go, "image_career")
	slot0._characteritem.txtnamecn = gohelper.findChildText(slot0._characteritem.go, "txt_namecn")
	slot0._characteritem.btndetail = gohelper.findChildButtonWithAudio(slot0._characteritem.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
	slot0._characteritem.gorole = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role1")
	slot0._characteritem.simagehero = gohelper.findChildSingleImage(slot0._characteritem.gorole, "#simage_role1")
	slot0._characteritem.tfimagehero = slot0._characteritem.simagehero.transform
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
	slot0._simagebg:UnLoadImage()
	slot0._simageunselect:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()

	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end

	if slot0._characteritem then
		slot0._characteritem.btndetail:RemoveClickListener()
		slot0._characteritem.simagehero:UnLoadImage()
		slot0._simagerole1outline:UnLoadImage()

		slot0._characteritem = nil
	end
end

function slot0.handleNeedPickStatus(slot0, slot1)
	gohelper.setActive(slot0._gosummonbtns, false)
	gohelper.setActive(slot0._goselected, false)
	gohelper.setActive(slot0._simageunselect, true)
	gohelper.setActive(slot0._goselfselect, true)
	gohelper.setActive(slot0._txttips, true)
	gohelper.setActive(slot0._simageunselect, true)
end

function slot0.handlePickOverStatus(slot0, slot1)
	gohelper.setActive(slot0._gosummonbtns, true)
	gohelper.setActive(slot0._goselected, true)
	gohelper.setActive(slot0._simageunselect, false)
	gohelper.setActive(slot0._goselfselect, false)
	gohelper.setActive(slot0._txttips, false)
	gohelper.setActive(slot0._simageunselect, false)
	slot0:refreshCost()
	slot0:refreshFreeSummonButton(slot1)
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
	slot2, slot3, slot0._txtcurrency102.text = SummonMainModel.instance.getCostByConfig(slot1)

	slot0._simagecurrency10:LoadImage(SummonMainModel.instance.getSummonItemIcon(slot2, slot3))

	slot6 = SummonMainModel.instance:getCurId()

	gohelper.setActive(slot0._gotip2bg, SummonMainModel.instance:getDiscountTime10Server(slot6) > 0)
	gohelper.setActive(slot0._txttips2, slot8 > 0)

	if slot3 == SummonMainModel.instance:getDiscountCostId(slot6) then
		gohelper.setActive(slot0._gocount, slot8 > 0)

		if slot8 > 0 then
			slot9 = SummonMainModel.instance:getDiscountCost10(slot6)
			slot0._txtcurrency101.text = string.format("<color=%s>%s</color>", "#FFE095", luaLang("multiple") .. slot9)
			slot0._txtcount.text = string.format(luaLang("summonpickchoice_discount"), (slot4 - slot9) / slot4 * 100)

			return
		end
	else
		gohelper.setActive(slot0._gocount, false)
	end

	slot0._txtcurrency101.text = string.format("<color=%s>%s</color>", "#000000", luaLang("multiple") .. slot4)
	slot0._txtcurrency102.text = ""
end

function slot0.getPickHeroIds(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot2.customPickMO then
		return slot2.customPickMO.pickHeroIds
	end

	return nil
end

function slot0.refreshPickHero(slot0, slot1)
	if slot0:getPickHeroIds(slot1) and #slot2 > 0 and slot0._characteritem then
		gohelper.setActive(slot0._characteritem.go, true)
		gohelper.setActive(slot0._characteritem.simagehero, true)

		slot4 = HeroConfig.instance:getHeroCO(slot2[1])
		slot8 = slot0._characteritem.imagecareer

		UISpriteSetMgr.instance:setCommonSprite(slot8, "lssx_" .. tostring(slot4.career))

		slot0._characteritem.txtnamecn.text = slot4.name

		for slot8 = 1, 6 do
			gohelper.setActive(slot0._characteritem.rares[slot8], slot8 <= CharacterEnum.Star[slot4.rare])
		end

		slot5, slot6, slot7 = slot0:getOffset(slot4.skinId)

		slot0._characteritem.simagehero:LoadImage(ResUrl.getHeadIconImg(slot4.skinId), slot0.handleLoadedImage, {
			imgTransform = slot0._simagerole1.gameObject.transform,
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
	else
		gohelper.setActive(slot0._characteritem.go, false)
		gohelper.setActive(slot0._characteritem.simagehero, false)
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
	slot4 = slot0.scale

	ZProj.UGUIHelper.SetImageSize(slot1.gameObject)
	recthelper.setAnchor(slot1, slot0.offsetX, slot0.offsetY)
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

	if SummonCustomPickModel.instance:isCustomPickOver(slot1.id) then
		slot0:handlePickOverStatus(slot1)
	else
		slot0:handleNeedPickStatus(slot1)
	end

	slot0:refreshPickHero(slot1)
	slot0:_refreshOpenTime()

	slot0._txttips2.text = string.format(luaLang("summon_discount_tips"), SummonMainModel.instance:getDiscountCost10(slot1.id, 1))
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
		slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		slot0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function slot0.playerEnterAnimFromScene(slot0)
	slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
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
