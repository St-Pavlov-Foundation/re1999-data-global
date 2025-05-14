module("modules.logic.versionactivity2_5.act186.view.Activity186MileStoneItem", package.seeall)

local var_0_0 = class("Activity186MileStoneItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.transform = arg_1_0.viewGO.transform
	arg_1_0.txtValue = gohelper.findChildTextMesh(arg_1_0.viewGO, "txt_pointvalue")
	arg_1_0.goStatus = gohelper.findChild(arg_1_0.viewGO, "#image_status")
	arg_1_0.goStatusGrey = gohelper.findChild(arg_1_0.viewGO, "#image_statusgrey")
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

	arg_5_0.actMo = Activity186Model.instance:getById(arg_5_0._mo.activityId)

	arg_5_0:refreshValue()
	arg_5_0:refreshReward()
end

function var_0_0.refreshValue(arg_6_0)
	local var_6_0 = arg_6_0._mo.isLoopBonus
	local var_6_1 = arg_6_0.actMo:getMilestoneRewardStatus(arg_6_0._mo.rewardId)
	local var_6_2 = var_6_1 == Activity186Enum.RewardStatus.Canget or var_6_1 == Activity186Enum.RewardStatus.Hasget

	if var_6_0 then
		arg_6_0.txtValue.text = "∞"
	else
		local var_6_3 = arg_6_0.actMo:getMilestoneValue(arg_6_0._mo.rewardId)

		if var_6_2 then
			arg_6_0.txtValue.text = string.format("<color=#BF5E26>%s</color>", var_6_3)
		else
			arg_6_0.txtValue.text = var_6_3
		end
	end

	gohelper.setActive(arg_6_0.goStatus, var_6_2)
	gohelper.setActive(arg_6_0.goStatusGrey, not var_6_2)
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
		var_8_0.imgCircle = gohelper.findChildImage(var_8_1, "#image_circle")
		var_8_0.imgQuality = gohelper.findChildImage(var_8_1, "#image_quality")
		var_8_0.goIcon = gohelper.findChild(var_8_1, "go_icon")
		var_8_0.goCanget = gohelper.findChild(var_8_1, "go_canget")
		var_8_0.goReceive = gohelper.findChild(var_8_1, "go_receive")
		var_8_0.txtNum = gohelper.findChildTextMesh(var_8_1, "#txt_num")
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

	local var_9_0 = ItemModel.instance:getItemConfigAndIcon(arg_9_2[1], arg_9_2[2])

	UISpriteSetMgr.instance:setUiFBSprite(arg_9_1.imgQuality, "bg_pinjidi_" .. var_9_0.rare)
	UISpriteSetMgr.instance:setUiFBSprite(arg_9_1.imgCircle, "bg_pinjidi_lanse_" .. var_9_0.rare)

	if not arg_9_1.itemIcon then
		arg_9_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_9_1.goIcon)
	end

	arg_9_1.itemIcon:setMOValue(arg_9_2[1], arg_9_2[2], arg_9_2[3])
	arg_9_1.itemIcon:setScale(0.7)
	arg_9_1.itemIcon:isShowQuality(false)
	arg_9_1.itemIcon:isShowEquipAndItemCount(false)
	gohelper.setActive(arg_9_1.goCanget, arg_9_3 == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(arg_9_1.goReceive, arg_9_3 == Activity186Enum.RewardStatus.Hasget)

	local var_9_1 = {
		actId = arg_9_0._mo.activityId,
		status = arg_9_3,
		itemCo = arg_9_2
	}

	arg_9_1.itemIcon:customOnClickCallback(var_0_0.onClickItemIcon, var_9_1)

	if arg_9_2[2] == 171504 then
		arg_9_1.txtNum.text = ""
	else
		arg_9_1.txtNum.text = string.format("×%s", arg_9_2[3])
	end
end

function var_0_0.onClickItemIcon(arg_10_0)
	local var_10_0 = arg_10_0.actId

	if not ActivityModel.instance:isActOnLine(var_10_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if arg_10_0.status == Activity186Enum.RewardStatus.Canget then
		Activity186Rpc.instance:sendGetAct186MilestoneRewardRequest(var_10_0)

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
