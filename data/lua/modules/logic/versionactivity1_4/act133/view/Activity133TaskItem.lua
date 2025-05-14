module("modules.logic.versionactivity1_4.act133.view.Activity133TaskItem", package.seeall)

local var_0_0 = class("Activity133TaskItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gonormalbg = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._goactivitybg = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_activity")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0.txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0.txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0.txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)

	arg_1_0.animatorPlayer:Play(UIAnimationName.Open)

	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0.btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0.btnFinishAll:AddClickListener(arg_2_0._btnFinishAllOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnNotFinish:RemoveClickListener()
	arg_3_0.btnFinish:RemoveClickListener()
	arg_3_0.btnFinishAll:RemoveClickListener()
end

var_0_0.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function var_0_0._btnNotFinishOnClick(arg_4_0)
	local var_4_0 = arg_4_0.co.jumpId

	if var_4_0 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if VersionActivity1_2DungeonModel.instance:jump2DailyEpisode(var_4_0) then
			return
		end

		if GameFacade.jump(var_4_0) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
		end
	end
end

function var_0_0._btnFinishAllOnClick(arg_5_0)
	arg_5_0:_btnFinishOnClick()
end

var_0_0.FinishKey = "FinishKey"

function var_0_0._btnFinishOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock(var_0_0.FinishKey)

	arg_6_0.animator.speed = 1

	arg_6_0.animatorPlayer:Play(UIAnimationName.Finish, arg_6_0.firstAnimationDone, arg_6_0)
end

function var_0_0.firstAnimationDone(arg_7_0)
	arg_7_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_7_0._index, arg_7_0.secondAnimationDone, arg_7_0)
end

function var_0_0.secondAnimationDone(arg_8_0)
	arg_8_0.animatorPlayer:Play(UIAnimationName.Idle)

	if arg_8_0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity133)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_8_0.co.id)
	end

	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0.taskMo = arg_10_1
	arg_10_0.scrollReward.parentGameObject = arg_10_0._view._csListScroll.gameObject

	gohelper.setActive(arg_10_0._gonormal, not arg_10_0.taskMo.getAll)
	gohelper.setActive(arg_10_0._gogetall, arg_10_0.taskMo.getAll)

	if arg_10_0.taskMo.getAll then
		arg_10_0:refreshGetAllUI()
	else
		arg_10_0:refreshNormalUI()
	end
end

function var_0_0.refreshNormalUI(arg_11_0)
	arg_11_0.co = arg_11_0.taskMo.config

	if not arg_11_0.co then
		return
	end

	arg_11_0.isActivity = arg_11_0.taskMo.config.loopType ~= 1

	if arg_11_0.isActivity then
		gohelper.setActive(arg_11_0._gonormalbg, false)
		gohelper.setActive(arg_11_0._goactivitybg, true)
	else
		gohelper.setActive(arg_11_0._gonormalbg, true)
		gohelper.setActive(arg_11_0._goactivitybg, false)
	end

	arg_11_0:refreshDesc()

	arg_11_0.txtnum.text = arg_11_0.taskMo.progress
	arg_11_0.txttotal.text = arg_11_0.co.maxProgress

	if arg_11_0.taskMo.finishCount > 0 then
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_11_0.goFinished, true)
	elseif arg_11_0.taskMo.hasFinished then
		gohelper.setActive(arg_11_0.btnFinish.gameObject, true)
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_11_0.goFinished, false)
	else
		gohelper.setActive(arg_11_0.btnNotFinish.gameObject, true)
		gohelper.setActive(arg_11_0.goFinished, false)
		gohelper.setActive(arg_11_0.btnFinish.gameObject, false)
	end

	arg_11_0:refreshRewardItems()
end

function var_0_0.refreshDesc(arg_12_0)
	if not arg_12_0.co then
		return
	end

	local var_12_0 = string.match(arg_12_0.co.desc, "%[(.-)%]")
	local var_12_1

	if not string.nilorempty(var_12_0) then
		if var_12_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			var_12_1 = "Story1"
		elseif var_12_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			var_12_1 = "Story2"
		elseif var_12_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			var_12_1 = "Story3"
		elseif var_12_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			var_12_1 = "Hard"
		end
	end

	local var_12_2 = arg_12_0.co.desc
	local var_12_3 = string.gsub(var_12_2, "(GLN%-%d+)", string.format("<color=%s>%s</color>", var_0_0.ModeToColorDict.Normal, "%1"))

	if var_12_1 then
		var_12_3 = string.gsub(var_12_3, "(%[.-%])", string.format("<color=%s>%s</color>", var_0_0.ModeToColorDict[var_12_1], "%1"))
	end

	arg_12_0.txttaskdesc.text = var_12_3
end

function var_0_0.refreshRewardItems(arg_13_0)
	local var_13_0 = arg_13_0.co.bonus

	if string.nilorempty(var_13_0) then
		gohelper.setActive(arg_13_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_13_0.scrollReward.gameObject, true)

	local var_13_1 = GameUtil.splitString2(var_13_0, true, "|", "#")

	arg_13_0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_13_1 > 2

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = iter_13_1[1]
		local var_13_3 = iter_13_1[2]
		local var_13_4 = iter_13_1[3]
		local var_13_5 = arg_13_0.rewardItemList[iter_13_0]

		if not var_13_5 then
			var_13_5 = IconMgr.instance:getCommonPropItemIcon(arg_13_0.goRewardContent)

			transformhelper.setLocalScale(var_13_5.go.transform, 0.62, 0.62, 1)
			var_13_5:setMOValue(var_13_2, var_13_3, var_13_4, nil, true)
			var_13_5:setCountFontSize(40)
			var_13_5:showStackableNum2()
			var_13_5:isShowEffect(true)
			table.insert(arg_13_0.rewardItemList, var_13_5)
		else
			var_13_5:setMOValue(var_13_2, var_13_3, var_13_4, nil, true)
		end

		gohelper.setActive(var_13_5.go, true)
	end

	for iter_13_2 = #var_13_1 + 1, #arg_13_0.rewardItemList do
		gohelper.setActive(arg_13_0.rewardItemList[iter_13_2].go, false)
	end

	arg_13_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.refreshGetAllUI(arg_14_0)
	return
end

function var_0_0.canGetReward(arg_15_0)
	return arg_15_0.taskMo.finishCount < arg_15_0.co.maxProgress and arg_15_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0.animator
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
