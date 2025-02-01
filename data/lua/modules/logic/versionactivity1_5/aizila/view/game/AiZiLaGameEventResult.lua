module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventResult", package.seeall)

slot0 = class("AiZiLaGameEventResult", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_PanelBG")
	slot0._scrollDescr = gohelper.findChildScrollRect(slot0.viewGO, "content/#scroll_Descr")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	slot0._simagePanelBGMask = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_PanelBGMask")
	slot0._simageLevelPic = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_LevelPic")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "content/Reward/#scroll_rewards")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "content/Reward/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnleave = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/Reward/Btn/#btn_leave")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "content/#txt_Tips")
	slot0._goTagBG = gohelper.findChild(slot0.viewGO, "content/#go_TagBG")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnleave:AddClickListener(slot0._btnleaveOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnleave:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	AiZiLaGameController.instance:leaveEventResult()
end

function slot0._btnleaveOnClick(slot0)
	AiZiLaGameController.instance:leaveEventResult()
end

function slot0._editableInitView(slot0)
	slot0._goodsItemGo = slot0:getResInst(AiZiLaGoodsItem.prefabPath, slot0.viewGO)

	gohelper.setActive(slot0._goodsItemGo, false)

	slot0._goRewardBG = gohelper.findChild(slot0.viewGO, "content/Reward/image_RewardBG")
	slot0._goTexReward = gohelper.findChild(slot0.viewGO, "content/Reward/txt_Reward")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0._eventId = slot0.viewParam.eventId
	slot0._actId = slot0.viewParam.actId
	slot0._optionId = slot0.viewParam.optionId
	slot0._optionResultId = slot0.viewParam.optionResultId
	slot0._itemMOList = slot0.viewParam.itemMOList
	slot0._eventCfg = AiZiLaConfig.instance:getEventCo(slot0._actId, slot0._eventId)
	slot0._optionCfg = AiZiLaConfig.instance:getOptionCo(slot0._actId, slot0._optionId)
	slot0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(slot0._actId, AiZiLaGameModel.instance:getEpisodeId())
	slot0._optionResultCfg = AiZiLaConfig.instance:getOptionResultCo(slot0._actId, slot0._optionResultId)

	if not slot0._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", slot0._actId, slot0._eventId)
	end

	if not slot0._optionCfg then
		logError("export_事件选项 配置找不到: activityId:%s optionId:%s", slot0._actId, slot0._optionId)
	end

	if not slot0._optionResultCfg then
		logError("export_选项结果 配置找不到: activityId:%s optionId:%s", slot0._actId, slot0._optionResultId)
	end

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageLevelPic:UnLoadImage()
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.refreshUI(slot0)
	if not slot0._eventCfg or not slot0._optionCfg then
		return
	end

	if slot0._episodeCfg and not string.nilorempty(slot0._episodeCfg.picture) then
		slot0._simageLevelPic:LoadImage(string.format("%s.png", slot0._episodeCfg.picture))
	end

	slot1 = slot0._itemMOList and #slot0._itemMOList > 0

	gohelper.setActive(slot0._goRewardBG, slot1)
	gohelper.setActive(slot0._goTexReward, slot1)
	gohelper.setActive(slot0._goTagBG, slot0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)
	gohelper.CreateObjList(slot0, slot0._onRewardItem, slot0._itemMOList, slot0._gorewards, slot0._goodsItemGo, AiZiLaGoodsItem)

	slot0._txtDescr.text = slot0._optionCfg.conditionDesc
	slot0._txtTips.text = string.format("%s\n<color=#8f5501>%s</color>", slot0._optionCfg.name, slot0._optionResultCfg and slot0._optionResultCfg.desc or slot0._optionCfg.desc)
end

function slot0._onRewardItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
end

return slot0
