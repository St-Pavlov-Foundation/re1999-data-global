module("modules.logic.season.view1_6.Season1_6TaskItem", package.seeall)

local var_0_0 = class("Season1_6TaskItem", UserDataDispose)

function var_0_0._singleActiveEnTxt(arg_1_0, arg_1_1)
	local var_1_0 = LangSettings.instance:isEn()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._enGOList) do
		gohelper.setActive(iter_1_1, not var_1_0 and iter_1_0 == arg_1_1)
	end
end

var_0_0.BlockKey = "Season1_6TaskItemAni"

function var_0_0.ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._enGOList = arg_2_0:getUserDataTb_()

	table.insert(arg_2_0._enGOList, gohelper.findChild(arg_2_1, "en1"))
	table.insert(arg_2_0._enGOList, gohelper.findChild(arg_2_1, "en2"))
	table.insert(arg_2_0._enGOList, gohelper.findChild(arg_2_1, "en3"))
	arg_2_0:__onInit()

	arg_2_0._viewGO = arg_2_1
	arg_2_0._simageBg = gohelper.findChildSingleImage(arg_2_1, "#simage_bg")
	arg_2_0._goNormal = gohelper.findChild(arg_2_1, "#goNormal")
	arg_2_0._goTotal = gohelper.findChild(arg_2_1, "#goTotal")
	arg_2_0._ani = arg_2_1:GetComponent(typeof(UnityEngine.Animator))

	arg_2_0:initNormal(arg_2_2)
	arg_2_0:initTotal()

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end

	arg_2_0:addEventListeners()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnGoto:AddClickListener(arg_3_0.onClickGoto, arg_3_0)
	arg_3_0._btnReceive:AddClickListener(arg_3_0.onClickReceive, arg_3_0)
	arg_3_0._btnGetTotal:AddClickListener(arg_3_0.onClickGetTotal, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnGoto:RemoveClickListener()
	arg_4_0._btnReceive:RemoveClickListener()
	arg_4_0._btnGetTotal:RemoveClickListener()
end

function var_0_0.initNormal(arg_5_0, arg_5_1)
	arg_5_0._txtCurCount = gohelper.findChildTextMesh(arg_5_0._goNormal, "#txt_curcount")
	arg_5_0._txtMaxCount = gohelper.findChildTextMesh(arg_5_0._goNormal, "#txt_curcount/#txt_maxcount")
	arg_5_0._txtDesc = gohelper.findChildTextMesh(arg_5_0._goNormal, "#txt_desc")
	arg_5_0._scrollreward = gohelper.findChild(arg_5_0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_5_0._gocontent = gohelper.findChild(arg_5_0._goNormal, "#scroll_rewards/Viewport/Content")
	arg_5_0._scrollreward.parentGameObject = arg_5_1
	arg_5_0._goRewardTemplate = gohelper.findChild(arg_5_0._gocontent, "#go_rewarditem")

	gohelper.setActive(arg_5_0._goRewardTemplate, false)

	arg_5_0._goMask = gohelper.findChild(arg_5_0._goNormal, "#go_blackmask")
	arg_5_0._goFinish = gohelper.findChild(arg_5_0._goNormal, "#go_finish")
	arg_5_0._goGoto = gohelper.findChild(arg_5_0._goNormal, "#btn_goto")
	arg_5_0._btnGoto = gohelper.findChildButtonWithAudio(arg_5_0._goNormal, "#btn_goto")
	arg_5_0._goReceive = gohelper.findChild(arg_5_0._goNormal, "#btn_receive")
	arg_5_0._btnReceive = gohelper.findChildButtonWithAudio(arg_5_0._goNormal, "#btn_receive")
	arg_5_0._goUnfinish = gohelper.findChild(arg_5_0._goNormal, "#go_unfinish")
	arg_5_0._goType1 = gohelper.findChild(arg_5_0._goGoto, "#go_gotype1")
	arg_5_0._goType3 = gohelper.findChild(arg_5_0._goGoto, "#go_gotype3")
end

function var_0_0.initTotal(arg_6_0)
	arg_6_0._btnGetTotal = gohelper.findChildButtonWithAudio(arg_6_0._goTotal, "#btn_getall")
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		gohelper.setActive(arg_7_0._viewGO, true)

		if arg_7_1.isTotalGet then
			gohelper.setActive(arg_7_0._goNormal, false)
			gohelper.setActive(arg_7_0._goTotal, true)
			arg_7_0._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
			arg_7_0:_singleActiveEnTxt(2)
		else
			gohelper.setActive(arg_7_0._goNormal, true)
			gohelper.setActive(arg_7_0._goTotal, false)
			arg_7_0:refreshNormal(arg_7_1)
		end

		if arg_7_2 then
			arg_7_0._ani:Play(UIAnimationName.Open)
		else
			arg_7_0._ani:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(arg_7_0._viewGO, false)
	end
end

function var_0_0.hide(arg_8_0)
	gohelper.setActive(arg_8_0._viewGO, false)
end

function var_0_0.refreshNormal(arg_9_0, arg_9_1)
	arg_9_0.taskId = arg_9_1.id
	arg_9_0.jumpId = arg_9_1.config.jumpId

	gohelper.setActive(arg_9_0._viewGO, true)
	arg_9_0:refreshReward(arg_9_1)
	arg_9_0:refreshDesc(arg_9_1)
	arg_9_0:refreshProgress(arg_9_1)
	arg_9_0:refreshState(arg_9_1)
end

function var_0_0.refreshReward(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.config
	local var_10_1 = string.split(var_10_0.bonus, "|")
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if not string.nilorempty(iter_10_1) then
			local var_10_3 = string.splitToNumber(iter_10_1, "#")
			local var_10_4 = {
				isIcon = true,
				materilType = var_10_3[1],
				materilId = var_10_3[2],
				quantity = var_10_3[3]
			}

			table.insert(var_10_2, var_10_4)
		end
	end

	if var_10_0.activity104EquipBonus > 0 then
		table.insert(var_10_2, {
			equipId = var_10_0.activity104EquipBonus
		})
	end

	if not arg_10_0._rewardItems then
		arg_10_0._rewardItems = {}
	end

	for iter_10_2 = 1, math.max(#arg_10_0._rewardItems, #var_10_2) do
		local var_10_5 = var_10_2[iter_10_2]
		local var_10_6 = arg_10_0._rewardItems[iter_10_2] or arg_10_0:createRewardItem(iter_10_2)

		arg_10_0:refreshRewardItem(var_10_6, var_10_5)
	end
end

function var_0_0.createRewardItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUserDataTb_()
	local var_11_1 = gohelper.clone(arg_11_0._goRewardTemplate, arg_11_0._gocontent, "reward_" .. tostring(arg_11_1))

	var_11_0.go = var_11_1
	var_11_0.itemParent = gohelper.findChild(var_11_1, "go_prop")
	var_11_0.cardParent = gohelper.findChild(var_11_1, "go_card")
	arg_11_0._rewardItems[arg_11_1] = var_11_0

	return var_11_0
end

function var_0_0.refreshRewardItem(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_2 then
		gohelper.setActive(arg_12_1.go, false)

		return
	end

	gohelper.setActive(arg_12_1.go, true)

	if arg_12_2.equipId then
		gohelper.setActive(arg_12_1.cardParent, true)
		gohelper.setActive(arg_12_1.itemParent, false)

		if not arg_12_1.equipIcon then
			arg_12_1.equipIcon = Season1_6CelebrityCardItem.New()

			arg_12_1.equipIcon:init(arg_12_1.cardParent, arg_12_2.equipId)
		end

		arg_12_1.equipIcon:reset(arg_12_2.equipId)

		return
	end

	gohelper.setActive(arg_12_1.cardParent, false)
	gohelper.setActive(arg_12_1.itemParent, true)

	if not arg_12_1.itemIcon then
		arg_12_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_12_1.itemParent)
	end

	arg_12_1.itemIcon:onUpdateMO(arg_12_2)
	arg_12_1.itemIcon:isShowCount(true)
	arg_12_1.itemIcon:setCountFontSize(40)
	arg_12_1.itemIcon:showStackableNum2()
	arg_12_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_12_1.itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.destroyRewardItem(arg_13_0, arg_13_1)
	if arg_13_1.itemIcon then
		arg_13_1.itemIcon:onDestroy()

		arg_13_1.itemIcon = nil
	end

	if arg_13_1.equipIcon then
		arg_13_1.equipIcon:destroy()

		arg_13_1.equipIcon = nil
	end
end

function var_0_0.refreshDesc(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.config
	local var_14_1 = var_14_0.bgType == 1 and 3 or 1
	local var_14_2 = string.format("tap%s.png", var_14_1)

	arg_14_0._simageBg:LoadImage(ResUrl.getSeasonIcon(var_14_2))

	arg_14_0._txtDesc.text = var_14_0.desc

	arg_14_0:_singleActiveEnTxt(var_14_1)
end

function var_0_0.refreshProgress(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.progress
	local var_15_1 = arg_15_1.config.maxProgress

	arg_15_0._txtCurCount.text = var_15_0
	arg_15_0._txtMaxCount.text = var_15_1
end

function var_0_0.refreshState(arg_16_0, arg_16_1)
	if arg_16_1.finishCount >= arg_16_1.config.maxFinishCount then
		gohelper.setActive(arg_16_0._goMask, true)
		gohelper.setActive(arg_16_0._goFinish, true)
		gohelper.setActive(arg_16_0._goGoto, false)
		gohelper.setActive(arg_16_0._goReceive, false)
	elseif arg_16_1.hasFinished then
		gohelper.setActive(arg_16_0._goMask, false)
		gohelper.setActive(arg_16_0._goFinish, false)
		gohelper.setActive(arg_16_0._goGoto, false)
		gohelper.setActive(arg_16_0._goReceive, true)
	else
		gohelper.setActive(arg_16_0._goMask, false)
		gohelper.setActive(arg_16_0._goFinish, false)
		gohelper.setActive(arg_16_0._goReceive, false)

		if arg_16_0.jumpId and arg_16_0.jumpId > 0 then
			local var_16_0 = arg_16_1.config

			gohelper.setActive(arg_16_0._goGoto, true)
			gohelper.setActive(arg_16_0._goUnfinish, false)
			gohelper.setActive(arg_16_0._goType1, arg_16_1.config.bgType ~= 1)
			gohelper.setActive(arg_16_0._goType3, arg_16_1.config.bgType == 1)
		else
			gohelper.setActive(arg_16_0._goGoto, false)
			gohelper.setActive(arg_16_0._goUnfinish, true)
		end
	end
end

function var_0_0.onClickGoto(arg_17_0)
	if not arg_17_0.jumpId then
		return
	end

	if GameFacade.jump(arg_17_0.jumpId) then
		Activity104Controller.instance:closeSeasonView(Activity104Enum.ViewName.TaskView, nil, true)
	end
end

function var_0_0.onClickReceive(arg_18_0)
	if not arg_18_0.taskId then
		return
	end

	gohelper.setActive(arg_18_0._goMask, true)
	arg_18_0._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_18_0._onPlayActAniFinished, arg_18_0, 0.76)
end

function var_0_0.onClickGetTotal(arg_19_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season)
end

function var_0_0._onPlayActAniFinished(arg_20_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(arg_20_0.taskId)
	arg_20_0:hide()
end

function var_0_0.destroy(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onPlayActAniFinished, arg_21_0)
	arg_21_0:removeEventListeners()

	if arg_21_0._rewardItems then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._rewardItems) do
			arg_21_0:destroyRewardItem(iter_21_1)
		end

		arg_21_0._rewardItems = nil
	end

	arg_21_0:__onDispose()
end

return var_0_0
