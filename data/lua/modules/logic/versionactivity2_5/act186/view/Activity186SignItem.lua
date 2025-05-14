module("modules.logic.versionactivity2_5.act186.view.Activity186SignItem", package.seeall)

local var_0_0 = class("Activity186SignItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "txtIndex")
	arg_1_0.goTomorrow = gohelper.findChild(arg_1_0.viewGO, "#go_TomorrowTag")
	arg_1_0.goNormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0.goCanget = gohelper.findChild(arg_1_0.viewGO, "#go_canget")
	arg_1_0.goCangetCookies1 = gohelper.findChild(arg_1_0.viewGO, "#go_canget/cookies1")
	arg_1_0.goCangetCookies2 = gohelper.findChild(arg_1_0.viewGO, "#go_canget/cookies2")
	arg_1_0.goHasget = gohelper.findChild(arg_1_0.viewGO, "#go_hasget")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClick")
	arg_1_0.canvasGroup = gohelper.findChildComponent(arg_1_0.viewGO, "#go_rewards", gohelper.Type_CanvasGroup)
	arg_1_0.rewardList = {}
	arg_1_0.hasgetCookiesAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#go_hasget/cookies/ani", gohelper.Type_Animator)
	arg_1_0.hasgetHookAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#go_hasget/gou/go_hasget", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClick:AddClickListener(arg_2_0.onClickBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.initActId(arg_5_0, arg_5_1)
	arg_5_0.act186Id = arg_5_1
end

function var_0_0.onClickBtn(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	local var_6_0 = Activity186SignModel.instance:getSignStatus(arg_6_0._mo.activityId, arg_6_0.act186Id, arg_6_0._mo.id)

	if var_6_0 == Activity186Enum.SignStatus.Canget then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_6_0._mo.activityId, arg_6_0._mo.id)
	elseif var_6_0 == Activity186Enum.SignStatus.None then
		GameFacade.showToast(ToastEnum.NorSign)
	else
		ViewMgr.instance:openView(ViewName.Activity186GameBiscuitsView, {
			config = arg_6_0._mo,
			act186Id = arg_6_0.act186Id
		})
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	if not arg_7_1 then
		gohelper.setActive(arg_7_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	local var_8_0 = arg_8_0._mo.id
	local var_8_1 = ActivityType101Model.instance:getType101LoginCount(arg_8_0._mo.activityId)

	gohelper.setActive(arg_8_0.goTomorrow, var_8_0 == var_8_1 + 1)

	local var_8_2 = Activity186SignModel.instance:getSignStatus(arg_8_0._mo.activityId, arg_8_0.act186Id, var_8_0)
	local var_8_3 = arg_8_0.status and arg_8_0.status ~= var_8_2

	gohelper.setActive(arg_8_0.goNormal, var_8_2 == Activity186Enum.SignStatus.None)
	gohelper.setActive(arg_8_0.goCanget, var_8_2 == Activity186Enum.SignStatus.Canplay or var_8_2 == Activity186Enum.SignStatus.Canget)
	gohelper.setActive(arg_8_0.goCangetCookies1, var_8_2 == Activity186Enum.SignStatus.Canplay)
	gohelper.setActive(arg_8_0.goCangetCookies2, var_8_2 == Activity186Enum.SignStatus.Canget)
	gohelper.setActive(arg_8_0.goHasget, var_8_2 == Activity186Enum.SignStatus.Hasget)

	if var_8_2 == Activity186Enum.SignStatus.Hasget then
		arg_8_0.txtIndex.text = string.format("<color=#6A372C>Day %s</color>", var_8_0)
	else
		arg_8_0.txtIndex.text = string.format("Day %s", var_8_0)
	end

	arg_8_0.canvasGroup.alpha = var_8_2 == Activity186Enum.SignStatus.Hasget and 0.5 or 1

	arg_8_0:refreshReward(var_8_2)

	if var_8_2 == Activity186Enum.SignStatus.Hasget then
		if var_8_3 then
			arg_8_0.hasgetCookiesAnim:Play("open")
			arg_8_0.hasgetHookAnim:Play("go_hasget_in")
		else
			arg_8_0.hasgetCookiesAnim:Play("opened")
			arg_8_0.hasgetHookAnim:Play("go_hasget_idle")
		end
	end

	arg_8_0.status = var_8_2
end

function var_0_0.refreshReward(arg_9_0, arg_9_1)
	local var_9_0 = GameUtil.splitString2(arg_9_0._mo.bonus, true)

	for iter_9_0 = 1, math.max(#var_9_0, #arg_9_0.rewardList) do
		arg_9_0:updateRewardItem(arg_9_0:getOrCreateRewardItem(iter_9_0), var_9_0[iter_9_0], arg_9_1)
	end
end

function var_0_0.getOrCreateRewardItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.rewardList[arg_10_1]

	if not var_10_0 then
		local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "#go_rewards/#go_reward" .. arg_10_1)

		if not var_10_1 then
			return
		end

		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = var_10_1
		var_10_0.goIcon = gohelper.findChild(var_10_1, "go_icon")
		arg_10_0.rewardList[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0.updateRewardItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_1 then
		return
	end

	if not arg_11_2 then
		gohelper.setActive(arg_11_1.go, false)

		return
	end

	gohelper.setActive(arg_11_1.go, true)

	if not arg_11_1.itemIcon then
		arg_11_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_11_1.goIcon)
	end

	arg_11_1.itemIcon:setMOValue(arg_11_2[1], arg_11_2[2], arg_11_2[3])
	arg_11_1.itemIcon:setScale(0.7)
	arg_11_1.itemIcon:setCountFontSize(46)
	arg_11_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_11_1.itemIcon:hideEquipLvAndBreak(true)

	local var_11_0 = {
		actId = arg_11_0._mo.activityId,
		index = arg_11_0._mo.id,
		status = arg_11_3,
		itemCo = arg_11_2,
		selfitem = arg_11_0
	}

	arg_11_1.itemIcon:customOnClickCallback(var_0_0.onClickItemIcon, var_11_0)
end

function var_0_0.onClickItemIcon(arg_12_0)
	local var_12_0 = arg_12_0.actId

	if not ActivityModel.instance:isActOnLine(var_12_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local var_12_1 = arg_12_0.itemCo

	MaterialTipController.instance:showMaterialInfo(var_12_1[1], var_12_1[2])
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
