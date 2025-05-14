module("modules.logic.versionactivity2_2.act173.view.Activity173FullView", package.seeall)

local var_0_0 = class("Activity173FullView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_Descr")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnGO = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_GO")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnGO:AddClickListener(arg_2_0._btnGOOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnGO:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnGOOnClick(arg_4_0)
	arg_4_0:closeThis()
	GameFacade.jump(JumpEnum.JumpId.Activity173)
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onClickModalMask(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onOpen(arg_9_0)
	PatFaceCustomHandler.setHasShow(PatFaceEnum.patFace.V2a2_LimitDecorate_PanelView)
	arg_9_0:refreshActRemainTime()
	TaskDispatcher.cancelTask(arg_9_0.refreshActRemainTime, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0.refreshActRemainTime, arg_9_0, var_0_1)
	arg_9_0:initRewards()
	arg_9_0:initActivityInfo()
end

function var_0_0.refreshActRemainTime(arg_10_0)
	arg_10_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function var_0_0.initActivityInfo(arg_11_0)
	local var_11_0 = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.LimitDecorate)

	arg_11_0._txtDescr.text = var_11_0 and var_11_0.actDesc
end

function var_0_0.initRewards(arg_12_0)
	arg_12_0._onlineTasks = Activity173Config.instance:getAllOnlineTasks()
	arg_12_0._bonusMap = {}

	for iter_12_0 = 1, #arg_12_0._onlineTasks do
		local var_12_0 = arg_12_0._onlineTasks[iter_12_0]
		local var_12_1 = arg_12_0:getOrCreateRewardItem(iter_12_0)

		if string.nilorempty(var_12_0.bonus) then
			logError("限定装饰品奖励活动任务奖励配置为空: 任务Id = " .. tostring(var_12_0.id))
		else
			local var_12_2 = string.splitToNumber(var_12_0.bonus, "#")

			if arg_12_0:checkIsPortraitReward(var_12_2) then
				arg_12_0:onConfigPortraitReward(var_12_2, var_12_1)
			end

			arg_12_0._bonusMap[var_12_0.id] = var_12_2
			var_12_1.txtNum.text = luaLang("multiple") .. tostring(var_12_2[3])
		end
	end
end

function var_0_0.getOrCreateRewardItem(arg_13_0, arg_13_1)
	arg_13_0._rewardItems = arg_13_0._rewardItems or arg_13_0:getUserDataTb_()

	local var_13_0 = arg_13_0._rewardItems[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.goRewardItem = gohelper.findChild(arg_13_0.viewGO, "Right/Reward" .. arg_13_1)
		var_13_0.txtNum = gohelper.findChildText(var_13_0.goRewardItem, "image_NumBG/txt_Num")
		var_13_0.simageheadicon = gohelper.findChildSingleImage(var_13_0.goRewardItem, "#simage_HeadIcon")
		var_13_0.btnclick = gohelper.findChildButtonWithAudio(var_13_0.goRewardItem, "btn_click")

		var_13_0.btnclick:AddClickListener(arg_13_0.onClickRewardIcon, arg_13_0, arg_13_1)

		arg_13_0._rewardItems[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.onClickRewardIcon(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._onlineTasks and arg_14_0._onlineTasks[arg_14_1]

	if not var_14_0 then
		return
	end

	local var_14_1 = arg_14_0._bonusMap and arg_14_0._bonusMap[var_14_0.id]

	if not var_14_1 then
		logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(var_14_0.id))

		return
	end

	MaterialTipController.instance:showMaterialInfo(var_14_1[1], var_14_1[2])
end

function var_0_0.checkIsPortraitReward(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1[1]
	local var_15_1 = arg_15_1[2]

	if var_15_0 == MaterialEnum.MaterialType.Item then
		local var_15_2 = ItemModel.instance:getItemConfig(var_15_0, var_15_1)

		if var_15_2 and var_15_2.subType == ItemEnum.SubType.Portrait then
			return true
		end
	end
end

function var_0_0.onConfigPortraitReward(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2.simageheadicon then
		if not arg_16_0._liveHeadIcon then
			arg_16_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_16_2.simageheadicon)
		end

		arg_16_0._liveHeadIcon:setLiveHead(tonumber(arg_16_1[2]))
	end
end

function var_0_0.removeAllRewardIconClick(arg_17_0)
	if arg_17_0._rewardItems then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._rewardItems) do
			if iter_17_1.btnclick then
				iter_17_1.btnclick:RemoveClickListener()
			end
		end
	end
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refreshActRemainTime, arg_18_0)
	arg_18_0:removeAllRewardIconClick()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
