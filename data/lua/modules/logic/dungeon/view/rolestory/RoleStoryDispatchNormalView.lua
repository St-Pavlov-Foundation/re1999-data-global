module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchNormalView", package.seeall)

slot0 = class("RoleStoryDispatchNormalView", BaseView)

function slot0.onInitView(slot0)
	slot0.itemList = {}
	slot0.goDispatchList = gohelper.findChild(slot0.viewGO, "DispatchList")
	slot0.goDispatchScroll = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch")
	slot0.goDispatch = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch/Content/#go_NormalDispatch")
	slot0.content = gohelper.findChild(slot0.viewGO, "DispatchList/#Scroll_Dispatch/Content")
	slot0._hLayoutGroup = slot0.content:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	slot0.dispatchType = RoleStoryEnum.DispatchType.Normal
	slot0.txtTips = gohelper.findChildTextMesh(slot0.goDispatch, "Title/txt/#txt_tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.NormalDispatchRefresh, slot0._onNormalDispatchRefresh, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.UpdateInfo, slot0._onDispatchStateChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onCloseView(slot0, slot1)
	slot0:playUnlockTween()
end

function slot0._onDispatchStateChange(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0.storyId = slot0.viewParam.storyId

	if not slot0.storyId then
		slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	end

	slot0:refreshView()

	if slot0.normalViewShow then
		slot0._hLayoutGroup.padding.right = (recthelper.getWidth(slot0.goDispatchList.transform) - recthelper.getWidth(slot0.goDispatch.transform)) / 2

		slot0:doDelayShow()
	end
end

function slot0.playUnlockTween(slot0)
	if ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchTipsView) then
		return
	end

	if slot0.needTween then
		slot0:doDelayShow()
	end
end

function slot0.doDelayShow(slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)
	TaskDispatcher.runDelay(slot0.delayShow, slot0, 0.05)
end

function slot0.moveLast(slot0, slot1)
	if slot0.tweenId then
		return
	end

	slot0.needTween = false
	slot2 = slot0.content.transform

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive_2)

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPosX(slot2, -math.max(recthelper.getWidth(slot2) - recthelper.getWidth(slot2.parent), 0), 1, slot0.onMoveEnd, slot0)
	else
		recthelper.setAnchorX(slot2, slot6)
	end
end

function slot0.onMoveEnd(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if not RoleStoryModel.instance:getById(slot0.storyId) then
		return
	end

	GameFacade.showToast(ToastEnum.RoleStoryDispatchNormalUnlock)
	slot0:refreshDispatchList(slot1:getNormalDispatchList(), true)
	slot1:setPlayNormalDispatchUnlockAnimFlag()
end

function slot0.delayShow(slot0)
	slot0:moveLast(slot0.needTween)
end

function slot0.onUpdateParam(slot0)
	slot0.storyId = slot0.viewParam.storyId

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot0.normalViewShow = false

	if not RoleStoryModel.instance:getById(slot0.storyId) then
		slot0:clearItems()
		gohelper.setActive(slot0.goDispatch, false)

		return
	end

	if #slot1:getNormalDispatchList() == 0 then
		slot0:clearItems()
		gohelper.setActive(slot0.goDispatch, false)

		return
	end

	slot0.normalViewShow = true

	gohelper.setActive(slot0.goDispatch, true)

	for slot7, slot8 in ipairs(slot2) do
		if slot8:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
			slot3 = 0 + 1
		end
	end

	if slot1:isScoreFull() then
		slot0.txtTips.text = luaLang("rolestoryscoreisfull")
	else
		slot0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rolestorynormaldispatchtips"), {
			slot3,
			#slot2
		})
	end

	if slot1:canPlayNormalDispatchUnlockAnim() then
		slot0:refreshDispatchList(slot2, nil, true)

		slot0.needTween = true

		slot0:playUnlockTween()
	else
		slot0:refreshDispatchList(slot2)
	end
end

function slot0.refreshDispatchList(slot0, slot1, slot2, slot3)
	slot7 = #slot1

	for slot7 = 1, math.max(slot7, #slot0.itemList) do
		slot0:refreshDispatchItem(slot0.itemList[slot7], slot1[slot7], slot7, {
			canPlayUnlockAnim = slot2,
			waitUnlock = slot3
		})
	end
end

function slot0.refreshDispatchItem(slot0, slot1, slot2, slot3, slot4)
	(slot1 or slot0:createItem(slot3)):onUpdateMO(slot2, slot0.storyId, slot3, slot4)
end

function slot0.createItem(slot0, slot1)
	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.normalItemRes, gohelper.findChild(slot0.goDispatch, string.format("Item/#go_item%s", slot1)), "go"), RoleStoryDispatchNormalItem)
	slot5.scrollDesc.parentGameObject = slot0.goDispatchScroll
	slot0.itemList[slot1] = slot5

	return slot5
end

function slot0._onNormalDispatchRefresh(slot0)
	TaskDispatcher.cancelTask(slot0.playRefreshAudio, slot0)
	TaskDispatcher.runDelay(slot0.playRefreshAudio, slot0, 0.05)
end

function slot0.playRefreshAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function slot0.onClose(slot0)
end

function slot0.clearItems(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:clear()
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.playRefreshAudio, slot0)
	TaskDispatcher.cancelTask(slot0._delayShow, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	slot0:clearItems()
end

return slot0
