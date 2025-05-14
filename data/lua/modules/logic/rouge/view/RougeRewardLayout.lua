module("modules.logic.rouge.view.RougeRewardLayout", package.seeall)

local var_0_0 = class("RougeRewardLayout", LuaCompBase)

function var_0_0.initcomp(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1

	gohelper.setActive(arg_1_0._go, false)

	arg_1_0._config = arg_1_2

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		arg_1_0._stage = iter_1_1.stage

		break
	end

	arg_1_0._index = arg_1_3
	arg_1_0._imgSlider = gohelper.findChildImage(arg_1_1, "Slider/image_SliderFG")
	arg_1_0._imgSliderIcon = gohelper.findChildImage(arg_1_1, "Slider/image_SliderFG/image_SliderFGIcon")
	arg_1_0._goVxLight = gohelper.findChild(arg_1_1, "Slider/image_SliderFG/image_SliderFGIcon/vx_light")
	arg_1_0._goReward = gohelper.findChild(arg_1_1, "Layout/#go_Reward")
	arg_1_0._goExchange = gohelper.findChild(arg_1_1, "Layout/#go_Exchange")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_1, "Layout/#go_Exchange/btn")
	arg_1_0._txtCost = gohelper.findChildText(arg_1_1, "Layout/#go_Exchange/#txt_Cost")
	arg_1_0._imgIcon = gohelper.findChildImage(arg_1_1, "Layout/#go_Exchange/#txt_Cost/costIcon")
	arg_1_0._animator = arg_1_0._go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0._goVxLight, false)
	arg_1_0:addEvents()

	arg_1_0._rewardList = {}
	arg_1_0._costConfig = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.RewardCost)

	local var_1_0 = string.split(arg_1_0._costConfig, "#")

	arg_1_0._costType, arg_1_0._costId, arg_1_0._costNum = var_1_0[1], var_1_0[2], var_1_0[3]
	arg_1_0._click = false
	arg_1_0._currentSelectIndex = 1
	arg_1_0._currentSelectId = nil
	arg_1_0._longPressArr = {
		0.5,
		99999
	}

	arg_1_0:_initItems()
	arg_1_0:refreshSlider(arg_1_0._config)

	arg_1_0.itemspace = 186
	arg_1_0._spacetime = 0.03
end

function var_0_0.refreshcomp(arg_2_0, arg_2_1)
	arg_2_0._config = arg_2_1

	local var_2_0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_0 = iter_2_1.stage

		break
	end

	if var_2_0 ~= arg_2_0._stage then
		arg_2_0:_onSwitchAnim(true)
		arg_2_0:hideExchangeBtn()

		arg_2_0._stage = var_2_0
		arg_2_0._lastRate = nil
	else
		arg_2_0:refreshItem()
		arg_2_0:refreshSlider()
	end
end

function var_0_0.refreshItem(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._config) do
		local var_3_0 = arg_3_0._rewardList[iter_3_0]
		local var_3_1 = string.split(iter_3_1.value, "#")
		local var_3_2 = var_3_1[1]
		local var_3_3 = var_3_1[2]
		local var_3_4 = var_3_1[3]
		local var_3_5, var_3_6 = ItemModel.instance:getItemConfigAndIcon(var_3_2, var_3_3, true)

		var_3_0.co = iter_3_1
		var_3_0.id = iter_3_1.id
		var_3_0.index = iter_3_0
		var_3_0._txtNum.text = var_3_4

		var_3_0._simageItem:LoadImage(var_3_6)
		UISpriteSetMgr.instance:setRougeSprite(var_3_0._imgQuality, "rouge_reward_quality" .. var_3_5.rare)

		local var_3_7 = RougeRewardModel.instance:checkRewardGot(iter_3_1.stage, iter_3_1.id)

		gohelper.setActive(var_3_0._goClaimed, var_3_7)
		var_3_0._long:RemoveLongPressListener()

		function arg_3_0.LongPressFunc()
			MaterialTipController.instance:showMaterialInfo(var_3_2, var_3_3)
		end

		var_3_0._long:AddLongPressListener(arg_3_0.LongPressFunc, arg_3_0)

		var_3_0._isLongPress = false

		if var_3_7 then
			local var_3_8 = string.split(iter_3_1.value, "#")
			local var_3_9 = var_3_8[1]
			local var_3_10 = var_3_8[2]
			local var_3_11 = var_3_8[3]

			local function var_3_12()
				MaterialTipController.instance:showMaterialInfo(var_3_9, var_3_10)
			end

			var_3_0._btn:AddClickListener(var_3_12, arg_3_0, var_3_0)
		else
			var_3_0._btn:AddClickListener(arg_3_0._btnOnClick, arg_3_0, var_3_0)
		end

		var_3_0._imgQuality.color = var_3_7 and var_0_0.Get or var_0_0.noGet
		var_3_0._imgItem.color = var_3_7 and var_0_0.Get or var_0_0.noGet
	end
end

function var_0_0.hideExchangeBtn(arg_6_0)
	if arg_6_0._click then
		gohelper.setActive(arg_6_0._goExchange, false)

		arg_6_0._click = false

		arg_6_0:_refreshReward(false)
	end
end

function var_0_0.refreshSlider(arg_7_0)
	if not arg_7_0._config then
		return
	end

	local var_7_0 = #arg_7_0._config
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._config) do
		if RougeRewardModel.instance:checkRewardGot(iter_7_1.stage, iter_7_1.id) then
			var_7_1 = var_7_1 + 1
		end
	end

	local var_7_2 = var_7_1 / var_7_0

	if not arg_7_0._lastRate then
		arg_7_0._lastRate = var_7_2
	elseif arg_7_0._lastRate ~= var_7_2 and var_7_2 == 1 then
		arg_7_0._showAnim = true
		arg_7_0._lastRate = var_7_2
	else
		arg_7_0._showAnim = false
	end

	if not arg_7_0._showAnim then
		arg_7_0._imgSlider.fillAmount = var_7_2

		if arg_7_0._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(arg_7_0._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

var_0_0.noGet = Color(1, 1, 1, 1)
var_0_0.Get = Color(0.3, 0.3, 0.3, 1)

function var_0_0._initItems(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._config) do
		local var_8_0 = arg_8_0._rewardList[iter_8_0]
		local var_8_1 = string.split(iter_8_1.value, "#")
		local var_8_2 = var_8_1[1]
		local var_8_3 = var_8_1[2]
		local var_8_4 = var_8_1[3]
		local var_8_5, var_8_6 = ItemModel.instance:getItemConfigAndIcon(var_8_2, var_8_3, true)

		if not var_8_0 then
			var_8_0 = arg_8_0:getUserDataTb_()

			local var_8_7 = gohelper.cloneInPlace(arg_8_0._goReward, "reward" .. iter_8_0)

			gohelper.setActive(var_8_7, true)

			var_8_0.go = var_8_7
			var_8_0.index = iter_8_0
			var_8_0.co = iter_8_1
			var_8_0.id = iter_8_1.id
			var_8_0._imgQuality = gohelper.findChildImage(var_8_7, "#img_Quality")
			var_8_0._simageItem = gohelper.findChildSingleImage(var_8_7, "#simage_Item")
			var_8_0._imgItem = var_8_0._simageItem:GetComponent(gohelper.Type_Image)
			var_8_0._goSelected1 = gohelper.findChild(var_8_7, "#go_Selected1")
			var_8_0._goSelected2 = gohelper.findChild(var_8_7, "#go_Selected2")
			var_8_0._txtNum = gohelper.findChildText(var_8_7, "image_NumBG/#txt_Num")
			var_8_0._goClaimed = gohelper.findChild(var_8_7, "#go_Claimed")
			var_8_0._gobtn = gohelper.findChild(var_8_7, "btn")
			var_8_0._btn = gohelper.findChildButtonWithAudio(var_8_7, "btn")

			var_8_0._btn:AddClickListener(arg_8_0._btnOnClick, arg_8_0, var_8_0)

			var_8_0._long = SLFramework.UGUI.UILongPressListener.Get(var_8_0._btn.gameObject)

			var_8_0._long:SetLongPressTime(arg_8_0._longPressArr)

			function arg_8_0.LongPressFunc()
				MaterialTipController.instance:showMaterialInfo(var_8_2, var_8_3)
			end

			var_8_0._long:AddLongPressListener(arg_8_0.LongPressFunc, arg_8_0)

			var_8_0._isLongPress = false

			table.insert(arg_8_0._rewardList, var_8_0)
		end

		var_8_0._txtNum.text = var_8_4

		var_8_0._simageItem:LoadImage(var_8_6)
		UISpriteSetMgr.instance:setRougeSprite(var_8_0._imgQuality, "rouge_reward_quality" .. var_8_5.rare)

		local var_8_8 = RougeRewardModel.instance:checkRewardGot(iter_8_1.stage, iter_8_1.id)

		gohelper.setActive(var_8_0._goClaimed, var_8_8)

		var_8_0._imgQuality.color = var_8_8 and var_0_0.Get or var_0_0.noGet
		var_8_0._imgItem.color = var_8_8 and var_0_0.Get or var_0_0.noGet
	end

	arg_8_0:_onSwitchAnim(false)
	gohelper.setAsLastSibling(arg_8_0._goExchange)
	arg_8_0._btnExchange:AddClickListener(arg_8_0._onClickExChangeBtn, arg_8_0)
end

function var_0_0._onEnterAnim(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onEnterAnim, arg_10_0)
	gohelper.setActive(arg_10_0._go, true)
	arg_10_0._animator:Update(0)
	arg_10_0._animator:Play("in", 0, 0)
	arg_10_0:refreshItem()
	arg_10_0:refreshSlider()
end

function var_0_0._onSwitchAnim(arg_11_0, arg_11_1)
	arg_11_0._animator:Update(0)
	arg_11_0._animator:Play("out", 0, 0)

	local var_11_0 = 0.03 * arg_11_0._index + (arg_11_1 and 0.167 or 0)

	TaskDispatcher.runDelay(arg_11_0._onEnterAnim, arg_11_0, var_11_0)
end

function var_0_0.addEvents(arg_12_0)
	arg_12_0:addEventCb(RougeController.instance, RougeEvent.OnClickReward, arg_12_0.refreshLayout, arg_12_0)
	arg_12_0:addEventCb(RougeController.instance, RougeEvent.OnGetRougeReward, arg_12_0.OnGetRougeReward, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_12_0._onCloseViewFinish, arg_12_0)
end

function var_0_0._btnOnClick(arg_13_0, arg_13_1)
	if arg_13_0._currentSelectIndex ~= arg_13_1.index then
		if arg_13_0._click then
			local var_13_0 = arg_13_0:_getUnlockNum(arg_13_1.index)

			arg_13_0._click = not arg_13_0._click

			gohelper.setActive(arg_13_0._goExchange, arg_13_0._click)

			local var_13_1 = (arg_13_1.index - 1) * arg_13_0.itemspace - arg_13_0.itemspace / 2

			recthelper.setAnchorX(arg_13_0._goExchange.transform, var_13_1)

			if var_13_0 > 0 then
				local var_13_2 = var_13_0 * arg_13_0._costNum

				arg_13_0._txtCost.text = var_13_2

				if var_13_2 > RougeRewardModel.instance:getRewardPoint() then
					arg_13_0._txtCost.color = GameUtil.parseColor("#9F342C")
				else
					arg_13_0._txtCost.color = GameUtil.parseColor("#E99B56")
				end

				local var_13_3 = string.format("%s_1", arg_13_0._costId)

				UISpriteSetMgr.instance:setCurrencyItemSprite(arg_13_0._imgIcon, var_13_3)
			end
		end

		arg_13_0._currentSelectIndex = arg_13_1.index
	end

	if arg_13_0._currentSelectId ~= arg_13_1.id then
		arg_13_0._currentSelectId = arg_13_1.id
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnClickReward, arg_13_0._index)
end

function var_0_0._onClickExChangeBtn(arg_14_0)
	local var_14_0 = RougeRewardModel.instance:getRewardPoint()
	local var_14_1 = arg_14_0:_getUnlockNum(arg_14_0._currentSelectIndex)
	local var_14_2 = 0

	if var_14_1 > 0 then
		if var_14_0 >= var_14_1 * arg_14_0._costNum then
			local var_14_3 = RougeOutsideModel.instance:season()

			RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(var_14_3, arg_14_0._currentSelectId)
		else
			GameFacade.showToast(ToastEnum.ExchangeFreeDiamond)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function var_0_0.refreshLayout(arg_15_0, arg_15_1)
	if arg_15_0._index == arg_15_1 then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._rewardList) do
			local var_15_0 = iter_15_1.co
			local var_15_1 = RougeRewardModel.instance:checkRewardGot(var_15_0.stage, var_15_0.id)

			if iter_15_0 == arg_15_0._currentSelectIndex and not var_15_1 then
				local var_15_2 = arg_15_0:_getUnlockNum(iter_15_0)

				arg_15_0._click = not arg_15_0._click

				gohelper.setActive(arg_15_0._goExchange, arg_15_0._click)

				local var_15_3 = (arg_15_0._currentSelectIndex - 1) * arg_15_0.itemspace - arg_15_0.itemspace / 2

				recthelper.setAnchorX(arg_15_0._goExchange.transform, var_15_3)

				if var_15_2 > 0 then
					local var_15_4 = var_15_2 * arg_15_0._costNum

					arg_15_0._txtCost.text = var_15_4

					if var_15_4 > RougeRewardModel.instance:getRewardPoint() then
						arg_15_0._txtCost.color = GameUtil.parseColor("#9F342C")
					else
						arg_15_0._txtCost.color = GameUtil.parseColor("#E99B56")
					end

					local var_15_5 = string.format("%s_1", arg_15_0._costId)

					UISpriteSetMgr.instance:setCurrencyItemSprite(arg_15_0._imgIcon, var_15_5)
				end
			end
		end

		arg_15_0:_refreshReward(arg_15_0._click)

		local var_15_6 = RougeRewardConfig.instance:getStageToLayourConfig(arg_15_0._stage, arg_15_0._index)

		arg_15_0:refreshSlider(var_15_6)
	else
		gohelper.setActive(arg_15_0._goExchange, false)

		arg_15_0._click = false

		arg_15_0:_refreshReward(false)
	end
end

function var_0_0._refreshReward(arg_16_0, arg_16_1)
	if arg_16_1 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._rewardList) do
			local var_16_0 = iter_16_1.co

			if not RougeRewardModel.instance:checkRewardGot(var_16_0.stage, var_16_0.id) then
				local var_16_1 = iter_16_1.index == arg_16_0._currentSelectIndex

				if iter_16_1.index <= arg_16_0._currentSelectIndex then
					gohelper.setActive(iter_16_1._goSelected1, not var_16_1)
					gohelper.setActive(iter_16_1._goSelected2, var_16_1)
				else
					gohelper.setActive(iter_16_1._goSelected1, false)
					gohelper.setActive(iter_16_1._goSelected2, false)
				end
			else
				gohelper.setActive(iter_16_1._goSelected1, false)
				gohelper.setActive(iter_16_1._goSelected2, false)
			end
		end
	else
		for iter_16_2, iter_16_3 in ipairs(arg_16_0._rewardList) do
			gohelper.setActive(iter_16_3._goSelected1, arg_16_1)
			gohelper.setActive(iter_16_3._goSelected2, arg_16_1)
		end
	end
end

function var_0_0._onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.CommonPropView then
		gohelper.setActive(arg_17_0._goVxLight, arg_17_0._showAnim)

		arg_17_0._imgSlider.fillAmount = arg_17_0._lastRate

		if arg_17_0._imgSlider.fillAmount == 1 then
			UISpriteSetMgr.instance:setRougeSprite(arg_17_0._imgSliderIcon, "rouge_reward_key1")
		else
			UISpriteSetMgr.instance:setRougeSprite(arg_17_0._imgSliderIcon, "rouge_reward_key0")
		end
	end
end

function var_0_0.OnGetRougeReward(arg_18_0, arg_18_1)
	arg_18_0._click = false

	gohelper.setActive(arg_18_0._goExchange, arg_18_0._click)
	arg_18_0:_refreshReward(false)
end

function var_0_0._getUnlockNum(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0 = 1, arg_19_1 do
		local var_19_1 = arg_19_0._rewardList[iter_19_0].co

		if not RougeRewardModel.instance:checkRewardGot(var_19_1.stage, var_19_1.id) then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0:removeEventCb(RougeController.instance, RougeEvent.OnClickReward, arg_20_0.refreshLayout, arg_20_0)
	arg_20_0:removeEventCb(RougeController.instance, RougeEvent.OnGetRougeReward, arg_20_0.OnGetRougeReward, arg_20_0)
	arg_20_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_20_0._onCloseViewFinish, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onEnterAnim, arg_20_0)

	for iter_20_0, iter_20_1 in pairs(arg_20_0._rewardList) do
		iter_20_1._btn:RemoveClickListener()
		iter_20_1._long:RemoveLongPressListener()
	end

	arg_20_0._btnExchange:RemoveClickListener()
end

return var_0_0
