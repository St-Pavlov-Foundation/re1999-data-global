module("modules.logic.seasonver.act123.view2_3.Season123_2_3TaskItem", package.seeall)

local var_0_0 = class("Season123_2_3TaskItem", ListScrollCell)

var_0_0.BlockKey = "Season123_2_3TaskItemAni"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._viewGO = arg_1_1
	arg_1_0._simageBg = gohelper.findChildSingleImage(arg_1_1, "#simage_bg")
	arg_1_0._goNormal = gohelper.findChild(arg_1_1, "#goNormal")
	arg_1_0._goTotal = gohelper.findChild(arg_1_1, "#goTotal")
	arg_1_0._animator = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:initNormal()
	arg_1_0:initTotal()

	arg_1_0.firstEnter = true
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnGoto:AddClickListener(arg_2_0.onClickGoto, arg_2_0)
	arg_2_0._btnReceive:AddClickListener(arg_2_0.onClickReceive, arg_2_0)
	arg_2_0._btnGetTotal:AddClickListener(arg_2_0.onClickGetTotal, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnGoto:RemoveClickListener()
	arg_3_0._btnReceive:RemoveClickListener()
	arg_3_0._btnGetTotal:RemoveClickListener()
end

function var_0_0.initNormal(arg_4_0)
	arg_4_0._txtCurCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount")
	arg_4_0._txtMaxCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount/#txt_maxcount")
	arg_4_0._txtDesc = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_desc")
	arg_4_0._scrollreward = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_4_0._gocontent = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards/Viewport/Content")
	arg_4_0._goRewardTemplate = gohelper.findChild(arg_4_0._gocontent, "#go_rewarditem")

	gohelper.setActive(arg_4_0._goRewardTemplate, false)

	arg_4_0._goMask = gohelper.findChild(arg_4_0._goNormal, "#go_blackmask")
	arg_4_0._goFinish = gohelper.findChild(arg_4_0._goNormal, "#go_finish")
	arg_4_0._goGoto = gohelper.findChild(arg_4_0._goNormal, "#btn_goto")
	arg_4_0._btnGoto = gohelper.findChildButtonWithAudio(arg_4_0._goNormal, "#btn_goto")
	arg_4_0._goReceive = gohelper.findChild(arg_4_0._goNormal, "#btn_receive")
	arg_4_0._btnReceive = gohelper.findChildButtonWithAudio(arg_4_0._goNormal, "#btn_receive")
	arg_4_0._goUnfinish = gohelper.findChild(arg_4_0._goNormal, "#go_unfinish")
	arg_4_0._goType1 = gohelper.findChild(arg_4_0._goGoto, "#go_gotype1")
	arg_4_0._goEffect1 = gohelper.findChild(arg_4_0._goGoto, "#go_gotype1/#go_effect1")
	arg_4_0._goType3 = gohelper.findChild(arg_4_0._goGoto, "#go_gotype3")
	arg_4_0._goEffect3 = gohelper.findChild(arg_4_0._goGoto, "#go_gotype3/#go_effect3")
	arg_4_0._goreward = gohelper.findChild(arg_4_0._goNormal, "rewardstar/#go_reward")
	arg_4_0._gorewardCanvasGroup = arg_4_0._goreward:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._gorewardredicon = gohelper.findChild(arg_4_0._goNormal, "rewardstar/#go_reward/red")
	arg_4_0._gorewardlighticon = gohelper.findChild(arg_4_0._goNormal, "rewardstar/#go_reward/light")
	arg_4_0._gorewarddardicon = gohelper.findChild(arg_4_0._goNormal, "rewardstar/#go_reward/dark")
end

function var_0_0.initTotal(arg_5_0)
	arg_5_0._btnGetTotal = gohelper.findChildButtonWithAudio(arg_5_0._goTotal, "#btn_getall")
end

var_0_0.TaskMaskTime = 0.65
var_0_0.ColumnCount = 1
var_0_0.AnimRowCount = 7
var_0_0.OpenAnimTime = 0.06
var_0_0.OpenAnimStartTime = 0

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return
	end

	arg_6_0.mo = arg_6_1
	arg_6_0._scrollreward.parentGameObject = arg_6_0._view._csListScroll.gameObject

	if arg_6_0.mo.canGetAll then
		gohelper.setActive(arg_6_0._goNormal, false)
		gohelper.setActive(arg_6_0._goTotal, true)
		arg_6_0._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
	else
		gohelper.setActive(arg_6_0._goNormal, true)
		gohelper.setActive(arg_6_0._goTotal, false)
		arg_6_0:refreshNormal()
	end

	arg_6_0:checkPlayAnim()
end

function var_0_0.endPlayOpenAnim(arg_7_0)
	gohelper.setActive(arg_7_0._goEffect1, false)
	gohelper.setActive(arg_7_0._goEffect3, false)

	arg_7_0._ani.enabled = true
	arg_7_0.firstEnter = false
end

function var_0_0.checkPlayAnim(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onDelayPlayOpen, arg_8_0)

	local var_8_0 = Season123TaskModel.instance:getDelayPlayTime(arg_8_0.mo)

	if var_8_0 == -1 then
		arg_8_0._animator:Play("idle", 0, 0)

		arg_8_0._animator.speed = 1

		gohelper.setActive(arg_8_0._goEffect1, false)
		gohelper.setActive(arg_8_0._goEffect3, false)
	else
		arg_8_0._animator:Play("open", 0, 0)

		arg_8_0._animator.speed = 0

		gohelper.setActive(arg_8_0._goEffect1, true)
		gohelper.setActive(arg_8_0._goEffect3, true)
		TaskDispatcher.runDelay(arg_8_0.onDelayPlayOpen, arg_8_0, var_8_0)
	end
end

function var_0_0.onDelayPlayOpen(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.onDelayPlayOpen, arg_9_0)
	arg_9_0._animator:Play("open", 0, 0)

	arg_9_0._animator.speed = 1
end

function var_0_0.refreshNormal(arg_10_0)
	arg_10_0.taskId = arg_10_0.mo.id
	arg_10_0.jumpId = arg_10_0.mo.config.jumpId

	arg_10_0:refreshReward()
	arg_10_0:refreshDesc()
	arg_10_0:refreshProgress()
	arg_10_0:refreshState()
end

function var_0_0.refreshReward(arg_11_0)
	local var_11_0 = arg_11_0.mo.config
	local var_11_1 = string.split(var_11_0.bonus, "|")
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if not string.nilorempty(iter_11_1) then
			local var_11_3 = string.splitToNumber(iter_11_1, "#")
			local var_11_4 = {
				isIcon = true,
				materilType = var_11_3[1],
				materilId = var_11_3[2],
				quantity = var_11_3[3]
			}

			table.insert(var_11_2, var_11_4)
		end
	end

	if var_11_0.equipBonus > 0 then
		table.insert(var_11_2, {
			equipId = var_11_0.equipBonus
		})
	end

	if not arg_11_0._rewardItems then
		arg_11_0._rewardItems = {}
	end

	for iter_11_2 = 1, math.max(#arg_11_0._rewardItems, #var_11_2) do
		local var_11_5 = var_11_2[iter_11_2]
		local var_11_6 = arg_11_0._rewardItems[iter_11_2] or arg_11_0:createRewardItem(iter_11_2)

		arg_11_0:refreshRewardItem(var_11_6, var_11_5)
	end
end

function var_0_0.createRewardItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()
	local var_12_1 = gohelper.clone(arg_12_0._goRewardTemplate, arg_12_0._gocontent, "reward_" .. tostring(arg_12_1))

	var_12_0.go = var_12_1
	var_12_0.itemParent = gohelper.findChild(var_12_1, "go_prop")
	var_12_0.cardParent = gohelper.findChild(var_12_1, "go_card")
	arg_12_0._rewardItems[arg_12_1] = var_12_0

	return var_12_0
end

function var_0_0.refreshRewardItem(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_2 then
		gohelper.setActive(arg_13_1.go, false)

		return
	end

	gohelper.setActive(arg_13_1.go, true)

	if arg_13_2.equipId then
		gohelper.setActive(arg_13_1.cardParent, true)
		gohelper.setActive(arg_13_1.itemParent, false)

		if not arg_13_1.equipIcon then
			arg_13_1.equipIcon = Season123_2_3CelebrityCardItem.New()

			arg_13_1.equipIcon:init(arg_13_1.cardParent, arg_13_2.equipId)
		end

		arg_13_1.equipIcon:reset(arg_13_2.equipId)

		return
	end

	gohelper.setActive(arg_13_1.cardParent, false)
	gohelper.setActive(arg_13_1.itemParent, true)

	if not arg_13_1.itemIcon then
		arg_13_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_13_1.itemParent)
	end

	arg_13_1.itemIcon:onUpdateMO(arg_13_2)
	arg_13_1.itemIcon:isShowCount(true)
	arg_13_1.itemIcon:setCountFontSize(40)
	arg_13_1.itemIcon:showStackableNum2()
	arg_13_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_13_1.itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.getAnimator(arg_14_0)
	return arg_14_0._ani
end

function var_0_0.destroyRewardItem(arg_15_0, arg_15_1)
	if arg_15_1.itemIcon then
		arg_15_1.itemIcon:onDestroy()

		arg_15_1.itemIcon = nil
	end

	if arg_15_1.equipIcon then
		arg_15_1.equipIcon:destroy()

		arg_15_1.equipIcon = nil
	end
end

function var_0_0.refreshDesc(arg_16_0)
	local var_16_0 = arg_16_0.mo.config
	local var_16_1 = string.format("tap%s.png", var_16_0.bgType == 1 and 3 or 4)

	arg_16_0._simageBg:LoadImage(ResUrl.getSeasonIcon(var_16_1))

	arg_16_0._txtDesc.text = var_16_0.desc
end

function var_0_0.refreshProgress(arg_17_0)
	local var_17_0 = arg_17_0.mo.progress
	local var_17_1 = arg_17_0.mo.config.maxProgress

	arg_17_0._txtCurCount.text = var_17_0
	arg_17_0._txtMaxCount.text = var_17_1

	local var_17_2 = Season123TaskModel.instance.curTaskType

	gohelper.setActive(arg_17_0._goreward, var_17_2 == Activity123Enum.TaskRewardViewType)
	gohelper.setActive(arg_17_0._txtCurCount.gameObject, var_17_2 == Activity123Enum.TaskNormalType)
end

function var_0_0.refreshState(arg_18_0)
	if arg_18_0.mo.finishCount >= arg_18_0.mo.config.maxFinishCount then
		gohelper.setActive(arg_18_0._goMask, true)
		gohelper.setActive(arg_18_0._goFinish, true)
		gohelper.setActive(arg_18_0._goGoto, false)
		gohelper.setActive(arg_18_0._goReceive, false)
		gohelper.setActive(arg_18_0._goUnfinish, false)
		gohelper.setActive(arg_18_0._gorewardredicon, arg_18_0.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(arg_18_0._gorewardlighticon, arg_18_0.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(arg_18_0._gorewarddardicon, false)

		arg_18_0._gorewardCanvasGroup.alpha = 0.3
	elseif arg_18_0.mo.hasFinished then
		gohelper.setActive(arg_18_0._goMask, false)
		gohelper.setActive(arg_18_0._goFinish, false)
		gohelper.setActive(arg_18_0._goGoto, false)
		gohelper.setActive(arg_18_0._goReceive, true)
		gohelper.setActive(arg_18_0._goUnfinish, false)
		gohelper.setActive(arg_18_0._gorewardredicon, arg_18_0.mo.config.bgType == Activity123Enum.TaskHardType.Hard)
		gohelper.setActive(arg_18_0._gorewardlighticon, arg_18_0.mo.config.bgType == Activity123Enum.TaskHardType.Normal)
		gohelper.setActive(arg_18_0._gorewarddardicon, false)

		arg_18_0._gorewardCanvasGroup.alpha = 1
	else
		gohelper.setActive(arg_18_0._goMask, false)
		gohelper.setActive(arg_18_0._goFinish, false)
		gohelper.setActive(arg_18_0._goReceive, false)

		if arg_18_0.jumpId and arg_18_0.jumpId > 0 then
			gohelper.setActive(arg_18_0._goGoto, true)
			gohelper.setActive(arg_18_0._goUnfinish, false)
			gohelper.setActive(arg_18_0._goType1, arg_18_0.mo.config.bgType ~= 1)
			gohelper.setActive(arg_18_0._goType3, arg_18_0.mo.config.bgType == 1)
		else
			gohelper.setActive(arg_18_0._goGoto, false)
			gohelper.setActive(arg_18_0._goUnfinish, true)
		end

		gohelper.setActive(arg_18_0._gorewardredicon, false)
		gohelper.setActive(arg_18_0._gorewardlighticon, false)
		gohelper.setActive(arg_18_0._gorewarddardicon, true)

		arg_18_0._gorewardCanvasGroup.alpha = 1
	end
end

function var_0_0.onClickGoto(arg_19_0)
	if not arg_19_0.jumpId then
		return
	end

	GameFacade.jump(arg_19_0.jumpId)
end

function var_0_0.onClickReceive(arg_20_0)
	if not arg_20_0.taskId and not arg_20_0.mo.canGetAll then
		return
	end

	gohelper.setActive(arg_20_0._goMask, true)
	arg_20_0._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	Season123Controller.instance:dispatchEvent(Season123Event.OnTaskRewardGetFinish, arg_20_0._index)
	TaskDispatcher.runDelay(arg_20_0._onPlayActAniFinished, arg_20_0, var_0_0.TaskMaskTime)
end

function var_0_0._onPlayActAniFinished(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onPlayActAniFinished, arg_21_0)

	if arg_21_0.mo.canGetAll then
		local var_21_0 = Season123TaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season123, 0, var_21_0, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(arg_21_0.taskId)
	end

	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
end

function var_0_0.onClickGetTotal(arg_22_0)
	arg_22_0:onClickReceive()
end

function var_0_0.onDestroy(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onPlayActAniFinished, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.onDelayPlayOpen, arg_23_0)

	if arg_23_0._rewardItems then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._rewardItems) do
			arg_23_0:destroyRewardItem(iter_23_1)
		end

		arg_23_0._rewardItems = nil
	end

	TaskDispatcher.cancelTask(arg_23_0._onPlayActAniFinished, arg_23_0)
end

return var_0_0
