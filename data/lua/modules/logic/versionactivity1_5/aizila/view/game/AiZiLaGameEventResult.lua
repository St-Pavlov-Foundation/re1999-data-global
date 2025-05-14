module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventResult", package.seeall)

local var_0_0 = class("AiZiLaGameEventResult", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_PanelBG")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/#scroll_Descr")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	arg_1_0._simagePanelBGMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_PanelBGMask")
	arg_1_0._simageLevelPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_LevelPic")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/Reward/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "content/Reward/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnleave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/Reward/Btn/#btn_leave")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_Tips")
	arg_1_0._goTagBG = gohelper.findChild(arg_1_0.viewGO, "content/#go_TagBG")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnleave:AddClickListener(arg_2_0._btnleaveOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnleave:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	AiZiLaGameController.instance:leaveEventResult()
end

function var_0_0._btnleaveOnClick(arg_5_0)
	AiZiLaGameController.instance:leaveEventResult()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goodsItemGo = arg_6_0:getResInst(AiZiLaGoodsItem.prefabPath, arg_6_0.viewGO)

	gohelper.setActive(arg_6_0._goodsItemGo, false)

	arg_6_0._goRewardBG = gohelper.findChild(arg_6_0.viewGO, "content/Reward/image_RewardBG")
	arg_6_0._goTexReward = gohelper.findChild(arg_6_0.viewGO, "content/Reward/txt_Reward")
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	arg_8_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_8_0.closeThis, arg_8_0)

	if arg_8_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_8_0.viewContainer.viewName, arg_8_0._btncloseOnClick, arg_8_0)
	end

	arg_8_0._eventId = arg_8_0.viewParam.eventId
	arg_8_0._actId = arg_8_0.viewParam.actId
	arg_8_0._optionId = arg_8_0.viewParam.optionId
	arg_8_0._optionResultId = arg_8_0.viewParam.optionResultId
	arg_8_0._itemMOList = arg_8_0.viewParam.itemMOList
	arg_8_0._eventCfg = AiZiLaConfig.instance:getEventCo(arg_8_0._actId, arg_8_0._eventId)
	arg_8_0._optionCfg = AiZiLaConfig.instance:getOptionCo(arg_8_0._actId, arg_8_0._optionId)
	arg_8_0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(arg_8_0._actId, AiZiLaGameModel.instance:getEpisodeId())
	arg_8_0._optionResultCfg = AiZiLaConfig.instance:getOptionResultCo(arg_8_0._actId, arg_8_0._optionResultId)

	if not arg_8_0._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", arg_8_0._actId, arg_8_0._eventId)
	end

	if not arg_8_0._optionCfg then
		logError("export_事件选项 配置找不到: activityId:%s optionId:%s", arg_8_0._actId, arg_8_0._optionId)
	end

	if not arg_8_0._optionResultCfg then
		logError("export_选项结果 配置找不到: activityId:%s optionId:%s", arg_8_0._actId, arg_8_0._optionResultId)
	end

	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageLevelPic:UnLoadImage()
end

function var_0_0.playViewAnimator(arg_11_0, arg_11_1)
	if arg_11_0._animator then
		arg_11_0._animator.enabled = true

		arg_11_0._animator:Play(arg_11_1, 0, 0)
	end
end

function var_0_0.refreshUI(arg_12_0)
	if not arg_12_0._eventCfg or not arg_12_0._optionCfg then
		return
	end

	if arg_12_0._episodeCfg and not string.nilorempty(arg_12_0._episodeCfg.picture) then
		arg_12_0._simageLevelPic:LoadImage(string.format("%s.png", arg_12_0._episodeCfg.picture))
	end

	local var_12_0 = arg_12_0._itemMOList and #arg_12_0._itemMOList > 0

	gohelper.setActive(arg_12_0._goRewardBG, var_12_0)
	gohelper.setActive(arg_12_0._goTexReward, var_12_0)
	gohelper.setActive(arg_12_0._goTagBG, arg_12_0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)
	gohelper.CreateObjList(arg_12_0, arg_12_0._onRewardItem, arg_12_0._itemMOList, arg_12_0._gorewards, arg_12_0._goodsItemGo, AiZiLaGoodsItem)

	arg_12_0._txtDescr.text = arg_12_0._optionCfg.conditionDesc

	local var_12_1 = arg_12_0._optionResultCfg and arg_12_0._optionResultCfg.desc or arg_12_0._optionCfg.desc

	arg_12_0._txtTips.text = string.format("%s\n<color=#8f5501>%s</color>", arg_12_0._optionCfg.name, var_12_1)
end

function var_0_0._onRewardItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:onUpdateMO(arg_13_2)
end

return var_0_0
