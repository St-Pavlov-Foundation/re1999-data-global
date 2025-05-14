module("modules.logic.seasonver.act123.view1_8.Season123_1_8RetailView", package.seeall)

local var_0_0 = class("Season123_1_8RetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "bottom/#btn_start/#image_icon")
	arg_1_0._txtenemylevelnum = gohelper.findChildText(arg_1_0.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	arg_1_0._btncelebrity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	arg_1_0._btncards = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbtns/#go_cards/#btn_cards")
	arg_1_0._gocards = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_cards")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "rightbtns/#go_cards/#go_hasget")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_start")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem/#go_rewarditem")
	arg_1_0._txtlevelname = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_levelname")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "bottom/#btn_start/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncelebrity:AddClickListener(arg_2_0._btncelebrityOnClick, arg_2_0)
	arg_2_0._btncards:AddClickListener(arg_2_0._btncardsOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncelebrity:RemoveClickListener()
	arg_3_0._btncards:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtcardPackageNum = gohelper.findChildText(arg_4_0.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	arg_4_0._rewardItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	Season123RetailController.instance:onCloseView()

	if arg_5_0._rewardItems then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._rewardItems) do
			iter_5_1.btnrewardicon:RemoveClickListener()
		end

		arg_5_0._rewardItems = nil
	end

	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, false)
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.actId

	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0.handleItemChanged, arg_6_0)
	arg_6_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_6_0.handleItemChanged, arg_6_0)
	Season123RetailController.instance:onOpenView(var_6_0)

	local var_6_1 = ActivityModel.instance:getActMO(var_6_0)

	if not var_6_1 or not var_6_1:isOpen() or var_6_1:isExpired() then
		return
	end

	arg_6_0:initIconUI()
	arg_6_0:refreshUI()
	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, true)
	Season123Controller.instance:dispatchEvent(Season123Event.SwitchRetailPrefab, Season123RetailModel.instance.retailId)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshInfo()
	arg_8_0:refreshCardPackageUI()
	arg_8_0:refreshRecommendLv()
	arg_8_0:refreshRewards()
	arg_8_0:refreshTicket()
end

function var_0_0.refreshInfo(arg_9_0)
	local var_9_0 = Season123RetailModel.instance.retailCO

	if var_9_0 then
		arg_9_0._txtlevelname.text = tostring(var_9_0.desc)
	end
end

function var_0_0.initIconUI(arg_10_0)
	arg_10_0.viewContainer:refreshCurrencyType()

	local var_10_0 = Season123RetailModel.instance.activityId
	local var_10_1 = Season123Config.instance:getEquipItemCoin(var_10_0, Activity123Enum.Const.UttuTicketsCoin)

	if var_10_1 then
		local var_10_2 = CurrencyConfig.instance:getCurrencyCo(var_10_1)

		if not var_10_2 then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_10_0._imageicon, tostring(var_10_2.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(var_10_0))
	end
end

function var_0_0.refreshRecommendLv(arg_11_0)
	local var_11_0 = Season123RetailModel.instance:getRecommentLevel()

	if var_11_0 then
		arg_11_0._txtenemylevelnum.text = HeroConfig.instance:getLevelDisplayVariant(var_11_0)
	else
		arg_11_0._txtenemylevelnum.text = luaLang("common_none")
	end
end

function var_0_0.refreshRewards(arg_12_0)
	local var_12_0 = Season123RetailModel.instance.rewardIcons

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0:getOrCreateRewardItem(iter_12_0)

		gohelper.setActive(var_12_1.go, true)

		if not string.nilorempty(iter_12_1) then
			var_12_1.simageicon:LoadImage(iter_12_1)
		end
	end

	if #arg_12_0._rewardItems > #var_12_0 then
		for iter_12_2 = #var_12_0, #arg_12_0._rewardItems do
			gohelper.setActive(arg_12_0._rewardItems[iter_12_2].go, false)
		end
	end
end

function var_0_0.refreshCardPackageUI(arg_13_0)
	local var_13_0 = Season123CardPackageModel.instance.packageCount

	arg_13_0._gocards:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_13_0 == 0 and 0.5 or 1
	arg_13_0._txtcardPackageNum.text = var_13_0

	gohelper.setActive(arg_13_0._gohasget, var_13_0 > 0)
end

function var_0_0.getOrCreateRewardItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._rewardItems[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._gorewarditem, "item" .. tostring(arg_14_1))
		var_14_0.simageicon = gohelper.findChildSingleImage(var_14_0.go, "#simage_rewardicon")
		var_14_0.btnrewardicon = gohelper.findChildButtonWithAudio(var_14_0.go, "#btn_rewardicon")

		var_14_0.btnrewardicon:AddClickListener(arg_14_0.onClickIcon, arg_14_0, arg_14_1)

		var_14_0.txtrare = gohelper.findChildText(var_14_0.go, "rare/#go_rare1/txt")
		var_14_0.txtrare.text = luaLang("dungeon_prob_flag1")
		arg_14_0._rewardItems[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.refreshTicket(arg_15_0)
	local var_15_0 = Season123RetailModel.instance:getUTTUTicketNum()

	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtcostnum, var_15_0 <= 0 and "#800015" or "#070706")
end

function var_0_0.handleItemChanged(arg_16_0)
	arg_16_0:refreshCardPackageUI()
	arg_16_0:refreshTicket()
end

function var_0_0._btncelebrityOnClick(arg_17_0)
	Season123Controller.instance:openSeasonEquipBookView(arg_17_0.viewParam.actId)
end

function var_0_0._btncardsOnClick(arg_18_0)
	Season123Controller.instance:openSeasonCardPackageView({
		actId = arg_18_0.viewParam.actId
	})
end

function var_0_0.onClickIcon(arg_19_0, arg_19_1)
	local var_19_0 = Season123RetailModel.instance.rewardIconCfgs[arg_19_1]

	if var_19_0 then
		MaterialTipController.instance:showMaterialInfo(var_19_0[1], var_19_0[2])
	end
end

function var_0_0._btnstartOnClick(arg_20_0)
	Season123RetailController.instance:enterRetailFightScene()
end

return var_0_0
