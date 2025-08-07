module("modules.logic.summon.view.SummonPoolPogressRewardView", package.seeall)

local var_0_0 = class("SummonPoolPogressRewardView", BaseView)
local var_0_1 = {
	Canget = 2,
	HasGet = 3,
	Normal = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goui = gohelper.findChild(arg_1_0.viewGO, "#go_ui")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#btn_close")
	arg_1_0._simagepanelMask1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/BG/#simage_panelMask1")
	arg_1_0._simagepanelMask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/BG/#simage_panelMask2")
	arg_1_0._simagepanelBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/BG/#simage_panelBG1")
	arg_1_0._simagepanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ui/current/BG/#simage_panelBG2")
	arg_1_0._txttotalTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/summonTimes/#txt_totalTimes")
	arg_1_0._txtcurTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/summonTimes/#txt_curTimes")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#go_ui/current/progress/#slider_progress")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ui/current/#btn_confirm")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_ui/current/#btn_confirm/#txt_Tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	local var_4_0 = {
		heroId = arg_4_0._heroId
	}

	if not HeroModel.instance:getByHeroId(arg_4_0._heroId) then
		var_4_0.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	end

	CharacterController.instance:openCharacterExSkillView(var_4_0)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._itemTbList = {}
	arg_6_0._goitem = gohelper.findChild(arg_6_0.viewGO, "#go_ui/current/progress/go_item")

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "#go_ui/current/progress")

	arg_6_0._progressWidth = recthelper.getWidth(var_6_0.transform)

	gohelper.setActive(arg_6_0._goitem, false)
	gohelper.setActive(arg_6_0._txtTips, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_updateParamByPoolId(arg_7_0.viewParam and arg_7_0.viewParam.poolId)
	arg_7_0:_refreshUI()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_8_0._refreshUI, arg_8_0)
	arg_8_0:addEventCb(SummonController.instance, SummonEvent.onSummonProgressRewards, arg_8_0._refreshProgressRewards, arg_8_0)
	arg_8_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_8_0._refreshHeroUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_8_0._startWaritCloseViewEvent, arg_8_0)
	arg_8_0:_updateParamByPoolId(arg_8_0.viewParam and arg_8_0.viewParam.poolId)
	arg_8_0:_refreshUI()
end

function var_0_0.onClose(arg_9_0)
	if arg_9_0._isHasRunRefreshViewTask then
		arg_9_0._isHasRunRefreshViewTask = nil

		TaskDispatcher.cancelTask(arg_9_0._onRunRefreshView, arg_9_0)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._itemTbList) do
		iter_10_1.btnclaim:RemoveClickListener()
	end
end

function var_0_0._updateParamByPoolId(arg_11_0, arg_11_1)
	arg_11_0._poolId = arg_11_1

	local var_11_0 = SummonMainModel.instance:getPoolServerMO(arg_11_0._poolId)

	arg_11_0._summonCount = var_11_0 and var_11_0.summonCount or 0
	arg_11_0._rewardCount = var_11_0 and var_11_0.customPickMO and var_11_0.customPickMO:getRewardCount() or 0
	arg_11_0._reawrdDataList = arg_11_0:_createRewardDataListById(arg_11_0._poolId)

	local var_11_1 = arg_11_0._reawrdDataList[#arg_11_0._reawrdDataList]

	arg_11_0._maxCount = var_11_1 and var_11_1.count or 0
	arg_11_0._heroId = var_11_1 and var_11_1.heroId or 0
	arg_11_0._heroCfg = HeroConfig.instance:getHeroCO(arg_11_0._heroId)
end

function var_0_0._createRewardDataListById(arg_12_0, arg_12_1)
	local var_12_0 = SummonConfig.instance:getSummonPool(arg_12_1)
	local var_12_1 = {}

	if var_12_0 and not string.nilorempty(var_12_0.progressRewards) then
		local var_12_2 = GameUtil.splitString2(var_12_0.progressRewards, true)

		if var_12_2 and #var_12_2 > 0 then
			for iter_12_0, iter_12_1 in ipairs(var_12_2) do
				local var_12_3 = iter_12_1[1]
				local var_12_4 = iter_12_1[2]

				table.insert(var_12_1, {
					heroId = var_12_4,
					count = var_12_3
				})
			end
		end
	end

	if #var_12_1 > 1 then
		table.sort(var_12_1, var_0_0._rewardDataSort)
	end

	return var_12_1
end

function var_0_0._refreshProgressRewards(arg_13_0)
	arg_13_0:_updateParamByPoolId(arg_13_0._poolId)
	arg_13_0:_refreshUI()
end

function var_0_0._startWaritCloseViewEvent(arg_14_0)
	if arg_14_0._isLockHeroRefresh then
		TaskDispatcher.cancelTask(arg_14_0._onRunRefreshView, arg_14_0)
		TaskDispatcher.runDelay(arg_14_0._onRunRefreshView, arg_14_0, 0.1)
	end
end

function var_0_0._onRunRefreshView(arg_15_0)
	if arg_15_0._isLockHeroRefresh and ViewHelper.instance:checkViewOnTheTop(arg_15_0.viewName) then
		arg_15_0._isLockHeroRefresh = nil

		arg_15_0:_refreshHeroUI()
	end
end

function var_0_0._rewardDataSort(arg_16_0, arg_16_1)
	if arg_16_0.count ~= arg_16_1.count then
		return arg_16_0.count < arg_16_1.count
	end
end

function var_0_0._refreshUI(arg_17_0)
	arg_17_0._txttotalTimes.text = tostring(arg_17_0._summonCount)
	arg_17_0._txtcurTimes.text = tostring(arg_17_0._maxCount)

	if arg_17_0._maxCount > 0 then
		arg_17_0._sliderprogress:SetValue(arg_17_0._summonCount / arg_17_0._maxCount)
	end

	arg_17_0:_refreshItemUI()
	arg_17_0:_refreshHeroUI()
end

function var_0_0._refreshHeroUI(arg_18_0)
	if arg_18_0._isLockHeroRefresh then
		return
	end

	arg_18_0._isHeroUIIsShow = (arg_18_0:_getSkillItemCount() or 0) > 0

	gohelper.setActive(arg_18_0._btnconfirm, arg_18_0._isHeroUIIsShow)
end

function var_0_0._getSkillItemCount(arg_19_0)
	local var_19_0 = 0
	local var_19_1 = SkillConfig.instance:getherolevelexskillCO(arg_19_0._heroId, 1)

	if var_19_1 and not string.nilorempty(var_19_1.consume) then
		local var_19_2 = string.splitToNumber(var_19_1.consume, "#")

		if var_19_2 then
			var_19_0 = ItemModel.instance:getItemQuantity(var_19_2[1], var_19_2[2])
		end
	end

	return var_19_0
end

function var_0_0._refreshItemUI(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._reawrdDataList) do
		local var_20_0 = arg_20_0._itemTbList[iter_20_0]

		if var_20_0 == nil then
			var_20_0 = arg_20_0:_createItemTB(gohelper.cloneInPlace(arg_20_0._goitem))

			table.insert(arg_20_0._itemTbList, var_20_0)
		end

		if arg_20_0._maxCount > 0 then
			local var_20_1 = iter_20_1.count * arg_20_0._progressWidth / arg_20_0._maxCount

			recthelper.setAnchorX(var_20_0.goTrs, var_20_1)
		end

		local var_20_2 = arg_20_0:_getRewardState(iter_20_0, iter_20_1.count)

		if var_20_0.rewardState ~= var_20_2 then
			var_20_0.rewardState = var_20_2

			gohelper.setActive(var_20_0.gonormal, var_20_2 == var_0_1.Normal)
			gohelper.setActive(var_20_0.gocanget, var_20_2 == var_0_1.Canget)
			gohelper.setActive(var_20_0.gohasget, var_20_2 == var_0_1.HasGet)
		end

		var_20_0.txtcount.text = tostring(iter_20_1.count)
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._itemTbList) do
		gohelper.setActive(iter_20_3.go, iter_20_2 <= #arg_20_0._reawrdDataList)
	end
end

function var_0_0._getRewardState(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 <= arg_21_0._rewardCount then
		return var_0_1.HasGet
	end

	if arg_21_2 <= arg_21_0._summonCount then
		return var_0_1.Canget
	end

	return var_0_1.Normal
end

function var_0_0._createItemTB(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0.go = arg_22_1
	var_22_0.goTrs = arg_22_1.transform
	var_22_0.gonormal = gohelper.findChild(arg_22_1, "normal")
	var_22_0.gocanget = gohelper.findChild(arg_22_1, "canget")
	var_22_0.gohasget = gohelper.findChild(arg_22_1, "hasget")
	var_22_0.btnclaim = gohelper.findChildButtonWithAudio(arg_22_1, "canget/btn_claim")
	var_22_0.txtcount = gohelper.findChildText(arg_22_1, "txt_count")

	var_22_0.btnclaim:AddClickListener(arg_22_0._itemBtnclaimOnClick, arg_22_0)

	return var_22_0
end

function var_0_0._itemBtnclaimOnClick(arg_23_0)
	arg_23_0._nextRewardsRequestTime = arg_23_0._nextRewardsRequestTime or 0

	if arg_23_0._poolId and arg_23_0._nextRewardsRequestTime <= Time.time then
		arg_23_0._nextRewardsRequestTime = Time.time + 0.3

		SummonRpc.instance:sendGetSummonProgressRewardsRequest(arg_23_0._poolId)

		if not arg_23_0._isLockHeroRefresh and arg_23_0:_getSkillItemCount() <= 0 then
			arg_23_0._isLockHeroRefresh = true
		end
	end
end

return var_0_0
