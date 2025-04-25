module("modules.logic.lifecircle.view.LifeCircleRewardView", package.seeall)

slot0 = class("LifeCircleRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtDays = gohelper.findChildText(slot0.viewGO, "TitleBG/#txt_Days")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Icon")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "#go_Reward")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_Reward/#scroll_Reward")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_Reward/#scroll_Reward/Viewport/#go_Content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

slot1 = SLFramework.AnimatorPlayer
slot2 = {
	ShowingRewards = 3,
	ShownRewards = 4,
	OpeningBox = 1,
	OpenedBox = 2,
	None = 0
}

function slot0._editableInitView(slot0)
	slot0._state = uv0.None
	slot0._contentGrid = slot0._goContent:GetComponent(gohelper.Type_GridLayoutGroup)
	slot0._click = gohelper.getClick(slot0.viewGO)
	slot0._animatorPlayer = uv1.Get(slot0.viewGO)
	slot0._animSelf = slot0._animatorPlayer.animator
	slot0._scrollitemTrans = slot0._scrollitem.transform
	slot0._goContentTrans = slot0._goContent.transform
	slot0._w = recthelper.getWidth(slot0._scrollitemTrans)
	slot0._h = recthelper.getHeight(slot0._scrollitemTrans)
	slot0._colCount = slot0._contentGrid.constraintCount
	slot0._itemHeight = slot0._contentGrid.cellSize.y
	slot0._spacingY = slot0._contentGrid.spacing.y

	NavigateMgr.instance:addEscape(slot0.viewName, slot0.closeThis, slot0)
	slot0:_setActive_goReward(false)
end

function slot0.closeThis(slot0)
	if slot0._state == uv0.None then
		slot0:_moveState()
	end

	if not slot0:_allowCloseView() then
		return
	end

	uv1.super.closeThis(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	CommonPropListItem.hasOpen = false
	slot0._contentGrid.enabled = false

	slot0:_setPropItems()

	slot0._txtDays.text = slot0:_loginDayCount()
end

function slot0._loginDayCount(slot0)
	return slot0.viewParam.loginDayCount or 0
end

function slot0._materialDataMOList(slot0)
	return slot0.viewParam.materialDataMOList or {}
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
end

function slot0.onOpenFinish(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_open_25251110)
end

function slot0.onClose(slot0)
	FrameTimerController.onDestroyViewMember(slot0, "_fTimer")
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	TaskDispatcher.cancelTask(slot0._moveState, slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._moveState, slot0)
end

function slot0._setPropItems(slot0)
	CommonPropListModel.instance:setPropList(slot0:_materialDataMOList())
	recthelper.setSize(slot0._goContentTrans, slot0._w, slot0:_getContentHeight())

	slot0._contentGrid.enabled = true
	slot2 = true

	FrameTimerController.onDestroyViewMember(slot0, "_fTimer")

	slot0._fTimer = FrameTimerController.instance:register(function ()
		uv0._contentGrid.enabled = uv1
		uv1 = not uv1
	end, 5, 2)

	slot0._fTimer:Start()
end

function slot0._setActive_goReward(slot0, slot1)
	gohelper.setActive(slot0._goReward, slot1)
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	slot0._animatorPlayer:Play(slot1, slot2, slot3)
end

function slot0._moveState(slot0)
	slot0:_setState(slot0._state + 1)
end

function slot0._setState(slot0, slot1)
	if slot1 <= slot0._state then
		return
	end

	slot0._state = slot1

	if slot1 == uv0.OpeningBox then
		slot0:_onOpenBoxAnim()
	elseif slot1 == uv0.OpenedBox then
		slot0:_onOpenedBox()
	elseif slot1 == uv0.ShowingRewards then
		slot0:_onShowingRewards()
	elseif slot1 == uv0.ShownRewards then
		-- Nothing
	end
end

function slot0._onOpenBoxAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_leiji_25251111)
	slot0:_playAnim(UIAnimationName.Click, slot0._moveState, slot0)
end

function slot0._onOpenedBox(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rewards_rare_2000081)
	slot0:_setActive_goReward(true)
	slot0:_moveState()
end

function slot0._onShowingRewards(slot0)
	TaskDispatcher.cancelTask(slot0._moveState, slot0)
	TaskDispatcher.runDelay(slot0._moveState, slot0, 0.8)
end

function slot0._allowCloseView(slot0)
	return uv0.ShownRewards <= slot0._state
end

function slot0._getContentHeight(slot0)
	slot6 = math.max(1, math.ceil(#CommonPropListModel.instance:getList() / slot0._colCount))

	return math.max(math.max(slot0._h, slot0._contentGrid.preferredHeight), (slot6 - 1) * slot0._spacingY + slot0._itemHeight * slot6)
end

return slot0
