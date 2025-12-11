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
	arg_1_0._goalreadyinvited = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/#go_alreadyinvited")
	arg_1_0._goinvite = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_luckybagopen/#go_invite")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#txt_deadline")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/#go_remaintimes/bg/#txt_times")
	arg_1_0._goremaintimes = gohelper.findChild(arg_1_0.viewGO, "#go_ui/#go_remaintimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsummon1:AddClickListener(arg_2_0._btnsummon1OnClick, arg_2_0)
	arg_2_0._btnsummon10:AddClickListener(arg_2_0._btnsummon10OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsummon1:RemoveClickListener()
	arg_3_0._btnsummon10:RemoveClickListener()
end

var_0_0.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_fullbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role2.png"
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._pageitems = {}
	arg_4_0._animRoot = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	arg_4_0._rectremaintimes = arg_4_0._goremaintimes.transform

	arg_4_0:initData()
	arg_4_0:initSingleBg()
	arg_4_0:initLuckyBagComp()
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0 = 1, arg_5_0._luckyBagCount do
		local var_5_0 = arg_5_0:getLuckyBagDetailBtn(iter_5_0)

		if var_5_0 then
			var_5_0:RemoveClickListener()
		end

		local var_5_1 = arg_5_0:getLuckyBagUseBtn(iter_5_0)

		if var_5_1 then
			var_5_1:RemoveClickListener()
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
	local var_10_2 = SummonConfig.instance:getSummonLuckyBag(var_10_1)

	if var_10_2 and next(var_10_2) then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if SummonLuckyBagModel.instance:isLuckyBagGot(var_10_1, iter_10_1) and not SummonLuckyBagModel.instance:isLuckyBagOpened(var_10_1, iter_10_1) and SummonLuckyBagModel.instance:needAutoPopup(var_10_1, iter_10_1) then
				ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
					poolId = var_10_1,
					luckyBagId = iter_10_1
				})
				SummonLuckyBagModel.instance:recordAutoPopup(var_10_1, iter_10_1)

				break
			end
		end
	end
end

function var_0_0.onClose(arg_11_0)
	logNormal("SummonMainLuckyBagView:onClose()")
	arg_11_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0.onViewCloseFinish, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonFailed, arg_11_0.onSummonFailed, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonReply, arg_11_0.onSummonReply, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, arg_11_0.playerEnterAnimFromScene, arg_11_0)
	arg_11_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_11_0.onItemChanged, arg_11_0)
	arg_11_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0.onItemChanged, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_11_0.refreshView, arg_11_0)
	arg_11_0:removeEventCb(SummonController.instance, SummonEvent.onRemainTimeCountdown, arg_11_0._refreshOpenTime, arg_11_0)
end

function var_0_0.initData(arg_12_0)
	local var_12_0 = SummonMainModel.instance:getCurPool().id

	arg_12_0._luckyBagList = SummonConfig.instance:getSummonLuckyBag(var_12_0)
	arg_12_0._luckyBagCount = 2
	arg_12_0._luckyBagUseDic = {}
end

function var_0_0.initSingleBg(arg_13_0)
	for iter_13_0 = 1, arg_13_0._luckyBagCount do
		arg_13_0["_simagerole" .. tostring(iter_13_0)] = gohelper.findChildSingleImage(arg_13_0.viewGO, "#go_ui/current/#simage_role" .. tostring(iter_13_0))
		arg_13_0["_simageshowicon" .. tostring(iter_13_0)] = gohelper.findChildSingleImage(arg_13_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1", iter_13_0))
	end
end

function var_0_0.initLuckyBagComp(arg_14_0)
	for iter_14_0 = 1, arg_14_0._luckyBagCount do
		local var_14_0 = "_btnluckybag" .. tostring(iter_14_0)
		local var_14_1 = gohelper.findChildButtonWithAudio(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/btn_detail", iter_14_0))

		if var_14_1 then
			arg_14_0[var_14_0] = var_14_1

			var_14_1:AddClickListener(var_0_0.onClickLuckyBagDetail, arg_14_0, iter_14_0)
		end

		local var_14_2 = "_txtName" .. tostring(iter_14_0)
		local var_14_3 = "_gogotvfx" .. tostring(iter_14_0)
		local var_14_4 = "_gogotimage" .. tostring(iter_14_0)
		local var_14_5 = "_animatorGet" .. tostring(iter_14_0)
		local var_14_6 = "_reddot" .. tostring(iter_14_0)

		arg_14_0[var_14_2] = gohelper.findChildText(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/txt_bg/txt1", iter_14_0))
		arg_14_0[var_14_3] = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/vx_light", iter_14_0))
		arg_14_0[var_14_4] = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget", iter_14_0))
		arg_14_0[var_14_5] = gohelper.findChildComponent(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget/go_hasget", iter_14_0), gohelper.Type_Animator)

		local var_14_7 = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#go_reddot", iter_14_0))
		local var_14_8 = arg_14_0._luckyBagList[iter_14_0]

		arg_14_0[var_14_6] = RedDotController.instance:addRedDot(var_14_7, RedDotEnum.DotNode.V3a3SkinDiscountCompensate, var_14_8)

		local var_14_9 = gohelper.findChildButton(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/#btn_use", iter_14_0))

		if var_14_9 then
			arg_14_0["#btn_use" .. tostring(iter_14_0)] = var_14_9

			var_14_9:AddClickListener(var_0_0._btnopenluckbagOnClick, arg_14_0, iter_14_0)
		end

		local var_14_10 = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget/go_hasget", iter_14_0))

		if var_14_10 then
			arg_14_0["_gohasget" .. tostring(iter_14_0)] = var_14_10
		end

		local var_14_11 = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/bg_opened", iter_14_0))

		if var_14_11 then
			arg_14_0["_goopenbg" .. tostring(iter_14_0)] = var_14_11
		end

		local var_14_12 = gohelper.findChild(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/bg_unopen", iter_14_0))

		if var_14_12 then
			arg_14_0["_gonoopenbg" .. tostring(iter_14_0)] = var_14_12
		end

		local var_14_13 = gohelper.findChildImage(arg_14_0.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/icon_star", iter_14_0))

		if var_14_13 then
			arg_14_0["_iconstar" .. tostring(iter_14_0)] = var_14_13
		end
	end
end

function var_0_0._btnopenluckbagOnClick(arg_15_0, arg_15_1)
	local var_15_0 = SummonMainModel.instance:getCurPool()

	if not var_15_0 or not arg_15_0._luckyBagList then
		return
	end

	local var_15_1 = arg_15_0._luckyBagList[arg_15_1]

	if var_15_1 == nil then
		return
	end

	local var_15_2 = var_15_0.id

	if SummonLuckyBagModel.instance:isLuckyBagGot(var_15_2, var_15_1) and not SummonLuckyBagModel.instance:isLuckyBagOpened(var_15_2, var_15_1) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = var_15_2,
			luckyBagId = var_15_1
		})
	end
end

function var_0_0._btnsummon1OnClick(arg_16_0)
	if SummonController.instance:isInSummonGuide() then
		return
	end

	local var_16_0 = SummonMainModel.instance:getCurPool()

	if not var_16_0 then
		return
	end

	local var_16_1, var_16_2, var_16_3 = SummonMainModel.getCostByConfig(var_16_0.cost1)
	local var_16_4 = {
		type = var_16_1,
		id = var_16_2,
		quantity = var_16_3,
		callback = arg_16_0._summon1Confirm,
		callbackObj = arg_16_0
	}

	var_16_4.notEnough = false

	local var_16_5 = var_16_3 <= ItemModel.instance:getItemQuantity(var_16_1, var_16_2)
	local var_16_6 = SummonMainModel.instance.everyCostCount
	local var_16_7 = SummonMainModel.instance:getOwnCostCurrencyNum()

	if not var_16_5 and var_16_7 < var_16_6 then
		var_16_4.notEnough = true
	end

	if var_16_5 then
		var_16_4.needTransform = false

		arg_16_0:_summon1Confirm()

		return
	else
		var_16_4.needTransform = true
		var_16_4.cost_type = SummonMainModel.instance.costCurrencyType
		var_16_4.cost_id = SummonMainModel.instance.costCurrencyId
		var_16_4.cost_quantity = var_16_6
		var_16_4.miss_quantity = 1
	end

	SummonMainController.instance:openSummonConfirmView(var_16_4)
end

function var_0_0._btnsummon10OnClick(arg_17_0)
	if not arg_17_0:checkRemainTimesEnough10() then
		return
	end

	local var_17_0 = SummonMainModel.instance:getCurPool()

	if not var_17_0 then
		return
	end

	local var_17_1, var_17_2, var_17_3, var_17_4 = SummonMainModel.getCostByConfig(var_17_0.cost10)
	local var_17_5 = {
		type = var_17_1,
		id = var_17_2,
		quantity = var_17_3,
		callback = arg_17_0._summon10Confirm,
		callbackObj = arg_17_0
	}

	var_17_5.notEnough = false
	var_17_4 = var_17_4 or ItemModel.instance:getItemQuantity(var_17_1, var_17_2)

	local var_17_6 = var_17_3 <= var_17_4
	local var_17_7 = SummonMainModel.instance.everyCostCount
	local var_17_8 = SummonMainModel.instance:getOwnCostCurrencyNum()
	local var_17_9 = 10 - var_17_4
	local var_17_10 = var_17_7 * var_17_9

	if not var_17_6 and var_17_8 < var_17_10 then
		var_17_5.notEnough = true
	end

	if var_17_6 then
		var_17_5.needTransform = false

		arg_17_0:_summon10Confirm()

		return
	else
		var_17_5.needTransform = true
		var_17_5.cost_type = SummonMainModel.instance.costCurrencyType
		var_17_5.cost_id = SummonMainModel.instance.costCurrencyId
		var_17_5.cost_quantity = var_17_10
		var_17_5.miss_quantity = var_17_9
	end

	SummonMainController.instance:openSummonConfirmView(var_17_5)
end

function var_0_0._summon10Confirm(arg_18_0)
	local var_18_0 = SummonMainModel.instance:getCurPool()

	if not var_18_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_18_0.id, 10, false, true)
end

function var_0_0.checkRemainTimesEnough10(arg_19_0)
	local var_19_0 = SummonMainModel.instance:getCurPool()

	if var_19_0 then
		if SummonLuckyBagModel.instance:getGachaRemainTimes(var_19_0.id) >= 10 then
			return true
		else
			GameFacade.showToast(ToastEnum.SummonLuckyBagLessThanSummon10)

			return false
		end
	end
end

function var_0_0._summon1Confirm(arg_20_0)
	local var_20_0 = SummonMainModel.instance:getCurPool()

	if not var_20_0 then
		return
	end

	SummonMainController.instance:sendStartSummon(var_20_0.id, 1, false, true)
end

function var_0_0.onClickLuckyBagDetail(arg_21_0, arg_21_1)
	local var_21_0 = SummonMainModel.instance:getCurPool()

	if not var_21_0 then
		return
	end

	if not arg_21_0._luckyBagList then
		return
	end

	local var_21_1 = arg_21_0._luckyBagList[arg_21_1]

	if var_21_1 then
		SummonMainController.instance:openSummonDetail(var_21_0, var_21_1)
	end
end

function var_0_0.refreshView(arg_22_0)
	arg_22_0.summonSuccess = false

	local var_22_0 = SummonMainModel.instance:getList()

	if not var_22_0 or #var_22_0 <= 0 then
		gohelper.setActive(arg_22_0._goui, false)

		return
	end

	arg_22_0:refreshPoolUI()
end

function var_0_0.refreshPoolUI(arg_23_0)
	local var_23_0 = SummonMainModel.instance:getCurPool()

	if not var_23_0 then
		return
	end

	arg_23_0:refreshLuckyBagStatus(var_23_0)
	arg_23_0:refreshLuckyBagDetails(var_23_0)
	arg_23_0:_refreshOpenTime()
end

function var_0_0.refreshLuckyBagDetails(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._luckyBagList

	if var_24_0 and next(var_24_0) then
		local var_24_1 = #var_24_0

		for iter_24_0 = 1, arg_24_0._luckyBagCount do
			local var_24_2 = arg_24_0:getLuckyBagDetailBtn(iter_24_0)

			if var_24_2 ~= nil then
				gohelper.setActive(var_24_2, iter_24_0 <= var_24_1)
			end

			local var_24_3 = arg_24_0["_txtName" .. tostring(iter_24_0)]

			if var_24_3 ~= nil then
				gohelper.setActive(var_24_3, iter_24_0 <= var_24_1)

				if iter_24_0 <= var_24_1 then
					local var_24_4 = var_24_0[iter_24_0]

					var_24_3.text = SummonConfig.instance:getLuckyBag(arg_24_1.id, var_24_4).name
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

function var_0_0.refreshLuckyBagStatus(arg_25_0, arg_25_1)
	local var_25_0 = true

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._luckyBagList) do
		if not SummonLuckyBagModel.instance:isLuckyBagGot(arg_25_1.id, iter_25_1) then
			var_25_0 = false

			break
		end
	end

	gohelper.setActive(arg_25_0._goluckybagbtns, var_25_0)
	gohelper.setActive(arg_25_0._gosummonbtns, not var_25_0)
	arg_25_0:setLuckyBagIconVfx()

	if var_25_0 then
		arg_25_0:refreshGotStatus(arg_25_1)
	else
		arg_25_0:refreshGachaStatus(arg_25_1)
	end
end

function var_0_0.refreshGotStatus(arg_26_0, arg_26_1)
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._luckyBagList) do
		if SummonLuckyBagModel.instance:isLuckyBagOpened(arg_26_1.id, iter_26_1) then
			var_26_0 = var_26_0 + 1
		end
	end

	local var_26_1 = SummonLuckyBagModel.instance:getLuckyGodCount(arg_26_1.id)
	local var_26_2 = #arg_26_0._luckyBagList
	local var_26_3 = var_26_2 <= var_26_1
	local var_26_4 = var_26_2 <= var_26_0

	gohelper.setActive(arg_26_0._goalreadyinvited, var_26_4)
	gohelper.setActive(arg_26_0._goinvite, not var_26_4)
	gohelper.setActive(arg_26_0._goremaintimes, not var_26_3)

	if not var_26_3 then
		local var_26_5 = var_0_0.RemainTimesPosition.ExistLuckyBag

		recthelper.setAnchor(arg_26_0._rectremaintimes, var_26_5.x, var_26_5.y)
		arg_26_0:refreshRemainTimes(arg_26_1)
	end
end

function var_0_0.refreshGachaStatus(arg_27_0, arg_27_1)
	arg_27_0:refreshCost()
	arg_27_0:refreshFreeSummonButton(arg_27_1)

	local var_27_0 = var_0_0.RemainTimesPosition.NoLuckyBag

	recthelper.setAnchor(arg_27_0._rectremaintimes, var_27_0.x, var_27_0.y)
	arg_27_0:refreshRemainTimes(arg_27_1)
end

function var_0_0.setLuckyBagIconVfx(arg_28_0)
	local var_28_0 = SummonMainModel.instance:getCurPool().id
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._luckyBagList) do
		local var_28_2 = "_gogotvfx" .. tostring(iter_28_0)
		local var_28_3 = "_gogotimage" .. tostring(iter_28_0)
		local var_28_4 = SummonLuckyBagModel.instance:isLuckyBagOpened(var_28_0, iter_28_1)
		local var_28_5 = SummonLuckyBagModel.instance:isLuckyBagGot(var_28_0, iter_28_1)
		local var_28_6 = arg_28_0[var_28_2]

		gohelper.setActive(var_28_6, var_28_5 and not var_28_4)
		gohelper.setActive(arg_28_0[var_28_3], true)

		local var_28_7 = arg_28_0:getLuckyBagHaveGetGo(iter_28_0)
		local var_28_8 = arg_28_0:getLuckyBagUseBtn(iter_28_0)

		gohelper.setActive(var_28_7, var_28_5 and var_28_4)
		gohelper.setActive(var_28_8, var_28_5 and not var_28_4)

		local var_28_9 = arg_28_0["_goopenbg" .. tostring(iter_28_0)]
		local var_28_10 = arg_28_0["_gonoopenbg" .. tostring(iter_28_0)]
		local var_28_11 = arg_28_0["_iconstar" .. tostring(iter_28_0)]

		gohelper.setActive(var_28_9, var_28_4)
		gohelper.setActive(var_28_10, not var_28_4)

		local var_28_12

		var_28_12.a, var_28_12 = not var_28_4 and 1 or 0.5, var_28_11.color
		var_28_11.color = var_28_12

		local var_28_13 = {
			time = 0,
			id = iter_28_1,
			value = var_28_5 and not var_28_4 and 1 or 0
		}

		table.insert(var_28_1, var_28_13)

		if not var_28_4 or not var_28_5 then
			arg_28_0._luckyBagUseDic[iter_28_0] = 0
		end

		if var_28_4 and var_28_5 then
			local var_28_14 = arg_28_0["_animatorGet" .. tostring(iter_28_0)]

			if var_28_14 then
				if arg_28_0._luckyBagUseDic[iter_28_0] ~= nil and arg_28_0._luckyBagUseDic[iter_28_0] == 0 then
					arg_28_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_28_0.onViewCloseFinish, arg_28_0)
					arg_28_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_28_0.onViewCloseFinish, arg_28_0)
				else
					var_28_14:Play("go_hasget_idle", 0, 0)
				end
			end
		end
	end

	local var_28_15 = {
		replaceAll = true,
		defineId = RedDotEnum.DotNode.V3a3SkinDiscountCompensate,
		infos = var_28_1
	}
	local var_28_16 = {
		var_28_15
	}

	RedDotModel.instance:setRedDotInfo(var_28_16)

	local var_28_17 = {}
	local var_28_18 = RedDotModel.instance:_getAssociateRedDots(RedDotEnum.DotNode.V3a3SkinDiscountCompensate)

	for iter_28_2, iter_28_3 in pairs(var_28_18) do
		var_28_17[iter_28_3] = true
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_28_17)
end

function var_0_0.onViewCloseFinish(arg_29_0, arg_29_1)
	if arg_29_1 == ViewName.CharacterGetView then
		local var_29_0 = SummonMainModel.instance:getCurPool().id

		arg_29_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_29_0.onViewCloseFinish, arg_29_0)

		for iter_29_0, iter_29_1 in ipairs(arg_29_0._luckyBagList) do
			local var_29_1 = SummonLuckyBagModel.instance:isLuckyBagOpened(var_29_0, iter_29_1)
			local var_29_2 = SummonLuckyBagModel.instance:isLuckyBagGot(var_29_0, iter_29_1)

			if var_29_1 and var_29_2 then
				local var_29_3 = arg_29_0["_animatorGet" .. tostring(iter_29_0)]

				if var_29_3 then
					if arg_29_0._luckyBagUseDic[iter_29_0] ~= nil and arg_29_0._luckyBagUseDic[iter_29_0] == 0 then
						arg_29_0._luckyBagUseDic[iter_29_0] = 1

						var_29_3:Play("go_hasget_in", 0, 0)
					else
						var_29_3:Play("go_hasget_idle", 0, 0)
					end
				end
			end
		end
	end
end

function var_0_0.refreshFreeSummonButton(arg_30_0, arg_30_1)
	arg_30_0._compFreeButton = arg_30_0._compFreeButton or SummonFreeSingleGacha.New(arg_30_0._btnsummon1.gameObject, arg_30_1.id)

	arg_30_0._compFreeButton:refreshUI()
end

function var_0_0.refreshRemainTimes(arg_31_0, arg_31_1)
	local var_31_0 = SummonConfig.getSummonSSRTimes(arg_31_1)
	local var_31_1 = SummonMainModel.instance:getPoolServerMO(arg_31_1.id)

	if var_31_1 and var_31_1.luckyBagMO then
		local var_31_2 = luaLang("summonluckybag_remain_count")
		local var_31_3 = math.max(0, var_31_0 - var_31_1.luckyBagMO.notSSRCount)

		arg_31_0._txttimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_31_2, var_31_3)
	else
		arg_31_0._txttimes.text = "-"
	end
end

function var_0_0.refreshCost(arg_32_0)
	local var_32_0 = SummonMainModel.instance:getCurPool()

	if var_32_0 then
		arg_32_0:_refreshSingleCost(var_32_0.cost1, arg_32_0._simagecurrency1, "_txtcurrency1")

		local var_32_1 = SummonLuckyBagModel.instance:getGachaRemainTimes(var_32_0.id)

		if var_32_1 and var_32_1 >= 10 then
			ZProj.UGUIHelper.SetGrayscale(arg_32_0._btnsummon10.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(arg_32_0._simagecurrency10.gameObject, false)
		else
			ZProj.UGUIHelper.SetGrayscale(arg_32_0._btnsummon10.gameObject, true)
			ZProj.UGUIHelper.SetGrayscale(arg_32_0._simagecurrency10.gameObject, true)
		end

		arg_32_0:_refreshSingleCost(var_32_0.cost10, arg_32_0._simagecurrency10, "_txtcurrency10")
	end
end

function var_0_0._refreshSingleCost(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0, var_33_1, var_33_2 = SummonMainModel.getCostByConfig(arg_33_1, true)
	local var_33_3 = SummonMainModel.getSummonItemIcon(var_33_0, var_33_1)

	arg_33_2:LoadImage(var_33_3)

	local var_33_4

	var_33_4 = var_33_2 <= ItemModel.instance:getItemQuantity(var_33_0, var_33_1)
	arg_33_0[arg_33_3 .. "1"].text = luaLang("multiple") .. var_33_2
	arg_33_0[arg_33_3 .. "2"].text = ""
end

function var_0_0._refreshOpenTime(arg_34_0)
	local var_34_0 = SummonMainModel.instance:getCurPool()

	if not var_34_0 then
		return
	end

	local var_34_1 = SummonMainModel.instance:getPoolServerMO(var_34_0.id)

	if var_34_1 ~= nil and var_34_1.offlineTime ~= 0 and var_34_1.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_34_2 = var_34_1.offlineTime - ServerTime.now()

		arg_34_0._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(var_34_2))
	else
		arg_34_0._txtdeadline.text = ""
	end
end

function var_0_0.getLuckyBagDetailBtn(arg_35_0, arg_35_1)
	return arg_35_0["_btnluckybag" .. tostring(arg_35_1)]
end

function var_0_0.getLuckyBagUseBtn(arg_36_0, arg_36_1)
	return arg_36_0["#btn_use" .. tostring(arg_36_1)]
end

function var_0_0.getLuckyBagHaveGetGo(arg_37_0, arg_37_1)
	return arg_37_0["_gohasget" .. tostring(arg_37_1)]
end

function var_0_0.onSummonFailed(arg_38_0)
	arg_38_0.summonSuccess = false

	arg_38_0:refreshCost()
end

function var_0_0.onSummonReply(arg_39_0)
	arg_39_0.summonSuccess = true
end

function var_0_0.onItemChanged(arg_40_0)
	if SummonController.instance.isWaitingSummonResult or arg_40_0.summonSuccess then
		return
	end

	arg_40_0:refreshCost()
end

return var_0_0
