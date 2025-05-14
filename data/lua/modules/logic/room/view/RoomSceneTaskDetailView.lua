module("modules.logic.room.view.RoomSceneTaskDetailView", package.seeall)

local var_0_0 = class("RoomSceneTaskDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotask1 = gohelper.findChild(arg_1_0.viewGO, "taskContent/#go_task1")
	arg_1_0._gotask2 = gohelper.findChild(arg_1_0.viewGO, "taskContent/#go_task2")
	arg_1_0._gotask3 = gohelper.findChild(arg_1_0.viewGO, "taskContent/#go_task3")
	arg_1_0._gotask4 = gohelper.findChild(arg_1_0.viewGO, "taskContent/#go_task4")
	arg_1_0._gotask5 = gohelper.findChild(arg_1_0.viewGO, "taskContent/#go_task5")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

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

var_0_0.PageShowNum = 5

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemObjs = {}
	arg_4_0._bgmask = gohelper.findChildSingleImage(arg_4_0.viewGO, "#bg_mask")
end

function var_0_0.onDestroyView(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._itemObjs) do
		if not gohelper.isNil(iter_5_1.btntouch) then
			iter_5_1.btntouch:RemoveClickListener()
		end

		if not gohelper.isNil(iter_5_1.simagebonus) then
			iter_5_1.simagebonus:UnLoadImage()
		end

		if iter_5_0 == 1 then
			iter_5_1.btnEdit:RemoveClickListener()
			iter_5_1.btnExpansion:RemoveClickListener()
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._curPage = 1

	arg_6_0:addEventCb(RoomSceneTaskController.instance, RoomEvent.TaskUpdate, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	for iter_8_0 = 1, var_0_0.PageShowNum do
		arg_8_0:refreshItem(iter_8_0)
	end
end

function var_0_0.onClickTask(arg_9_0)
	local var_9_0 = arg_9_0.self
	local var_9_1 = arg_9_0.index
	local var_9_2 = var_9_1 + (var_9_0._curPage - 1) * var_0_0.PageShowNum
	local var_9_3 = RoomTaskModel.instance:getShowList()[var_9_2]

	if not var_9_3 then
		return
	end

	if RoomTaskModel.instance:tryGetTaskMO(var_9_3.id) and var_9_1 == 1 then
		var_9_0:showMaterialInfoByTaskConfig(var_9_3)
	elseif var_9_3 then
		if RoomSceneTaskController.isTaskOverUnlockLevel(var_9_3) then
			GameFacade.showToast(ToastEnum.RoomTaskUnlock)
		else
			GameFacade.showToast(ToastEnum.RoomSceneTaskOpen, var_9_3.name)
		end
	end
end

function var_0_0.onClickJump(arg_10_0)
	local var_10_0 = RoomTaskModel.instance:getShowList()

	if var_10_0 and #var_10_0 > 0 then
		local var_10_1 = var_10_0[1]

		if RoomTaskModel.instance:tryGetTaskMO(var_10_1.id) and not RoomSceneTaskDetailController.instance:goToTask(var_10_1) then
			arg_10_0:closeThis()
		end
	end
end

function var_0_0.showMaterialInfoByTaskConfig(arg_11_0, arg_11_1)
	local var_11_0 = string.split(arg_11_1.bonus, "|")

	if #var_11_0 > 0 then
		local var_11_1 = string.splitToNumber(var_11_0[1], "#")
		local var_11_2 = tonumber(var_11_1[1])
		local var_11_3 = tonumber(var_11_1[2])
		local var_11_4, var_11_5 = ItemModel.instance:getItemConfigAndIcon(var_11_2, var_11_3)

		MaterialTipController.instance:showMaterialInfo(var_11_2, var_11_3, false, nil, true)
	end
end

function var_0_0.getOrCreateItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._itemObjs[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.go = arg_12_0["_gotask" .. tostring(arg_12_1)]
		var_12_0.gofinish = gohelper.findChild(var_12_0.go, "go_finish")
		var_12_0.gounfinish = gohelper.findChild(var_12_0.go, "go_unfinish")
		var_12_0.golock = gohelper.findChild(var_12_0.go, "go_unfinish/go_lock")
		var_12_0.txtlock = gohelper.findChildText(var_12_0.go, "go_unfinish/go_lock/txt_lock")
		var_12_0.gorunning = gohelper.findChild(var_12_0.go, "go_running")
		var_12_0.goorderbg = gohelper.findChild(var_12_0.go, "go_lightbg")
		var_12_0.txtid = gohelper.findChildText(var_12_0.go, "txt_id")

		if arg_12_1 == 1 then
			var_12_0.goJump = gohelper.findChild(var_12_0.go, "#go_jump")
			var_12_0.txtnum = gohelper.findChildText(var_12_0.goJump, "txt_rewardnum")
			var_12_0.txtdesc = gohelper.findChildText(var_12_0.goJump, "txt_taskdesc")
			var_12_0.txtRunningTips = gohelper.findChildText(var_12_0.goJump, "txt_rewardtip")
			var_12_0.simagebonus = gohelper.findChildSingleImage(var_12_0.goJump, "simage_reward")
			var_12_0.imagebonus = gohelper.findChildImage(var_12_0.goJump, "simage_reward")
			var_12_0.btnEdit = gohelper.findChildButtonWithAudio(var_12_0.goJump, "btn_edit")
			var_12_0.btnExpansion = gohelper.findChildButtonWithAudio(var_12_0.goJump, "btn_expansion")
			var_12_0.btntouch = gohelper.findChildButtonWithAudio(var_12_0.goJump, "btn_touch")

			var_12_0.btnEdit:AddClickListener(arg_12_0.onClickJump, arg_12_0)
			var_12_0.btnExpansion:AddClickListener(arg_12_0.onClickJump, arg_12_0)

			local var_12_1 = gohelper.findChild(var_12_0.go, "btn_touch")

			gohelper.setActive(var_12_1, false)
		else
			var_12_0.txtnum = gohelper.findChildText(var_12_0.go, "go_unfinish/txt_num")
			var_12_0.txtdesc = gohelper.findChildText(var_12_0.go, "go_unfinish/txt_desc")
			var_12_0.simagebonus = gohelper.findChildSingleImage(var_12_0.go, "go_unfinish/simage_build")
			var_12_0.imagebonus = gohelper.findChildImage(var_12_0.go, "go_unfinish/simage_build")
			var_12_0.btntouch = gohelper.findChildButtonWithAudio(var_12_0.go, "btn_touch")
		end

		var_12_0.btntouch:AddClickListener(arg_12_0.onClickTask, {
			self = arg_12_0,
			index = arg_12_1
		})

		arg_12_0._itemObjs[arg_12_1] = var_12_0
	end

	return var_12_0
end

local var_0_1 = Color.New(0.090196, 0.08627451, 0.08627451, 1)
local var_0_2 = Color.New(0.8980392, 0.8980392, 0.8980392, 0.5)
local var_0_3 = Color.New(0.5372549, 0.5215687, 0.5176471, 1)
local var_0_4 = Color.New(0.8980392, 0.8980392, 0.8980392, 1)

function var_0_0.refreshItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getOrCreateItem(arg_13_1)
	local var_13_1 = arg_13_1 + (arg_13_0._curPage - 1) * var_0_0.PageShowNum
	local var_13_2 = RoomTaskModel.instance:getShowList()[var_13_1]
	local var_13_3

	if var_13_2 then
		var_13_3 = RoomTaskModel.instance:tryGetTaskMO(var_13_2.id)
	end

	local var_13_4 = false

	if var_13_3 and arg_13_1 == 1 then
		arg_13_0:refreshWhenRunning(var_13_0, var_13_3, var_13_2)

		var_13_4 = true
	elseif not var_13_2 then
		arg_13_0:refreshWhenFinish(var_13_0)
	else
		arg_13_0:refreshWhenLock(var_13_0, var_13_2)
	end

	if not gohelper.isNil(var_13_0.gorunning) then
		gohelper.setActive(var_13_0.gorunning, var_13_4)
	end
end

function var_0_0.refreshWhenRunning(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	gohelper.setActive(arg_14_1.gofinish, false)
	gohelper.setActive(arg_14_1.gounfinish, false)
	gohelper.setActive(arg_14_1.goJump, true)
	gohelper.setActive(arg_14_1.golock, false)
	gohelper.setActive(arg_14_1.goorderbg, true)

	local var_14_0 = arg_14_2.hasFinished == true and "%s(%s/%s)" or "%s(<color=#b26161>%s</color>/%s)"

	arg_14_1.txtdesc.text = string.format(var_14_0, arg_14_3.desc, arg_14_2.progress, arg_14_3.maxProgress)

	arg_14_0:setRewardIcon(arg_14_3, arg_14_1, true)

	local var_14_1 = false
	local var_14_2 = false
	local var_14_3 = arg_14_3.tips or ""

	if arg_14_3.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or arg_14_3.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
		var_14_2 = true
	elseif arg_14_3.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
		var_14_1 = true

		local var_14_4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, RoomSceneTaskEnum.RoomLevelUpItem)
		local var_14_5 = tostring(var_14_4)

		if var_14_4 > 0 then
			var_14_5 = string.format("<color=#ffffff>%s</color>", var_14_4)
		end

		if not string.nilorempty(var_14_3) then
			var_14_3 = string.format(var_14_3, var_14_5)
		end
	end

	if not string.nilorempty(var_14_3) then
		arg_14_1.txtRunningTips.text = var_14_3

		gohelper.setActive(arg_14_1.txtRunningTips, true)
	else
		gohelper.setActive(arg_14_1.txtRunningTips, false)
	end

	gohelper.setActive(arg_14_1.btnExpansion, var_14_1)
	gohelper.setActive(arg_14_1.btnEdit, var_14_2)

	arg_14_1.imagebonus.color = Color.white
	arg_14_1.txtdesc.color = Color.white
	arg_14_1.txtid.color = var_0_4
	arg_14_1.txtid.text = arg_14_3.order
end

function var_0_0.refreshWhenFinish(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_1.gofinish, true)
	gohelper.setActive(arg_15_1.gounfinish, false)
	gohelper.setActive(arg_15_1.goorderbg, false)

	if arg_15_1.goJump then
		gohelper.setActive(arg_15_1.goJump, false)
	end

	arg_15_1.txtid.text = ""
end

function var_0_0.refreshWhenLock(arg_16_0, arg_16_1, arg_16_2)
	gohelper.setActive(arg_16_1.gofinish, false)
	gohelper.setActive(arg_16_1.gounfinish, true)
	gohelper.setActive(arg_16_1.golock, true)
	gohelper.setActive(arg_16_1.goorderbg, false)

	if arg_16_1.goJump then
		gohelper.setActive(arg_16_1.goJump, false)
	end

	arg_16_1.txtdesc.text = arg_16_2.desc

	if not gohelper.isNil(arg_16_1.txtlock) then
		if RoomSceneTaskController.isTaskOverUnlockLevel(arg_16_2) then
			arg_16_1.txtlock.text = luaLang("room_task_lock_by_task")
		else
			arg_16_1.txtlock.text = string.format(luaLang("room_task_lock_by_level"), RoomSceneTaskController.getTaskUnlockLevel(arg_16_2.openLimit))
		end
	end

	arg_16_0:setRewardIcon(arg_16_2, arg_16_1, false)

	arg_16_1.imagebonus.color = var_0_1
	arg_16_1.txtdesc.color = var_0_2
	arg_16_1.txtid.color = var_0_3
	arg_16_1.txtid.text = arg_16_2.order
end

function var_0_0.setRewardIcon(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0, var_17_1, var_17_2 = RoomSceneTaskController.getRewardConfigAndIcon(arg_17_1)

	if not string.nilorempty(arg_17_1.bonusIcon) then
		var_17_1 = ResUrl.getRoomTaskBonusIcon(arg_17_1.bonusIcon)
	end

	if not string.nilorempty(var_17_1) then
		arg_17_2.simagebonus:LoadImage(var_17_1)
	end

	if var_17_2 and arg_17_3 then
		gohelper.setActive(arg_17_2.txtnum.gameObject, true)

		arg_17_2.txtnum.text = tostring(GameUtil.numberDisplay(var_17_2))
	else
		gohelper.setActive(arg_17_2.txtnum.gameObject, false)
	end
end

function var_0_0.getMaxPage(arg_18_0)
	local var_18_0 = RoomTaskModel.instance:getShowList()

	return math.ceil(#var_18_0 / var_0_0.PageShowNum)
end

return var_0_0
