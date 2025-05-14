module("modules.logic.season.view1_5.Season1_5TaskItem", package.seeall)

local var_0_0 = class("Season1_5TaskItem", UserDataDispose)

var_0_0.BlockKey = "Season1_5TaskItemAni"

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._viewGO = arg_1_1
	arg_1_0._simageBg = gohelper.findChildSingleImage(arg_1_1, "#simage_bg")
	arg_1_0._goNormal = gohelper.findChild(arg_1_1, "#goNormal")
	arg_1_0._goTotal = gohelper.findChild(arg_1_1, "#goTotal")
	arg_1_0._ani = arg_1_1:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:initNormal(arg_1_2)
	arg_1_0:initTotal()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0:addEventListeners()
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

function var_0_0.initNormal(arg_4_0, arg_4_1)
	arg_4_0._txtCurCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount")
	arg_4_0._txtMaxCount = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_curcount/#txt_maxcount")
	arg_4_0._txtDesc = gohelper.findChildTextMesh(arg_4_0._goNormal, "#txt_desc")
	arg_4_0._scrollreward = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_4_0._gocontent = gohelper.findChild(arg_4_0._goNormal, "#scroll_rewards/Viewport/Content")
	arg_4_0._scrollreward.parentGameObject = arg_4_1
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
	arg_4_0._goType3 = gohelper.findChild(arg_4_0._goGoto, "#go_gotype3")
end

function var_0_0.initTotal(arg_5_0)
	arg_5_0._btnGetTotal = gohelper.findChildButtonWithAudio(arg_5_0._goTotal, "#btn_getall")
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		gohelper.setActive(arg_6_0._viewGO, true)

		if arg_6_1.isTotalGet then
			gohelper.setActive(arg_6_0._goNormal, false)
			gohelper.setActive(arg_6_0._goTotal, true)
			arg_6_0._simageBg:LoadImage(ResUrl.getSeasonIcon("tap2.png"))
		else
			gohelper.setActive(arg_6_0._goNormal, true)
			gohelper.setActive(arg_6_0._goTotal, false)
			arg_6_0:refreshNormal(arg_6_1)
		end

		if arg_6_2 then
			arg_6_0._ani:Play(UIAnimationName.Open)
		else
			arg_6_0._ani:Play(UIAnimationName.Idle)
		end
	else
		gohelper.setActive(arg_6_0._viewGO, false)
	end
end

function var_0_0.hide(arg_7_0)
	gohelper.setActive(arg_7_0._viewGO, false)
end

function var_0_0.refreshNormal(arg_8_0, arg_8_1)
	arg_8_0.taskId = arg_8_1.id
	arg_8_0.jumpId = arg_8_1.config.jumpId

	gohelper.setActive(arg_8_0._viewGO, true)
	arg_8_0:refreshReward(arg_8_1)
	arg_8_0:refreshDesc(arg_8_1)
	arg_8_0:refreshProgress(arg_8_1)
	arg_8_0:refreshState(arg_8_1)
end

function var_0_0.refreshReward(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.config
	local var_9_1 = string.split(var_9_0.bonus, "|")
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if not string.nilorempty(iter_9_1) then
			local var_9_3 = string.splitToNumber(iter_9_1, "#")
			local var_9_4 = {
				isIcon = true,
				materilType = var_9_3[1],
				materilId = var_9_3[2],
				quantity = var_9_3[3]
			}

			table.insert(var_9_2, var_9_4)
		end
	end

	if var_9_0.activity104EquipBonus > 0 then
		table.insert(var_9_2, {
			equipId = var_9_0.activity104EquipBonus
		})
	end

	if not arg_9_0._rewardItems then
		arg_9_0._rewardItems = {}
	end

	for iter_9_2 = 1, math.max(#arg_9_0._rewardItems, #var_9_2) do
		local var_9_5 = var_9_2[iter_9_2]
		local var_9_6 = arg_9_0._rewardItems[iter_9_2] or arg_9_0:createRewardItem(iter_9_2)

		arg_9_0:refreshRewardItem(var_9_6, var_9_5)
	end
end

function var_0_0.createRewardItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()
	local var_10_1 = gohelper.clone(arg_10_0._goRewardTemplate, arg_10_0._gocontent, "reward_" .. tostring(arg_10_1))

	var_10_0.go = var_10_1
	var_10_0.itemParent = gohelper.findChild(var_10_1, "go_prop")
	var_10_0.cardParent = gohelper.findChild(var_10_1, "go_card")
	arg_10_0._rewardItems[arg_10_1] = var_10_0

	return var_10_0
end

function var_0_0.refreshRewardItem(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		gohelper.setActive(arg_11_1.go, false)

		return
	end

	gohelper.setActive(arg_11_1.go, true)

	if arg_11_2.equipId then
		gohelper.setActive(arg_11_1.cardParent, true)
		gohelper.setActive(arg_11_1.itemParent, false)

		if not arg_11_1.equipIcon then
			arg_11_1.equipIcon = Season1_5CelebrityCardItem.New()

			arg_11_1.equipIcon:init(arg_11_1.cardParent, arg_11_2.equipId)
		end

		arg_11_1.equipIcon:reset(arg_11_2.equipId)

		return
	end

	gohelper.setActive(arg_11_1.cardParent, false)
	gohelper.setActive(arg_11_1.itemParent, true)

	if not arg_11_1.itemIcon then
		arg_11_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_11_1.itemParent)
	end

	arg_11_1.itemIcon:onUpdateMO(arg_11_2)
	arg_11_1.itemIcon:isShowCount(true)
	arg_11_1.itemIcon:setCountFontSize(40)
	arg_11_1.itemIcon:showStackableNum2()
	arg_11_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_11_1.itemIcon:hideEquipLvAndBreak(true)
end

function var_0_0.destroyRewardItem(arg_12_0, arg_12_1)
	if arg_12_1.itemIcon then
		arg_12_1.itemIcon:onDestroy()

		arg_12_1.itemIcon = nil
	end

	if arg_12_1.equipIcon then
		arg_12_1.equipIcon:destroy()

		arg_12_1.equipIcon = nil
	end
end

function var_0_0.refreshDesc(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.config
	local var_13_1 = string.format("tap%s.png", var_13_0.bgType == 1 and 3 or 1)

	arg_13_0._simageBg:LoadImage(ResUrl.getSeasonIcon(var_13_1))

	arg_13_0._txtDesc.text = var_13_0.desc
end

function var_0_0.refreshProgress(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.progress
	local var_14_1 = arg_14_1.config.maxProgress

	arg_14_0._txtCurCount.text = var_14_0
	arg_14_0._txtMaxCount.text = var_14_1
end

function var_0_0.refreshState(arg_15_0, arg_15_1)
	if arg_15_1.finishCount >= arg_15_1.config.maxFinishCount then
		gohelper.setActive(arg_15_0._goMask, true)
		gohelper.setActive(arg_15_0._goFinish, true)
		gohelper.setActive(arg_15_0._goGoto, false)
		gohelper.setActive(arg_15_0._goReceive, false)
	elseif arg_15_1.hasFinished then
		gohelper.setActive(arg_15_0._goMask, false)
		gohelper.setActive(arg_15_0._goFinish, false)
		gohelper.setActive(arg_15_0._goGoto, false)
		gohelper.setActive(arg_15_0._goReceive, true)
	else
		gohelper.setActive(arg_15_0._goMask, false)
		gohelper.setActive(arg_15_0._goFinish, false)
		gohelper.setActive(arg_15_0._goReceive, false)

		if arg_15_0.jumpId and arg_15_0.jumpId > 0 then
			local var_15_0 = arg_15_1.config

			gohelper.setActive(arg_15_0._goGoto, true)
			gohelper.setActive(arg_15_0._goUnfinish, false)
			gohelper.setActive(arg_15_0._goType1, arg_15_1.config.bgType ~= 1)
			gohelper.setActive(arg_15_0._goType3, arg_15_1.config.bgType == 1)
		else
			gohelper.setActive(arg_15_0._goGoto, false)
			gohelper.setActive(arg_15_0._goUnfinish, true)
		end
	end
end

function var_0_0.onClickGoto(arg_16_0)
	if not arg_16_0.jumpId then
		return
	end

	if GameFacade.jump(arg_16_0.jumpId) then
		Activity104Controller.instance:closeSeasonView(Activity104Enum.ViewName.TaskView, nil, true)
	end
end

function var_0_0.onClickReceive(arg_17_0)
	if not arg_17_0.taskId then
		return
	end

	gohelper.setActive(arg_17_0._goMask, true)
	arg_17_0._ani:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)
	TaskDispatcher.runDelay(arg_17_0._onPlayActAniFinished, arg_17_0, 0.76)
end

function var_0_0.onClickGetTotal(arg_18_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Season)
end

function var_0_0._onPlayActAniFinished(arg_19_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
	TaskRpc.instance:sendFinishTaskRequest(arg_19_0.taskId)
	arg_19_0:hide()
end

function var_0_0.destroy(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._onPlayActAniFinished, arg_20_0)
	arg_20_0:removeEventListeners()

	if arg_20_0._rewardItems then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._rewardItems) do
			arg_20_0:destroyRewardItem(iter_20_1)
		end

		arg_20_0._rewardItems = nil
	end

	arg_20_0:__onDispose()
end

return var_0_0
