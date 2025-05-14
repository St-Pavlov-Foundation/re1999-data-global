module("modules.logic.versionactivity.view.VersionActivityTaskBonusItem", package.seeall)

local var_0_0 = class("VersionActivityTaskBonusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.txtIndex = gohelper.findChildText(arg_1_0.viewGO, "index")
	arg_1_0.imagePoint = gohelper.findChildImage(arg_1_0.viewGO, "progress/point")
	arg_1_0.scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_rewards")
	arg_1_0.goRewardRoot = gohelper.findChild(arg_1_0.viewGO, "#scroll_rewards/Viewport/rewardsroot")
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "go_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.pointItemList = {}
	arg_2_0.rewardItems = {}
	arg_2_0._animator = arg_2_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_2_0.imagePoint.gameObject, false)
	gohelper.setActive(arg_2_0.goFinish, false)
	arg_2_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.AddTaskActivityBonus, arg_2_0.addActivityPoints, arg_2_0)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0.co = arg_3_1

	arg_3_0:show()

	arg_3_0.txtIndex.text = string.format("%2d", arg_3_0.co.id)
	arg_3_0.taskActivityMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)

	arg_3_0:refreshPoints()
	arg_3_0:refreshRewardItems()
end

function var_0_0.refreshPoints(arg_4_0)
	local var_4_0
	local var_4_1 = arg_4_0.taskActivityMo
	local var_4_2 = 0

	gohelper.setActive(arg_4_0.goFinish, false)

	if arg_4_0.co.id <= var_4_1.defineId then
		var_4_2 = arg_4_0.co.needActivity

		gohelper.setActive(arg_4_0.goFinish, true)
	elseif arg_4_0.co.id == var_4_1.defineId + 1 then
		var_4_2 = var_4_1.value - var_4_1.gainValue
	end

	for iter_4_0 = 1, arg_4_0.co.needActivity do
		local var_4_3 = arg_4_0.pointItemList[iter_4_0]

		if not var_4_3 then
			var_4_3 = arg_4_0:getUserDataTb_()
			var_4_3.go = gohelper.cloneInPlace(arg_4_0.imagePoint.gameObject)
			var_4_3.image = var_4_3.go:GetComponent(gohelper.Type_Image)
			var_4_3.playGo = gohelper.findChild(var_4_3.go, "play")

			table.insert(arg_4_0.pointItemList, var_4_3)
		end

		gohelper.setActive(var_4_3.go, true)
		gohelper.setActive(var_4_3.playGo, false)
		UISpriteSetMgr.instance:setVersionActivitySprite(var_4_3.image, iter_4_0 <= var_4_2 and "img_li1" or "img_li2")
	end

	for iter_4_1 = arg_4_0.co.needActivity + 1, #arg_4_0.pointItemList do
		gohelper.setActive(arg_4_0.pointItemList[iter_4_1].go, false)
	end
end

function var_0_0.refreshRewardItems(arg_5_0)
	local var_5_0
	local var_5_1
	local var_5_2 = string.split(arg_5_0.co.bonus, "|")

	for iter_5_0 = 1, #var_5_2 do
		local var_5_3 = arg_5_0.rewardItems[iter_5_0]
		local var_5_4 = string.splitToNumber(var_5_2[iter_5_0], "#")

		if not var_5_3 then
			var_5_3 = IconMgr.instance:getCommonPropItemIcon(arg_5_0.goRewardRoot)

			table.insert(arg_5_0.rewardItems, var_5_3)
			transformhelper.setLocalScale(var_5_3.go.transform, 0.62, 0.62, 1)
			var_5_3:setMOValue(var_5_4[1], var_5_4[2], var_5_4[3], nil, true)
			var_5_3:setCountFontSize(50)
			var_5_3:showStackableNum2()
			var_5_3:isShowEffect(true)
			var_5_3:setHideLvAndBreakFlag(true)
			var_5_3:hideEquipLvAndBreak(true)
		else
			var_5_3:setMOValue(var_5_4[1], var_5_4[2], var_5_4[3], nil, true)
		end

		gohelper.setActive(var_5_3.go, true)
	end

	for iter_5_1 = #var_5_2 + 1, #arg_5_0.rewardItems do
		gohelper.setActive(arg_5_0.rewardItems[iter_5_1].go, false)
	end

	arg_5_0.scrollRewards.horizontalNormalizedPosition = 0
end

function var_0_0.addActivityPoints(arg_6_0)
	if not VersionActivityTaskBonusListModel.instance:checkActivityPointCountHasChange() then
		return
	end

	for iter_6_0 = 1, #arg_6_0.pointItemList do
		if VersionActivityTaskBonusListModel.instance:checkNeedPlayEffect(arg_6_0.co.id, iter_6_0) then
			local var_6_0 = arg_6_0.pointItemList[iter_6_0]

			gohelper.setActive(var_6_0.playGo, true)
		end
	end
end

function var_0_0.playAnimation(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._animator:Play(arg_7_1, 0, -arg_7_2)
end

function var_0_0.getAnimator(arg_8_0)
	return arg_8_0._animator
end

function var_0_0.show(arg_9_0)
	gohelper.setActive(arg_9_0.viewGO, true)
end

function var_0_0.hide(arg_10_0)
	gohelper.setActive(arg_10_0.viewGO, false)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
