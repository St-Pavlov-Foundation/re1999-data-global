module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskView", package.seeall)

local var_0_0 = class("Act183TaskView", BaseView)
local var_0_1 = {
	[Act183Enum.TaskType.Daily] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn1_1"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#D2D0D0",
		"v2a5_challenge_reward_btn2_1"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#C14A3E",
		"v2a5_challenge_reward_btn3_1"
	}
}
local var_0_2 = {
	[Act183Enum.TaskType.Daily] = {
		"#9B9899",
		"v2a5_challenge_reward_btn1_2"
	},
	[Act183Enum.TaskType.NormalMain] = {
		"#9B9899",
		"v2a5_challenge_reward_btn2_2"
	},
	[Act183Enum.TaskType.HardMain] = {
		"#873D30",
		"v2a5_challenge_reward_btn3_2"
	}
}
local var_0_3 = 740
local var_0_4 = 893
local var_0_5 = -106
local var_0_6 = -25

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._gocategorys = gohelper.findChild(arg_1_0.viewGO, "root/left/#go_categorys")
	arg_1_0._gocategoryitem = gohelper.findChild(arg_1_0.viewGO, "root/left/#go_categorys/#go_categoryitem")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#scroll_task")
	arg_1_0._goonekeypos = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_onekeypos")

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
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_4_0._onFinishTask, arg_4_0)
	arg_4_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_4_0._onFinishTask, arg_4_0)

	arg_4_0._taskTypes = {
		Act183Enum.TaskType.Daily,
		Act183Enum.TaskType.NormalMain,
		Act183Enum.TaskType.HardMain
	}
	arg_4_0._defaultSelectTaskType = arg_4_0._taskTypes[1]
	arg_4_0._categoryItemTab = arg_4_0:getUserDataTb_()
	Act183TaskListModel.instance.startFrameCount = UnityEngine.Time.frameCount
end

function var_0_0._onFinishTask(arg_5_0)
	Act183TaskListModel.instance:refresh()
	arg_5_0:initOrRefreshOneKeyTaskItem()
	arg_5_0:refreshAllCategoryItemReddot()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenTaskView)
	arg_7_0:initInfo()
	arg_7_0:refresh()
end

function var_0_0.refresh(arg_8_0)
	Act183TaskListModel.instance:init(arg_8_0._activityId, arg_8_0._selectTaskType)
	arg_8_0:_initCategorys()
	arg_8_0:initOrRefreshOneKeyTaskItem()
end

function var_0_0.initInfo(arg_9_0)
	if arg_9_0.viewParam then
		arg_9_0._selectGroupType = arg_9_0.viewParam.selectGroupType
		arg_9_0._selectGroupId = arg_9_0.viewParam.selectGroupId

		if arg_9_0._selectGroupType then
			arg_9_0._selectTaskType = Act183Enum.GroupTypeToTaskType[arg_9_0._selectGroupType]
		end
	end

	arg_9_0._selectTaskType = arg_9_0._selectTaskType or arg_9_0._defaultSelectTaskType
	arg_9_0._activityId = Act183Model.instance:getActivityId()
end

function var_0_0.initOrRefreshOneKeyTaskItem(arg_10_0)
	local var_10_0 = Act183TaskListModel.instance:getOneKeyTaskItem()
	local var_10_1 = var_10_0 ~= nil

	if arg_10_0._oneKeyTaskItem then
		gohelper.setActive(arg_10_0._oneKeyTaskItem.go, false)
	end

	recthelper.setHeight(arg_10_0._scrolltask.transform, var_10_1 and var_0_3 or var_0_4)
	recthelper.setAnchorY(arg_10_0._scrolltask.transform, var_10_1 and var_0_5 or var_0_6)

	if not var_10_1 then
		return
	end

	if not arg_10_0._oneKeyTaskItem then
		local var_10_2 = arg_10_0.viewContainer._viewSetting.otherRes[3]
		local var_10_3 = arg_10_0:getResInst(var_10_2, arg_10_0._goonekeypos)

		arg_10_0._oneKeyTaskItem = MonoHelper.addLuaComOnceToGo(var_10_3, Act183TaskOneKeyItem)
		arg_10_0._oneKeyTaskItem._index = 1
	end

	gohelper.setActive(arg_10_0._oneKeyTaskItem.go, true)
	arg_10_0._oneKeyTaskItem:onUpdateMO(var_10_0)
end

function var_0_0.onOpenFinish(arg_11_0)
	arg_11_0:focusTargetGroupTasks()
end

function var_0_0.focusTargetGroupTasks(arg_12_0)
	if arg_12_0._selectGroupType ~= Act183Enum.TaskType.Daily or not arg_12_0._selectGroupId then
		return
	end

	local var_12_0 = 0
	local var_12_1 = Act183TaskListModel.instance:getList()
	local var_12_2 = false

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_3 = Act183Enum.TaskItemHeightMap[iter_12_1.type] or 0
		local var_12_4 = iter_12_1.data and iter_12_1.data.config

		if iter_12_1.type == Act183Enum.TaskListItemType.Head and var_12_4 ~= nil and var_12_4.groupId == arg_12_0._selectGroupId then
			var_12_2 = true

			break
		end

		var_12_0 = var_12_0 + var_12_3
	end

	local var_12_5 = var_12_2 and var_12_0 or 0

	arg_12_0:setTaskVerticalScrollPixel(var_12_5)
end

function var_0_0.setTaskVerticalScrollPixel(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.viewContainer:getTaskScrollView()
	local var_13_1 = var_13_0 and var_13_0:getCsScroll()

	if var_13_1 then
		var_13_1.VerticalScrollPixel = arg_13_1
	end
end

function var_0_0._initCategorys(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._taskTypes) do
		local var_14_0 = arg_14_0:_getOrCreateCategoryItem(iter_14_0)

		var_14_0.txtselecttitle.text = luaLang(Act183Enum.TaskNameLangId[iter_14_1])
		var_14_0.txtunselecttitle.text = luaLang(Act183Enum.TaskNameLangId[iter_14_1])
		var_14_0.reddot = RedDotController.instance:addRedDot(var_14_0.goreddot, RedDotEnum.DotNode.V2a5_Act183Task, iter_14_1, arg_14_0._categoryReddotOverrideFunc, iter_14_1)

		local var_14_1 = iter_14_1 == arg_14_0._selectTaskType

		gohelper.setActive(var_14_0.goselect, var_14_1)
		gohelper.setActive(var_14_0.gounselect, not var_14_1)
		gohelper.setActive(var_14_0.viewGO, true)

		local var_14_2 = var_0_1[iter_14_1]
		local var_14_3 = var_0_2[iter_14_1]

		SLFramework.UGUI.GuiHelper.SetColor(var_14_0.txtselecttitle, var_14_2[1])
		SLFramework.UGUI.GuiHelper.SetColor(var_14_0.txtunselecttitle, var_14_3[1])
		UISpriteSetMgr.instance:setChallengeSprite(var_14_0.imageselectbg, var_14_2[2])
		UISpriteSetMgr.instance:setChallengeSprite(var_14_0.imageunselectbg, var_14_3[2])
		gohelper.setActive(var_14_0.goselect_normaleffect, var_14_1 and iter_14_1 ~= Act183Enum.TaskType.HardMain)
		gohelper.setActive(var_14_0.goselect_hardeffect, var_14_1 and iter_14_1 == Act183Enum.TaskType.HardMain)
	end
end

function var_0_0._categoryReddotOverrideFunc(arg_15_0, arg_15_1)
	local var_15_0 = false
	local var_15_1 = Act183TaskListModel.instance:getTaskMosByType(arg_15_0)

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			if Act183Helper.isTaskCanGetReward(iter_15_1.id) then
				var_15_0 = true

				break
			end
		end
	end

	arg_15_1.show = var_15_0

	arg_15_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0.refreshAllCategoryItemReddot(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._taskTypes) do
		arg_16_0:_getOrCreateCategoryItem(iter_16_0).reddot:refreshDot()
	end
end

function var_0_0._getOrCreateCategoryItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._categoryItemTab[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.viewGO = gohelper.cloneInPlace(arg_17_0._gocategoryitem, "categoryitem_" .. arg_17_1)
		var_17_0.goselect = gohelper.findChild(var_17_0.viewGO, "go_select")
		var_17_0.gounselect = gohelper.findChild(var_17_0.viewGO, "go_unselect")
		var_17_0.imageselectbg = gohelper.findChildImage(var_17_0.viewGO, "go_select/bg")
		var_17_0.imageunselectbg = gohelper.findChildImage(var_17_0.viewGO, "go_unselect/bg")
		var_17_0.txtselecttitle = gohelper.findChildText(var_17_0.viewGO, "go_select/txt_title")
		var_17_0.txtunselecttitle = gohelper.findChildText(var_17_0.viewGO, "go_unselect/txt_title")
		var_17_0.goreddot = gohelper.findChild(var_17_0.viewGO, "go_reddot")
		var_17_0.goselect_normaleffect = gohelper.findChild(var_17_0.viewGO, "go_select/vx_normal")
		var_17_0.goselect_hardeffect = gohelper.findChild(var_17_0.viewGO, "go_select/vx_hard")
		var_17_0.btnclick = gohelper.findChildButtonWithAudio(var_17_0.viewGO, "btn_click")

		var_17_0.btnclick:AddClickListener(arg_17_0._onClickCategoryItem, arg_17_0, arg_17_1)

		arg_17_0._categoryItemTab[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0._onClickCategoryItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._taskTypes[arg_18_1]

	if not var_18_0 or arg_18_0._selectTaskType == var_18_0 then
		return
	end

	arg_18_0._selectTaskType = var_18_0

	arg_18_0:setTaskVerticalScrollPixel(0)
	arg_18_0:refresh()
end

function var_0_0.relreaseAllCategoryItems(arg_19_0)
	if arg_19_0._categoryItemTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._categoryItemTab) do
			iter_19_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.playTaskItmeAnimation(arg_20_0)
	if not arg_20_0.viewContainer:getTaskScrollView() then
		return
	end
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:relreaseAllCategoryItems()
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
