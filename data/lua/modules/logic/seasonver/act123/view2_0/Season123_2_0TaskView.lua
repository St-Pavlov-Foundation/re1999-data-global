module("modules.logic.seasonver.act123.view2_0.Season123_2_0TaskView", package.seeall)

local var_0_0 = class("Season123_2_0TaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "top/#go_reward")
	arg_1_0._gorewardunchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_reward/#go_rewardunchoose")
	arg_1_0._gorewardchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_reward/#go_rewardchoose")
	arg_1_0._gorewardreddot = gohelper.findChild(arg_1_0.viewGO, "top/#go_reward/#go_rewardreddot")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_reward/#btn_reward")
	arg_1_0._gotask = gohelper.findChild(arg_1_0.viewGO, "top/#go_task")
	arg_1_0._gotaskunchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_task/#go_taskunchoose")
	arg_1_0._gotaskchoose = gohelper.findChild(arg_1_0.viewGO, "top/#go_task/#go_taskchoose")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "top/#go_task/#go_taskreddot")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_task/#btn_task")
	arg_1_0._scrolltasklist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tasklist")
	arg_1_0._scrollmaplist = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#go_maplist/#scroll_maplist")
	arg_1_0._gomapcontent = gohelper.findChild(arg_1_0.viewGO, "left/#go_maplist/#scroll_maplist/Viewport/#go_mapContent")
	arg_1_0._gomaplist = gohelper.findChild(arg_1_0.viewGO, "left/#go_maplist")
	arg_1_0._btnarrowdown = gohelper.findChildButton(arg_1_0.viewGO, "left/#go_maplist/#btn_arrowDown")
	arg_1_0._btnarrowtop = gohelper.findChildButton(arg_1_0.viewGO, "left/#go_maplist/#btn_arrowTop")
	arg_1_0._goreddotdown = gohelper.findChild(arg_1_0.viewGO, "left/#go_maplist/#btn_arrowDown/#go_reddotDown")
	arg_1_0._goreddottop = gohelper.findChild(arg_1_0.viewGO, "left/#go_maplist/#btn_arrowTop/#go_reddotTop")
	arg_1_0._goscrollArea = gohelper.findChild(arg_1_0.viewGO, "left/#go_maplist/#go_scrollArea")
	arg_1_0._goachievement = gohelper.findChild(arg_1_0.viewGO, "left/#go_achievement")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnarrowdown:AddClickListener(arg_2_0._btnArrowDownOnClick, arg_2_0)
	arg_2_0._btnarrowtop:AddClickListener(arg_2_0._btnArrowUpOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.TaskUpdated, arg_2_0.refreshRedDot, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, arg_2_0.moveScrollPos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnarrowdown:RemoveClickListener()
	arg_3_0._btnarrowtop:RemoveClickListener()
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.OnTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.TaskUpdated, arg_3_0.refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(Season123Controller.instance, Season123Event.clickTaskMapItem, arg_3_0.moveScrollPos, arg_3_0)
end

var_0_0.TaskMaskTime = 0.65
var_0_0.TaskGetAnimTime = 0.567
var_0_0.StageMapItemCount = 6
var_0_0.moveDistance = 50

function var_0_0._btnrewardOnClick(arg_4_0)
	arg_4_0.curTaskType = Activity123Enum.TaskRewardViewType

	arg_4_0:refreshUI()
end

function var_0_0._btntaskOnClick(arg_5_0)
	arg_5_0.curTaskType = Activity123Enum.TaskNormalType

	arg_5_0:refreshUI()
end

function var_0_0._btnArrowDownOnClick(arg_6_0)
	arg_6_0.curStage = Mathf.Min(arg_6_0.curStage + 1, var_0_0.StageMapItemCount)
	Season123TaskModel.instance.curStage = arg_6_0.curStage

	arg_6_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function var_0_0._btnArrowUpOnClick(arg_7_0)
	arg_7_0.curStage = Mathf.Max(arg_7_0.curStage - 1, 1)
	Season123TaskModel.instance.curStage = arg_7_0.curStage

	arg_7_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_feedback_open)
end

function var_0_0._onScrollDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.scrollStartPos = arg_8_2.position
end

function var_0_0._onScrollDragEnd(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position - arg_9_0.scrollStartPos
	local var_9_1 = Mathf.Abs(var_9_0.y) - var_0_0.moveDistance >= 0

	if var_9_0.y > 0 and var_9_1 then
		arg_9_0:_btnArrowDownOnClick()
	elseif var_9_0.y < 0 and var_9_1 then
		arg_9_0:_btnArrowUpOnClick()
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_10_0.viewContainer.scrollView)

	arg_10_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_10_0._taskAnimRemoveItem:setMoveAnimationTime(var_0_0.TaskMaskTime - var_0_0.TaskGetAnimTime)

	arg_10_0.stageMapItemTab = arg_10_0:getUserDataTb_()
	arg_10_0.layoutGroup = arg_10_0._gomapcontent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	arg_10_0.mapcontentRectTrans = arg_10_0._gomapcontent:GetComponent(gohelper.Type_RectTransform)
	arg_10_0.mapScroll = SLFramework.UGUI.UIDragListener.Get(arg_10_0._goscrollArea)

	arg_10_0.mapScroll:AddDragBeginListener(arg_10_0._onScrollDragBegin, arg_10_0)
	arg_10_0.mapScroll:AddDragEndListener(arg_10_0._onScrollDragEnd, arg_10_0)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId
	arg_11_0.stageId = arg_11_0.viewParam.stage

	local var_11_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	Season123TaskModel.instance:setTaskInfoList(var_11_0)
	Season123TaskModel.instance:initStageAndTaskType()

	Season123TaskModel.instance.curStage = arg_11_0.stageId ~= nil and arg_11_0.stageId or Season123TaskModel.instance.curStage
	arg_11_0.curTaskType = arg_11_0.stageId ~= nil and Activity123Enum.TaskRewardViewType or arg_11_0.curTaskType

	arg_11_0:createStageMapItem()
	arg_11_0:refreshUI()
	arg_11_0:refreshArrowRedDot()
	UIBlockMgr.instance:startBlock("playEnterSeason123_2_0TaskViewAnim")
	TaskDispatcher.runDelay(arg_11_0.endEnterAnimBlock, arg_11_0, 0.8)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0.curStage = Season123TaskModel.instance.curStage

	local var_12_0 = not arg_12_0.curTaskType and Season123TaskModel.instance.curTaskType or arg_12_0.curTaskType

	Season123TaskModel.instance:refreshList(var_12_0)

	arg_12_0._scrolltasklist.verticalNormalizedPosition = 1

	gohelper.setActive(arg_12_0._gorewardchoose, var_12_0 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(arg_12_0._gorewardunchoose, var_12_0 == Activity123Enum.TaskNormalType)
	gohelper.setActive(arg_12_0._gotaskchoose, var_12_0 == Activity123Enum.TaskNormalType)
	gohelper.setActive(arg_12_0._gotaskunchoose, var_12_0 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(arg_12_0._goachievement, var_12_0 == Activity123Enum.TaskNormalType)
	gohelper.setActive(arg_12_0._scrollmaplist.gameObject, var_12_0 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(arg_12_0._gomaplist, var_12_0 == Activity123Enum.TaskRewardViewType)
	arg_12_0:refreshArrowUI()
	arg_12_0:refreshRedDot()
	arg_12_0:moveScrollPos()
end

function var_0_0.refreshRedDot(arg_13_0)
	gohelper.setActive(arg_13_0._gorewardreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskRewardViewType])
	gohelper.setActive(arg_13_0._gotaskreddot, Season123TaskModel.instance.reddotShowMap[Activity123Enum.TaskNormalType])
end

function var_0_0.refreshArrowRedDot(arg_14_0)
	local var_14_0 = Season123TaskModel.instance:getHaveRewardTaskIndexList()
	local var_14_1 = Mathf.Max(arg_14_0.curStage - 1, 1)
	local var_14_2 = Mathf.Min(arg_14_0.curStage + 1, var_0_0.StageMapItemCount)
	local var_14_3 = false
	local var_14_4 = false

	for iter_14_0 = 1, #var_14_0 do
		if var_14_1 - var_14_0[iter_14_0] >= 0 then
			var_14_3 = true

			break
		end
	end

	for iter_14_1 = 1, #var_14_0 do
		if var_14_0[iter_14_1] - var_14_2 >= 0 then
			var_14_4 = true

			break
		end
	end

	gohelper.setActive(arg_14_0._goreddotdown, var_14_2 - arg_14_0.curStage > 0 and var_14_4)
	gohelper.setActive(arg_14_0._goreddottop, arg_14_0.curStage - var_14_1 > 0 and var_14_3)
end

function var_0_0.refreshArrowUI(arg_15_0)
	gohelper.setActive(arg_15_0._btnarrowdown.gameObject, arg_15_0.curStage < var_0_0.StageMapItemCount)
	gohelper.setActive(arg_15_0._btnarrowtop.gameObject, arg_15_0.curStage > 1)
	arg_15_0:refreshArrowRedDot()
end

function var_0_0._playGetRewardFinishAnim(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.removeIndexTab = {
			arg_16_1
		}
	end

	TaskDispatcher.runDelay(arg_16_0.delayPlayFinishAnim, arg_16_0, var_0_0.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_17_0)
	arg_17_0._taskAnimRemoveItem:removeByIndexs(arg_17_0.removeIndexTab)
end

function var_0_0.endEnterAnimBlock(arg_18_0)
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_0TaskViewAnim")
end

function var_0_0.createStageMapItem(arg_19_0)
	for iter_19_0 = 1, var_0_0.StageMapItemCount do
		local var_19_0 = arg_19_0.stageMapItemTab[iter_19_0]

		if not var_19_0 then
			var_19_0 = {
				itemGO = gohelper.findChild(arg_19_0._gomapcontent, "go_item" .. iter_19_0)
			}
			var_19_0.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_0.itemGO, Season123_2_0TaskMapItem, {
				stage = iter_19_0,
				actId = arg_19_0.actId
			})
			var_19_0.height = recthelper.getHeight(var_19_0.itemGO:GetComponent(gohelper.Type_RectTransform))
			arg_19_0.stageMapItemTab[iter_19_0] = var_19_0
		end

		gohelper.setActive(var_19_0.itemGO, true)
		var_19_0.item:refreshUI()
	end
end

function var_0_0.moveScrollPos(arg_20_0)
	arg_20_0.curStage = Season123TaskModel.instance.curStage

	local var_20_0 = recthelper.getHeight(arg_20_0._scrollmaplist:GetComponent(gohelper.Type_RectTransform))
	local var_20_1 = arg_20_0.layoutGroup.spacing
	local var_20_2 = 0

	for iter_20_0 = 1, arg_20_0.curStage - 1 do
		var_20_2 = var_20_2 + arg_20_0.stageMapItemTab[iter_20_0].height
	end

	local var_20_3 = -var_20_0 / 2 + (arg_20_0.curStage - 1) * var_20_1 + var_20_2 + arg_20_0.stageMapItemTab[arg_20_0.curStage].height / 2

	arg_20_0.scrollMoveTweenId = ZProj.TweenHelper.DOAnchorPosY(arg_20_0.mapcontentRectTrans, var_20_3, 0.5, arg_20_0.refreshArrowUI, arg_20_0)

	for iter_20_1, iter_20_2 in ipairs(arg_20_0.stageMapItemTab) do
		iter_20_2.item:setScale()
	end
end

function var_0_0.onClose(arg_21_0)
	Season123TaskModel.instance:clear()
	UIBlockMgr.instance:endBlock("playEnterSeason123_2_0TaskViewAnim")
	TaskDispatcher.cancelTask(arg_21_0.endEnterAnimBlock, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.delayPlayFinishAnim, arg_21_0)
	arg_21_0.mapScroll:RemoveDragBeginListener()
	arg_21_0.mapScroll:RemoveDragEndListener()
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0.scrollMoveTweenId then
		ZProj.TweenHelper.KillById(arg_22_0.scrollMoveTweenId)
	end
end

return var_0_0
