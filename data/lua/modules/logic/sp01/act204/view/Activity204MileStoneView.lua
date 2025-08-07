module("modules.logic.sp01.act204.view.Activity204MileStoneView", package.seeall)

local var_0_0 = class("Activity204MileStoneView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnStoneCanget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/leftReward/#btn_click")
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
	arg_1_0.imageSpBonusRare = gohelper.findChildImage(arg_1_0.viewGO, "root/bonusNode/bubble/#image_rare")
	arg_1_0.goreward = gohelper.findChild(arg_1_0.viewGO, "root/bonusNode/bubble/goreward")

	gohelper.setActive(arg_1_0.goBubble, false)

	arg_1_0.cellSpace = 0
	arg_1_0.bonusAnim = gohelper.findChildComponent(arg_1_0.viewGO, "root/bonusNode", gohelper.Type_Animator)
	arg_1_0.gocangetdaily = gohelper.findChild(arg_1_0.viewGO, "root/leftReward/dailyreward/canget")
	arg_1_0.txtdailynum = gohelper.findChildText(arg_1_0.viewGO, "root/leftReward/dailyreward/canget/numbg/#txt_num")
	arg_1_0.gohasgetdaily = gohelper.findChild(arg_1_0.viewGO, "root/leftReward/dailyreward/hasget")
	arg_1_0.txtcangettips = gohelper.findChildText(arg_1_0.viewGO, "root/leftReward/dailyreward/hasget/txt_canget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.scroll:AddOnValueChanged(arg_2_0.onValueChanged, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnStoneCanget, arg_2_0.onClickBtnStoneCanget, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSpBonus, arg_2_0.onClickBtnSpBonus, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.GetDailyCollection, arg_2_0.onGetDailyCollection, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.GetMilestoneReward, arg_2_0.onGetMilestoneReward, arg_2_0)
	arg_2_0:addEventCb(Activity204Controller.instance, Activity204Event.UpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.scroll:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onValueChanged(arg_5_0)
	arg_5_0:refreshSpBonusReward()
end

function var_0_0.onClickBtnStoneCanget(arg_6_0)
	if arg_6_0.actMo.getDailyCollection then
		return
	end

	Activity204Rpc.instance:sendGetAct204DailyCollectionRequest(arg_6_0.actId)
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

	if arg_9_1[Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)] then
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
	arg_14_0:refreshView()
end

function var_0_0.refreshParam(arg_15_0)
	arg_15_0.actId = arg_15_0.viewParam.actId
	arg_15_0.actMo = Activity204Model.instance:getById(arg_15_0.actId)

	Activity204MileStoneListModel.instance:init(arg_15_0.actMo)
end

function var_0_0.refreshView(arg_16_0)
	arg_16_0._waitRefresh = false

	arg_16_0:refreshList()
	arg_16_0:refreshStone()
end

function var_0_0.refreshStone(arg_17_0)
	local var_17_0 = arg_17_0.actMo.getDailyCollection
	local var_17_1 = string.splitToNumber(Activity204Config.instance:getConstStr(Activity204Enum.ConstId.DailyStoneCount), "#")
	local var_17_2 = var_17_1 and var_17_1[3]

	arg_17_0.txtdailynum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), var_17_2)

	gohelper.setActive(arg_17_0.gohasgetdaily, var_17_0)
	gohelper.setActive(arg_17_0.gocangetdaily, not var_17_0)

	if var_17_0 then
		arg_17_0.txtcangettips.text = luaLangUTC("activity204taskview_dailyget")
	end

	local var_17_3 = Activity204MileStoneListModel.instance:getMaxMileStoneValue()
	local var_17_4 = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
	local var_17_5 = CurrencyModel.instance:getCurrency(var_17_4)
	local var_17_6 = var_17_5 and var_17_5.quantity or 0

	arg_17_0.txtStoneProgress.text = string.format("%s/%s", var_17_6, var_17_3)
end

function var_0_0.refreshList(arg_18_0)
	Activity204MileStoneListModel.instance:refresh()
	TaskDispatcher.cancelTask(arg_18_0.refreshLine, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.refreshLine, arg_18_0, 0.01)
end

function var_0_0.refreshLine(arg_19_0)
	local var_19_0 = Activity204MileStoneListModel.instance:caleProgressIndex()
	local var_19_1 = math.floor(var_19_0)
	local var_19_2 = Activity204MileStoneListModel.instance:getItemPosX(var_19_1)
	local var_19_3 = var_19_0 - var_19_1

	if var_19_3 > 0 then
		var_19_2 = var_19_2 + (Activity204MileStoneListModel.instance:getItemWidth(var_19_1) + Activity204MileStoneListModel.instance:getItemWidth(var_19_1 + 1)) / 2 * var_19_3
	end

	if arg_19_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_19_0._moveTweenId)

		arg_19_0._moveTweenId = nil
	end

	if arg_19_0._lineWith and arg_19_0._lineWith ~= var_19_2 then
		arg_19_0._lineWith = var_19_2
		arg_19_0._moveTweenId = ZProj.TweenHelper.DOWidth(arg_19_0.trsLine, var_19_2, 2)

		arg_19_0.bonusAnim:Play("get", 0, 0)
	else
		arg_19_0.bonusAnim:Play("idle")

		arg_19_0._lineWith = var_19_2

		recthelper.setWidth(arg_19_0.trsLine, var_19_2)
	end

	if not arg_19_0.isOpen then
		arg_19_0.isOpen = true

		arg_19_0:moveToDefaultPos()
	end

	arg_19_0:onValueChanged()
end

function var_0_0.refreshSpBonusReward(arg_20_0)
	local var_20_0 = arg_20_0:getSpBonusIndex()

	if arg_20_0._spBonusIndex == var_20_0 then
		return
	end

	arg_20_0._spBonusIndex = var_20_0

	gohelper.setActive(arg_20_0.goBubble, var_20_0 ~= nil)

	if var_20_0 ~= nil then
		local var_20_1 = Activity204Config.instance:getMileStoneList(arg_20_0.actId)[var_20_0]

		if var_20_1 then
			local var_20_2 = GameUtil.splitString2(var_20_1.bonus, true)[1]

			if not arg_20_0.itemIcon then
				arg_20_0.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_20_0.goreward)
			end

			arg_20_0.itemIcon:setMOValue(var_20_2[1], var_20_2[2], var_20_2[3], nil, true)
			arg_20_0.itemIcon:isShowQuality(false)
			arg_20_0.itemIcon:isShowEquipAndItemCount(false)
			arg_20_0.itemIcon:setCanShowDeadLine(false)

			local var_20_3 = ItemModel.instance:getItemConfigAndIcon(var_20_2[1], var_20_2[2], true)
			local var_20_4 = var_20_3 and var_20_3.rare or 5

			UISpriteSetMgr.instance:setOptionalGiftSprite(arg_20_0.imageSpBonusRare, "bg_pinjidi_" .. tostring(var_20_4))
		end
	end
end

function var_0_0.getSpBonusIndex(arg_21_0)
	local var_21_0 = recthelper.getAnchorX(arg_21_0.contentTransform)
	local var_21_1 = -(var_21_0 - arg_21_0.scrollWidth)
	local var_21_2 = -var_21_0
	local var_21_3 = Activity204MileStoneListModel.instance:getList()

	for iter_21_0, iter_21_1 in ipairs(var_21_3) do
		if iter_21_1.isSpBonus then
			local var_21_4 = Activity204MileStoneListModel.instance:getItemPosX(iter_21_0)
			local var_21_5 = arg_21_0.actMo:getMilestoneRewardStatus(iter_21_1.rewardId)

			if var_21_2 <= var_21_4 and var_21_4 <= var_21_1 and var_21_5 == Activity204Enum.RewardStatus.Canget then
				return
			end

			if var_21_1 < var_21_4 and var_21_5 ~= Activity204Enum.RewardStatus.Hasget then
				return iter_21_0
			end
		end
	end
end

function var_0_0.moveToDefaultPos(arg_22_0)
	local var_22_0 = Activity204Config.instance:getMileStoneList(arg_22_0.actId)
	local var_22_1 = 1

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if arg_22_0.actMo:getMilestoneRewardStatus(iter_22_1.rewardId) ~= Activity204Enum.RewardStatus.Hasget then
			var_22_1 = iter_22_0

			break
		end
	end

	arg_22_0:_moveToIndex(var_22_1)
end

function var_0_0._moveToIndex(arg_23_0, arg_23_1)
	if not arg_23_1 then
		return
	end

	arg_23_0:moveToByIndex(arg_23_1)
	arg_23_0:onValueChanged()
end

function var_0_0.moveToByIndex(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.viewContainer.mileStoneScrollView._csMixScroll.gameObject
	local var_24_1 = Activity204MileStoneListModel.instance:getItemFocusPosX(arg_24_1)
	local var_24_2 = var_24_0:GetComponent(gohelper.Type_ScrollRect)
	local var_24_3 = var_24_2.content
	local var_24_4 = 0
	local var_24_5 = recthelper.getWidth(var_24_3) - recthelper.getWidth(var_24_2.transform)
	local var_24_6 = math.max(0, var_24_5)
	local var_24_7 = -math.min(var_24_6, var_24_1)

	recthelper.setAnchorX(var_24_3, var_24_7)
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.refreshLine, arg_26_0)

	if arg_26_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._moveTweenId)

		arg_26_0._moveTweenId = nil
	end
end

return var_0_0
