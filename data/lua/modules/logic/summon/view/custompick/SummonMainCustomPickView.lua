module("modules.logic.summon.view.custompick.SummonMainCustomPickView", package.seeall)

slot0 = class("SummonMainCustomPickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simageunselect = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_unselect")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	slot0._gosummon10 = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns/summon10")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gopageitem = gohelper.findChild(slot0.viewGO, "#go_ui/pageicon/#go_pageitem")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")
	slot0._gosummonbtns = gohelper.findChild(slot0.viewGO, "#go_ui/summonbtns")
	slot0._gocustompick = gohelper.findChild(slot0.viewGO, "#go_ui/selfselect")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	slot0._btnpick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/selfselect/#btn_selfselect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
	slot0._btnpick:AddClickListener(slot0._btnpickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
	slot0._btnpick:RemoveClickListener()
end

slot0.preloadList = {
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/full/v1a6_selfselectsix_summon_fullbg"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_rolemask"),
	ResUrl.getSummonCoverBg("heroversion_1_6/selfselectsix/v1a6_selfselectsix_summon_mask2")
}

function slot0._editableInitView(slot0)
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	slot0._txttips = gohelper.findChildText(slot0.viewGO, "#go_ui/current/txt_tips")
	slot0._characteritems = {}
	slot0._charaterItemCount = slot0._charaterItemCount or SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	for slot4 = 1, slot0._charaterItemCount do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem" .. slot4)
		slot5.imagecareer = gohelper.findChildImage(slot5.go, "image_career")
		slot5.txtnamecn = gohelper.findChildText(slot5.go, "txt_namecn")
		slot5.btndetail = gohelper.findChildButtonWithAudio(slot5.go, "btn_detail", AudioEnum.UI.play_ui_action_explore)
		slot5.gorole = gohelper.findChild(slot0.viewGO, "#go_ui/current/#go_selected/#go_role" .. tostring(slot4))
		slot9 = "#simage_role" .. tostring(slot4)
		slot5.simagehero = gohelper.findChildSingleImage(slot5.gorole, slot9)
		slot5.tfimagehero = slot5.simagehero.transform
		slot5.rares = {}

		for slot9 = 1, 6 do
			table.insert(slot5.rares, gohelper.findChild(slot5.go, "rare/go_rare" .. slot9))
		end

		table.insert(slot0._characteritems, slot5)
		slot5.btndetail:AddClickListener(slot0._onClickDetailByIndex, slot0, slot4)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageunselect:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
	slot0._simageline:UnLoadImage()

	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end

	if slot0._characteritems then
		for slot4, slot5 in ipairs(slot0._characteritems) do
			slot5.btndetail:RemoveClickListener()
		end

		slot0._characteritems = nil
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	logNormal("SummonMainCustomPickView:onOpen()")
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
	slot0:playEnterAnim()
	slot0:refreshView()
end

function slot0.onOpenFinish(slot0)
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

function slot0.onClose(slot0)
	logNormal("SummonMainCustomPickView:onClose()")
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0.refreshView, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
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

	if not (slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3)) and SummonMainModel.instance:getOwnCostCurrencyNum() < SummonMainModel.instance.everyCostCount * (10 - slot6) then
		-- Nothing
	end

	if slot7 then
		slot5.needTransform = false

		slot0:_summon10Confirm()

		return
	else
		slot5.needTransform = true
		slot5.cost_type = SummonMainModel.instance.costCurrencyType
		slot5.cost_id = SummonMainModel.instance.costCurrencyId
		slot5.cost_quantity = slot11
		slot5.miss_quantity = slot10
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

function slot0._btnpickOnClick(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonCustomPickChoice, {
		poolId = slot1.id
	})
end

function slot0._onClickDetailByIndex(slot0, slot1)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if SummonMainModel.instance:getPoolServerMO(slot2.id) and slot3.customPickMO and slot3.customPickMO.pickHeroIds[slot1] then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot4
		})
	end
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

	slot0:_refreshOpenTime()
end

function slot0.handleNeedPickStatus(slot0, slot1)
	gohelper.setActive(slot0._gosummonbtns, false)
	gohelper.setActive(slot0._simageunselect, true)
	gohelper.setActive(slot0._gocustompick, true)

	slot5 = true

	gohelper.setActive(slot0._txttips, slot5)

	for slot5 = 1, slot0._charaterItemCount do
		slot0:refreshPickHero(slot1.id, slot5, nil)
	end
end

function slot0.handlePickOverStatus(slot0, slot1)
	gohelper.setActive(slot0._gosummonbtns, true)
	gohelper.setActive(slot0._simageunselect, false)
	gohelper.setActive(slot0._gocustompick, false)
	gohelper.setActive(slot0._txttips, false)
	slot0:refreshPickHeroes(slot1)
	slot0:refreshCost()
	slot0:refreshFreeSummonButton(slot1)
end

function slot0.refreshPickHeroes(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot2.customPickMO then
		for slot6 = 1, slot0._charaterItemCount do
			slot0:refreshPickHero(slot1.id, slot6, slot2.customPickMO.pickHeroIds[slot6])
		end
	end
end

function slot0.refreshPickHero(slot0, slot1, slot2, slot3)
	if slot0._characteritems[slot2] then
		if slot3 then
			gohelper.setActive(slot4.go, true)
			gohelper.setActive(slot4.simagehero, true)

			slot5 = HeroConfig.instance:getHeroCO(slot3)
			slot9 = slot4.imagecareer

			UISpriteSetMgr.instance:setCommonSprite(slot9, "lssx_" .. tostring(slot5.career))

			slot4.txtnamecn.text = slot5.name

			for slot9 = 1, 6 do
				gohelper.setActive(slot4.rares[slot9], slot9 <= CharacterEnum.Star[slot5.rare])
			end

			slot4.simagehero:LoadImage(ResUrl.getHeadIconImg(slot5.skinId), slot0.handleLoadedImage, {
				panel = slot0,
				skinId = slot5.skinId,
				index = slot2
			})
		else
			gohelper.setActive(slot4.go, false)
			gohelper.setActive(slot4.simagehero, false)
		end
	end
end

function slot0.handleLoadedImage(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0.panel._characteritems[slot0.index].simagehero.gameObject)

	if not string.nilorempty(SkinConfig.instance:getSkinCo(slot0.skinId).skinViewImgOffset) then
		slot7 = string.splitToNumber(slot6, "#")

		recthelper.setAnchor(slot4.tfimagehero, tonumber(slot7[1]), tonumber(slot7[2]))
		transformhelper.setLocalScale(slot4.tfimagehero, tonumber(slot7[3]), tonumber(slot7[3]), tonumber(slot7[3]))
	else
		recthelper.setAnchor(slot4.tfimagehero, -150, -150)
		transformhelper.setLocalScale(slot4.tfimagehero, 0.6, 0.6, 0.6)
	end
end

function slot0.refreshFreeSummonButton(slot0, slot1)
	slot0._compFreeButton = slot0._compFreeButton or SummonFreeSingleGacha.New(slot0._btnsummon1.gameObject, slot1.id)

	slot0._compFreeButton:refreshUI()
end

function slot0.refreshRemainTimes(slot0, slot1)
	if SummonMainModel.instance:getPoolServerMO(slot1.id) and slot3.luckyBagMO then
		slot0._txttimes.text = string.format("%s/%s", slot3.luckyBagMO.summonTimes, SummonConfig.getSummonSSRTimes(slot1))
	else
		slot0._txttimes.text = "-"
	end
end

function slot0.refreshCost(slot0)
	if SummonMainModel.instance:getCurPool() then
		slot0:_refreshSingleCost(slot1.cost1, slot0._simagecurrency1, "_txtcurrency1")
		slot0:_refreshSingleCost(slot1.cost10, slot0._simagecurrency10, "_txtcurrency10")
	end
end

function slot0._refreshSingleCost(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = SummonMainModel.getCostByConfig(slot1)

	slot2:LoadImage(SummonMainModel.getSummonItemIcon(slot4, slot5))

	slot9 = slot6 <= ItemModel.instance:getItemQuantity(slot4, slot5)
	slot0[slot3 .. "1"].text = luaLang("multiple") .. slot6
	slot0[slot3 .. "2"].text = ""
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

function slot0.onSummonFailed(slot0)
	slot0.summonSuccess = false

	slot0:refreshCost()
end

function slot0.onSummonReply(slot0)
	slot0.summonSuccess = true
end

function slot0.onItemChanged(slot0)
	if SummonController.instance.isWaitingSummonResult or slot0.summonSuccess then
		return
	end

	slot0:refreshCost()
end

return slot0
