module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventView", package.seeall)

slot0 = class("AiZiLaGameEventView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_PanelBG")
	slot0._scrollDescr = gohelper.findChildScrollRect(slot0.viewGO, "content/#scroll_Descr")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	slot0._simagePanelBGMask = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_PanelBGMask")
	slot0._simageLevelPic = gohelper.findChildSingleImage(slot0.viewGO, "content/#simage_LevelPic")
	slot0._goselectItem = gohelper.findChild(slot0.viewGO, "content/#go_selectItem")
	slot0._goEnable = gohelper.findChild(slot0.viewGO, "content/#go_selectItem/#go_Enable")
	slot0._goDisable = gohelper.findChild(slot0.viewGO, "content/#go_selectItem/#go_Disable")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/#go_selectItem/#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "content/#go_selectItem/#txt_desc")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/#go_selectItem/#btn_click")
	slot0._goselectGroup = gohelper.findChild(slot0.viewGO, "content/scroll_select/Viewport/#go_selectGroup")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0._goTagBG = gohelper.findChild(slot0.viewGO, "content/image_TagBG")

	transformhelper.setLocalPos(slot0._goselectItem.transform, 0, 0, 0)
	gohelper.setActive(slot0._goselectItem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.RefreshGameEpsiode, slot0.refreshUI, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0._eventId = AiZiLaGameModel.instance:getEventId()
	slot0._actId = AiZiLaGameModel.instance:getActivityID()
	slot0._eventCfg = AiZiLaConfig.instance:getEventCo(slot0._actId, slot0._eventId)
	slot0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(slot0._actId, AiZiLaGameModel.instance:getEpisodeId())

	if not slot0._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", slot0._actId, slot0._eventId)
	end

	if slot0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OnBranchLineEvent)
	end

	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageLevelPic:UnLoadImage()
end

function slot0.refreshUI(slot0)
	if not slot0._eventCfg then
		return
	end

	if slot0._episodeCfg and not string.nilorempty(slot0._episodeCfg.picture) then
		slot0._simageLevelPic:LoadImage(string.format("%s.png", slot0._episodeCfg.picture))
	end

	gohelper.setActive(slot0._goTagBG, slot0._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)
	gohelper.CreateObjList(slot0, slot0._onSelectItem, slot0:_getOptionMOList(), slot0._goselectGroup, slot0._goselectItem, AiZiLaGameEventItem)

	slot0._txtDescr.text = slot0._eventCfg.desc
end

function slot0._getOptionMOList(slot0)
	slot1 = {}

	if slot0._eventCfg and not string.nilorempty(slot0._eventCfg.optionIds) and string.splitToNumber(slot0._eventCfg.optionIds, "|") then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot1, {
				optionId = slot7,
				actId = slot0._actId,
				index = slot6,
				eventType = slot0._eventCfg.eventType
			})
		end
	end

	return slot1
end

function slot0._onSelectItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	slot1._view = slot0
end

return slot0
