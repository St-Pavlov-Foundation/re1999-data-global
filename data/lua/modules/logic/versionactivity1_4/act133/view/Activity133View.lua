module("modules.logic.versionactivity1_4.act133.view.Activity133View", package.seeall)

local var_0_0 = class("Activity133View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/Content/#go_item")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_obtain/#go_reddot")
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gocheckingmask = gohelper.findChild(arg_1_0.viewGO, "checkingmask")
	arg_1_0._simagecheckingmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "checkingmask/mask/#simage_checkingmask")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "checkingmask/detailbg/#txt_title")
	arg_1_0._txtdetail = gohelper.findChildText(arg_1_0.viewGO, "checkingmask/detailbg/scroll_view/Viewport/Content/#txt_detail")
	arg_1_0._simagecompleted = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_completed")
	arg_1_0._com_animator = arg_1_0._simagecompleted.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._imagetitle = gohelper.findChildImage(arg_1_0.viewGO, "#image_title")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#image_title/remaintime/bg/#txt_remaintime")
	arg_1_0._txtschedule = gohelper.findChildText(arg_1_0.viewGO, "schedule/bg/txt_scheduletitle/#txt_schedule")
	arg_1_0._imagefill = gohelper.findChildImage(arg_1_0.viewGO, "schedule/fill/#go_fill")
	arg_1_0._btnobtain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_obtain")
	arg_1_0._unlockAniTime = 0.6
	arg_1_0.tweenDuration = 0.6
	arg_1_0._completedAnitime = 1
	arg_1_0._itemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnobtain:AddClickListener(arg_2_0._btnobtainOnClick, arg_2_0)

	arg_2_0.maskClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0._simagecheckingmask.gameObject)

	arg_2_0.maskClick:AddClickListener(arg_2_0._onClickMask, arg_2_0)
	arg_2_0:addEventCb(Activity133Controller.instance, Activity133Event.OnSelectCheckNote, arg_2_0._checkNote, arg_2_0)
	arg_2_0:addEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, arg_2_0.onUpdateParam, arg_2_0)
	arg_2_0:addEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, arg_2_0._onGetBouns, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnobtain:RemoveClickListener()
	arg_3_0.maskClick:RemoveClickListener()
	arg_3_0:removeEventCb(Activity133Controller.instance, Activity133Event.OnSelectCheckNote, arg_3_0._checkNote, arg_3_0)
	arg_3_0:removeEventCb(Activity133Controller.instance, Activity133Event.OnUpdateInfo, arg_3_0.onUpdateParam, arg_3_0)
	arg_3_0:removeEventCb(Activity133Controller.instance, Activity133Event.OnGetBonus, arg_3_0._onGetBouns, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._btnobtainOnClick(arg_4_0)
	Activity133Controller.instance:openActivity133TaskView({
		arg_4_0.actId
	})
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagefullbg:LoadImage(ResUrl.getActivity133Icon("v1a4_shiprepair_fullbg_0"))
	arg_5_0._simagecheckingmask:LoadImage(ResUrl.getActivity133Icon("v1a4_shiprepair_fullbg_mask"))

	arg_5_0._focusmaskopen = false
	arg_5_0._csView = arg_5_0.viewContainer._scrollview
	arg_5_0._fixitemList = {}
	arg_5_0.needfixnum = Activity133Config.instance:getNeedFixNum()

	for iter_5_0 = 1, arg_5_0.needfixnum do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0.viewGO, "#simage_fullbg/" .. iter_5_0)

		gohelper.setActive(var_5_0.go, false)

		var_5_0.hadfix = false
		var_5_0.id = iter_5_0

		if var_5_0.go then
			table.insert(arg_5_0._fixitemList, var_5_0)
		end
	end

	local var_5_1 = Activity133Config.instance:getFinalBonus()

	arg_5_0.finalBonus = GameUtil.splitString2(var_5_1, true)

	for iter_5_1, iter_5_2 in ipairs(arg_5_0.finalBonus) do
		local var_5_2 = arg_5_0._itemList[iter_5_1]

		if not var_5_2 then
			var_5_2 = arg_5_0:getUserDataTb_()
			var_5_2.go = gohelper.cloneInPlace(arg_5_0._goitem)

			gohelper.setActive(var_5_2.go, true)

			var_5_2.icon = IconMgr.instance:getCommonPropItemIcon(var_5_2.go)
			var_5_2.goget = gohelper.findChild(var_5_2.go, "get")

			gohelper.setAsLastSibling(var_5_2.goget)
			gohelper.setActive(var_5_2.goget, false)
			table.insert(arg_5_0._itemList, var_5_2)
		end

		var_5_2.icon:setMOValue(iter_5_2[1], iter_5_2[2], iter_5_2[3], nil, true)
		var_5_2.icon:SetCountLocalY(45)
		var_5_2.icon:SetCountBgHeight(30)
		var_5_2.icon:setCountFontSize(36)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	Activity133ListModel.instance:init(arg_6_0._scrollview.gameObject)
	arg_6_0:_refreshView()
end

function var_0_0._fixShip(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = Activity133ListModel.instance:getList()
		local var_7_1

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1.id == arg_7_1 then
				var_7_1 = iter_7_1.icon
			end
		end

		local var_7_2 = arg_7_0._fixitemList[var_7_1]

		if var_7_2 then
			gohelper.setActive(var_7_2.go, true)

			local var_7_3 = var_7_2.go:GetComponent(typeof(UnityEngine.Animator))

			var_7_3.speed = 1

			var_7_3:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			var_7_3:Update(0)
		end
	end

	arg_7_0:_refreshFixList()
end

function var_0_0._refreshView(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0:_refreshFixList()
		arg_8_0:_checkFixNum()
	end

	arg_8_0:_refreshRemainTime()
	arg_8_0:_checkCompletedItem()
	arg_8_0:_refreshRedDot()
end

function var_0_0._refreshFixList(arg_9_0)
	local var_9_0 = Activity133ListModel.instance:getList()

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		local var_9_1 = iter_9_1.icon

		if iter_9_1:isReceived() then
			gohelper.setActive(arg_9_0._fixitemList[var_9_1].go, true)
		else
			gohelper.setActive(arg_9_0._fixitemList[var_9_1].go, false)
		end
	end
end

function var_0_0._onCloseViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.CommonPropView and arg_10_0.fixid then
		arg_10_0:_fixShip(arg_10_0.fixid)
	end
end

function var_0_0._refreshRedDot(arg_11_0)
	RedDotController.instance:addRedDot(arg_11_0._goreddot, RedDotEnum.DotNode.Activity1_4Act133Task)
end

function var_0_0._onGetBouns(arg_12_0, arg_12_1)
	arg_12_0.fixid = arg_12_1.id

	arg_12_0:_checkFixedCompleted()
end

function var_0_0._checkFixedCompleted(arg_13_0)
	local var_13_0 = Activity133Model.instance:getFixedNum()

	arg_13_0._txtschedule.text = var_13_0 .. "/" .. arg_13_0.needfixnum

	local var_13_1 = Mathf.Clamp01(var_13_0 / arg_13_0.needfixnum)

	arg_13_0._imagefill.fillAmount = var_13_1

	if var_13_1 == 1 then
		arg_13_0._iscomplete = true

		function arg_13_0.callback()
			TaskDispatcher.cancelTask(arg_13_0.callback, arg_13_0)
			gohelper.setActive(arg_13_0._simagecompleted.gameObject, true)

			arg_13_0._com_animator.speed = 1

			arg_13_0._com_animator:Play(UIAnimationName.Open, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_preference_open)
			arg_13_0._com_animator:Update(0)
			TaskDispatcher.runDelay(arg_13_0._onCompletedAniFinish, arg_13_0, arg_13_0._completedAnitime)
		end

		TaskDispatcher.runDelay(arg_13_0.callback, arg_13_0, 1.8)
	else
		gohelper.setActive(arg_13_0._simagecompleted.gameObject, false)
		arg_13_0:_checkFixNum()
	end
end

function var_0_0._onCompletedAniFinish(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._onCompletedAniFinish, arg_15_0)
	arg_15_0:_checkCompletedItem()

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.finalBonus) do
		local var_15_1 = MaterialDataMO.New()

		var_15_1:initValue(iter_15_1[1], iter_15_1[2], iter_15_1[3], nil, true)
		table.insert(var_15_0, var_15_1)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_15_0)
end

function var_0_0._checkCompletedItem(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._itemList) do
		gohelper.setActive(iter_16_1.goget, arg_16_0._iscomplete)

		if arg_16_0._iscomplete then
			iter_16_1.icon:setAlpha(0.45, 0.8)
		else
			iter_16_1.icon:setAlpha(1, 1)
		end
	end
end

function var_0_0._checkFixNum(arg_17_0)
	local var_17_0 = Activity133Model.instance:getFixedNum()

	arg_17_0._txtschedule.text = var_17_0 .. "/" .. arg_17_0.needfixnum

	local var_17_1 = Mathf.Clamp01(var_17_0 / arg_17_0.needfixnum)

	arg_17_0._imagefill.fillAmount = var_17_1

	if var_17_1 == 1 then
		arg_17_0._iscomplete = true

		gohelper.setActive(arg_17_0._simagecompleted.gameObject, true)
	else
		gohelper.setActive(arg_17_0._simagecompleted.gameObject, false)
	end
end

function var_0_0._refreshRemainTime(arg_18_0)
	local var_18_0 = ActivityModel.instance:getActivityInfo()[arg_18_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_18_1 = Mathf.Floor(var_18_0 / TimeUtil.OneDaySecond)
	local var_18_2 = var_18_0 % TimeUtil.OneDaySecond
	local var_18_3 = Mathf.Floor(var_18_2 / TimeUtil.OneHourSecond)
	local var_18_4 = var_18_1 .. luaLang("time_day")

	if LangSettings.instance:isEn() then
		var_18_4 = var_18_4 .. " "
	end

	local var_18_5 = var_18_4 .. var_18_3 .. luaLang("time_hour2")

	arg_18_0._txtremaintime.text = string.format(luaLang("remain"), var_18_5)
end

function var_0_0._checkNote(arg_19_0, arg_19_1)
	if arg_19_1 then
		local var_19_0 = arg_19_1.id
		local var_19_1, var_19_2 = arg_19_1:getPos()

		Activity133Model.instance:setSelectID(var_19_0)

		if not arg_19_0._focusmaskopen then
			arg_19_0._focusmaskopen = true

			gohelper.setActive(arg_19_0._gocheckingmask, true)
		end

		local var_19_3 = Activity133ListModel.instance:getById(var_19_0)

		UIBlockMgr.instance:startBlock("Activity133View")
		arg_19_0:_moveBg(var_19_1, var_19_2, 2.5, 1)

		arg_19_0._txttitle.text = var_19_3.title
		arg_19_0._txtdetail.text = var_19_3.desc

		gohelper.setActive(arg_19_0._simagecompleted.gameObject, not arg_19_0._focusmaskopen and arg_19_0._iscomplete)
	else
		if arg_19_0._focusmaskopen then
			arg_19_0._focusmaskopen = false

			gohelper.setActive(arg_19_0._gocheckingmask, false)
			UIBlockMgr.instance:startBlock("Activity133View")
			arg_19_0:_moveBg(nil, nil, 1, 0)

			local var_19_4 = Activity133Model.instance:getSelectID()

			arg_19_0._csView:selectCell(var_19_4, false)
		end

		gohelper.setActive(arg_19_0._simagecompleted.gameObject, not arg_19_0._focusmaskopen and arg_19_0._iscomplete)
	end
end

function var_0_0._moveBg(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	arg_20_0:playMoveTween(arg_20_1, arg_20_2)
	arg_20_0:playScaleTween(arg_20_3)
	arg_20_0:playDoFade(arg_20_4, 0.2)
end

function var_0_0.playDoFade(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._fadeTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._fadeTweenId)

		arg_21_0._fadeTweenId = nil
	end

	local var_21_0 = arg_21_0._gocheckingmask:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

	arg_21_0._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_21_0._gocheckingmask, var_21_0, arg_21_1, arg_21_2)
end

function var_0_0.playScaleTween(arg_22_0, arg_22_1)
	if arg_22_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._scaleTweenId)

		arg_22_0._scaleTweenId = nil
	end

	arg_22_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_22_0._simagefullbg.transform, arg_22_1, arg_22_1, arg_22_1, arg_22_0.tweenDuration, arg_22_0.onTweenFinish, arg_22_0)
end

function var_0_0.onTweenFinish(arg_23_0)
	UIBlockMgr.instance:endBlock("Activity133View")
end

function var_0_0.playMoveTween(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_24_0._moveTweenId)

		arg_24_0._moveTweenId = nil
	end

	if arg_24_1 and arg_24_2 then
		arg_24_0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_24_0._simagefullbg.transform, arg_24_1, arg_24_2, arg_24_0.tweenDuration)
	else
		arg_24_0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_24_0._simagefullbg.transform, 0, 0, arg_24_0.tweenDuration)
	end
end

function var_0_0._onClickMask(arg_25_0)
	if arg_25_0._focusmaskopen then
		arg_25_0._focusmaskopen = false

		gohelper.setActive(arg_25_0._gocheckingmask, false)

		local var_25_0 = Activity133Model.instance:getSelectID()

		arg_25_0:_moveBg(nil, nil, 1, 0)
		arg_25_0._csView:selectCell(var_25_0, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		gohelper.setActive(arg_25_0._simagecompleted.gameObject, not arg_25_0._focusmaskopen and arg_25_0._iscomplete)
	end
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0.actId = arg_26_0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(arg_26_0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_26_0.actId
	})
	Activity133ListModel.instance:init(arg_26_0._scrollview.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	arg_26_0:_refreshView(true)
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onCompletedAniFinish, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simagefullbg:UnLoadImage()
	arg_28_0._simagecheckingmask:UnLoadImage()
end

return var_0_0
