module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluTaskItem", package.seeall)

local var_0_0 = class("PeaceUluTaskItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._gogame = gohelper.findChild(arg_1_0.viewGO, "#go_game")
	arg_1_0._gonormalbg = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._goactivitybg = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_activity")
	arg_1_0.txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0.txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0.txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.btnRemove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_removebg", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	arg_1_0.btnGame = gohelper.findChildButton(arg_1_0.viewGO, "#go_game/#btn_game")
	arg_1_0.btnGameCanvasGroup = arg_1_0.btnGame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.txtgamedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_game/#txt_desc")
	arg_1_0.txtgametimes = gohelper.findChildText(arg_1_0.viewGO, "#go_game/#btn_game/times/#txt_times")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animationStartTime = 0

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0.btnNotFinish:AddClickListener(arg_2_0._btnNotFinishOnClick, arg_2_0)
	arg_2_0.btnFinish:AddClickListener(arg_2_0._btnFinishOnClick, arg_2_0)
	arg_2_0.btnRemove:AddClickListener(arg_2_0._btnRemoveOnClick, arg_2_0)
	arg_2_0.btnFinishAll:AddClickListener(arg_2_0._btnFinishAllOnClick, arg_2_0)
	arg_2_0.btnGame:AddClickListener(arg_2_0._btnGameOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.btnNotFinish:RemoveClickListener()
	arg_3_0.btnRemove:RemoveClickListener()
	arg_3_0.btnFinish:RemoveClickListener()
	arg_3_0.btnFinishAll:RemoveClickListener()
	arg_3_0.btnGame:RemoveClickListener()
end

var_0_0.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function var_0_0._btnGameOnClick(arg_4_0)
	arg_4_0:_playGame()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._playGame(arg_5_0)
	if not PeaceUluModel.instance:checkCanPlay() then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function var_0_0._btnNotFinishOnClick(arg_6_0)
	local var_6_0 = arg_6_0.co.jumpId

	if var_6_0 ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if var_6_0 == 10011507 then
			arg_6_0:_playGame()
		else
			GameFacade.jump(var_6_0)
		end
	end
end

function var_0_0._btnRemoveOnClick(arg_7_0)
	if PeaceUluModel.instance:checkCanRemove() then
		arg_7_0:_btnFinishOnClick()
	end
end

function var_0_0._btnFinishAllOnClick(arg_8_0)
	arg_8_0:_btnFinishOnClick()
end

var_0_0.FinishKey = "FinishKey"

function var_0_0._btnFinishOnClick(arg_9_0)
	UIBlockMgr.instance:startBlock(var_0_0.FinishKey)

	arg_9_0.animator.enabled = true
	arg_9_0.animator.speed = 1

	arg_9_0.animator:Play(UIAnimationName.Finish)
	arg_9_0:firstAnimationDone()
end

function var_0_0.firstAnimationDone(arg_10_0)
	TaskDispatcher.runDelay(arg_10_0.secondAnimationDone, arg_10_0, PeaceUluEnum.TaskMaskTime)
	arg_10_0._view.viewContainer:dispatchEvent(PeaceUluEvent.onFinishTask, arg_10_0._index)
end

function var_0_0.secondAnimationDone(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.secondAnimationDone, arg_11_0)
	arg_11_0.animator:Play(UIAnimationName.Idle)

	local function var_11_0()
		arg_11_0.animator:Play(UIAnimationName.Idle)
	end

	if PeaceUluModel.instance:checkCanRemove() and not arg_11_0.taskMo.hasFinished then
		PeaceUluRpc.instance:sendAct145RemoveTaskRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, arg_11_0.taskId, var_11_0, arg_11_0)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_11_0.co.id, var_11_0, arg_11_0)
	end

	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0.taskMo = arg_14_1
	arg_14_0.firstOpen = arg_14_1.firstOpen
	arg_14_0.taskId = arg_14_0.taskMo.id
	arg_14_0.animator.enabled = true
	arg_14_0.scrollReward.parentGameObject = arg_14_0._view._csListScroll.gameObject

	gohelper.setActive(arg_14_0._gonormal, not arg_14_0.taskMo.isGame)
	gohelper.setActive(arg_14_0._gogame, arg_14_0.taskMo.isGame)

	if arg_14_0.taskMo.isGame then
		arg_14_0:refreshGameUI()
	else
		arg_14_0:refreshNormalUI()
	end

	if arg_14_0.firstOpen then
		if arg_14_1.isupdate then
			arg_14_0._animationStartTime = Time.time
		end

		arg_14_0:_refreshOpenAnimation()

		arg_14_1.isupdate = false
	end
end

function var_0_0.refreshGameUI(arg_15_0)
	local var_15_0 = PeaceUluConfig.instance:getGameTimes()
	local var_15_1 = PeaceUluModel.instance:getGameHaveTimes()

	arg_15_0._cannotPlay = var_15_1 == 0 and true or false
	arg_15_0.txtgametimes.text = string.format("<color=#DB8542>%s</color>", var_15_1) .. "/" .. var_15_0

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(arg_15_0.btnGame.gameObject, true)

		arg_15_0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_getallreward")
	else
		gohelper.setActive(arg_15_0.btnGame.gameObject, not PeaceUluModel.instance:checkCanRemove())

		if PeaceUluModel.instance:checkCanRemove() then
			arg_15_0.txtgamedesc.text = string.format(luaLang("v1a5_peaceulu_mainview_times"), PeaceUluModel.instance:getRemoveNum())
		elseif arg_15_0._cannotPlay and not PeaceUluTaskModel.instance:checkAllTaskFinished() then
			arg_15_0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_statusdesc")
		elseif arg_15_0._cannotPlay and PeaceUluTaskModel.instance:checkAllTaskFinished() then
			arg_15_0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_statusdesczero")
		else
			arg_15_0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_gamedesc")
		end
	end
end

function var_0_0.refreshNormalUI(arg_16_0)
	arg_16_0.co = arg_16_0.taskMo.config

	if not arg_16_0.co then
		return
	end

	local var_16_0 = arg_16_0.taskMo.config.loopType == 1

	gohelper.setActive(arg_16_0._gonormalbg, not var_16_0)
	gohelper.setActive(arg_16_0._goactivitybg, var_16_0)
	arg_16_0:refreshDesc()

	arg_16_0.txtnum.text = arg_16_0.taskMo.progress
	arg_16_0.txttotal.text = arg_16_0.co.maxProgress

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(arg_16_0.btnRemove.gameObject, false)
		gohelper.setActive(arg_16_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_16_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_16_0.goFinished, true)
	elseif arg_16_0.taskMo.finishCount > 0 then
		gohelper.setActive(arg_16_0.btnRemove.gameObject, false)
		gohelper.setActive(arg_16_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_16_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_16_0.goFinished, true)
	elseif arg_16_0.taskMo.hasFinished then
		gohelper.setActive(arg_16_0.btnRemove.gameObject, false)
		gohelper.setActive(arg_16_0.btnFinish.gameObject, true)
		gohelper.setActive(arg_16_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_16_0.goFinished, false)
	elseif PeaceUluModel.instance:checkCanRemove() and arg_16_0.co.canRemove == 1 then
		gohelper.setActive(arg_16_0.btnNotFinish.gameObject, false)
		gohelper.setActive(arg_16_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_16_0.goFinished, false)
		gohelper.setActive(arg_16_0.btnRemove.gameObject, true)
	else
		gohelper.setActive(arg_16_0.btnNotFinish.gameObject, true)
		gohelper.setActive(arg_16_0.goFinished, false)
		gohelper.setActive(arg_16_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_16_0.btnRemove.gameObject, false)
	end

	arg_16_0:refreshRewardItems()
end

function var_0_0.refreshDesc(arg_17_0)
	if not arg_17_0.co then
		return
	end

	local var_17_0 = string.match(arg_17_0.co.desc, "%[(.-)%]")
	local var_17_1

	if not string.nilorempty(var_17_0) then
		if var_17_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			var_17_1 = "Story1"
		elseif var_17_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			var_17_1 = "Story2"
		elseif var_17_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			var_17_1 = "Story3"
		elseif var_17_0 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			var_17_1 = "Hard"
		end
	end

	local var_17_2 = arg_17_0.co.desc
	local var_17_3 = string.gsub(var_17_2, "(GLN%-%d+)", string.format("<color=%s>%s</color>", var_0_0.ModeToColorDict.Normal, "%1"))

	if var_17_1 then
		var_17_3 = string.gsub(var_17_3, "(%[.-%])", string.format("<color=%s>%s</color>", var_0_0.ModeToColorDict[var_17_1], "%1"))
	end

	local var_17_4 = string.format(var_17_3, arg_17_0.co.maxProgress)

	arg_17_0.txttaskdesc.text = var_17_4
end

function var_0_0.refreshRewardItems(arg_18_0)
	local var_18_0 = arg_18_0.co.bonus

	if string.nilorempty(var_18_0) then
		gohelper.setActive(arg_18_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_18_0.scrollReward.gameObject, true)

	local var_18_1 = GameUtil.splitString2(var_18_0, true, "|", "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = iter_18_1[1]
		local var_18_3 = iter_18_1[2]
		local var_18_4 = iter_18_1[3]
		local var_18_5 = arg_18_0.rewardItemList[iter_18_0]

		if not var_18_5 then
			var_18_5 = IconMgr.instance:getCommonPropItemIcon(arg_18_0.goRewardContent)

			transformhelper.setLocalScale(var_18_5.go.transform, 0.62, 0.62, 1)
			var_18_5:setMOValue(var_18_2, var_18_3, var_18_4, nil, true)
			var_18_5:setCountFontSize(40)
			var_18_5:showStackableNum2()
			var_18_5:isShowEffect(true)
			table.insert(arg_18_0.rewardItemList, var_18_5)
		else
			var_18_5:setMOValue(var_18_2, var_18_3, var_18_4, nil, true)
		end

		gohelper.setActive(var_18_5.go, true)
	end

	for iter_18_2 = #var_18_1 + 1, #arg_18_0.rewardItemList do
		gohelper.setActive(arg_18_0.rewardItemList[iter_18_2].go, false)
	end

	arg_18_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0._refreshOpenAnimation(arg_19_0)
	if not arg_19_0.animator or not arg_19_0.animator.gameObject.activeInHierarchy then
		return
	end

	if arg_19_0.firstOpen then
		local var_19_0 = arg_19_0:_getAnimationTime()

		arg_19_0.animator.speed = 1

		if arg_19_0.taskMo.isGame and arg_19_0._cannotPlay then
			arg_19_0.animator:Play("open1", 0, 0)
		else
			arg_19_0.animator:Play("open", 0, 0)
		end

		arg_19_0.animator:Update(0)

		local var_19_1 = arg_19_0.animator:GetCurrentAnimatorStateInfo(0).length

		if var_19_1 <= 0 then
			var_19_1 = 1
		end

		if arg_19_0.taskMo.isGame and arg_19_0._cannotPlay then
			arg_19_0.animator:Play("open1", 0, (Time.time - var_19_0) / var_19_1)
		else
			arg_19_0.animator:Play("open", 0, (Time.time - var_19_0) / var_19_1)
		end

		arg_19_0.animator:Update(0)
	elseif arg_19_0.taskMo.isGame and arg_19_0._cannotPlay then
		arg_19_0.animator:Play("idle1", 0, 0)
	else
		arg_19_0.animator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_0._getAnimationTime(arg_20_0)
	if not arg_20_0._animationStartTime then
		return nil
	end

	arg_20_0._animationDelayTimes = 0.06 * arg_20_0._index

	return arg_20_0._animationStartTime + arg_20_0._animationDelayTimes
end

function var_0_0.refreshGetAllUI(arg_21_0)
	return
end

function var_0_0.canGetReward(arg_22_0)
	return arg_22_0.taskMo.finishCount < arg_22_0.co.maxProgress and arg_22_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_23_0)
	return arg_23_0.animator
end

function var_0_0.onDestroyView(arg_24_0)
	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
	TaskDispatcher.cancelTask(arg_24_0._opencallack, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.secondAnimationDone, arg_24_0)
end

return var_0_0
