module("modules.logic.versionactivity2_3.newinsight.view.ActivityInsightShowTaskItem_2_3", package.seeall)

local var_0_0 = class("ActivityInsightShowTaskItem_2_3", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._index = arg_1_2
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goinfo = gohelper.findChild(arg_1_1, "root/info")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_1, "root/info/txt_taskdes")
	arg_1_0._txtprocess = gohelper.findChildText(arg_1_1, "root/info/txt_process")
	arg_1_0._gorewards = gohelper.findChild(arg_1_1, "root/scroll_reward/Viewport/go_rewardContent")
	arg_1_0._gonotget = gohelper.findChild(arg_1_1, "root/go_notget")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_1, "root/go_notget/btn_goto")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_1, "root/go_notget/btn_canget")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_1, "root/go_notget/btn_use")
	arg_1_0._goget = gohelper.findChild(arg_1_1, "root/go_get")

	gohelper.setActive(arg_1_0.go, false)

	arg_1_0._rewardItems = {}

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
end

function var_0_0._btngotoOnClick(arg_4_0)
	if arg_4_0._config.jumpId > 0 then
		GameFacade.jump(arg_4_0._config.jumpId)
	end
end

function var_0_0._btncangetOnClick(arg_5_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_5_0._config.id)
end

function var_0_0._btnuseOnClick(arg_6_0)
	local var_6_0 = {
		id = arg_6_0._config.itemId
	}

	var_6_0.uid = ItemInsightModel.instance:getEarliestExpireInsight(var_6_0.id).uid

	GiftController.instance:openGiftInsightHeroChoiceView(var_6_0)
end

function var_0_0.setTask(arg_7_0, arg_7_1)
	arg_7_0._taskId = arg_7_1

	arg_7_0:refresh()
end

function var_0_0.refresh(arg_8_0)
	arg_8_0._taskMO = TaskModel.instance:getTaskById(arg_8_0._taskId)

	gohelper.setActive(arg_8_0._goclick, false)
	gohelper.setActive(arg_8_0.go, true)

	arg_8_0._config = Activity172Config.instance:getAct172TaskById(arg_8_0._taskId)
	arg_8_0._txttaskdes.text = arg_8_0._config.desc
	arg_8_0._txtprocess.text = string.format("%s/%s", arg_8_0._taskMO.progress, arg_8_0._config.maxProgress)

	arg_8_0:_refreshTaskRewards()
	arg_8_0:_refreshBtns()
end

function var_0_0._refreshBtns(arg_9_0)
	gohelper.setActive(arg_9_0._goget, false)
	gohelper.setActive(arg_9_0._gonotget, false)
	gohelper.setActive(arg_9_0._btnuse.gameObject, false)
	gohelper.setActive(arg_9_0._btncanget.gameObject, false)
	gohelper.setActive(arg_9_0._btngoto.gameObject, false)

	if arg_9_0._taskMO.finishCount >= 1 then
		local var_9_0 = ActivityEnum.Activity.V2a3_NewInsight

		if not ActivityType172Model.instance:isTaskHasUsed(var_9_0, arg_9_0._taskId) and arg_9_0._config.itemId ~= 0 then
			gohelper.setActive(arg_9_0._gonotget, true)
			gohelper.setActive(arg_9_0._btnuse.gameObject, true)
		else
			gohelper.setActive(arg_9_0._goget, true)
		end
	elseif arg_9_0._taskMO.hasFinished then
		gohelper.setActive(arg_9_0._gonotget, true)
		gohelper.setActive(arg_9_0._btncanget.gameObject, true)
	else
		gohelper.setActive(arg_9_0._gonotget, true)
		gohelper.setActive(arg_9_0._btngoto.gameObject, true)
	end
end

function var_0_0._refreshTaskRewards(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._rewardItems) do
		gohelper.setActive(iter_10_1.go, false)
	end

	local var_10_0 = string.split(arg_10_0._config.bonus, "|")

	for iter_10_2 = 1, #var_10_0 do
		local var_10_1 = string.splitToNumber(var_10_0[iter_10_2], "#")

		if not arg_10_0._rewardItems[iter_10_2] then
			arg_10_0._rewardItems[iter_10_2] = IconMgr.instance:getCommonPropItemIcon(arg_10_0._gorewards)
		end

		gohelper.setActive(arg_10_0._rewardItems[iter_10_2].go, true)
		arg_10_0._rewardItems[iter_10_2]:setMOValue(var_10_1[1], var_10_1[2], var_10_1[3])
		arg_10_0._rewardItems[iter_10_2]:setScale(0.7)
		arg_10_0._rewardItems[iter_10_2]:setCountFontSize(46)
		arg_10_0._rewardItems[iter_10_2]:setHideLvAndBreakFlag(true)
	end
end

function var_0_0.destroy(arg_11_0)
	arg_11_0:removeEvents()
end

return var_0_0
