module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventView", package.seeall)

local var_0_0 = class("AiZiLaGameEventView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_PanelBG")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/#scroll_Descr")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	arg_1_0._simagePanelBGMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_PanelBGMask")
	arg_1_0._simageLevelPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/#simage_LevelPic")
	arg_1_0._goselectItem = gohelper.findChild(arg_1_0.viewGO, "content/#go_selectItem")
	arg_1_0._goEnable = gohelper.findChild(arg_1_0.viewGO, "content/#go_selectItem/#go_Enable")
	arg_1_0._goDisable = gohelper.findChild(arg_1_0.viewGO, "content/#go_selectItem/#go_Disable")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/#go_selectItem/#txt_name")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "content/#go_selectItem/#txt_desc")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/#go_selectItem/#btn_click")
	arg_1_0._goselectGroup = gohelper.findChild(arg_1_0.viewGO, "content/scroll_select/Viewport/#go_selectGroup")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclickOnClick(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_6_0._goTagBG = gohelper.findChild(arg_6_0.viewGO, "content/image_TagBG")

	transformhelper.setLocalPos(arg_6_0._goselectItem.transform, 0, 0, 0)
	gohelper.setActive(arg_6_0._goselectItem, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.playViewAnimator(arg_8_0, arg_8_1)
	if arg_8_0._animator then
		arg_8_0._animator.enabled = true

		arg_8_0._animator:Play(arg_8_1, 0, 0)
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_9_0.closeThis, arg_9_0)
	arg_9_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.RefreshGameEpsiode, arg_9_0.refreshUI, arg_9_0)

	if arg_9_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_9_0.viewContainer.viewName, arg_9_0._btncloseOnClick, arg_9_0)
	end

	arg_9_0._eventId = AiZiLaGameModel.instance:getEventId()
	arg_9_0._actId = AiZiLaGameModel.instance:getActivityID()
	arg_9_0._eventCfg = AiZiLaConfig.instance:getEventCo(arg_9_0._actId, arg_9_0._eventId)
	arg_9_0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(arg_9_0._actId, AiZiLaGameModel.instance:getEpisodeId())

	if not arg_9_0._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", arg_9_0._actId, arg_9_0._eventId)
	end

	if arg_9_0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OnBranchLineEvent)
	end

	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper)
	arg_9_0:refreshUI()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageLevelPic:UnLoadImage()
end

function var_0_0.refreshUI(arg_12_0)
	if not arg_12_0._eventCfg then
		return
	end

	if arg_12_0._episodeCfg and not string.nilorempty(arg_12_0._episodeCfg.picture) then
		arg_12_0._simageLevelPic:LoadImage(string.format("%s.png", arg_12_0._episodeCfg.picture))
	end

	gohelper.setActive(arg_12_0._goTagBG, arg_12_0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)

	local var_12_0 = arg_12_0:_getOptionMOList()

	gohelper.CreateObjList(arg_12_0, arg_12_0._onSelectItem, var_12_0, arg_12_0._goselectGroup, arg_12_0._goselectItem, AiZiLaGameEventItem)

	arg_12_0._txtDescr.text = arg_12_0._eventCfg.desc
end

function var_0_0._getOptionMOList(arg_13_0)
	local var_13_0 = {}

	if arg_13_0._eventCfg and not string.nilorempty(arg_13_0._eventCfg.optionIds) then
		local var_13_1 = string.splitToNumber(arg_13_0._eventCfg.optionIds, "|")

		if var_13_1 then
			for iter_13_0, iter_13_1 in ipairs(var_13_1) do
				table.insert(var_13_0, {
					optionId = iter_13_1,
					actId = arg_13_0._actId,
					index = iter_13_0,
					eventType = arg_13_0._eventCfg.eventType
				})
			end
		end
	end

	return var_13_0
end

function var_0_0._onSelectItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:onUpdateMO(arg_14_2)

	arg_14_1._view = arg_14_0
end

return var_0_0
