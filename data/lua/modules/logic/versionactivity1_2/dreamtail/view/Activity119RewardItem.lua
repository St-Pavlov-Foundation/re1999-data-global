module("modules.logic.versionactivity1_2.dreamtail.view.Activity119RewardItem", package.seeall)

local var_0_0 = class("Activity119RewardItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.taskId = nil
	arg_1_0.bonusCount = 0
	arg_1_0.bonusItems = {}

	arg_1_0:onInitView()
	arg_1_0:addEvents()
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._rewards = {}

	for iter_2_0 = 1, 3 do
		arg_2_0._rewards[iter_2_0] = {}
		arg_2_0._rewards[iter_2_0]._goreward = gohelper.findChild(arg_2_0.go, "reward" .. iter_2_0)
		arg_2_0._rewards[iter_2_0]._bg = gohelper.findChild(arg_2_0._rewards[iter_2_0]._goreward, "bg")
		arg_2_0._rewards[iter_2_0]._itemposContent = gohelper.findChild(arg_2_0._rewards[iter_2_0]._goreward, "itemposContent")
		arg_2_0._rewards[iter_2_0]._state = gohelper.findChild(arg_2_0._rewards[iter_2_0]._goreward, "state")
		arg_2_0._rewards[iter_2_0]._lockbg = gohelper.findChild(arg_2_0._rewards[iter_2_0]._goreward, "lockbg")

		for iter_2_1 = 1, 3 do
			arg_2_0._rewards[iter_2_0]["_itempos" .. iter_2_1] = gohelper.findChild(arg_2_0._rewards[iter_2_0]._itemposContent, "itempos" .. iter_2_1)
		end

		arg_2_0._rewards[iter_2_0]._goclaimed = gohelper.findChild(arg_2_0._rewards[iter_2_0]._state, "go_claimed")
		arg_2_0._rewards[iter_2_0]._goclaim = gohelper.findChild(arg_2_0._rewards[iter_2_0]._state, "go_claim")
		arg_2_0._rewards[iter_2_0]._golocked = gohelper.findChild(arg_2_0._rewards[iter_2_0]._state, "go_locked")
		arg_2_0._rewards[iter_2_0]._btnclaim = gohelper.findChildButtonWithAudio(arg_2_0._rewards[iter_2_0]._state, "go_claim")
		arg_2_0._rewards[iter_2_0]._canvasGroup = gohelper.onceAddComponent(arg_2_0._rewards[iter_2_0]._itemposContent, typeof(UnityEngine.CanvasGroup))

		gohelper.setActive(arg_2_0._rewards[iter_2_0]._goreward, false)
	end
end

function var_0_0.addEvents(arg_3_0)
	for iter_3_0 = 1, 3 do
		arg_3_0._rewards[iter_3_0]._btnclaim:AddClickListener(arg_3_0.onTaskFinish, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	for iter_4_0 = 1, 3 do
		arg_4_0._rewards[iter_4_0]._btnclaim:RemoveClickListener()
	end
end

function var_0_0.setBonus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.taskId = arg_5_2

	local var_5_0 = GameUtil.splitString2(arg_5_1, true)
	local var_5_1 = #var_5_0

	if arg_5_0.bonusCount ~= var_5_1 then
		if arg_5_0.bonusCount > 0 then
			gohelper.setActive(arg_5_0._rewards[arg_5_0.bonusCount]._goreward, false)
		end

		gohelper.setActive(arg_5_0._rewards[var_5_1]._goreward, true)

		for iter_5_0 = var_5_1 + 1, arg_5_0.bonusCount do
			gohelper.setActive(arg_5_0.bonusItems[iter_5_0].go, false)
		end

		for iter_5_1 = 1, var_5_1 do
			if not arg_5_0.bonusItems[iter_5_1] then
				arg_5_0.bonusItems[iter_5_1] = IconMgr.instance:getCommonPropItemIcon(arg_5_0._rewards[var_5_1]["_itempos" .. iter_5_1])
			else
				gohelper.setActive(arg_5_0.bonusItems[iter_5_1].go, true)
				arg_5_0.bonusItems[iter_5_1].go.transform:SetParent(arg_5_0._rewards[var_5_1]["_itempos" .. iter_5_1].transform, false)
			end
		end

		arg_5_0.bonusCount = var_5_1
	end

	local var_5_2 = arg_5_0._rewards[arg_5_0.bonusCount]

	arg_5_3 = true

	gohelper.setActive(var_5_2._bg, arg_5_3)
	gohelper.setActive(var_5_2._itemposContent, arg_5_3)
	gohelper.setActive(var_5_2._state, arg_5_3)
	gohelper.setActive(var_5_2._lockbg, not arg_5_3)

	if arg_5_3 then
		for iter_5_2 = 1, var_5_1 do
			local var_5_3 = var_5_0[iter_5_2]

			arg_5_0.bonusItems[iter_5_2]:setMOValue(var_5_3[1], var_5_3[2], var_5_3[3], nil, true)
			arg_5_0.bonusItems[iter_5_2]:setCountFontSize(48)
			arg_5_0.bonusItems[iter_5_2]:SetCountBgHeight(32)
		end
	end
end

function var_0_0.updateTaskStatus(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._rewards[arg_6_0.bonusCount]

	gohelper.setActive(var_6_0._goclaimed, arg_6_1 == 3)
	gohelper.setActive(var_6_0._goclaim, arg_6_1 == 2)
	gohelper.setActive(var_6_0._golocked, arg_6_1 == 1)

	var_6_0._canvasGroup.alpha = arg_6_1 == 3 and 0.7 or 1

	for iter_6_0 = 1, #arg_6_0.bonusItems do
		arg_6_0.bonusItems[iter_6_0]:setAlpha(arg_6_1 == 3 and 0.5 or 1)
	end
end

function var_0_0.onTaskFinish(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	TaskRpc.instance:sendFinishTaskRequest(arg_7_0.taskId)
end

function var_0_0.dispose(arg_8_0)
	arg_8_0:removeEvents()

	arg_8_0.go = nil
	arg_8_0.bonusCount = 0

	for iter_8_0 = 1, #arg_8_0.bonusItems do
		arg_8_0.bonusItems[iter_8_0]:onDestroy()
	end

	arg_8_0.bonusItems = nil

	for iter_8_1 = 1, 3 do
		for iter_8_2, iter_8_3 in pairs(arg_8_0._rewards[iter_8_1]) do
			arg_8_0._rewards[iter_8_1][iter_8_2] = nil
		end
	end

	arg_8_0._rewards = nil
	arg_8_0.taskId = nil
end

return var_0_0
