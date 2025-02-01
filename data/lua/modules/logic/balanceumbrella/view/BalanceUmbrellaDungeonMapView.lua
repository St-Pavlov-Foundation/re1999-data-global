module("modules.logic.balanceumbrella.view.BalanceUmbrellaDungeonMapView", package.seeall)

slot0 = class("BalanceUmbrellaDungeonMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnunfull = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull")
	slot0._btnfull = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full")
	slot0._effect1 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_unfull/vx_get")
	slot0._effect2 = gohelper.findChild(slot0.viewGO, "#go_main/#go_rightbtns/#btn_balanceumbrella_full/vx_get")
end

function slot0.addEvents(slot0)
	slot0._btnunfull:AddClickListener(slot0._openBalanceUmbrellaView, slot0)
	slot0._btnfull:AddClickListener(slot0._openBalanceUmbrellaView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:addEventCb(BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ClueUpdate, slot0.checkBtnShow, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
	slot0:addEventCb(BalanceUmbrellaController.instance, BalanceUmbrellaEvent.ShowGetEffect, slot0.showEffect, slot0)
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

function slot0._openBalanceUmbrellaView(slot0)
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaView)
end

function slot0.refreshView(slot0)
	slot0._isEpisodeListShow = true
	slot0.chapterId = slot0.viewParam.chapterId

	if slot0.chapterId == DungeonEnum.ChapterId.Main1_7 then
		slot0:checkBtnShow()

		for slot5, slot6 in pairs(BalanceUmbrellaModel.instance:getAllNewIds()) do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BalanceUmbrellaClueView, {
				isGet = true,
				id = slot6
			})
		end

		BalanceUmbrellaModel.instance:markAllNewIds()
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
	if slot0.chapterId ~= DungeonEnum.ChapterId.Main1_7 then
		return
	end

	slot1 = ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)

	gohelper.setActive(slot0._btnfull, BalanceUmbrellaModel.instance:isGetAllClue() and not slot1 and slot0._isEpisodeListShow)
	gohelper.setActive(slot0._btnunfull, BalanceUmbrellaModel.instance:isHaveClue() and not slot2 and not slot1 and slot0._isEpisodeListShow)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayHideEffect, slot0)
end

return slot0
