module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluTaskItem", package.seeall)

slot0 = class("PeaceUluTaskItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._gogame = gohelper.findChild(slot0.viewGO, "#go_game")
	slot0._gonormalbg = gohelper.findChild(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._goactivitybg = gohelper.findChild(slot0.viewGO, "#go_normal/#go_activity")
	slot0.txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0.txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0.txttaskdesc = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0.scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goRewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	slot0.goFinished = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0.btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0.btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	slot0.btnRemove = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_removebg", AudioEnum.UI.play_ui_task_slide)
	slot0.btnFinishAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	slot0.btnGame = gohelper.findChildButton(slot0.viewGO, "#go_game/#btn_game")
	slot0.btnGameCanvasGroup = slot0.btnGame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.txtgamedesc = gohelper.findChildText(slot0.viewGO, "#go_game/#txt_desc")
	slot0.txtgametimes = gohelper.findChildText(slot0.viewGO, "#go_game/#btn_game/times/#txt_times")
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animationStartTime = 0

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0.btnFinish:AddClickListener(slot0._btnFinishOnClick, slot0)
	slot0.btnRemove:AddClickListener(slot0._btnRemoveOnClick, slot0)
	slot0.btnFinishAll:AddClickListener(slot0._btnFinishAllOnClick, slot0)
	slot0.btnGame:AddClickListener(slot0._btnGameOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnNotFinish:RemoveClickListener()
	slot0.btnRemove:RemoveClickListener()
	slot0.btnFinish:RemoveClickListener()
	slot0.btnFinishAll:RemoveClickListener()
	slot0.btnGame:RemoveClickListener()
end

slot0.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function slot0._btnGameOnClick(slot0)
	slot0:_playGame()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._playGame(slot0)
	if not PeaceUluModel.instance:checkCanPlay() then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function slot0._btnNotFinishOnClick(slot0)
	if slot0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if slot1 == 10011507 then
			slot0:_playGame()
		else
			GameFacade.jump(slot1)
		end
	end
end

function slot0._btnRemoveOnClick(slot0)
	if PeaceUluModel.instance:checkCanRemove() then
		slot0:_btnFinishOnClick()
	end
end

function slot0._btnFinishAllOnClick(slot0)
	slot0:_btnFinishOnClick()
end

slot0.FinishKey = "FinishKey"

function slot0._btnFinishOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0.FinishKey)

	slot0.animator.enabled = true
	slot0.animator.speed = 1

	slot0.animator:Play(UIAnimationName.Finish)
	slot0:firstAnimationDone()
end

function slot0.firstAnimationDone(slot0)
	TaskDispatcher.runDelay(slot0.secondAnimationDone, slot0, PeaceUluEnum.TaskMaskTime)
	slot0._view.viewContainer:dispatchEvent(PeaceUluEvent.onFinishTask, slot0._index)
end

function slot0.secondAnimationDone(slot0)
	TaskDispatcher.cancelTask(slot0.secondAnimationDone, slot0)
	slot0.animator:Play(UIAnimationName.Idle)

	if PeaceUluModel.instance:checkCanRemove() and not slot0.taskMo.hasFinished then
		PeaceUluRpc.instance:sendAct145RemoveTaskRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, slot0.taskId, function ()
			uv0.animator:Play(UIAnimationName.Idle)
		end, slot0)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.co.id, slot1, slot0)
	end

	UIBlockMgr.instance:endBlock(uv0.FinishKey)
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1
	slot0.firstOpen = slot1.firstOpen
	slot0.taskId = slot0.taskMo.id
	slot0.animator.enabled = true
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.isGame)
	gohelper.setActive(slot0._gogame, slot0.taskMo.isGame)

	if slot0.taskMo.isGame then
		slot0:refreshGameUI()
	else
		slot0:refreshNormalUI()
	end

	if slot0.firstOpen then
		if slot1.isupdate then
			slot0._animationStartTime = Time.time
		end

		slot0:_refreshOpenAnimation()

		slot1.isupdate = false
	end
end

function slot0.refreshGameUI(slot0)
	slot0._cannotPlay = PeaceUluModel.instance:getGameHaveTimes() == 0 and true or false
	slot0.txtgametimes.text = string.format("<color=#DB8542>%s</color>", slot2) .. "/" .. PeaceUluConfig.instance:getGameTimes()

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(slot0.btnGame.gameObject, true)

		slot0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_getallreward")
	else
		gohelper.setActive(slot0.btnGame.gameObject, not PeaceUluModel.instance:checkCanRemove())

		if PeaceUluModel.instance:checkCanRemove() then
			slot0.txtgamedesc.text = string.format(luaLang("v1a5_peaceulu_mainview_times"), PeaceUluModel.instance:getRemoveNum())
		elseif slot0._cannotPlay and not PeaceUluTaskModel.instance:checkAllTaskFinished() then
			slot0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_statusdesc")
		elseif slot0._cannotPlay and PeaceUluTaskModel.instance:checkAllTaskFinished() then
			slot0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_statusdesczero")
		else
			slot0.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_gamedesc")
		end
	end
end

function slot0.refreshNormalUI(slot0)
	slot0.co = slot0.taskMo.config

	if not slot0.co then
		return
	end

	slot1 = slot0.taskMo.config.loopType == 1

	gohelper.setActive(slot0._gonormalbg, not slot1)
	gohelper.setActive(slot0._goactivitybg, slot1)
	slot0:refreshDesc()

	slot0.txtnum.text = slot0.taskMo.progress
	slot0.txttotal.text = slot0.co.maxProgress

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(slot0.btnRemove.gameObject, false)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, true)
	elseif slot0.taskMo.finishCount > 0 then
		gohelper.setActive(slot0.btnRemove.gameObject, false)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0.btnRemove.gameObject, false)
		gohelper.setActive(slot0.btnFinish.gameObject, true)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, false)
	elseif PeaceUluModel.instance:checkCanRemove() and slot0.co.canRemove == 1 then
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, false)
		gohelper.setActive(slot0.btnRemove.gameObject, true)
	else
		gohelper.setActive(slot0.btnNotFinish.gameObject, true)
		gohelper.setActive(slot0.goFinished, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.btnRemove.gameObject, false)
	end

	slot0:refreshRewardItems()
end

function slot0.refreshDesc(slot0)
	if not slot0.co then
		return
	end

	slot2 = nil

	if not string.nilorempty(string.match(slot0.co.desc, "%[(.-)%]")) then
		if slot1 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			slot2 = "Story1"
		elseif slot1 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			slot2 = "Story2"
		elseif slot1 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			slot2 = "Story3"
		elseif slot1 == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			slot2 = "Hard"
		end
	end

	if slot2 then
		slot3 = string.gsub(string.gsub(slot0.co.desc, "(GLN%-%d+)", string.format("<color=%s>%s</color>", uv0.ModeToColorDict.Normal, "%1")), "(%[.-%])", string.format("<color=%s>%s</color>", uv0.ModeToColorDict[slot2], "%1"))
	end

	slot0.txttaskdesc.text = string.format(slot3, slot0.co.maxProgress)
end

function slot0.refreshRewardItems(slot0)
	if string.nilorempty(slot0.co.bonus) then
		gohelper.setActive(slot0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(slot0.scrollReward.gameObject, true)

	slot6 = "#"

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true, "|", slot6)) do
		if not slot0.rewardItemList[slot6] then
			slot11 = IconMgr.instance:getCommonPropItemIcon(slot0.goRewardContent)

			transformhelper.setLocalScale(slot11.go.transform, 0.62, 0.62, 1)
			slot11:setMOValue(slot7[1], slot7[2], slot7[3], nil, true)
			slot11:setCountFontSize(40)
			slot11:showStackableNum2()
			slot11:isShowEffect(true)
			table.insert(slot0.rewardItemList, slot11)
		else
			slot11:setMOValue(slot8, slot9, slot10, nil, true)
		end

		gohelper.setActive(slot11.go, true)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot6].go, false)
	end

	slot0.scrollReward.horizontalNormalizedPosition = 0
end

function slot0._refreshOpenAnimation(slot0)
	if not slot0.animator or not slot0.animator.gameObject.activeInHierarchy then
		return
	end

	if slot0.firstOpen then
		slot1 = slot0:_getAnimationTime()
		slot0.animator.speed = 1

		if slot0.taskMo.isGame and slot0._cannotPlay then
			slot0.animator:Play("open1", 0, 0)
		else
			slot0.animator:Play("open", 0, 0)
		end

		slot0.animator:Update(0)

		if slot0.animator:GetCurrentAnimatorStateInfo(0).length <= 0 then
			slot3 = 1
		end

		if slot0.taskMo.isGame and slot0._cannotPlay then
			slot0.animator:Play("open1", 0, (Time.time - slot1) / slot3)
		else
			slot0.animator:Play("open", 0, (Time.time - slot1) / slot3)
		end

		slot0.animator:Update(0)
	elseif slot0.taskMo.isGame and slot0._cannotPlay then
		slot0.animator:Play("idle1", 0, 0)
	else
		slot0.animator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function slot0._getAnimationTime(slot0)
	if not slot0._animationStartTime then
		return nil
	end

	slot0._animationDelayTimes = 0.06 * slot0._index

	return slot0._animationStartTime + slot0._animationDelayTimes
end

function slot0.refreshGetAllUI(slot0)
end

function slot0.canGetReward(slot0)
	return slot0.taskMo.finishCount < slot0.co.maxProgress and slot0.taskMo.hasFinished
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock(uv0.FinishKey)
	TaskDispatcher.cancelTask(slot0._opencallack, slot0)
	TaskDispatcher.cancelTask(slot0.secondAnimationDone, slot0)
end

return slot0
