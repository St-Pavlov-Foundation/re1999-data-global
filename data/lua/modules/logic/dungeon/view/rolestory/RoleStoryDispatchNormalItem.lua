module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalItem", package.seeall)

local var_0_0 = class("RoleStoryDispatchNormalItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
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
	TaskDispatcher.cancelTask(arg_4_0.refreshItem, arg_4_0)

	arg_4_0.isPlayingRefresh = false

	if not arg_4_0.data then
		arg_4_0:clear()
		gohelper.setActive(arg_4_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_4_0.viewGO, true)

	local var_4_0 = arg_4_0.data.config

	arg_4_0.txtOrder.text = string.format("%02d", arg_4_0.index)
	arg_4_0.txtLockedOrder.text = string.format("%02d", arg_4_0.index)

	arg_4_0:refreshState()

	if not arg_4_0.isPlayingRefresh then
		arg_4_0.txtTitle.text = luaLang("rolestorydispatchtitle_2")
		arg_4_0.txtContent.text = var_4_0.desc
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.RoleStoryDispatchTipsView then
		arg_5_0:checkPlayAnim()
	end
end

function var_0_0.checkPlayAnim(arg_6_0)
	if not ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		if arg_6_0.data:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			arg_6_0:playFinishAnim()
		end

		if arg_6_0.canPlayUnlockAnim then
			arg_6_0.canPlayUnlockAnim = false

			arg_6_0.data:setRefreshAnimFlag()
			gohelper.setActive(arg_6_0.goLocked, true)
			arg_6_0.lockedAnim:Play("unlock")
			TaskDispatcher.runDelay(arg_6_0.refreshItem, arg_6_0, 1.5)
		elseif arg_6_0.data:canPlayRefreshAnim() then
			arg_6_0.data:setRefreshAnimFlag()
			RoleStoryController.instance:dispatchEvent(RoleStoryEvent.NormalDispatchRefresh)
			arg_6_0.viewAnim:Play("refresh", 0, 0)

			arg_6_0.isPlayingRefresh = true

			TaskDispatcher.runDelay(arg_6_0.refreshItem, arg_6_0, 0.5)
		end
	end
end

function var_0_0.playFinishAnim(arg_7_0)
	if arg_7_0.data:checkFinishAnimIsPlayed() then
		arg_7_0.finishAnim:Play("go_hasget_idle")
	else
		arg_7_0.data:setFinishAnimFlag()
		arg_7_0.finishAnim:Play("go_hasget_in")
	end
end

function var_0_0.refreshState(arg_8_0)
	local var_8_0 = arg_8_0.data:getDispatchState()

	if arg_8_0.waitUnlock then
		var_8_0 = RoleStoryEnum.DispatchState.Locked
	end

	gohelper.setActive(arg_8_0.goFinish, var_8_0 == RoleStoryEnum.DispatchState.Finish)
	gohelper.setActive(arg_8_0.goDispatching, var_8_0 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(arg_8_0.goGoto, var_8_0 == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(arg_8_0.goCanget, var_8_0 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(arg_8_0.goLocked, var_8_0 == RoleStoryEnum.DispatchState.Locked)
	arg_8_0:refreshDispatchTime(var_8_0)

	if arg_8_0.waitUnlock then
		return
	end

	if var_8_0 == RoleStoryEnum.DispatchState.Canget then
		arg_8_0.rewardAnim:Play("loop")
	end

	arg_8_0:checkPlayAnim()
end

function var_0_0.refreshDispatchTime(arg_9_0, arg_9_1)
	TaskDispatcher.cancelTask(arg_9_0.updateDispatchTime, arg_9_0)

	if arg_9_1 ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	arg_9_0.dispatchEndTime = arg_9_0.data.endTime

	arg_9_0:updateDispatchTime()
	TaskDispatcher.runRepeat(arg_9_0.updateDispatchTime, arg_9_0, 1)
end

function var_0_0.updateDispatchTime(arg_10_0)
	local var_10_0 = arg_10_0.dispatchEndTime * 0.001 - ServerTime.now()

	if var_10_0 < 0 then
		arg_10_0:refreshItem()

		return
	end

	arg_10_0.txtDispatchTime.text = TimeUtil.second2TimeString(var_10_0, true)
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0.data = arg_11_1
	arg_11_0.index = arg_11_3
	arg_11_0.storyId = arg_11_2
	arg_11_0.param = arg_11_4 or {}
	arg_11_0.canPlayUnlockAnim = arg_11_0.param.canPlayUnlockAnim
	arg_11_0.waitUnlock = arg_11_0.param.waitUnlock

	arg_11_0:refreshItem()
end

function var_0_0.onClickBtnGoto(arg_12_0)
	arg_12_0:openTipsView()
end

function var_0_0.onClickBtnCanget(arg_13_0)
	arg_13_0:openTipsView()
end

function var_0_0.onClickBtnClick(arg_14_0)
	arg_14_0:openTipsView()
end

function var_0_0.openTipsView(arg_15_0)
	if not arg_15_0.data then
		return
	end

	local var_15_0 = arg_15_0.data:getDispatchState()

	if var_15_0 == RoleStoryEnum.DispatchState.Locked or var_15_0 == RoleStoryEnum.DispatchState.goFinish then
		return
	end

	ViewMgr.instance:openView(ViewName.RoleStoryDispatchTipsView, {
		dispatchId = arg_15_0.data.id,
		storyId = arg_15_0.storyId
	})
end

function var_0_0._editableInitView(arg_16_0)
	return
end

function var_0_0.clear(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.updateDispatchTime, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0:clear()
	TaskDispatcher.cancelTask(arg_18_0.refreshItem, arg_18_0)
end

return var_0_0
