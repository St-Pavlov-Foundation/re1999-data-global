module("modules.logic.investigate.view.InvestigateDungeonMapView", package.seeall)

slot0 = class("InvestigateDungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnunfull = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_investigate_unfull")
	slot0._btnfull = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full")
	slot0._effect1 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_investigate_unfull/vx_get")
	slot0._effect2 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full/vx_get")
	slot0._goredpoint = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_investigate_full/#go_giftredpoint")

	RedDotController.instance:addRedDot(slot0._goredpoint, RedDotEnum.DotNode.InvestigateTask)
end

function slot0.addEvents(slot0)
	slot0._btnunfull:AddClickListener(slot0._openInvestigateView, slot0)
	slot0._btnfull:AddClickListener(slot0._openInvestigateView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.ClueUpdate, slot0.checkBtnShow, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.ShowGetEffect, slot0.showEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfull:RemoveClickListener()
	slot0._btnfull:RemoveClickListener()
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0:checkBtnShow()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0:checkBtnShow()
	end
end

function slot0._openInvestigateView(slot0)
	InvestigateController.instance:openInvestigateView()
end

function slot0.refreshView(slot0)
	slot0._isEpisodeListShow = true
	slot0.chapterId = slot0.viewParam.chapterId

	if slot0.chapterId == DungeonEnum.ChapterId.Main1_8 then
		if not InvestigateOpinionModel.instance:getIsInitOpinionInfo() then
			InvestigateRpc.instance:sendGetInvestigateRequest()
		end

		slot0:checkBtnShow()

		for slot5, slot6 in pairs(InvestigateModel.instance:getAllNewIds()) do
			if lua_investigate_info.configDict[slot6] and slot7.entrance ~= 0 then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.InvestigateClueView, {
					isGet = true,
					id = slot6
				})
			end
		end

		InvestigateModel.instance:markAllNewIds()
	else
		gohelper.setActive(slot0._btnfull, false)
		gohelper.setActive(slot0._btnunfull, false)
	end

	gohelper.setActive(slot0._effect1, false)
	gohelper.setActive(slot0._effect2, false)
end

function slot0.onOpen(slot0)
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.showEffect(slot0)
	gohelper.setActive(slot0._effect1, true)
	gohelper.setActive(slot0._effect2, true)
	TaskDispatcher.runDelay(slot0._delayHideEffect, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_qiutu_list_maintain)
end

function slot0._delayHideEffect(slot0)
	gohelper.setActive(slot0._effect1, false)
	gohelper.setActive(slot0._effect2, false)
end

function slot0.setEpisodeListVisible(slot0, slot1)
	slot0._isEpisodeListShow = slot1

	slot0:checkBtnShow()
end

function slot0.checkBtnShow(slot0)
	if slot0.chapterId ~= DungeonEnum.ChapterId.Main1_8 then
		return
	end

	gohelper.setActive(slot0._btnfull, InvestigateModel.instance:isHaveClue() and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and slot0._isEpisodeListShow)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
end

return slot0
