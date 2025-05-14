module("modules.logic.versionactivity2_5.act186.view.Activity186MileStoneView", package.seeall)

local var_0_0 = class("Activity186MileStoneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnStoneCanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bonusNode/milestone/go_canget")
	arg_1_0.txtStoneProgress = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/bonusNode/milestone/progress/txtprogress")
	arg_1_0.itemGO = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem")

	gohelper.setActive(arg_1_0.itemGO, false)

	arg_1_0.goLine = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")
	arg_1_0.trsLine = arg_1_0.goLine.transform
	arg_1_0.goContent = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content")
	arg_1_0.contentTransform = arg_1_0.goContent.transform
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/#scroll_reward")
	arg_1_0.scroll = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/bonusNode/#scroll_reward")
	arg_1_0.scrollRect = gohelper.findChildComponent(arg_1_0.viewGO, "root/bonusNode/#scroll_reward", typeof(ZProj.LimitedScrollRect))
	arg_1_0.scrollWidth = recthelper.getWidth(arg_1_0.goScroll.transform)
	arg_1_0.goBubble = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/bubble")
	arg_1_0.btnSpBonus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/bonusNode/bubble/btn")
	arg_1_0.goreward = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(arg_1_0.goBubble, false)

	arg_1_0.cellSpace = 30
	arg_1_0.bonusAnim = gohelper.findChildComponent(arg_1_0.viewGO, "root/bonusNode", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.scroll:AddOnValueChanged(arg_2_0.onValueChanged, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStoneCanget, arg_2_0.onClickBtnStoneCanget, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSpBonus, arg_2_0.onClickBtnSpBonus, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.GetDailyCollection, arg_2_0.onGetDailyCollection, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.GetMilestoneReward, arg_2_0.onGetMilestoneReward, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.scroll:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.txttips = gohelper.findChildTextMesh(arg_4_0.viewGO, "root/bonusNode/tips/txt_tips")

	local var_4_0 = luaLang("p_activity186taskview_txt_tips")

	arg_4_0.txttips.text = ServerTime.ReplaceUTCStr(var_4_0)
end

function var_0_0.onValueChanged(arg_5_0)
	arg_5_0:refreshSpBonusReward()
end

function var_0_0.onClickBtnStoneCanget(arg_6_0)
	Activity186Rpc.instance:sendGetAct186DailyCollectionRequest(arg_6_0.actId)
end

function var_0_0.onClickBtnSpBonus(arg_7_0)
	arg_7_0:_moveToIndex(arg_7_0._spBonusIndex)
end

function var_0_0.onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CommonPropView and arg_8_0._waitRefresh then
		arg_8_0:refreshView()
	end
end

function var_0_0.onCurrencyChange(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	if arg_9_1[Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)] then
		arg_9_0._waitRefresh = true
	end
end

function var_0_0.onGetMilestoneReward(arg_10_0)
	arg_10_0:refreshList()
end

function var_0_0.onUpdateInfo(arg_11_0)
	arg_11_0:refreshView()
end

function var_0_0.onGetDailyCollection(arg_12_0)
	arg_12_0:refreshStone()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:refreshParam()
	arg_13_0:refreshView()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshParam()
	arg_14_0:refreshView(true)
end

function var_0_0.refreshParam(arg_15_0)
	arg_15_0.actId = arg_15_0.viewParam.actId
	arg_15_0.actMo = Activity186Model.instance:getById(arg_15_0.actId)

	Activity186MileStoneListModel.instance:init(arg_15_0.actMo)
end

function var_0_0.refreshView(arg_16_0)
	arg_16_0._waitRefresh = false

	arg_16_0:refreshStone()
	arg_16_0:refreshList()
end

function var_0_0.refreshStone(arg_17_0)
	local var_17_0 = arg_17_0.actMo.getDailyCollection
	local var_17_1 = Activity186Config.instance:getConstStr(Activity186Enum.ConstId.DailyStoneCount)
	local var_17_2 = GameUtil.splitString2(var_17_1, true)[1][3]

	if not var_17_0 then
		gohelper.setActive(arg_17_0.btnStoneCanget, true)

		arg_17_0.txtStoneProgress.text = string.format("%s/%s", var_17_2, var_17_2)
	else
		gohelper.setActive(arg_17_0.btnStoneCanget, false)

		arg_17_0.txtStoneProgress.text = string.format("0/%s", var_17_2)
	end
end

function var_0_0.refreshList(arg_18_0)
	Activity186MileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(arg_18_0.refreshLine, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.refreshLine, arg_18_0, 0.01)
end

function var_0_0.refreshLine(arg_19_0)
	local var_19_0 = Activity186MileStoneListModel.instance:caleProgressIndex()
	local var_19_1 = math.floor(var_19_0)
	local var_19_2 = arg_19_0:getItemWidth(var_19_1)
	local var_19_3 = arg_19_0:getItemPosX(var_19_1) - 15
	local var_19_4 = var_19_0 - var_19_1

	if var_19_4 > 0 then
		local var_19_5 = arg_19_0:getItemWidth(var_19_1 + 1)

		if var_19_1 > 0 then
			var_19_3 = var_19_3 + (var_19_5 + arg_19_0.cellSpace) * var_19_4
		else
			var_19_3 = 72 * var_19_4
		end
	end

	if arg_19_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_19_0._moveTweenId)

		arg_19_0._moveTweenId = nil
	end

	if arg_19_0._lineWith and arg_19_0._lineWith ~= var_19_3 then
		arg_19_0._lineWith = var_19_3
		arg_19_0._moveTweenId = ZProj.TweenHelper.DOWidth(arg_19_0.trsLine, var_19_3, 2)

		arg_19_0.bonusAnim:Play("get", 0, 0)
	else
		arg_19_0.bonusAnim:Play("idle")

		arg_19_0._lineWith = var_19_3

		recthelper.setWidth(arg_19_0.trsLine, var_19_3)
	end

	if not arg_19_0.isOpen then
		arg_19_0.isOpen = true

		arg_19_0:moveToDefaultPos()
	end

	arg_19_0:onValueChanged()
end

function var_0_0.caleProgressIndex(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)
	local var_20_2 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_20_1)
	local var_20_3 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_4 = iter_20_1.coinNum

		if var_20_2 < var_20_4 then
			var_20_0 = iter_20_0 + (var_20_2 - var_20_3) / (var_20_4 - var_20_3) - 1

			return var_20_0
		end

		var_20_3 = var_20_4
	end

	local var_20_5 = #arg_20_1
	local var_20_6

	var_20_6 = arg_20_1[var_20_5 - 1] and arg_20_1[var_20_5 - 1].coinNum or 0

	local var_20_7 = arg_20_1[var_20_5]
	local var_20_8 = arg_20_0.actMo.getMilestoneProgress
	local var_20_9 = var_20_7.loopBonusIntervalNum or 1
	local var_20_10 = var_20_7.coinNum

	if var_20_8 < var_20_10 then
		var_20_0 = var_20_5
	else
		local var_20_11 = (var_20_2 - var_20_10) / var_20_9
		local var_20_12 = math.floor(var_20_11)

		if var_20_12 > math.floor((var_20_8 - var_20_10) / var_20_9) then
			var_20_0 = var_20_5
		else
			var_20_0 = var_20_5 - 1 + var_20_11 - var_20_12
		end
	end

	return var_20_0
end

function var_0_0.refreshSpBonusReward(arg_21_0)
	local var_21_0 = arg_21_0:getSpBonusIndex()

	if arg_21_0._spBonusIndex == var_21_0 then
		return
	end

	arg_21_0._spBonusIndex = var_21_0

	gohelper.setActive(arg_21_0.goBubble, var_21_0 ~= nil)

	if var_21_0 ~= nil then
		local var_21_1 = Activity186Config.instance:getMileStoneList(arg_21_0.actId)[var_21_0]

		if var_21_1 then
			local var_21_2 = GameUtil.splitString2(var_21_1.bonus, true)[1]

			if not arg_21_0.itemIcon then
				arg_21_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_21_0.goreward)
			end

			arg_21_0.itemIcon:setMOValue(var_21_2[1], var_21_2[2], var_21_2[3])
			arg_21_0.itemIcon:isShowQuality(false)
			arg_21_0.itemIcon:isShowEquipAndItemCount(false)
			arg_21_0.itemIcon:setCanShowDeadLine(false)
		end
	end
end

function var_0_0.getSpBonusIndex(arg_22_0)
	local var_22_0 = recthelper.getAnchorX(arg_22_0.contentTransform)
	local var_22_1 = -(var_22_0 - arg_22_0.scrollWidth)
	local var_22_2 = -var_22_0
	local var_22_3 = Activity186MileStoneListModel.instance:getList()

	for iter_22_0, iter_22_1 in ipairs(var_22_3) do
		if iter_22_1.isSpBonus then
			local var_22_4 = arg_22_0:getItemPosX(iter_22_0)
			local var_22_5 = arg_22_0.actMo:getMilestoneRewardStatus(iter_22_1.rewardId)

			if var_22_2 <= var_22_4 and var_22_4 <= var_22_1 and var_22_5 == Activity186Enum.RewardStatus.Canget then
				return
			end

			if var_22_1 < var_22_4 and var_22_5 ~= Activity186Enum.RewardStatus.Hasget then
				return iter_22_0
			end
		end
	end
end

function var_0_0.getItemPosX(arg_23_0, arg_23_1)
	if arg_23_1 <= 0 then
		return 0
	end

	return (arg_23_1 - 1) * 240 + 95
end

function var_0_0.getItemWidth(arg_24_0, arg_24_1)
	if not arg_24_1 then
		return 0
	end

	if Activity186MileStoneListModel.instance:getList()[arg_24_1] then
		return 210
	end

	return 0
end

function var_0_0.moveToDefaultPos(arg_25_0)
	local var_25_0 = Activity186Config.instance:getMileStoneList(arg_25_0.actId)
	local var_25_1 = 1

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if arg_25_0.actMo:getMilestoneRewardStatus(iter_25_1.rewardId) ~= Activity186Enum.RewardStatus.Hasget then
			var_25_1 = iter_25_0

			break
		end
	end

	arg_25_0:_moveToIndex(var_25_1)
end

function var_0_0._moveToIndex(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return
	end

	arg_26_0.viewContainer.mileStoneScrollView:moveToByIndex(arg_26_1)
	arg_26_0:onValueChanged()
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.refreshLine, arg_28_0)

	if arg_28_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_28_0._moveTweenId)

		arg_28_0._moveTweenId = nil
	end
end

return var_0_0
