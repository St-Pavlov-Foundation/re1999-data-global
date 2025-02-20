module("modules.logic.versionactivity1_4.act133.view.Activity133View", package.seeall)

slot0 = class("Activity133View", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_obtain/#go_reddot")
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gocheckingmask = gohelper.findChild(slot0.viewGO, "checkingmask")
	slot0._simagecheckingmask = gohelper.findChildSingleImage(slot0.viewGO, "checkingmask/mask/#simage_checkingmask")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "checkingmask/detailbg/#txt_title")
	slot0._txtdetail = gohelper.findChildText(slot0.viewGO, "checkingmask/detailbg/scroll_view/Viewport/Content/#txt_detail")
	slot0._simagecompleted = gohelper.findChildSingleImage(slot0.viewGO, "#simage_completed")
	slot0._com_animator = slot0._simagecompleted.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._imagetitle = gohelper.findChildImage(slot0.viewGO, "#image_title")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "#image_title/remaintime/bg/#txt_remaintime")
	slot0._txtschedule = gohelper.findChildText(slot0.viewGO, "schedule/bg/txt_scheduletitle/#txt_schedule")
	slot0._imagefill = gohelper.findChildImage(slot0.viewGO, "schedule/fill/#go_fill")
	slot0._btnobtain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_obtain")
	slot0._unlockAniTime = 0.6
	slot0.tweenDuration = 0.6
	slot0._completedAnitime = 1
	slot0._itemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnobtain:AddClickListener(slot0._btnobtainOnClick, slot0)

	slot0.maskClick = SLFramework.UGUI.UIClickListener.Get(slot0._simagecheckingmask.gameObject)

	slot0.maskClick:AddClickListener(slot0._onClickMask, slot0)
	slot0:addEventCb(Activity133Controller.instance, Activity133Event.OnSelectCheckNote, slot0._checkNote, slot0)
	slot0:addEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, slot0.onUpdateParam, slot0)
	slot0:addEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, slot0._onGetBouns, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnobtain:RemoveClickListener()
	slot0.maskClick:RemoveClickListener()
	slot0:removeEventCb(Activity133Controller.instance, Activity133Event.OnSelectCheckNote, slot0._checkNote, slot0)
	slot0:removeEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, slot0.onUpdateParam, slot0)
	slot0:removeEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, slot0._onGetBouns, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0._btnobtainOnClick(slot0)
	Activity133Controller.instance:openActivity133TaskView({
		slot0.actId
	})
end

function slot0._editableInitView(slot0)
	slot0._simagefullbg:LoadImage(ResUrl.getActivity133Icon("v1a4_shiprepair_fullbg_0"))

	slot4 = ResUrl.getActivity133Icon

	slot0._simagecheckingmask:LoadImage(slot4("v1a4_shiprepair_fullbg_mask"))

	slot0._focusmaskopen = false
	slot0._csView = slot0.viewContainer._scrollview
	slot0._fixitemList = {}
	slot0.needfixnum = Activity133Config.instance:getNeedFixNum()

	for slot4 = 1, slot0.needfixnum do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "#simage_fullbg/" .. slot4)

		gohelper.setActive(slot5.go, false)

		slot5.hadfix = false
		slot5.id = slot4

		if slot5.go then
			table.insert(slot0._fixitemList, slot5)
		end
	end

	slot5 = true
	slot0.finalBonus = GameUtil.splitString2(Activity133Config.instance:getFinalBonus(), slot5)

	for slot5, slot6 in ipairs(slot0.finalBonus) do
		if not slot0._itemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goitem)

			gohelper.setActive(slot7.go, true)

			slot7.icon = IconMgr.instance:getCommonPropItemIcon(slot7.go)
			slot7.goget = gohelper.findChild(slot7.go, "get")

			gohelper.setAsLastSibling(slot7.goget)
			gohelper.setActive(slot7.goget, false)
			table.insert(slot0._itemList, slot7)
		end

		slot7.icon:setMOValue(slot6[1], slot6[2], slot6[3], nil, true)
		slot7.icon:SetCountLocalY(45)
		slot7.icon:SetCountBgHeight(30)
		slot7.icon:setCountFontSize(36)
	end
end

function slot0.onUpdateParam(slot0)
	Activity133ListModel.instance:init(slot0._scrollview.gameObject)
	slot0:_refreshView()
end

function slot0._fixShip(slot0, slot1)
	if slot1 then
		slot3 = nil

		for slot7, slot8 in pairs(Activity133ListModel.instance:getList()) do
			if slot8.id == slot1 then
				slot3 = slot8.icon
			end
		end

		if slot0._fixitemList[slot3] then
			gohelper.setActive(slot4.go, true)

			slot5 = slot4.go:GetComponent(typeof(UnityEngine.Animator))
			slot5.speed = 1

			slot5:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			slot5:Update(0)
		end
	end

	slot0:_refreshFixList()
end

function slot0._refreshView(slot0, slot1)
	if slot1 then
		slot0:_refreshFixList()
		slot0:_checkFixNum()
	end

	slot0:_refreshRemainTime()
	slot0:_checkCompletedItem()
	slot0:_refreshRedDot()
end

function slot0._refreshFixList(slot0)
	for slot5, slot6 in pairs(Activity133ListModel.instance:getList()) do
		if slot6:isReceived() then
			gohelper.setActive(slot0._fixitemList[slot6.icon].go, true)
		else
			gohelper.setActive(slot0._fixitemList[slot7].go, false)
		end
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView and slot0.fixid then
		slot0:_fixShip(slot0.fixid)
	end
end

function slot0._refreshRedDot(slot0)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.Activity1_4Act133Task)
end

function slot0._onGetBouns(slot0, slot1)
	slot0.fixid = slot1.id

	slot0:_checkFixedCompleted()
end

function slot0._checkFixedCompleted(slot0)
	slot1 = Activity133Model.instance:getFixedNum()
	slot0._txtschedule.text = slot1 .. "/" .. slot0.needfixnum
	slot2 = Mathf.Clamp01(slot1 / slot0.needfixnum)
	slot0._imagefill.fillAmount = slot2

	if slot2 == 1 then
		slot0._iscomplete = true

		function slot0.callback()
			TaskDispatcher.cancelTask(uv0.callback, uv0)
			gohelper.setActive(uv0._simagecompleted.gameObject, true)

			uv0._com_animator.speed = 1

			uv0._com_animator:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
			uv0._com_animator:Update(0)
			TaskDispatcher.runDelay(uv0._onCompletedAniFinish, uv0, uv0._completedAnitime)
		end

		TaskDispatcher.runDelay(slot0.callback, slot0, 1.8)
	else
		gohelper.setActive(slot0._simagecompleted.gameObject, false)
		slot0:_checkFixNum()
	end
end

function slot0._onCompletedAniFinish(slot0)
	TaskDispatcher.cancelTask(slot0._onCompletedAniFinish, slot0)
	slot0:_checkCompletedItem()

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.finalBonus) do
		slot7 = MaterialDataMO.New()

		slot7:initValue(slot6[1], slot6[2], slot6[3], nil, true)
		table.insert(slot1, slot7)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot1)
end

function slot0._checkCompletedItem(slot0)
	for slot4, slot5 in pairs(slot0._itemList) do
		gohelper.setActive(slot5.goget, slot0._iscomplete)

		if slot0._iscomplete then
			slot5.icon:setAlpha(0.45, 0.8)
		else
			slot5.icon:setAlpha(1, 1)
		end
	end
end

function slot0._checkFixNum(slot0)
	slot1 = Activity133Model.instance:getFixedNum()
	slot0._txtschedule.text = slot1 .. "/" .. slot0.needfixnum
	slot2 = Mathf.Clamp01(slot1 / slot0.needfixnum)
	slot0._imagefill.fillAmount = slot2

	if slot2 == 1 then
		slot0._iscomplete = true

		gohelper.setActive(slot0._simagecompleted.gameObject, true)
	else
		gohelper.setActive(slot0._simagecompleted.gameObject, false)
	end
end

function slot0._refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now()
	slot5 = Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)

	if LangSettings.instance:isEn() then
		slot6 = Mathf.Floor(slot2 / TimeUtil.OneDaySecond) .. luaLang("time_day") .. " "
	end

	slot0._txtremaintime.text = string.format(luaLang("remain"), slot6 .. slot5 .. luaLang("time_hour2"))
end

function slot0._checkNote(slot0, slot1)
	if slot1 then
		slot3, slot4 = slot1:getPos()

		Activity133Model.instance:setSelectID(slot1.id)

		if not slot0._focusmaskopen then
			slot0._focusmaskopen = true

			gohelper.setActive(slot0._gocheckingmask, true)
		end

		slot5 = Activity133ListModel.instance:getById(slot2)

		UIBlockMgr.instance:startBlock("Activity133View")
		slot0:_moveBg(slot3, slot4, 2.5, 1)

		slot0._txttitle.text = slot5.title
		slot0._txtdetail.text = slot5.desc

		gohelper.setActive(slot0._simagecompleted.gameObject, not slot0._focusmaskopen and slot0._iscomplete)
	else
		if slot0._focusmaskopen then
			slot0._focusmaskopen = false

			gohelper.setActive(slot0._gocheckingmask, false)
			UIBlockMgr.instance:startBlock("Activity133View")
			slot0:_moveBg(nil, , 1, 0)
			slot0._csView:selectCell(Activity133Model.instance:getSelectID(), false)
		end

		gohelper.setActive(slot0._simagecompleted.gameObject, not slot0._focusmaskopen and slot0._iscomplete)
	end
end

function slot0._moveBg(slot0, slot1, slot2, slot3, slot4)
	slot0:playMoveTween(slot1, slot2)
	slot0:playScaleTween(slot3)
	slot0:playDoFade(slot4, 0.2)
end

function slot0.playDoFade(slot0, slot1, slot2)
	if slot0._fadeTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId)

		slot0._fadeTweenId = nil
	end

	slot0._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._gocheckingmask, slot0._gocheckingmask:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha, slot1, slot2)
end

function slot0.playScaleTween(slot0, slot1)
	if slot0._scaleTweenId then
		ZProj.TweenHelper.KillById(slot0._scaleTweenId)

		slot0._scaleTweenId = nil
	end

	slot0._scaleTweenId = ZProj.TweenHelper.DOScale(slot0._simagefullbg.transform, slot1, slot1, slot1, slot0.tweenDuration, slot0.onTweenFinish, slot0)
end

function slot0.onTweenFinish(slot0)
	UIBlockMgr.instance:endBlock("Activity133View")
end

function slot0.playMoveTween(slot0, slot1, slot2)
	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	if slot1 and slot2 then
		slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0._simagefullbg.transform, slot1, slot2, slot0.tweenDuration)
	else
		slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0._simagefullbg.transform, 0, 0, slot0.tweenDuration)
	end
end

function slot0._onClickMask(slot0)
	if slot0._focusmaskopen then
		slot0._focusmaskopen = false

		gohelper.setActive(slot0._gocheckingmask, false)
		slot0:_moveBg(nil, , 1, 0)
		slot0._csView:selectCell(Activity133Model.instance:getSelectID(), false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		gohelper.setActive(slot0._simagecompleted.gameObject, not slot0._focusmaskopen and slot0._iscomplete)
	end
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(slot0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.actId
	})
	Activity133ListModel.instance:init(slot0._scrollview.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	slot0:_refreshView(true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onCompletedAniFinish, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagefullbg:UnLoadImage()
	slot0._simagecheckingmask:UnLoadImage()
end

return slot0
