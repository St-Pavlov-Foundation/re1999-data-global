module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryItem", package.seeall)

slot0 = class("RoleStoryDispatchStoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
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
	if not slot0.data then
		slot0:clear()
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.txtOrder.text = string.format("%02d", slot0.index)
	slot0.txtLockedOrder.text = string.format("%02d", slot0.index)
	slot0.txtTitle.text = formatLuaLang("rolestorydispatchtitle_1", GameUtil.getNum2Chinese(slot0.index))
	slot0.txtContent.text = slot0.data.desc

	slot0:refreshState()

	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		slot0:playFinishAnim()
	end

	slot0.notFirstUpdate = true
end

function slot0.refreshState(slot0)
	gohelper.setActive(slot0.goFinish, RoleStoryModel.instance:getById(slot0.data.heroStoryId):getDispatchState(slot0.data.id) == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(slot0.goDispatching, slot2 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(slot0.goGoto, slot2 == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(slot0.goCanget, slot2 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(slot0.goLocked, slot2 == RoleStoryEnum.DispatchState.Locked)

	if slot2 == RoleStoryEnum.DispatchState.Locked then
		slot3 = slot0.data.unlockEpisodeId
		slot0.txtLocked.text = formatLuaLang("room_formula_lock_episode", string.format("%s %s", DungeonConfig.instance:getEpisodeDisplay(slot3), DungeonConfig.instance:getEpisodeCO(slot3).name))
	end

	slot0:refreshDispatchTime(slot2)

	if slot2 == RoleStoryEnum.DispatchState.Canget then
		slot0.rewardAnim:Play("loop")
	end

	slot0:checkPlayAnim()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.RoleStoryDispatchTipsView then
		slot0:checkPlayAnim()
	end
end

function slot0.checkPlayAnim(slot0)
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		if RoleStoryModel.instance:getById(slot0.data.heroStoryId):getDispatchMo(slot0.data.id):getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			slot0:playFinishAnim()
		end

		if slot2:canPlayRefreshAnim() then
			slot2:setRefreshAnimFlag()
			gohelper.setActive(slot0.goGoto, false)
			gohelper.setActive(slot0.goLocked, true)
			TaskDispatcher.cancelTask(slot0.playUnlockAnim, slot0)

			if not slot0.notFirstUpdate then
				TaskDispatcher.runDelay(slot0.playUnlockAnim, slot0, 1)
			else
				slot0:playUnlockAnim()
			end
		end
	end
end

function slot0.playUnlockAnim(slot0)
	slot0.lockedAnim:Play("unlock")
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryDispatchUnlock)
	TaskDispatcher.runDelay(slot0.refreshItem, slot0, 1.5)
end

function slot0.playFinishAnim(slot0)
	if RoleStoryModel.instance:getById(slot0.data.heroStoryId):getDispatchMo(slot0.data.id):getDispatchState() == RoleStoryEnum.DispatchState.Finish then
		if slot2:checkFinishAnimIsPlayed() then
			slot0.finishAnim:Play("go_hasget_idle")
		else
			slot2:setFinishAnimFlag()
			slot0.finishAnim:Play("go_hasget_in")
		end
	end
end

function slot0.refreshDispatchTime(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)

	if slot1 ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	slot0.dispatchEndTime = RoleStoryModel.instance:getById(slot0.data.heroStoryId):getDispatchMo(slot0.data.id).endTime

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

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2

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

	if RoleStoryModel.instance:getById(slot0.data.heroStoryId):getDispatchState(slot0.data.id) == RoleStoryEnum.DispatchState.Locked then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLockTips)

		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = slot0.data.id,
		storyId = slot0.data.heroStoryId
	})
end

function slot0._editableInitView(slot0)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)
	TaskDispatcher.cancelTask(slot0.refreshItem, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clear()
end

return slot0
