module("modules.logic.versionactivity1_4.act129.view.Activity129RewardView", package.seeall)

local var_0_0 = class("Activity129RewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRewards = gohelper.findChild(arg_1_0.viewGO, "#go_Rewards")
	arg_1_0.goRewardItem = gohelper.findChild(arg_1_0.goRewards, "#scroll_RewardList/Viewport/Content/#go_RewardItem")
	arg_1_0.goBuy = gohelper.findChild(arg_1_0.viewGO, "#go_Rewards/Buy")
	arg_1_0.inputValue = gohelper.findChildTextMeshInputField(arg_1_0.goBuy, "ValueBG/#input_Value")
	arg_1_0.txtCost = gohelper.findChildTextMesh(arg_1_0.goBuy, "#btn_Buy/#txt_Cost")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.goBuy, "#btn_Buy/#simage_CostIcon")
	arg_1_0.txtBuy = gohelper.findChildTextMesh(arg_1_0.goBuy, "#btn_Buy/txt_Buy")
	arg_1_0.imgBuy = gohelper.findChildImage(arg_1_0.goBuy, "#btn_Buy")
	arg_1_0.btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.goBuy, "#btn_Buy")
	arg_1_0.btnMax = gohelper.findChildButtonWithAudio(arg_1_0.goBuy, "#btn_Max")
	arg_1_0.btnMin = gohelper.findChildButtonWithAudio(arg_1_0.goBuy, "#btn_Min")
	arg_1_0.goAdd = gohelper.findChild(arg_1_0.goBuy, "#btn_Add")
	arg_1_0.goSub = gohelper.findChild(arg_1_0.goBuy, "#btn_Sub")
	arg_1_0.maxDisable = gohelper.findChild(arg_1_0.goBuy, "#btn_Max/image_Disable")
	arg_1_0.minDisable = gohelper.findChild(arg_1_0.goBuy, "#btn_Min/image_Disable")
	arg_1_0.goBack = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0.goCurreny = gohelper.findChild(arg_1_0.viewGO, "#go_CurrenyBar")
	arg_1_0.txtTitleEn = gohelper.findChildTextMesh(arg_1_0.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitleEn")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.goRewards, "RewardTitle/image_RewardTitleBG/txt_RewardTitle")
	arg_1_0.anim = arg_1_0.goRewards:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.inputValue:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBuy, arg_2_0.onClickBuy, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMax, arg_2_0.onClickMax, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMin, arg_2_0.onClickMin, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_2_0.onEnterPool, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnLotterySuccess, arg_2_0.onLotterySuccess, arg_2_0)
	arg_2_0:addEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, arg_2_0.onLotteryEnd, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)

	local var_2_0 = {}

	var_2_0[1] = 0.5

	for iter_2_0 = 2, 10 do
		local var_2_1 = 0.7 * var_2_0[iter_2_0 - 1]
		local var_2_2 = math.max(var_2_1, 0.1)

		table.insert(var_2_0, var_2_2)
	end

	arg_2_0._subPress = SLFramework.UGUI.UILongPressListener.Get(arg_2_0.goSub)

	arg_2_0._subPress:SetLongPressTime(var_2_0)
	arg_2_0._subPress:AddLongPressListener(arg_2_0._subLongPressTimeEnd, arg_2_0)

	arg_2_0._subClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0.goSub)

	arg_2_0._subClick:AddClickListener(arg_2_0.onClickSub, arg_2_0)
	arg_2_0._subClick:AddClickUpListener(arg_2_0._subClickUp, arg_2_0)

	arg_2_0._addPress = SLFramework.UGUI.UILongPressListener.Get(arg_2_0.goAdd)

	arg_2_0._addPress:SetLongPressTime(var_2_0)
	arg_2_0._addPress:AddLongPressListener(arg_2_0._addLongPressTimeEnd, arg_2_0)

	arg_2_0._addClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0.goAdd)

	arg_2_0._addClick:AddClickListener(arg_2_0.onClickAdd, arg_2_0)
	arg_2_0._addClick:AddClickUpListener(arg_2_0._addClickUp, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.inputValue:RemoveOnValueChanged()
	arg_3_0:removeClickCb(arg_3_0.btnBuy)
	arg_3_0:removeClickCb(arg_3_0.btnMax)
	arg_3_0:removeClickCb(arg_3_0.btnMin)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnEnterPool, arg_3_0.onEnterPool, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotterySuccess, arg_3_0.onLotterySuccess, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, arg_3_0.onLotteryEnd, arg_3_0)
	arg_3_0:removeEventCb(Activity129Controller.instance, Activity129Event.OnLotteryEnd, arg_3_0.onLotteryEnd, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0._subPress:RemoveLongPressListener()
	arg_3_0._subClick:RemoveClickListener()
	arg_3_0._subClick:RemoveClickUpListener()
	arg_3_0._addPress:RemoveLongPressListener()
	arg_3_0._addClick:RemoveClickListener()
	arg_3_0._addClick:RemoveClickUpListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.poolItems = {}
	arg_4_0.rewardItems = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = gohelper.findChild(arg_4_0.goRewards, string.format("#scroll_RewardList/Viewport/Content/Reward%s", iter_4_0))
		local var_4_1 = {
			goItem = arg_4_0.goRewardItem,
			itemList = arg_4_0.rewardItems,
			rare = iter_4_0 == 1 and 5 or 4
		}

		arg_4_0.poolItems[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_0, Activity129RewardPoolItem, var_4_1)
	end
end

function var_0_0._onCurrencyChange(arg_5_0, arg_5_1)
	if not arg_5_0.actId then
		return
	end

	if not arg_5_1[Activity129Config.instance:getConstValue1(arg_5_0.actId, Activity129Enum.ConstEnum.CostId)] then
		return
	end

	arg_5_0:refreshBuyButton()
end

function var_0_0.onLotterySuccess(arg_6_0)
	gohelper.setActive(arg_6_0.goBack, false)
	gohelper.setActive(arg_6_0.goCurreny, false)
	arg_6_0:setVisible(false)
end

function var_0_0.onLotteryEnd(arg_7_0)
	gohelper.setActive(arg_7_0.goBack, true)
	gohelper.setActive(arg_7_0.goCurreny, true)
	arg_7_0:refreshView()
end

function var_0_0.onEnterPool(arg_8_0)
	arg_8_0.curCount = 1

	arg_8_0:refreshView()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId

	arg_9_0:refreshView()
end

function var_0_0.refreshView(arg_10_0)
	if not Activity129Model.instance:getSelectPoolId() then
		arg_10_0:setVisible(false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	arg_10_0:setVisible(true)
	arg_10_0:refreshMaxCount()
	arg_10_0:refreshReward()
	arg_10_0:refreshBuy()
end

function var_0_0.refreshMaxCount(arg_11_0)
	local var_11_0 = Activity129Model.instance:getSelectPoolId()

	if not var_11_0 then
		return
	end

	arg_11_0.maxCount = Activity129Config.instance:getPoolConfig(arg_11_0.actId, var_11_0).maxDraw or Activity129Config.instance:getConstValue1(arg_11_0.actId, Activity129Enum.ConstEnum.MaxMoreDraw) or 1

	local var_11_1, var_11_2 = Activity129Model.instance:getActivityMo(arg_11_0.actId):getPoolMo(var_11_0):getPoolDrawCount()
	local var_11_3 = arg_11_0:_calcAffordableCount(1)

	arg_11_0.maxCount = math.min(var_11_3, arg_11_0.maxCount)

	if var_11_2 > 0 then
		local var_11_4 = var_11_2 - var_11_1

		if var_11_4 <= 0 then
			var_11_4 = 1
		end

		arg_11_0.maxCount = math.min(var_11_4, arg_11_0.maxCount)
	end

	arg_11_0.maxCount = math.max(1, arg_11_0.maxCount)
end

function var_0_0.refreshReward(arg_12_0)
	local var_12_0 = Activity129Model.instance:getSelectPoolId()

	if not var_12_0 then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardItems) do
		iter_12_1:setHideMark()
	end

	local var_12_1 = Activity129Config.instance:getGoodsDict(var_12_0)
	local var_12_2 = {}

	if var_12_1 then
		for iter_12_2, iter_12_3 in pairs(var_12_1) do
			var_12_2[iter_12_2] = GameUtil.splitString2(iter_12_3.goodsId, true)
		end
	end

	for iter_12_4, iter_12_5 in ipairs(arg_12_0.poolItems) do
		iter_12_5:setDict(var_12_2, arg_12_0.actId, var_12_0)
	end

	for iter_12_6, iter_12_7 in ipairs(arg_12_0.rewardItems) do
		iter_12_7:checkHide()
	end

	local var_12_3 = Activity129Config.instance:getPoolConfig(arg_12_0.actId, var_12_0)

	arg_12_0.txtTitle.text = var_12_3.name
	arg_12_0.txtTitleEn.text = var_12_3.nameEn
end

function var_0_0.refreshBuy(arg_13_0)
	local var_13_0 = arg_13_0.curCount or arg_13_0.maxCount
	local var_13_1 = arg_13_0:getInputCount(0, var_13_0)

	arg_13_0:setInputTxt(var_13_1)
	arg_13_0:refreshBuyButton()
end

function var_0_0.refreshBuyButton(arg_14_0)
	local var_14_0 = Activity129Model.instance:getSelectPoolId()

	if not var_14_0 then
		return
	end

	local var_14_1 = Activity129Config.instance:getPoolConfig(arg_14_0.actId, var_14_0).cost
	local var_14_2 = arg_14_0.inputValue:GetText()
	local var_14_3 = tonumber(var_14_2)
	local var_14_4 = string.splitToNumber(var_14_1, "#")
	local var_14_5 = var_14_4[3] * var_14_3
	local var_14_6, var_14_7 = ItemModel.instance:getItemConfigAndIcon(var_14_4[1], var_14_4[2], true)

	arg_14_0.simageIcon:LoadImage(var_14_7)

	local var_14_8 = var_14_5 <= ItemModel.instance:getItemQuantity(var_14_4[1], var_14_4[2])

	arg_14_0.txtCost.text = var_14_8 and tostring(var_14_5) or string.format("<color=#d33838>%s</color>", var_14_5)
	arg_14_0.txtBuy.text = formatLuaLang("v1a4_tokenstore_confirm", GameUtil.getNum2Chinese(var_14_3))

	gohelper.setActive(arg_14_0.maxDisable, false)
	gohelper.setActive(arg_14_0.minDisable, false)
end

function var_0_0._onValueChanged(arg_15_0)
	local var_15_0 = arg_15_0.inputValue:GetText()
	local var_15_1 = tonumber(var_15_0)

	if not var_15_1 or var_15_1 < 1 or var_15_1 > arg_15_0.maxCount then
		local var_15_2 = arg_15_0:getInputCount(0, var_15_1)

		arg_15_0:setInputTxt(var_15_2)
	end

	arg_15_0:refreshBuyButton()
end

function var_0_0.onClickBuy(arg_16_0)
	local var_16_0 = Activity129Model.instance:getSelectPoolId()

	if not var_16_0 then
		return
	end

	if Activity129Model.instance:checkPoolIsEmpty(arg_16_0.actId, var_16_0) then
		GameFacade.showToast(ToastEnum.Activity129PoolIsEmpty)
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnClickEmptyPool)

		return
	end

	local var_16_1 = Activity129Config.instance:getPoolConfig(arg_16_0.actId, var_16_0).cost
	local var_16_2 = arg_16_0.inputValue:GetText()
	local var_16_3 = tonumber(var_16_2) or 1
	local var_16_4 = string.splitToNumber(var_16_1, "#")
	local var_16_5 = {}
	local var_16_6 = {
		type = var_16_4[1],
		id = var_16_4[2],
		quantity = var_16_4[3] * var_16_3
	}

	table.insert(var_16_5, var_16_6)

	local var_16_7, var_16_8, var_16_9 = ItemModel.instance:hasEnoughItems(var_16_5)

	if not var_16_8 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_16_9, var_16_7)

		return
	end

	local var_16_10 = Activity129Model.instance:getSelectPoolId()

	if not var_16_10 then
		return
	end

	Activity129Rpc.instance:sendAct129LotteryRequest(arg_16_0.actId, var_16_10, var_16_3)
end

function var_0_0.onClickMin(arg_17_0)
	arg_17_0:setInputTxt(1)
end

function var_0_0.onClickMax(arg_18_0)
	arg_18_0:setInputTxt(arg_18_0.maxCount)
end

function var_0_0.setInputTxt(arg_19_0, arg_19_1)
	arg_19_0.curCount = tonumber(arg_19_1)

	arg_19_0.inputValue:SetText(tostring(arg_19_1))
end

function var_0_0.getInputCount(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or tonumber(arg_20_0.inputValue:GetText()) or arg_20_0.curCount or 1
	arg_20_1 = arg_20_1 or 0

	return Mathf.Clamp(arg_20_2 + arg_20_1, 1, arg_20_0.maxCount)
end

function var_0_0.onClickAdd(arg_21_0)
	arg_21_0:setInputTxt(arg_21_0:getInputCount(1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0.onClickSub(arg_22_0)
	arg_22_0:setInputTxt(arg_22_0:getInputCount(-1))
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._subLongPressTimeEnd(arg_23_0)
	local var_23_0 = arg_23_0._isLongPress

	arg_23_0._isLongPress = true

	arg_23_0:setInputTxt(arg_23_0:getInputCount(-1))

	if not var_23_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._subClickUp(arg_24_0)
	arg_24_0._isLongPress = false
end

function var_0_0._addLongPressTimeEnd(arg_25_0)
	local var_25_0 = arg_25_0._isLongPress

	arg_25_0._isLongPress = true

	arg_25_0:setInputTxt(arg_25_0:getInputCount(1))

	if not var_25_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function var_0_0._addClickUp(arg_26_0)
	arg_26_0._isLongPress = false
end

function var_0_0.setVisible(arg_27_0, arg_27_1)
	TaskDispatcher.cancelTask(arg_27_0._hide, arg_27_0)

	if arg_27_1 then
		gohelper.setActive(arg_27_0.goRewards, true)
	else
		arg_27_0.anim:Play("close")
		TaskDispatcher.runDelay(arg_27_0._hide, arg_27_0, 0.17)
	end
end

function var_0_0._hide(arg_28_0)
	gohelper.setActive(arg_28_0.goRewards, false)
end

function var_0_0.onClose(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._hide, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0.simageIcon:UnLoadImage()
end

function var_0_0._calcAffordableCount(arg_31_0, arg_31_1)
	local var_31_0 = Activity129Model.instance:getSelectPoolId()

	if not var_31_0 then
		return arg_31_1 or 0
	end

	local var_31_1 = Activity129Config.instance:getPoolConfig(arg_31_0.actId, var_31_0).cost
	local var_31_2 = string.splitToNumber(var_31_1, "#")
	local var_31_3 = var_31_2[3]
	local var_31_4 = ItemModel.instance:getItemQuantity(var_31_2[1], var_31_2[2])

	return math.floor(var_31_4 / var_31_3)
end

return var_0_0
