module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalView", package.seeall)

local var_0_0 = class("RoleStoryDispatchNormalView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.itemList = {}
	arg_1_0.goDispatchList = gohelper.findChild(arg_1_0.viewGO, "DispatchList")
	arg_1_0.goDispatchScroll = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch")
	arg_1_0.goDispatch = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_NormalDispatch")
	arg_1_0.content = gohelper.findChild(arg_1_0.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	arg_1_0._hLayoutGroup = arg_1_0.content:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	arg_1_0.dispatchType = RoleStoryEnum.DispatchType.Normal
	arg_1_0.txtTips = gohelper.findChildTextMesh(arg_1_0.goDispatch, "Title/txt/#txt_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.NormalDispatchRefresh, arg_2_0._onNormalDispatchRefresh, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, arg_2_0._onDispatchStateChange, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	arg_5_0:playUnlockTween()
end

function var_0_0._onDispatchStateChange(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.storyId = arg_7_0.viewParam.storyId

	if not arg_7_0.storyId then
		arg_7_0.storyId = RoleStoryModel.instance:getCurActStoryId()
	end

	arg_7_0:refreshView()

	if arg_7_0.normalViewShow then
		local var_7_0 = (recthelper.getWidth(arg_7_0.goDispatchList.transform) - recthelper.getWidth(arg_7_0.goDispatch.transform)) / 2

		arg_7_0._hLayoutGroup.padding.right = var_7_0

		arg_7_0:doDelayShow()
	end
end

function var_0_0.playUnlockTween(arg_8_0)
	if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		return
	end

	if arg_8_0.needTween then
		arg_8_0:doDelayShow()
	end
end

function var_0_0.doDelayShow(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayShow, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0.delayShow, arg_9_0, 0.05)
end

function var_0_0.moveLast(arg_10_0, arg_10_1)
	if arg_10_0.tweenId then
		return
	end

	arg_10_0.needTween = false

	local var_10_0 = arg_10_0.content.transform
	local var_10_1 = recthelper.getWidth(var_10_0.parent)
	local var_10_2 = recthelper.getWidth(var_10_0)
	local var_10_3 = -math.max(var_10_2 - var_10_1, 0)

	if arg_10_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive_2)

		arg_10_0.tweenId = ZProj.TweenHelper.DOAnchorPosX(var_10_0, var_10_3, 1, arg_10_0.onMoveEnd, arg_10_0)
	else
		recthelper.setAnchorX(var_10_0, var_10_3)
	end
end

function var_0_0.onMoveEnd(arg_11_0)
	if arg_11_0.tweenId then
		ZProj.TweenHelper.KillById(arg_11_0.tweenId)

		arg_11_0.tweenId = nil
	end

	local var_11_0 = RoleStoryModel.instance:getById(arg_11_0.storyId)

	if not var_11_0 then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchNormalUnlock)

	local var_11_1 = var_11_0:getNormalDispatchList()

	arg_11_0:refreshDispatchList(var_11_1, true)
	var_11_0:setPlayNormalDispatchUnlockAnimFlag()
end

function var_0_0.delayShow(arg_12_0)
	arg_12_0:moveLast(arg_12_0.needTween)
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0.storyId = arg_13_0.viewParam.storyId

	arg_13_0:refreshView()
end

function var_0_0.refreshView(arg_14_0)
	arg_14_0.normalViewShow = false

	local var_14_0 = RoleStoryModel.instance:getById(arg_14_0.storyId)

	if not var_14_0 then
		arg_14_0:clearItems()
		gohelper.setActive(arg_14_0.goDispatch, false)

		return
	end

	local var_14_1 = var_14_0:getNormalDispatchList()

	if #var_14_1 == 0 then
		arg_14_0:clearItems()
		gohelper.setActive(arg_14_0.goDispatch, false)

		return
	end

	arg_14_0.normalViewShow = true

	gohelper.setActive(arg_14_0.goDispatch, true)

	local var_14_2 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			var_14_2 = var_14_2 + 1
		end
	end

	if var_14_0:isScoreFull() then
		arg_14_0.txtTips.text = luaLang("rolestoryscoreisfull")
	else
		local var_14_3 = {
			var_14_2,
			#var_14_1
		}

		arg_14_0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestorynormaldispatchtips"), var_14_3)
	end

	if var_14_0:canPlayNormalDispatchUnlockAnim() then
		arg_14_0:refreshDispatchList(var_14_1, nil, true)

		arg_14_0.needTween = true

		arg_14_0:playUnlockTween()
	else
		arg_14_0:refreshDispatchList(var_14_1)
	end
end

function var_0_0.refreshDispatchList(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	for iter_15_0 = 1, math.max(#arg_15_1, #arg_15_0.itemList) do
		arg_15_0:refreshDispatchItem(arg_15_0.itemList[iter_15_0], arg_15_1[iter_15_0], iter_15_0, {
			canPlayUnlockAnim = arg_15_2,
			waitUnlock = arg_15_3
		})
	end
end

function var_0_0.refreshDispatchItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_1 = arg_16_1 or arg_16_0:createItem(arg_16_3)

	arg_16_1:onUpdateMO(arg_16_2, arg_16_0.storyId, arg_16_3, arg_16_4)
end

function var_0_0.createItem(arg_17_0, arg_17_1)
	local var_17_0 = gohelper.findChild(arg_17_0.goDispatch, string.format("Item/#go_item%s", arg_17_1))
	local var_17_1 = arg_17_0.viewContainer:getSetting().otherRes.normalItemRes
	local var_17_2 = arg_17_0.viewContainer:getResInst(var_17_1, var_17_0, "go")
	local var_17_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_2, RoleStoryDispatchNormalItem)

	var_17_3.scrollDesc.parentGameObject = arg_17_0.goDispatchScroll
	arg_17_0.itemList[arg_17_1] = var_17_3

	return var_17_3
end

function var_0_0._onNormalDispatchRefresh(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.playRefreshAudio, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0.playRefreshAudio, arg_18_0, 0.05)
end

function var_0_0.playRefreshAudio(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.clearItems(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.itemList) do
		iter_21_1:clear()
	end
end

function var_0_0.onDestroyView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.playRefreshAudio, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._delayShow, arg_22_0)

	if arg_22_0.tweenId then
		ZProj.TweenHelper.KillById(arg_22_0.tweenId)

		arg_22_0.tweenId = nil
	end

	arg_22_0:clearItems()
end

return var_0_0
