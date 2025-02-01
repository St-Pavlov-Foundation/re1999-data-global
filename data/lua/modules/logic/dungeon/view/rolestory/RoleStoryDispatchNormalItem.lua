module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalItem", package.seeall)

slot0 = class("RoleStoryDispatchNormalItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.txtOrder = gohelper.findChildTextMesh(slot0.viewGO, "#txt_order")
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.viewGO, "#txt_title")
	slot0.txtContent = gohelper.findChildTextMesh(slot0.viewGO, "#scroll_Desc/Viewport/#txt_DecContent")
	slot0.scrollDesc = gohelper.findChild(slot0.viewGO, "#scroll_Desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0.finishAnim = gohelper.findChildComponent(slot0.goFinish, "icon/go_hasget", typeof(UnityEngine.Animator))
	slot0.goDispatching = gohelper.findChild(slot0.viewGO, "#go_dispatching")
	slot0.txtDispatchTime = gohelper.findChildTextMesh(slot0.goDispatching, "#txt_time")
	slot0.goGoto = gohelper.findChild(slot0.viewGO, "#go_goto")
	slot0.btnGoto = gohelper.findChildButtonWithAudio(slot0.goGoto, "#btn_goto")
	slot0.goCanget = gohelper.findChild(slot0.viewGO, "#go_canget")
	slot0.btnCanget = gohelper.findChildButtonWithAudio(slot0.goCanget, "#btn_canget")
	slot0.rewardAnim = gohelper.findChildComponent(slot0.goCanget, "#btn_canget/ani", typeof(UnityEngine.Animator))
	slot0.goLocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0.lockedAnim = gohelper.findChildComponent(slot0.viewGO, "#go_locked", typeof(UnityEngine.Animator))
	slot0.txtLockedOrder = gohelper.findChildTextMesh(slot0.goLocked, "#txt_order")
	slot0.txtLocked = gohelper.findChildTextMesh(slot0.goLocked, "#txt_locked")
	slot0.btnClick = gohelper.getClickWithAudio(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnGoto, slot0.onClickBtnGoto, slot0)
	slot0:addClickCb(slot0.btnCanget, slot0.onClickBtnCanget, slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClickBtnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refreshItem(slot0)
	TaskDispatcher.cancelTask(slot0.refreshItem, slot0)

	slot0.isPlayingRefresh = false

	if not slot0.data then
		slot0:clear()
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.txtOrder.text = string.format("%02d", slot0.index)
	slot0.txtLockedOrder.text = string.format("%02d", slot0.index)

	slot0:refreshState()

	if not slot0.isPlayingRefresh then
		slot0.txtTitle.text = luaLang("rolestorydispatchtitle_2")
		slot0.txtContent.text = slot0.data.config.desc
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoleStoryDispatchTipsView then
		slot0:checkPlayAnim()
	end
end

function slot0.checkPlayAnim(slot0)
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		if slot0.data:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			slot0:playFinishAnim()
		end

		if slot0.canPlayUnlockAnim then
			slot0.canPlayUnlockAnim = false

			slot0.data:setRefreshAnimFlag()
			gohelper.setActive(slot0.goLocked, true)
			slot0.lockedAnim:Play("unlock")
			TaskDispatcher.runDelay(slot0.refreshItem, slot0, 1.5)
		elseif slot0.data:canPlayRefreshAnim() then
			slot0.data:setRefreshAnimFlag()
			RoleStoryController.instance:dispatchEvent(RoleStoryEvent.NormalDispatchRefresh)
			slot0.viewAnim:Play("refresh", 0, 0)

			slot0.isPlayingRefresh = true

			TaskDispatcher.runDelay(slot0.refreshItem, slot0, 0.5)
		end
	end
end

function slot0.playFinishAnim(slot0)
	if slot0.data:checkFinishAnimIsPlayed() then
		slot0.finishAnim:Play("go_hasget_idle")
	else
		slot0.data:setFinishAnimFlag()
		slot0.finishAnim:Play("go_hasget_in")
	end
end

function slot0.refreshState(slot0)
	slot1 = slot0.data:getDispatchState()

	if slot0.waitUnlock then
		slot1 = RoleStoryEnum.DispatchState.Locked
	end

	gohelper.setActive(slot0.goFinish, slot1 == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(slot0.goDispatching, slot1 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(slot0.goGoto, slot1 == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(slot0.goCanget, slot1 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(slot0.goLocked, slot1 == RoleStoryEnum.DispatchState.Locked)
	slot0:refreshDispatchTime(slot1)

	if slot0.waitUnlock then
		return
	end

	if slot1 == RoleStoryEnum.DispatchState.Canget then
		slot0.rewardAnim:Play("loop")
	end

	slot0:checkPlayAnim()
end

function slot0.refreshDispatchTime(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)

	if slot1 ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	slot0.dispatchEndTime = slot0.data.endTime

	slot0:updateDispatchTime()
	TaskDispatcher.runRepeat(slot0.updateDispatchTime, slot0, 1)
end

function slot0.updateDispatchTime(slot0)
	if slot0.dispatchEndTime * 0.001 - ServerTime.now() < 0 then
		slot0:refreshItem()

		return
	end

	slot0.txtDispatchTime.text = TimeUtil.second2TimeString(slot1, true)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.index = slot3
	slot0.storyId = slot2
	slot0.param = slot4 or {}
	slot0.canPlayUnlockAnim = slot0.param.canPlayUnlockAnim
	slot0.waitUnlock = slot0.param.waitUnlock

	slot0:refreshItem()
end

function slot0.onClickBtnGoto(slot0)
	slot0:openTipsView()
end

function slot0.onClickBtnCanget(slot0)
	slot0:openTipsView()
end

function slot0.onClickBtnClick(slot0)
	slot0:openTipsView()
end

function slot0.openTipsView(slot0)
	if not slot0.data then
		return
	end

	if slot0.data:getDispatchState() == RoleStoryEnum.DispatchState.Locked or slot1 == RoleStoryEnum.DispatchState.goFinish then
		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = slot0.data.id,
		storyId = slot0.storyId
	})
end

function slot0._editableInitView(slot0)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clear()
	TaskDispatcher.cancelTask(slot0.refreshItem, slot0)
end

return slot0
