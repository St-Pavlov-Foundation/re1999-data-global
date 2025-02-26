module("modules.logic.summon.view.SummonMainCharacterProbUp", package.seeall)

slot0 = class("SummonMainCharacterProbUp", BaseView)

function slot0.onInitView(slot0)
	slot0._goui = gohelper.findChild(slot0.viewGO, "#go_ui")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_bg")
	slot0._simagefrontbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_frontbg")
	slot0._gocharacteritem1 = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem1")
	slot0._simagesignature1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/right/#go_characteritem1/#simage_signature1")
	slot0._btnsummon1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	slot0._simagecurrency1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	slot0._txtcurrency11 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	slot0._txtcurrency12 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	slot0._btnsummon10 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	slot0._simagecurrency10 = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	slot0._txtcurrency101 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	slot0._txtcurrency102 = gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	slot0._gopageitem = gohelper.findChild(slot0.viewGO, "#go_ui/pageicon/#go_pageitem")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_lefttop")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_ui/#go_righttop")
	slot0._txtdeadline = gohelper.findChildText(slot0.viewGO, "#go_ui/current/#txt_deadline")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	slot0._txtpreferential = gohelper.findChildText(slot0.viewGO, "#go_ui/current/first/#txt_times")
	slot0._gopreferential = gohelper.findChild(slot0.viewGO, "#go_ui/current/first")

	for slot4 = 1, 3 do
		slot0["_simagead" .. slot4] = gohelper.findChildSingleImage(slot0.viewGO, "#go_ui/current/#simage_ad" .. slot4)
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsummon1:AddClickListener(slot0._btnsummon1OnClick, slot0)
	slot0._btnsummon10:AddClickListener(slot0._btnsummon10OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsummon1:RemoveClickListener()
	slot0._btnsummon10:RemoveClickListener()
end

slot0.DETAIL_COUNT = 1
slot0.SIMAGE_COUNT = 3
slot0.preloadList = {
	ResUrl.getSummonHeroIcon("full/bg111")
}

for slot4 = 1, slot0.SIMAGE_COUNT do
	table.insert(slot0.preloadList, ResUrl.getSummonHeroIcon("role" .. slot4))
end

function slot0._editableInitView(slot0)
	slot0._characteritems = {}
	slot0._pageitems = {}
	slot0._animRoot = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	slot0:refreshSingleImage()

	slot0._charaterItemCount = slot0._charaterItemCount or uv0.DETAIL_COUNT

	for slot4 = 1, slot0._charaterItemCount do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "#go_ui/current/right/#go_characteritem" .. slot4)
		slot5.imagecareer = gohelper.findChildImage(slot5.go, "image_career")
		slot5.txtnamecn = gohelper.findChildText(slot5.go, "txt_namecn")
		slot9 = AudioEnum.UI.play_ui_action_explore
		slot5.btndetail = gohelper.findChildButtonWithAudio(slot5.go, "btn_detail", slot9)
		slot5.rares = {}

		for slot9 = 1, 6 do
			table.insert(slot5.rares, gohelper.findChild(slot5.go, "rare/go_rare" .. slot9))
		end

		table.insert(slot0._characteritems, slot5)
		slot5.btndetail:AddClickListener(uv0._onClickDetailByIndex, slot0, slot4)
	end

	if GameConfig:GetCurLangType() == LangSettings.en then
		gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon1/text").text = string.format(luaLang("p_summon_once"), luaLang("multiple"))
		gohelper.findChildText(slot0.viewGO, "#go_ui/summonbtns/summon10/text").text = string.format(luaLang("p_summon_tentimes"), luaLang("multiple"))
	else
		slot1.text = luaLang("p_summon_once")
		slot2.text = luaLang("p_summon_tentimes")
	end
end

function slot0.onDestroyView(slot0)
	if slot0._compFreeButton then
		slot0._compFreeButton:dispose()

		slot0._compFreeButton = nil
	end

	for slot4 = 1, #slot0._characteritems do
		slot0._characteritems[slot4].btndetail:RemoveClickListener()
	end

	slot0:unloadSingleImage()
end

function slot0.refreshSingleImage(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSummonHeroIcon("full/bg111"))
	slot0._simagefrontbg:LoadImage(ResUrl.getSummonHeroIcon("bg_role_3"))

	slot4 = "title_img_deco"

	slot0._simageline:LoadImage(ResUrl.getSummonHeroIcon(slot4))

	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:LoadImage(ResUrl.getSummonHeroIcon("role" .. slot4), slot0._adLoaded, slot0)
	end

	slot0._simagesignature1:LoadImage(ResUrl.getSignature("3009"))
end

function slot0.unloadSingleImage(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:UnLoadImage()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefrontbg:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simagesignature1:UnLoadImage()
	slot0._simagecurrency1:UnLoadImage()
	slot0._simagecurrency10:UnLoadImage()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0._refreshView, slot0)
	slot0:playEnterAnim()
	slot0:_refreshView()
end

function slot0.playEnterAnim(slot0)
	if slot0._animRoot then
		if SummonMainModel.instance:getFirstTimeSwitch() then
			SummonMainModel.instance:setFirstTimeSwitch(false)
			slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
		else
			slot0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
		end
	end
end

function slot0.playerEnterAnimFromScene(slot0)
	slot0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, slot0.onSummonFailed, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, slot0.onSummonReply, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, slot0.playerEnterAnimFromScene, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, slot0._refreshOpenTime, slot0)
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onItemChanged, slot0)
	slot0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0._refreshView, slot0)
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

function slot0._summon1Confirm(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	SummonMainController.instance:sendStartSummon(slot1.id, 1, false, true)
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

function slot0._onClickDetailByIndex(slot0, slot1)
	if not slot0._characteritems then
		return
	end

	if slot0._characteritems[slot1] then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = slot2.characterDetailId
		})
	end
end

function slot0._refreshView(slot0)
	slot0.summonSuccess = false

	if not SummonMainModel.instance:getList() or #slot1 <= 0 then
		gohelper.setActive(slot0._goui, false)

		return
	end

	slot0:_refreshPoolUI()
end

function slot0._refreshPoolUI(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot0:_refreshCost()
	slot0:showCharacter(slot1)
	slot0:refreshFreeSummonButton(slot1)
	slot0:_refreshOpenTime()
	slot0:_refreshPreferentialInfo()
end

function slot0.refreshFreeSummonButton(slot0, slot1)
	slot0._compFreeButton = slot0._compFreeButton or SummonFreeSingleGacha.New(slot0._btnsummon1.gameObject, slot1.id)

	slot0._compFreeButton:refreshUI()
end

function slot0._refreshOpenTime(slot0)
	slot0._txtdeadline.text = ""

	if not SummonMainModel.instance:getCurPool() then
		return
	end

	if not SummonMainModel.instance:getPoolServerMO(slot1.id) then
		return
	end

	slot3, slot4 = slot2:onOffTimestamp()

	if slot3 < slot4 and slot4 > 0 then
		slot0._txtdeadline.text = formatLuaLang("summonmainequipprobup_deadline", SummonModel.formatRemainTime(slot4 - ServerTime.now()))
	end
end

function slot0._refreshPreferentialInfo(slot0)
	if not SummonMainModel.instance:getCurPool() then
		return
	end

	slot3 = SummonMainModel.instance:getPoolServerMO(slot1.id).canGetGuaranteeSRCount

	if slot0._gopreferential then
		gohelper.setActive(slot0._gopreferential, slot3 > 0)

		if slot0._txtpreferential and slot3 > 0 then
			slot0._txtpreferential.text = slot2.guaranteeSRCountDown
		end
	end
end

function slot0._adLoaded(slot0)
	for slot4 = 1, uv0.SIMAGE_COUNT do
		slot0["_simagead" .. slot4]:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function slot0.showCharacter(slot0, slot1)
	slot2 = nil

	if not string.nilorempty(slot1.characterDetail) then
		slot2 = string.split(slot1.characterDetail, "#")
	end

	slot3 = {}

	if slot2 ~= nil then
		for slot7 = 1, #slot2 do
			if slot0._characteritems[SummonConfig.instance:getCharacterDetailConfig(tonumber(slot2[slot7])).location] then
				slot13 = HeroConfig.instance:getHeroCO(slot9.heroId)
				slot17 = "lssx_" .. tostring(slot13.career)

				UISpriteSetMgr.instance:setCommonSprite(slot11.imagecareer, slot17)

				slot11.txtnamecn.text = slot13.name

				for slot17 = 1, 6 do
					gohelper.setActive(slot11.rares[slot17], slot17 <= CharacterEnum.Star[slot13.rare])
				end

				slot11.characterDetailId = slot8

				gohelper.setActive(slot11.go, true)

				slot3[slot10] = true
			end
		end
	end

	for slot7 = 1, #slot0._characteritems do
		gohelper.setActive(slot0._characteritems[slot7].go, slot3[slot7])
	end
end

function slot0._refreshCost(slot0)
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

function slot0.onSummonFailed(slot0)
	slot0.summonSuccess = false

	slot0:_refreshCost()
end

function slot0.onSummonReply(slot0)
	slot0.summonSuccess = true

	slot0:_refreshPreferentialInfo()
end

function slot0.onItemChanged(slot0)
	if SummonController.instance.isWaitingSummonResult or slot0.summonSuccess then
		return
	end

	slot0:_refreshCost()
end

return slot0
