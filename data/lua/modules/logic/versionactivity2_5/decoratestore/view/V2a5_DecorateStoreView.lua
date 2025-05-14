module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreView", package.seeall)

local var_0_0 = class("V2a5_DecorateStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Right/#btn_goto")
	arg_1_0.txtLimitTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "Root/Right/#txt_LimitTime")
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.items = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnShop, arg_2_0._btngotoOnClick, arg_2_0)

	if arg_2_0.btnClose then
		arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	end

	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickBtnClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btngotoOnClick(arg_6_0)
	local var_6_0 = 10176

	if var_6_0 and var_6_0 ~= 0 then
		GameFacade.jump(var_6_0)
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.parent

	if var_8_0 then
		gohelper.addChild(var_8_0, arg_8_0.viewGO)
	end

	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.actId = ActivityEnum.Activity.V2a5_DecorateStore
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0:_showDeadline()
	arg_10_0:refreshItems()
end

function var_0_0.refreshItems(arg_11_0)
	local var_11_0 = ActivityConfig.instance:getNorSignActivityCos(arg_11_0.actId)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0:getOrCreateItem(iter_11_0)

		if var_11_1 then
			arg_11_0:updateItem(var_11_1, iter_11_1)
		end
	end
end

function var_0_0.getOrCreateItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.items[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()

		local var_12_1 = gohelper.findChild(arg_12_0.viewGO, string.format("Root/Right/Day/go_day%s", arg_12_1))

		var_12_0.go = var_12_1
		var_12_0.rewards = {}

		for iter_12_0 = 1, 3 do
			var_12_0.rewards[iter_12_0] = arg_12_0:createReward(var_12_1, iter_12_0)
		end

		var_12_0.goTomorrow = gohelper.findChild(var_12_1, "#go_TomorrowTag")
		arg_12_0.items[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.updateItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2.id
	local var_13_1 = ActivityType101Model.instance:isType101RewardGet(arg_13_0.actId, var_13_0)
	local var_13_2 = ActivityType101Model.instance:isType101RewardCouldGet(arg_13_0.actId, var_13_0)
	local var_13_3 = ActivityType101Model.instance:getType101LoginCount(arg_13_0.actId)
	local var_13_4 = GameUtil.splitString2(arg_13_2.bonus, true)

	for iter_13_0 = 1, math.max(#arg_13_1.rewards, #var_13_4) do
		local var_13_5 = arg_13_1.rewards[iter_13_0]
		local var_13_6 = var_13_4[iter_13_0]

		arg_13_0:updateReward(var_13_5, var_13_6, {
			actId = arg_13_0.actId,
			index = var_13_0,
			rewardGet = var_13_1,
			couldGet = var_13_2
		})
	end

	gohelper.setActive(arg_13_1.goTomorrow, var_13_0 == var_13_3 + 1)
end

function var_0_0.createReward(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.findChild(arg_14_1, string.format("reward/#go_rewarditem%s", arg_14_2))
	var_14_0.iconGO = gohelper.findChild(var_14_0.go, "go_icon")
	var_14_0.goCanget = gohelper.findChild(var_14_0.go, "go_canget")
	var_14_0.goReceive = gohelper.findChild(var_14_0.go, "go_receive")

	return var_14_0
end

function var_0_0.updateReward(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_1 then
		return
	end

	gohelper.setActive(arg_15_1.go, arg_15_2 ~= nil)

	if not arg_15_2 then
		return
	end

	gohelper.setActive(arg_15_1.goCanget, arg_15_3.couldGet)
	gohelper.setActive(arg_15_1.goReceive, arg_15_3.rewardGet)

	if not arg_15_1.itemIcon then
		arg_15_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_15_1.iconGO)
	end

	arg_15_1.itemIcon:setMOValue(arg_15_2[1], arg_15_2[2], arg_15_2[3])
	arg_15_1.itemIcon:setScale(0.7)
	arg_15_1.itemIcon:setCountFontSize(46)
	arg_15_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_15_1.itemIcon:hideEquipLvAndBreak(true)

	arg_15_3.itemCo = arg_15_2

	arg_15_1.itemIcon:customOnClickCallback(var_0_0.onClickItemIcon, arg_15_3)
end

function var_0_0.onClickItemIcon(arg_16_0)
	local var_16_0 = arg_16_0.actId
	local var_16_1 = arg_16_0.index

	if not ActivityModel.instance:isActOnLine(var_16_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if ActivityType101Model.instance:isType101RewardCouldGet(var_16_0, var_16_1) then
		Activity101Rpc.instance:sendGet101BonusRequest(var_16_0, var_16_1)

		return
	end

	local var_16_2 = arg_16_0.itemCo

	MaterialTipController.instance:showMaterialInfo(var_16_2[1], var_16_2[2])
end

function var_0_0._showDeadline(arg_17_0)
	arg_17_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_17_0._onRefreshDeadline, arg_17_0)
	TaskDispatcher.runRepeat(arg_17_0._onRefreshDeadline, arg_17_0, 60)
end

function var_0_0._onRefreshDeadline(arg_18_0)
	arg_18_0.txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_18_0.actId)
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onRefreshDeadline, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onRefreshDeadline, arg_20_0)
end

return var_0_0
