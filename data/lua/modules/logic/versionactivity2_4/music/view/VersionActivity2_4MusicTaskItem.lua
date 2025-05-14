module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicTaskItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0.txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0.txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0.txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0.scrollReward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goRewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0.goFinished = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0.goDoing = gohelper.findChild(arg_1_0.viewGO, "#go_normal/txt_finishing")
	arg_1_0.btnNotFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0.goRunning = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#go_running")
	arg_1_0.btnFinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0.btnFinishAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall")
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

function var_0_0._btnNotFinishOnClick(arg_4_0)
	if arg_4_0.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(arg_4_0.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicTaskView)
		end
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicTaskView)
	end
end

function var_0_0.getAllPlayAnim(arg_5_0)
	if arg_5_0.taskMo.getAll or not arg_5_0._showFinishedBtn then
		return
	end

	arg_5_0.animator.speed = 1

	arg_5_0.animatorPlayer:Play(UIAnimationName.Finish, arg_5_0._getAllPlayAnimDone, arg_5_0)
end

function var_0_0._getAllPlayAnimDone(arg_6_0)
	arg_6_0.animatorPlayer:Play(UIAnimationName.Idle)
	arg_6_0:refreshNormalUI(true)
end

function var_0_0._btnFinishAllOnClick(arg_7_0)
	local var_7_0 = arg_7_0._view.viewContainer:getTaskItemList()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1:getAllPlayAnim()
	end

	arg_7_0:_btnFinishOnClick()
end

var_0_0.FinishKey = "VersionActivity2_4MusicTaskItem FinishKey"

function var_0_0._btnFinishOnClick(arg_8_0)
	UIBlockMgr.instance:startBlock(var_0_0.FinishKey)

	arg_8_0.animator.speed = 1

	arg_8_0.animatorPlayer:Play(UIAnimationName.Finish, arg_8_0.firstAnimationDone, arg_8_0)
end

function var_0_0.firstAnimationDone(arg_9_0)
	arg_9_0._view.viewContainer.taskAnimRemoveItem:removeByIndex(arg_9_0._index, arg_9_0.secondAnimationDone, arg_9_0)
end

function var_0_0.secondAnimationDone(arg_10_0)
	UIBlockMgr.instance:endBlock(var_0_0.FinishKey)
	arg_10_0.animatorPlayer:Play(UIAnimationName.Idle)

	if arg_10_0.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity179)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_10_0.taskMo.id)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.rewardItemList = {}
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0.taskMo = arg_12_1
	arg_12_0.scrollReward.parentGameObject = arg_12_0._view._csListScroll.gameObject

	gohelper.setActive(arg_12_0._gonormal, not arg_12_0.taskMo.getAll)
	gohelper.setActive(arg_12_0._gogetall, arg_12_0.taskMo.getAll)

	arg_12_0._showFinishedBtn = false

	if arg_12_0.taskMo.getAll then
		arg_12_0:refreshGetAllUI()
	else
		arg_12_0:refreshNormalUI()
	end

	arg_12_0._view.viewContainer:addTaskItem(arg_12_0)
end

function var_0_0.refreshNormalUI(arg_13_0, arg_13_1)
	arg_13_0.co = lua_activity179_task.configDict[arg_13_0.taskMo.id]
	arg_13_0._maxFinishCount = 1
	arg_13_0.txttaskdesc.text = arg_13_0.co.desc
	arg_13_0.txtnum.text = arg_13_0.taskMo.progress
	arg_13_0.txttotal.text = arg_13_0.co.maxProgress
	arg_13_0._showFinishedBtn = false

	if arg_13_0.taskMo.finishCount >= arg_13_0._maxFinishCount or arg_13_1 then
		gohelper.setActive(arg_13_0.goDoing, false)
		gohelper.setActive(arg_13_0.btnNotFinish, false)
		gohelper.setActive(arg_13_0.goRunning, false)
		gohelper.setActive(arg_13_0.btnFinish.gameObject, false)
		gohelper.setActive(arg_13_0.goFinished, true)
	elseif arg_13_0.taskMo.hasFinished then
		arg_13_0._showFinishedBtn = true

		gohelper.setActive(arg_13_0.btnFinish, true)
		gohelper.setActive(arg_13_0.btnNotFinish, false)
		gohelper.setActive(arg_13_0.goDoing, false)
		gohelper.setActive(arg_13_0.goRunning, false)
		gohelper.setActive(arg_13_0.goFinished, false)
	else
		if arg_13_0.co.jumpId ~= 0 then
			gohelper.setActive(arg_13_0.btnNotFinish, true)
			gohelper.setActive(arg_13_0.goDoing, false)
			gohelper.setActive(arg_13_0.goRunning, false)
		else
			gohelper.setActive(arg_13_0.btnNotFinish, true)
			gohelper.setActive(arg_13_0.goDoing, true)
			gohelper.setActive(arg_13_0.goRunning, true)
		end

		gohelper.setActive(arg_13_0.goFinished, false)
		gohelper.setActive(arg_13_0.btnFinish.gameObject, false)
	end

	arg_13_0:refreshRewardItems()
end

function var_0_0.refreshRewardItems(arg_14_0)
	local var_14_0 = arg_14_0.co.bonus

	if string.nilorempty(var_14_0) then
		gohelper.setActive(arg_14_0.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(arg_14_0.scrollReward.gameObject, true)

	local var_14_1 = {}

	if tonumber(var_14_0) then
		local var_14_2 = DungeonConfig.instance:getRewardItems(tonumber(var_14_0))

		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			var_14_1[iter_14_0] = {
				iter_14_1[1],
				iter_14_1[2],
				iter_14_1[3]
			}
		end
	else
		var_14_1 = ItemModel.instance:getItemDataListByConfigStr(var_14_0)
	end

	arg_14_0.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #var_14_1 > 2

	for iter_14_2, iter_14_3 in ipairs(var_14_1) do
		local var_14_3 = iter_14_3[1]
		local var_14_4 = iter_14_3[2]
		local var_14_5 = iter_14_3[3]
		local var_14_6 = arg_14_0.rewardItemList[iter_14_2]

		if not var_14_6 then
			var_14_6 = IconMgr.instance:getCommonPropItemIcon(arg_14_0.goRewardContent)

			transformhelper.setLocalScale(var_14_6.go.transform, 1, 1, 1)
			table.insert(arg_14_0.rewardItemList, var_14_6)
		end

		var_14_6:setMOValue(var_14_3, var_14_4, var_14_5, nil, true)
		var_14_6:setCountFontSize(39)
		var_14_6:showStackableNum2()
		var_14_6:isShowEffect(true)
		gohelper.setActive(var_14_6.go, true)
	end

	for iter_14_4 = #var_14_1 + 1, #arg_14_0.rewardItemList do
		gohelper.setActive(arg_14_0.rewardItemList[iter_14_4].go, false)
	end

	arg_14_0.scrollReward.horizontalNormalizedPosition = 0
end

function var_0_0.refreshGetAllUI(arg_15_0)
	return
end

function var_0_0.canGetReward(arg_16_0)
	return arg_16_0.taskMo.finishCount < arg_16_0._maxFinishCount and arg_16_0.taskMo.hasFinished
end

function var_0_0.getAnimator(arg_17_0)
	return arg_17_0.animator
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagenormalbg:UnLoadImage()
	arg_18_0._simagegetallbg:UnLoadImage()
end

return var_0_0
