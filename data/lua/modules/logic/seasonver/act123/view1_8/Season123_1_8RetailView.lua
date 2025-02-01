module("modules.logic.seasonver.act123.view1_8.Season123_1_8RetailView", package.seeall)

slot0 = class("Season123_1_8RetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "bottom/#btn_start/#image_icon")
	slot0._txtenemylevelnum = gohelper.findChildText(slot0.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	slot0._btncelebrity = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	slot0._btncards = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtns/#go_cards/#btn_cards")
	slot0._gocards = gohelper.findChild(slot0.viewGO, "rightbtns/#go_cards")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "rightbtns/#go_cards/#go_hasget")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_start")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem/#go_rewarditem")
	slot0._txtlevelname = gohelper.findChildText(slot0.viewGO, "bottom/#txt_levelname")
	slot0._txtcostnum = gohelper.findChildText(slot0.viewGO, "bottom/#btn_start/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncelebrity:AddClickListener(slot0._btncelebrityOnClick, slot0)
	slot0._btncards:AddClickListener(slot0._btncardsOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncelebrity:RemoveClickListener()
	slot0._btncards:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._txtcardPackageNum = gohelper.findChildText(slot0.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	slot0._rewardItems = {}
end

function slot0.onDestroyView(slot0)
	Season123RetailController.instance:onCloseView()

	if slot0._rewardItems then
		for slot4, slot5 in ipairs(slot0._rewardItems) do
			slot5.btnrewardicon:RemoveClickListener()
		end

		slot0._rewardItems = nil
	end

	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, false)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.actId

	slot0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.handleItemChanged, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.handleItemChanged, slot0)
	Season123RetailController.instance:onOpenView(slot1)

	if not ActivityModel.instance:getActMO(slot1) or not slot2:isOpen() or slot2:isExpired() then
		return
	end

	slot0:initIconUI()
	slot0:refreshUI()
	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, true)
	Season123Controller.instance:dispatchEvent(Season123Event.SwitchRetailPrefab, Season123RetailModel.instance.retailId)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshInfo()
	slot0:refreshCardPackageUI()
	slot0:refreshRecommendLv()
	slot0:refreshRewards()
	slot0:refreshTicket()
end

function slot0.refreshInfo(slot0)
	if Season123RetailModel.instance.retailCO then
		slot0._txtlevelname.text = tostring(slot1.desc)
	end
end

function slot0.initIconUI(slot0)
	slot0.viewContainer:refreshCurrencyType()

	if Season123Config.instance:getEquipItemCoin(Season123RetailModel.instance.activityId, Activity123Enum.Const.UttuTicketsCoin) then
		if not CurrencyConfig.instance:getCurrencyCo(slot2) then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageicon, tostring(slot3.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(slot1))
	end
end

function slot0.refreshRecommendLv(slot0)
	if Season123RetailModel.instance:getRecommentLevel() then
		slot0._txtenemylevelnum.text = HeroConfig.instance:getLevelDisplayVariant(slot1)
	else
		slot0._txtenemylevelnum.text = luaLang("common_none")
	end
end

function slot0.refreshRewards(slot0)
	for slot5, slot6 in ipairs(Season123RetailModel.instance.rewardIcons) do
		gohelper.setActive(slot0:getOrCreateRewardItem(slot5).go, true)

		if not string.nilorempty(slot6) then
			slot7.simageicon:LoadImage(slot6)
		end
	end

	if #slot0._rewardItems > #slot1 then
		for slot5 = #slot1, #slot0._rewardItems do
			gohelper.setActive(slot0._rewardItems[slot5].go, false)
		end
	end
end

function slot0.refreshCardPackageUI(slot0)
	slot0._gocards:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = Season123CardPackageModel.instance.packageCount == 0 and 0.5 or 1
	slot0._txtcardPackageNum.text = slot1

	gohelper.setActive(slot0._gohasget, slot1 > 0)
end

function slot0.getOrCreateRewardItem(slot0, slot1)
	if not slot0._rewardItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gorewarditem, "item" .. tostring(slot1))
		slot2.simageicon = gohelper.findChildSingleImage(slot2.go, "#simage_rewardicon")
		slot2.btnrewardicon = gohelper.findChildButtonWithAudio(slot2.go, "#btn_rewardicon")

		slot2.btnrewardicon:AddClickListener(slot0.onClickIcon, slot0, slot1)

		slot2.txtrare = gohelper.findChildText(slot2.go, "rare/#go_rare1/txt")
		slot2.txtrare.text = luaLang("dungeon_prob_flag1")
		slot0._rewardItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshTicket(slot0)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcostnum, Season123RetailModel.instance:getUTTUTicketNum() <= 0 and "#800015" or "#070706")
end

function slot0.handleItemChanged(slot0)
	slot0:refreshCardPackageUI()
	slot0:refreshTicket()
end

function slot0._btncelebrityOnClick(slot0)
	Season123Controller.instance:openSeasonEquipBookView(slot0.viewParam.actId)
end

function slot0._btncardsOnClick(slot0)
	Season123Controller.instance:openSeasonCardPackageView({
		actId = slot0.viewParam.actId
	})
end

function slot0.onClickIcon(slot0, slot1)
	if Season123RetailModel.instance.rewardIconCfgs[slot1] then
		MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])
	end
end

function slot0._btnstartOnClick(slot0)
	Season123RetailController.instance:enterRetailFightScene()
end

return slot0
