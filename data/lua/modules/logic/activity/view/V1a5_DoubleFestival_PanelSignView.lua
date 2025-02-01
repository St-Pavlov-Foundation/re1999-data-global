module("modules.logic.activity.view.V1a5_DoubleFestival_PanelSignView", package.seeall)

slot0 = class("V1a5_DoubleFestival_PanelSignView", Activity101SignViewBase)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._goSign = gohelper.findChild(slot0.viewGO, "Root/#go_Sign")
	slot0._imageSignNext = gohelper.findChildImage(slot0.viewGO, "Root/#go_Sign/#image_SignNext")
	slot0._imageSignNow = gohelper.findChildImage(slot0.viewGO, "Root/#go_Sign/#image_SignNow")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Root/#txt_Descr")
	slot0._scrollItemList = gohelper.findChildScrollRect(slot0.viewGO, "Root/#scroll_ItemList")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyRight")
	slot0._goBlock = gohelper.findChild(slot0.viewGO, "#go_Block")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity101SignViewBase.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity101SignViewBase.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
end

slot1 = ActivityEnum.Activity.DoubleFestivalSign_1_5
slot2 = "onSwitchEnd"

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._imageSignNextTran = slot0._imageSignNext.transform
	slot0._imageSignNowTran = slot0._imageSignNow.transform
	slot0._animSelf = slot0._goSign:GetComponent(gohelper.Type_Animator)
	slot0._animEvent = slot0._goSign:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0._animEvent:AddEventListener(uv0, slot0._onSwitchEnd, slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_df_title"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_df_sign_panelbg"))

	slot0._txtDescr.text = ""
end

function slot0.onOpen(slot0)
	ActivityType101Model.instance:setCurIndex(nil)

	slot0._lastDay = nil
	slot0._txtLimitTime.text = ""

	slot0:_setActiveBlock(false)
	slot0:internal_set_actId(slot0.viewParam.actId)
	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	slot0:internal_onOpen()
	slot0:_resetByDay(ActivityType101Model.instance:getLastGetIndex(uv0))
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0.onClose(slot0)
	slot0._animEvent:RemoveEventListener(uv0)

	if slot0._fTimer then
		slot0._fTimer:Stop()

		slot0._fTimer = nil
	end

	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	slot0:_setActiveBlock(false)
end

function slot0.onDestroyView(slot0)
	Activity101SignViewBase._internal_onDestroy(slot0)
	slot0._simageTitle:UnLoadImage()
	slot0._simagePanelBG:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0._setPinStartIndex(slot0, slot1)
	slot2, slot3 = slot0:getRewardCouldGetIndex()

	slot0.viewContainer:getScrollModel():setStartPinIndex(slot3 <= 4 and 1 or 3)
end

function slot0._resetByDay(slot0, slot1)
	GameUtil.setActive01(slot0._imageSignNowTran, ActivityType101Config.instance:getDoubleFestivalCOByDay(uv0, slot1) ~= nil)
	GameUtil.setActive01(slot0._imageSignNextTran, false)

	if slot2 then
		UISpriteSetMgr.instance:setV1a5DfSignSprite(slot0._imageSignNow, slot2.bgSpriteName)
	end

	slot0._lastDay = slot1

	slot0._animSelf:Play(UIAnimationName.Idle, 0, 1)

	slot0._txtDescr.text = slot2.blessContentType or ""
end

function slot0._setActiveBlock(slot0, slot1)
	gohelper.setActive(slot0._goBlock, slot1)
end

function slot0._tweenSprite(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:_setActiveBlock(true)

	slot0._curDay = slot1
	slot2 = ActivityType101Config.instance:getDoubleFestivalCOByDay(uv0, slot0._lastDay)

	GameUtil.setActive01(slot0._imageSignNextTran, ActivityType101Config.instance:getDoubleFestivalCOByDay(uv0, slot1) ~= nil)

	if slot3 then
		slot4 = slot3.bgSpriteName

		if slot2 and slot2.bgSpriteName == slot4 then
			slot0:_onSwitchEnd()

			return
		end

		UISpriteSetMgr.instance:setV1a5DfSignSprite(slot0._imageSignNext, slot4)
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
	slot0._animSelf:Play(UIAnimationName.Switch, 0, 0)
end

function slot0._onSwitchEnd(slot0)
	slot0:_showWish(slot0._curDay)
	slot0:_setActiveBlock(false)
end

function slot0._showWish(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._fTimer then
		slot0._fTimer = FrameTimer.New(nil, 0, 0)
	end

	slot2 = true

	slot0._fTimer:Reset(function ()
		if uv0 then
			uv0 = false

			ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
				day = uv1
			})
		else
			uv2:_resetByDay(uv1)
		end
	end, 1, 2)
	slot0._fTimer:Start()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.CommonPropView then
		return
	end

	if not ActivityType101Model.instance:getCurIndex() then
		return
	end

	if slot0._lastDay == slot2 then
		return
	end

	slot0:_tweenSprite(slot2)
end

return slot0
