module("modules.logic.sp01.act204.view.Activity204MileStoneItem", package.seeall)

local var_0_0 = class("Activity204MileStoneItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.transform = arg_1_0.viewGO.transform
	arg_1_0.txtValue = gohelper.findChildTextMesh(arg_1_0.viewGO, "#image_status_hasget/txt_pointvalue")
	arg_1_0.txtValue2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#image_status_grey/txt_pointvalue")
	arg_1_0.txtValue3 = gohelper.findChildTextMesh(arg_1_0.viewGO, "#image_status_canget/txt_pointvalue")
	arg_1_0.gohasget = gohelper.findChild(arg_1_0.viewGO, "#image_status_hasget")
	arg_1_0.gogrey = gohelper.findChild(arg_1_0.viewGO, "#image_status_grey")
	arg_1_0.gocanget = gohelper.findChild(arg_1_0.viewGO, "#image_status_canget")
	arg_1_0.rewardList = {}

	for iter_1_0 = 1, 2 do
		arg_1_0:getOrCreateRewardItem(iter_1_0)
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	if not arg_5_1 then
		gohelper.setActive(arg_5_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_5_0.viewGO, true)

	arg_5_0.actMo = Activity204Model.instance:getById(arg_5_0._mo.activityId)

	arg_5_0:refreshValue()
	arg_5_0:refreshReward()
end

function var_0_0.refreshValue(arg_6_0)
	local var_6_0 = arg_6_0._mo.isLoopBonus
	local var_6_1 = arg_6_0.actMo:getMilestoneRewardStatus(arg_6_0._mo.rewardId)
	local var_6_2 = var_6_1 == Activity204Enum.RewardStatus.Canget or var_6_1 == Activity204Enum.RewardStatus.Hasget
	local var_6_3 = ""
	local var_6_4 = var_6_0 and "∞" or arg_6_0.actMo:getMilestoneValue(arg_6_0._mo.rewardId)

	arg_6_0.txtValue.text = var_6_4
	arg_6_0.txtValue2.text = var_6_4
	arg_6_0.txtValue3.text = var_6_4

	gohelper.setActive(arg_6_0.gogrey, not var_6_2)
	gohelper.setActive(arg_6_0.gocanget, var_6_1 == Activity204Enum.RewardStatus.Canget)
	gohelper.setActive(arg_6_0.gohasget, var_6_1 == Activity204Enum.RewardStatus.Hasget)
end

function var_0_0.refreshReward(arg_7_0)
	local var_7_0 = GameUtil.splitString2(arg_7_0._mo.bonus, true)
	local var_7_1 = #var_7_0
	local var_7_2 = arg_7_0.actMo:getMilestoneRewardStatus(arg_7_0._mo.rewardId)

	for iter_7_0 = 1, math.max(#var_7_0, #arg_7_0.rewardList) do
		arg_7_0:updateRewardItem(arg_7_0:getOrCreateRewardItem(iter_7_0), var_7_0[iter_7_0], var_7_2)
	end

	arg_7_0.itemWidth = var_7_1 * 210 + (var_7_1 - 1) * 10

	recthelper.setWidth(arg_7_0.transform, arg_7_0.itemWidth)
end

function var_0_0.getOrCreateRewardItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.rewardList[arg_8_1]

	if not var_8_0 then
		local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "#go_rewards/#go_reward" .. arg_8_1)

		if not var_8_1 then
			return
		end

		var_8_0 = arg_8_0:getUserDataTb_()
		var_8_0.go = var_8_1
		var_8_0.goIcon = gohelper.findChild(var_8_1, "go_icon")
		var_8_0.goCanget = gohelper.findChild(var_8_1, "go_canget")
		var_8_0.goReceive = gohelper.findChild(var_8_1, "go_receive")
		arg_8_0.rewardList[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.updateRewardItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 then
		return
	end

	if not arg_9_2 then
		gohelper.setActive(arg_9_1.go, false)

		return
	end

	gohelper.setActive(arg_9_1.go, true)

	if not arg_9_1.itemIcon then
		arg_9_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_9_1.goIcon)
	end

	arg_9_1.itemIcon:setMOValue(arg_9_2[1], arg_9_2[2], arg_9_2[3], nil, true)
	arg_9_1.itemIcon:setScale(0.63)
	arg_9_1.itemIcon:setCountTxtSize(46)
	gohelper.setActive(arg_9_1.goCanget, arg_9_3 == Activity204Enum.RewardStatus.Canget)
	gohelper.setActive(arg_9_1.goReceive, arg_9_3 == Activity204Enum.RewardStatus.Hasget)

	local var_9_0 = {
		actId = arg_9_0._mo.activityId,
		status = arg_9_3,
		itemCo = arg_9_2
	}

	arg_9_1.itemIcon:customOnClickCallback(var_0_0.onClickItemIcon, var_9_0)
end

function var_0_0.onClickItemIcon(arg_10_0)
	local var_10_0 = arg_10_0.actId

	if not ActivityModel.instance:isActOnLine(var_10_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if arg_10_0.status == Activity204Enum.RewardStatus.Canget then
		Activity204Rpc.instance:sendGetAct204MilestoneRewardRequest(var_10_0)

		return
	end

	local var_10_1 = arg_10_0.itemCo

	MaterialTipController.instance:showMaterialInfo(var_10_1[1], var_10_1[2])
end

function var_0_0.getItemWidth(arg_11_0)
	return arg_11_0.itemWidth
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
