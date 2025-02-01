module("modules.logic.versionactivity1_4.act133.view.Activity133TaskItem", package.seeall)

slot0 = class("Activity133TaskItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gonormalbg = gohelper.findChild(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._goactivitybg = gohelper.findChild(slot0.viewGO, "#go_normal/#go_activity")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0.txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0.txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0.txttaskdesc = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0.scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goRewardContent = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	slot0.goFinished = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0.btnNotFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0.btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	slot0.btnFinishAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0.animatorPlayer:Play(UIAnimationName.Open)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnNotFinish:AddClickListener(slot0._btnNotFinishOnClick, slot0)
	slot0.btnFinish:AddClickListener(slot0._btnFinishOnClick, slot0)
	slot0.btnFinishAll:AddClickListener(slot0._btnFinishAllOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnNotFinish:RemoveClickListener()
	slot0.btnFinish:RemoveClickListener()
	slot0.btnFinishAll:RemoveClickListener()
end

slot0.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function slot0._btnNotFinishOnClick(slot0)
	if slot0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if VersionActivity1_2DungeonModel.instance:jump2DailyEpisode(slot1) then
			return
		end

		if GameFacade.jump(slot1) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
		end
	end
end

function slot0._btnFinishAllOnClick(slot0)
	slot0:_btnFinishOnClick()
end

slot0.FinishKey = "FinishKey"

function slot0._btnFinishOnClick(slot0)
	UIBlockMgr.instance:startBlock(uv0.FinishKey)

	slot0.animator.speed = 1

	slot0.animatorPlayer:Play(UIAnimationName.Finish, slot0.firstAnimationDone, slot0)
end

function slot0.firstAnimationDone(slot0)
	slot0._view.viewContainer.taskAnimRemoveItem:removeByIndex(slot0._index, slot0.secondAnimationDone, slot0)
end

function slot0.secondAnimationDone(slot0)
	slot0.animatorPlayer:Play(UIAnimationName.Idle)

	if slot0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity133)
	else
		TaskRpc.instance:sendFinishTaskRequest(slot0.co.id)
	end

	UIBlockMgr.instance:endBlock(uv0.FinishKey)
end

function slot0._editableInitView(slot0)
	slot0.rewardItemList = {}
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.taskMo = slot1
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject

	gohelper.setActive(slot0._gonormal, not slot0.taskMo.getAll)
	gohelper.setActive(slot0._gogetall, slot0.taskMo.getAll)

	if slot0.taskMo.getAll then
		slot0:refreshGetAllUI()
	else
		slot0:refreshNormalUI()
	end
end

function slot0.refreshNormalUI(slot0)
	slot0.co = slot0.taskMo.config

	if not slot0.co then
		return
	end

	slot0.isActivity = slot0.taskMo.config.loopType ~= 1

	if slot0.isActivity then
		gohelper.setActive(slot0._gonormalbg, false)
		gohelper.setActive(slot0._goactivitybg, true)
	else
		gohelper.setActive(slot0._gonormalbg, true)
		gohelper.setActive(slot0._goactivitybg, false)
	end

	slot0:refreshDesc()

	slot0.txtnum.text = slot0.taskMo.progress
	slot0.txttotal.text = slot0.co.maxProgress

	if slot0.taskMo.finishCount > 0 then
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, true)
	elseif slot0.taskMo.hasFinished then
		gohelper.setActive(slot0.btnFinish.gameObject, true)
		gohelper.setActive(slot0.btnNotFinish.gameObject, false)
		gohelper.setActive(slot0.goFinished, false)
	else
		gohelper.setActive(slot0.btnNotFinish.gameObject, true)
		gohelper.setActive(slot0.goFinished, false)
		gohelper.setActive(slot0.btnFinish.gameObject, false)
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

	slot0.txttaskdesc.text = slot3
end

function slot0.refreshRewardItems(slot0)
	if string.nilorempty(slot0.co.bonus) then
		gohelper.setActive(slot0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(slot0.scrollReward.gameObject, true)

	slot0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #GameUtil.splitString2(slot1, true, "|", "#") > 2

	for slot6, slot7 in ipairs(slot2) do
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

function slot0.refreshGetAllUI(slot0)
end

function slot0.canGetReward(slot0)
	return slot0.taskMo.finishCount < slot0.co.maxProgress and slot0.taskMo.hasFinished
end

function slot0.getAnimator(slot0)
	return slot0.animator
end

function slot0.onDestroyView(slot0)
end

return slot0
