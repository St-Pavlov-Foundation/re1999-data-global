module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchStoryItem", package.seeall)

local var_0_0 = class("RoleStoryDispatchStoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtOrder = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_order")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_title")
	arg_1_0.txtContent = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_Desc/Viewport/#txt_DecContent")
	arg_1_0.scrollDesc = gohelper.findChild(arg_1_0.viewGO, "#scroll_Desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0.finishAnim = gohelper.findChildComponent(arg_1_0.goFinish, "icon/go_hasget", typeof(UnityEngine.Animator))
	arg_1_0.goDispatching = gohelper.findChild(arg_1_0.viewGO, "#go_dispatching")
	arg_1_0.txtDispatchTime = gohelper.findChildTextMesh(arg_1_0.goDispatching, "#txt_time")
	arg_1_0.goGoto = gohelper.findChild(arg_1_0.viewGO, "#go_goto")
	arg_1_0.btnGoto = gohelper.findChildButtonWithAudio(arg_1_0.goGoto, "#btn_goto")
	arg_1_0.goCanget = gohelper.findChild(arg_1_0.viewGO, "#go_canget")
	arg_1_0.btnCanget = gohelper.findChildButtonWithAudio(arg_1_0.goCanget, "#btn_canget")
	arg_1_0.rewardAnim = gohelper.findChildComponent(arg_1_0.goCanget, "#btn_canget/ani", typeof(UnityEngine.Animator))
	arg_1_0.goLocked = gohelper.findChild(arg_1_0.viewGO, "#go_locked")
	arg_1_0.lockedAnim = gohelper.findChildComponent(arg_1_0.viewGO, "#go_locked", typeof(UnityEngine.Animator))
	arg_1_0.txtLockedOrder = gohelper.findChildTextMesh(arg_1_0.goLocked, "#txt_order")
	arg_1_0.txtLocked = gohelper.findChildTextMesh(arg_1_0.goLocked, "#txt_locked")
	arg_1_0.btnClick = gohelper.getClickWithAudio(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnGoto, arg_2_0.onClickBtnGoto, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCanget, arg_2_0.onClickBtnCanget, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClickBtnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refreshItem(arg_4_0)
	if not arg_4_0.data then
		arg_4_0:clear()
		gohelper.setActive(arg_4_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_4_0.viewGO, true)

	arg_4_0.txtOrder.text = string.format("%02d", arg_4_0.index)
	arg_4_0.txtLockedOrder.text = string.format("%02d", arg_4_0.index)
	arg_4_0.txtTitle.text = formatLuaLang("rolestorydispatchtitle_1", GameUtil.getNum2Chinese(arg_4_0.index))
	arg_4_0.txtContent.text = arg_4_0.data.desc

	arg_4_0:refreshState()

	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		arg_4_0:playFinishAnim()
	end

	arg_4_0.notFirstUpdate = true
end

function var_0_0.refreshState(arg_5_0)
	local var_5_0 = RoleStoryModel.instance:getById(arg_5_0.data.heroStoryId):getDispatchState(arg_5_0.data.id)

	gohelper.setActive(arg_5_0.goFinish, var_5_0 == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(arg_5_0.goDispatching, var_5_0 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(arg_5_0.goGoto, var_5_0 == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(arg_5_0.goCanget, var_5_0 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(arg_5_0.goLocked, var_5_0 == RoleStoryEnum.DispatchState.Locked)

	if var_5_0 == RoleStoryEnum.DispatchState.Locked then
		local var_5_1 = arg_5_0.data.unlockEpisodeId
		local var_5_2 = DungeonConfig.instance:getEpisodeCO(var_5_1)
		local var_5_3 = string.format("%s %s", DungeonConfig.instance:getEpisodeDisplay(var_5_1), var_5_2.name)

		arg_5_0.txtLocked.text = formatLuaLang("room_formula_lock_episode", var_5_3)
	end

	arg_5_0:refreshDispatchTime(var_5_0)

	if var_5_0 == RoleStoryEnum.DispatchState.Canget then
		arg_5_0.rewardAnim:Play("loop")
	end

	arg_5_0:checkPlayAnim()
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.RoleStoryDispatchTipsView then
		arg_6_0:checkPlayAnim()
	end
end

function var_0_0.checkPlayAnim(arg_7_0)
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		local var_7_0 = RoleStoryModel.instance:getById(arg_7_0.data.heroStoryId):getDispatchMo(arg_7_0.data.id)

		if var_7_0:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			arg_7_0:playFinishAnim()
		end

		if var_7_0:canPlayRefreshAnim() then
			var_7_0:setRefreshAnimFlag()
			gohelper.setActive(arg_7_0.goGoto, false)
			gohelper.setActive(arg_7_0.goLocked, true)
			TaskDispatcher.cancelTask(arg_7_0.playUnlockAnim, arg_7_0)

			if not arg_7_0.notFirstUpdate then
				TaskDispatcher.runDelay(arg_7_0.playUnlockAnim, arg_7_0, 1)
			else
				arg_7_0:playUnlockAnim()
			end
		end
	end
end

function var_0_0.playUnlockAnim(arg_8_0)
	arg_8_0.lockedAnim:Play("unlock")
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.StoryDispatchUnlock)
	TaskDispatcher.runDelay(arg_8_0.refreshItem, arg_8_0, 1.5)
end

function var_0_0.playFinishAnim(arg_9_0)
	local var_9_0 = RoleStoryModel.instance:getById(arg_9_0.data.heroStoryId):getDispatchMo(arg_9_0.data.id)

	if var_9_0:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
		if var_9_0:checkFinishAnimIsPlayed() then
			arg_9_0.finishAnim:Play("go_hasget_idle")
		else
			var_9_0:setFinishAnimFlag()
			arg_9_0.finishAnim:Play("go_hasget_in")
		end
	end
end

function var_0_0.refreshDispatchTime(arg_10_0, arg_10_1)
	TaskDispatcher.cancelTask(arg_10_0.updateDispatchTime, arg_10_0)

	if arg_10_1 ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	arg_10_0.dispatchEndTime = RoleStoryModel.instance:getById(arg_10_0.data.heroStoryId):getDispatchMo(arg_10_0.data.id).endTime

	arg_10_0:updateDispatchTime()
	TaskDispatcher.runRepeat(arg_10_0.updateDispatchTime, arg_10_0, 1)
end

function var_0_0.updateDispatchTime(arg_11_0)
	local var_11_0 = arg_11_0.dispatchEndTime * 0.001 - ServerTime.now()

	if var_11_0 < 0 then
		arg_11_0:refreshItem()

		return
	end

	arg_11_0.txtDispatchTime.text = TimeUtil.second2TimeString(var_11_0, true)
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.data = arg_12_1
	arg_12_0.index = arg_12_2

	arg_12_0:refreshItem()
end

function var_0_0.onClickBtnGoto(arg_13_0)
	arg_13_0:openTipsView()
end

function var_0_0.onClickBtnCanget(arg_14_0)
	arg_14_0:openTipsView()
end

function var_0_0.onClickBtnClick(arg_15_0)
	arg_15_0:openTipsView()
end

function var_0_0.openTipsView(arg_16_0)
	if not arg_16_0.data then
		return
	end

	if RoleStoryModel.instance:getById(arg_16_0.data.heroStoryId):getDispatchState(arg_16_0.data.id) == RoleStoryEnum.DispatchState.Locked then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLockTips)

		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = arg_16_0.data.id,
		storyId = arg_16_0.data.heroStoryId
	})
end

function var_0_0._editableInitView(arg_17_0)
	return
end

function var_0_0.clear(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.playUnlockAnim, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.updateDispatchTime, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refreshItem, arg_18_0)
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0:clear()
end

return var_0_0
