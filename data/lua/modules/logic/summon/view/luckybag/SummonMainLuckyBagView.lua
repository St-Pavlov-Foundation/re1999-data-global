module("modules.logic.summon.view.luckybag.SummonMainLuckyBagView", package.seeall)

local var_0_0 = class("SummonMainLuckyBagView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._gocharacteritem1 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem1")
	arg_1_0._gocharacteritem2 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/current/right/#go_characteritem2")
	arg_1_0._btnsummon1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	arg_1_0._simagecurrency1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	arg_1_0._txtcurrency11 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	arg_1_0._txtcurrency12 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	arg_1_0._gosummon10 = gohelper.findChild(arg_1_0.viewGO, "#go_ui/summonbtns/summon10")
	arg_1_0._btnsummon10 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	arg_1_0._simagecurrency10 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	arg_1_0._txtcurrency101 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	arg_1_0._txtcurrency102 = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	arg_1_0._gopageitem = gohelper.findChild(arg_1_0.viewGO, "#go_ui/pageicon/#go_pageitem")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_lefttop")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_righttop")
	arg_1_0._gosummonbtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/summonbtns")
	arg_1_0._goluckybagbtns = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_luckybagopen")
	arg_1_0._goluckbagbtn = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag")
	arg_1_0._btnluckybagbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#btn_openluckbag")
	arg_1_0._goalreadyinvited = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/#go_alreadyinvited")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_remaintimes/bg/#txt_times")
	arg_1_0._simageluckybag = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/btnopenluckbag/#simage_jinfangjie")
	arg_1_0._goremaintimes = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_remaintimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnluckybagbtn:AddClickListener(arg_2_0._btnopenluckbagOnClick, arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnluckybagbtn:RemoveClickListener()
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_fullbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role2.png"
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._luckyBagCount = 2
	arg_4_0._pageitems = {}
	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_4_0._rectremaintimes = arg_4_0._goremaintimes.transform

	arg_4_0:initSingleBg()
	arg_4_0:initLuckyBagComp()
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0 = 1, arg_5_0._luckyBagCount do
		local var_5_0 = arg_5_0:getLuckyBagDetailBtn(iter_5_0)

		if var_5_0 then
			var_5_0:RemoveClickListener()
		end

		arg_5_0["_simagerole" .. tostring(iter_5_0)]:UnLoadImage()
		arg_5_0["_simageshowicon" .. tostring(iter_5_0)]:UnLoadImage()
	end

	arg_5_0._simagecurrency1:UnLoadImage()
	arg_5_0._simagecurrency10:UnLoadImage()
	arg_5_0._simageline:UnLoadImage()

	if arg_5_0._compFreeButton then
		arg_5_0._compFreeButton:dispose()

		arg_5_0._compFreeButton = nil
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	logNormal("SummonMainLuckyBagView:onOpen()")
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_7_0.onSummonFailed, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_7_0.onSummonReply, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_7_0.playerEnterAnimFromScene, arg_7_0)
	arg_7_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_7_0.onItemChanged, arg_7_0)
	arg_7_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_7_0.onItemChanged, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_7_0.refreshView, arg_7_0)
	arg_7_0:addEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_7_0._refreshOpenTime, arg_7_0)
	arg_7_0:playEnterAnim()
	arg_7_0:refreshView()
	arg_7_0:checkAutoOpenLuckyBag()
	SummonController.instance:dispatchEvent(SummonEvent.LuckyBagViewOpen)
end

function var_0_0.playEnterAnim(arg_8_0)
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		arg_8_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		arg_8_0._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function var_0_0.playerEnterAnimFromScene(arg_9_0)
	arg_9_0._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function var_0_0.checkAutoOpenLuckyBag(arg_10_0)
	local var_10_0 = SummonMainModel.instance:getCurPool()

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0.id
	local var_10_2, var_10_3 = SummonLuckyBagModel.instance:isLuckyBagGot(var_10_1)

	if var_10_2 and not SummonLuckyBagModel.instance:isLuckyBagOpened(var_10_1, var_10_3) and SummonLuckyBagModel.instance:needAutoPopup(var_10_1) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = var_10_1,
			luckyBagId = var_10_3
		})
		SummonLuckyBagModel.instance:recordAutoPopup(var_10_1)
	end
end

function var_0_0.onClose(arg_11_0)
	logNormal("SummonMainLuckyBagView:onClose()")
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_11_0.onSummonFailed, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_11_0.onSummonReply, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_11_0.playerEnterAnimFromScene, arg_11_0)
	arg_11_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0.onItemChanged, arg_11_0)
	arg_11_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0.onItemChanged, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_11_0.refreshView, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_11_0._refreshOpenTime, arg_11_0)
end

function var_0_0.initSingleBg(arg_12_0)
	for iter_12_0 = 1, arg_12_0._luckyBagCount do
		arg_12_0["_simagerole" .. tostring(iter_12_0)] = gohelper.findChildSingleImage(arg_12_0.viewGO, "#go_ui/current/#simage_role" .. tostring(iter_12_0))
		arg_12_0["_simageshowicon" .. tostring(iter_12_0)] = gohelper.findChildSingleImage(arg_12_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1", iter_12_0))
	end
end

function var_0_0.initLuckyBagComp(arg_13_0)
	for iter_13_0 = 1, arg_13_0._luckyBagCount do
		local var_13_0 = "_btnluckybag" .. tostring(iter_13_0)
		local var_13_1 = gohelper.findChildButtonWithAudio(arg_13_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/btn_detail", iter_13_0))

		if var_13_1 then
			arg_13_0[var_13_0] = var_13_1

			var_13_1:AddClickListener(var_0_0.onClickLuckyBagDetail, arg_13_0, iter_13_0)
		end

		local var_13_2 = "_txtName" .. tostring(iter_13_0)
		local var_13_3 = "_gogotvfx" .. tostring(iter_13_0)
		local var_13_4 = "_gogotimage" .. tostring(iter_13_0)

		arg_13_0[var_13_2] = gohelper.findChildText(arg_13_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/txt1", iter_13_0))
		arg_13_0[var_13_3] = gohelper.findChild(arg_13_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1_glow", iter_13_0))
		arg_13_0[var_13_4] = gohelper.findChild(arg_13_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget", iter_13_0))
	end
end

function var_0_0._btnopenluckbagOnClick(arg_14_0)
	local var_14_0 = SummonMainModel.instance:getCurPool()

	if not var_14_0 then
		return
	end

	local var_14_1, var_14_2 = SummonLuckyBagModel.instance:isLuckyBagGot(var_14_0.id)

	if var_14_1 and not SummonLuckyBagModel.instance:isLuckyBagOpened(var_14_0.id, var_14_2) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = var_14_0.id,
			luckyBagId = var_14_2
		})
	end
end

function var_0_0._btnsummon1OnClick(arg_15_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 then
		return
	end

	local var_15_1, var_15_2, var_15_3 = SummonMainModel.getCostByConfig(var_15_0.cost1)
	local var_15_4 = {
		type = var_15_1,
		id = var_15_2,
		quantity = var_15_3,
		callback = arg_15_0._summon1Confirm,
		callbackObj = arg_15_0
	}

	var_15_4.notEnough = false

	local var_15_5 = var_15_3 <= ItemModel.instance:getItemQuantity(var_15_1, var_15_2)
	local var_15_6 = SummonMainModel.instance.everyCostCount
	local var_15_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_15_5 and var_15_7 < var_15_6 then
		var_15_4.notEnough = true
	end

	if var_15_5 then
		var_15_4.needTransform = false

		arg_15_0:_summon1Confirm()

		return
	else
		var_15_4.needTransform = true
		var_15_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_15_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_15_4.cost_quantity = var_15_6
		var_15_4.miss_quantity = 1
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_15_4)
end

function var_0_0._btnsummon10OnClick(arg_16_0)
	if not arg_16_0:checkRemainTimesEnough10() then
		return
	end

	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	local var_16_1, var_16_2, var_16_3 = SummonMainModel.getCostByConfig(var_16_0.cost10)
	local var_16_4 = {
		type = var_16_1,
		id = var_16_2,
		quantity = var_16_3,
		callback = arg_16_0._summon10Confirm,
		callbackObj = arg_16_0
	}

	var_16_4.notEnough = false

	local var_16_5 = ItemModel.instance:getItemQuantity(var_16_1, var_16_2)
	local var_16_6 = var_16_3 <= var_16_5
	local var_16_7 = SummonMainModel.instance.everyCostCount
	local var_16_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_16_9 = 10 - var_16_5
	local var_16_10 = var_16_7 * var_16_9

	if not var_16_6 and var_16_8 < var_16_10 then
		var_16_4.notEnough = true
	end

	if var_16_6 then
		var_16_4.needTransform = false

		arg_16_0:_summon10Confirm()

		return
	else
		var_16_4.needTransform = true
		var_16_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_16_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_16_4.cost_quantity = var_16_10
		var_16_4.miss_quantity = var_16_9
	end

	ViewMgr.instance:openView(ViewName.SummonConfirmView, var_16_4)
end

function var_0_0._summon10Confirm(arg_17_0)
	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_17_0.id, 10, false, true)
end

function var_0_0.checkRemainTimesEnough10(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if var_18_0 then
		if SummonLuckyBagModel.instance:getGachaRemainTimes(var_18_0.id) >= 10 then
			return true
		else
			GameFacade.showToast(ToastEnum.SummonLuckyBagLessThanSummon10)

			return false
		end
	end
end

function var_0_0._summon1Confirm(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if not var_19_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_19_0.id, 1, false, true)
end

function var_0_0.onClickLuckyBagDetail(arg_20_0, arg_20_1)
	local var_20_0 = SummonMainModel.instance:getCurPool()

	if not var_20_0 then
		return
	end

	local var_20_1 = SummonConfig.instance:getSummonLuckyBag(var_20_0.id)

	if not var_20_1 then
		return
	end

	local var_20_2 = var_20_1[arg_20_1]

	if var_20_2 then
		SummonMainController.instance:openSummonDetail(var_20_0, var_20_2)
	end
end

function var_0_0.refreshView(arg_21_0)
	arg_21_0.summonSuccess = false

	local var_21_0 = SummonMainModel.instance:getList()

	if not var_21_0 or #var_21_0 <= 0 then
		gohelper.setActive(arg_21_0._goui, false)

		return
	end

	arg_21_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_22_0)
	local var_22_0 = SummonMainModel.instance:getCurPool()

	if not var_22_0 then
		return
	end

	arg_22_0:refreshLuckyBagStatus(var_22_0)
	arg_22_0:refreshLuckyBagDetails(var_22_0)
	arg_22_0:_refreshOpenTime()
end

function var_0_0.refreshLuckyBagDetails(arg_23_0, arg_23_1)
	local var_23_0 = SummonConfig.instance:getSummonLuckyBag(arg_23_1.id)

	if var_23_0 and next(var_23_0) then
		local var_23_1 = #var_23_0

		for iter_23_0 = 1, arg_23_0._luckyBagCount do
			local var_23_2 = arg_23_0:getLuckyBagDetailBtn(iter_23_0)

			if var_23_2 ~= nil then
				gohelper.setActive(var_23_2, iter_23_0 <= var_23_1)
			end

			local var_23_3 = arg_23_0["_txtName" .. tostring(iter_23_0)]

			if var_23_3 ~= nil then
				gohelper.setActive(var_23_3, iter_23_0 <= var_23_1)

				if iter_23_0 <= var_23_1 then
					local var_23_4 = var_23_0[iter_23_0]

					var_23_3.text = SummonConfig.instance:getLuckyBag(arg_23_1.id, var_23_4).name
				end
			end
		end
	end
end

var_0_0.RemainTimesPosition = {
	NoLuckyBag = {
		x = -232.5,
		y = 113.9
	},
	ExistLuckyBag = {
		x = 140,
		y = 113.9
	}
}

function var_0_0.refreshLuckyBagStatus(arg_24_0, arg_24_1)
	local var_24_0, var_24_1 = SummonLuckyBagModel.instance:isLuckyBagGot(arg_24_1.id)

	gohelper.setActive(arg_24_0._goluckybagbtns, var_24_0)
	gohelper.setActive(arg_24_0._gosummonbtns, not var_24_0)

	if var_24_0 then
		arg_24_0:refreshGotStatus(arg_24_1, var_24_1)
	else
		arg_24_0:refreshGachaStatus(arg_24_1)
	end
end

function var_0_0.refreshGotStatus(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = SummonLuckyBagModel.instance:isLuckyBagOpened(arg_25_1.id, arg_25_2)

	gohelper.setActive(arg_25_0._goalreadyinvited, var_25_0)
	gohelper.setActive(arg_25_0._goluckbagbtn, not var_25_0)

	local var_25_1 = SummonConfig.instance:getLuckyBag(arg_25_1.id, arg_25_2)

	if var_25_1 then
		arg_25_0._simageluckybag:LoadImage(ResUrl.getSummonCoverBg(var_25_1.icon))
	end

	gohelper.setActive(arg_25_0._goremaintimes, not var_25_0)

	if not var_25_0 then
		local var_25_2 = var_0_0.RemainTimesPosition.ExistLuckyBag

		recthelper.setAnchor(arg_25_0._rectremaintimes, var_25_2.x, var_25_2.y)
		arg_25_0:refreshRemainTimes(arg_25_1)
	end

	local var_25_3 = SummonConfig.instance:getSummonLuckyBag(arg_25_1.id)

	if var_25_3 then
		arg_25_0:setLuckyBagIconVfx(tabletool.indexOf(var_25_3, arg_25_2))
	else
		arg_25_0:setLuckyBagIconVfx(-1)
	end
end

function var_0_0.refreshGachaStatus(arg_26_0, arg_26_1)
	arg_26_0:refreshCost()
	arg_26_0:refreshFreeSummonButton(arg_26_1)
	arg_26_0:setLuckyBagIconVfx(-1)

	local var_26_0 = var_0_0.RemainTimesPosition.NoLuckyBag

	recthelper.setAnchor(arg_26_0._rectremaintimes, var_26_0.x, var_26_0.y)
	arg_26_0:refreshRemainTimes(arg_26_1)
end

function var_0_0.setLuckyBagIconVfx(arg_27_0, arg_27_1)
	for iter_27_0 = 1, arg_27_0._luckyBagCount do
		local var_27_0 = "_gogotvfx" .. tostring(iter_27_0)
		local var_27_1 = "_gogotimage" .. tostring(iter_27_0)

		gohelper.setActive(arg_27_0[var_27_0], arg_27_1 == iter_27_0)
		gohelper.setActive(arg_27_0[var_27_1], arg_27_1 == iter_27_0)
	end
end

function var_0_0.refreshFreeSummonButton(arg_28_0, arg_28_1)
	arg_28_0._compFreeButton = arg_28_0._compFreeButton or SummonFreeSingleGacha.New(arg_28_0._btnsummon1.gameObject, arg_28_1.id)

	arg_28_0._compFreeButton:refreshUI()
end

function var_0_0.refreshRemainTimes(arg_29_0, arg_29_1)
	local var_29_0 = SummonConfig.getSummonSSRTimes(arg_29_1)
	local var_29_1 = SummonMainModel.instance:getPoolServerMO(arg_29_1.id)

	if var_29_1 and var_29_1.luckyBagMO then
		arg_29_0._txttimes.text = string.format("%s/%s", var_29_1.luckyBagMO.summonTimes, var_29_0)
	else
		arg_29_0._txttimes.text = "-"
	end
end

function var_0_0.refreshCost(arg_30_0)
	local var_30_0 = SummonMainModel.instance:getCurPool()

	if var_30_0 then
		arg_30_0:_refreshSingleCost(var_30_0.cost1, arg_30_0._simagecurrency1, "_txtcurrency1")

		local var_30_1 = SummonLuckyBagModel.instance:getGachaRemainTimes(var_30_0.id)

		if var_30_1 and var_30_1 >= 10 then
			ZProj.UGUIHelper.SetGrayscale(arg_30_0._btnsummon10.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(arg_30_0._simagecurrency10.gameObject, false)
		else
			ZProj.UGUIHelper.SetGrayscale(arg_30_0._btnsummon10.gameObject, true)
			ZProj.UGUIHelper.SetGrayscale(arg_30_0._simagecurrency10.gameObject, true)
		end

		arg_30_0:_refreshSingleCost(var_30_0.cost10, arg_30_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0, var_31_1, var_31_2 = SummonMainModel.getCostByConfig(arg_31_1)
	local var_31_3 = SummonMainModel.getSummonItemIcon(var_31_0, var_31_1)

	arg_31_2:LoadImage(var_31_3)

	local var_31_4

	var_31_4 = var_31_2 <= ItemModel.instance:getItemQuantity(var_31_0, var_31_1)
	arg_31_0[arg_31_3 .. "1"].text = luaLang("multiple") .. var_31_2
	arg_31_0[arg_31_3 .. "2"].text = ""
end

function var_0_0._refreshOpenTime(arg_32_0)
	local var_32_0 = SummonMainModel.instance:getCurPool()

	if not var_32_0 then
		return
	end

	local var_32_1 = SummonMainModel.instance:getPoolServerMO(var_32_0.id)

	if var_32_1 ~= nil and var_32_1.offlineTime ~= 0 and var_32_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_32_2 = var_32_1.offlineTime - ServerTime.now()

		arg_32_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_32_2))
	else
		arg_32_0._txtdeadline.text = ""
	end
end

function var_0_0.getLuckyBagDetailBtn(arg_33_0, arg_33_1)
	return arg_33_0["_btnluckybag" .. tostring(arg_33_1)]
end

function var_0_0.onSummonFailed(arg_34_0)
	arg_34_0.summonSuccess = false

	arg_34_0:refreshCost()
end

function var_0_0.onSummonReply(arg_35_0)
	arg_35_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_36_0)
	if SummonController.instance.isWaitingSummonResult or arg_36_0.summonSuccess then
		return
	end

	arg_36_0:refreshCost()
end

return var_0_0
