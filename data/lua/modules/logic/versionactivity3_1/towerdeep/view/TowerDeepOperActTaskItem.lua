module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActTaskItem", package.seeall)

local var_0_0 = class("TowerDeepOperActTaskItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.go, "txt_task")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.go, "go_rewarditem")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.go, "go_rewarditem/go_icon")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.go, "go_rewarditem/go_canget")
	arg_1_0._goreceive = gohelper.findChild(arg_1_0.go, "go_rewarditem/go_receive")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "go_rewarditem/btn_click")

	arg_1_0:_initItem()
	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._config and arg_4_0._canGetReward then
		TaskRpc.instance:sendFinishTaskRequest(arg_4_0._config.id)

		return
	end

	if not arg_4_0._bonus or #arg_4_0._bonus <= 0 then
		local var_4_0 = arg_4_0._config and arg_4_0._config.id

		logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(var_4_0))

		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_4_0._bonus[1], arg_4_0._bonus[2])
end

function var_0_0.refresh(arg_5_0)
	arg_5_0._taskMo = TaskModel.instance:getTaskById(arg_5_0._config.id)

	local var_5_0 = arg_5_0._taskMo and arg_5_0._taskMo.finishCount > 0
	local var_5_1 = arg_5_0._taskMo and arg_5_0._taskMo.progress or 0

	arg_5_0._canGetReward = arg_5_0._taskMo and var_5_1 >= arg_5_0._config.maxProgress and arg_5_0._taskMo.finishCount <= 0

	gohelper.setActive(arg_5_0._gocanget, arg_5_0._canGetReward)
	gohelper.setActive(arg_5_0._goreceive, var_5_0)
end

function var_0_0._initItem(arg_6_0)
	arg_6_0._txttask.text = string.format(arg_6_0._config.desc, arg_6_0._config.maxProgress)
	arg_6_0._bonus = string.splitToNumber(arg_6_0._config.bonus, "#")
	arg_6_0._rewardItem = IconMgr.instance:getCommonItemIcon(arg_6_0._goicon)

	arg_6_0._rewardItem:setMOValue(arg_6_0._bonus[1], arg_6_0._bonus[2], arg_6_0._bonus[3], nil, true)
	arg_6_0._rewardItem:isShowName(false)
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:removeEvents()
end

return var_0_0
