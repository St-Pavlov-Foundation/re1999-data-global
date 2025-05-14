module("modules.logic.explore.view.ExploreBonusItem", package.seeall)

local var_0_0 = class("ExploreBonusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._progress = gohelper.findChildImage(arg_1_1, "bottom/progressbar1/image_progresssilder")
	arg_1_0._progress2 = gohelper.findChildImage(arg_1_1, "bottom/progressbar2/image_progresssilder")
	arg_1_0._bglight = gohelper.findChild(arg_1_1, "bottom/bg_light")
	arg_1_0._bgdark = gohelper.findChild(arg_1_1, "bottom/bg_dark")
	arg_1_0._point = gohelper.findChildTextMesh(arg_1_1, "bottom/txt_point")
	arg_1_0._rewardItem = gohelper.findChild(arg_1_1, "go_rewarditem")
	arg_1_0._itemParent = gohelper.findChild(arg_1_1, "icons")
	arg_1_0._display = gohelper.findChild(arg_1_1, "bottom/bg_normal/bg_canget")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	ExploreController.instance:registerCallback(ExploreEvent.TaskUpdate, arg_2_0._onUpdateTask, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.TaskUpdate, arg_3_0._onUpdateTask, arg_3_0)
end

function var_0_0.getAnimator(arg_4_0)
	return arg_4_0._anim
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	local var_5_0 = string.splitToNumber(arg_5_1.listenerParam, "#")
	local var_5_1 = ExploreConfig.instance:getTaskList(var_5_0[1], var_5_0[2])
	local var_5_2 = TaskModel.instance:getTaskById(arg_5_1.id)
	local var_5_3 = var_5_2 and var_5_2.progress or 0
	local var_5_4 = 1
	local var_5_5 = 0
	local var_5_6 = var_5_3 >= arg_5_1.maxProgress

	if var_5_6 then
		if arg_5_0._index == #var_5_1 then
			var_5_5 = 1
		else
			local var_5_7 = TaskModel.instance:getTaskById(var_5_1[arg_5_0._index + 1].id)

			var_5_3 = var_5_7 and var_5_7.progress or var_5_3
			var_5_5 = Mathf.Clamp((var_5_3 - arg_5_1.maxProgress) / (var_5_1[arg_5_0._index + 1].maxProgress - arg_5_1.maxProgress), 0, 0.5)
			var_5_5 = var_5_5 * 2
		end
	elseif arg_5_0._index == 1 then
		var_5_4 = var_5_3 / arg_5_1.maxProgress
	else
		var_5_4 = Mathf.Clamp((var_5_3 - var_5_1[arg_5_0._index - 1].maxProgress) / (arg_5_1.maxProgress - var_5_1[arg_5_0._index - 1].maxProgress), 0.5, 1) - 0.5
		var_5_4 = var_5_4 * 2
	end

	arg_5_0._progress.fillAmount = var_5_4
	arg_5_0._progress2.fillAmount = var_5_5
	arg_5_0._point.text = arg_5_1.maxProgress

	SLFramework.UGUI.GuiHelper.SetColor(arg_5_0._point, var_5_6 and "#1e1919" or "#d2c197")

	local var_5_8 = GameUtil.splitString2(arg_5_1.bonus, true)

	arg_5_0._items = arg_5_0._items or {}

	gohelper.CreateObjList(arg_5_0, arg_5_0._setRewardItem, var_5_8, arg_5_0._itemParent, arg_5_0._rewardItem)
	arg_5_0:_onUpdateTask()
	gohelper.setActive(arg_5_0._display, arg_5_1.display == 1)
	gohelper.setActive(arg_5_0._bglight, var_5_6)
	gohelper.setActive(arg_5_0._bgdark, not var_5_6)
end

function var_0_0._setRewardItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._items[arg_6_3] = arg_6_0._items[arg_6_3] or {}

	local var_6_0 = gohelper.findChild(arg_6_1, "go_icon")
	local var_6_1 = gohelper.findChild(arg_6_1, "go_receive")
	local var_6_2 = arg_6_0._items[arg_6_3].item or IconMgr.instance:getCommonPropItemIcon(var_6_0)

	arg_6_0._items[arg_6_3].item = var_6_2

	var_6_2:setMOValue(arg_6_2[1], arg_6_2[2], arg_6_2[3], nil, true)
	var_6_2:setCountFontSize(46)
	var_6_2:SetCountBgHeight(31)

	arg_6_0._items[arg_6_3].hasget = var_6_1
end

function var_0_0._onUpdateTask(arg_7_0)
	local var_7_0 = TaskModel.instance:getTaskById(arg_7_0._mo.id)
	local var_7_1 = var_7_0 and var_7_0.finishCount > 0 or false

	for iter_7_0 = 1, #arg_7_0._items do
		gohelper.setActive(arg_7_0._items[iter_7_0].hasget, var_7_1)
	end
end

function var_0_0.onDestroy(arg_8_0)
	for iter_8_0 = 1, #arg_8_0._items do
		arg_8_0._items[iter_8_0].item:onDestroy()
	end
end

return var_0_0
