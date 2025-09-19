module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndCollectionPageView", package.seeall)

local var_0_0 = class("Activity2ndCollectionPageView", BaseView)

var_0_0.InAnim = "swith_in"
var_0_0.OutAnim = "switch_out"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMiddle = gohelper.findChildSingleImage(arg_1_0.viewGO, "TypeMechine/#simage_Middle")
	arg_1_0._btntypemechine = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "TypeMechine/#btn_typemechine")
	arg_1_0._simageMiddleDec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "TypeMechine/#simage_MiddleDec1")
	arg_1_0._goPage1 = gohelper.findChild(arg_1_0.viewGO, "Page1")
	arg_1_0._goPage2 = gohelper.findChild(arg_1_0.viewGO, "Page2")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Page1/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Page1/#txt_LimitTime")
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Page2/#btn_Back")
	arg_1_0._btnOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Page2/#btn_OK")
	arg_1_0._inputname = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "Page2/InputField")
	arg_1_0._txtInput = gohelper.findChildText(arg_1_0.viewGO, "Page2/inputField/#txt_input")
	arg_1_0._goInputTip = gohelper.findChild(arg_1_0.viewGO, "Page2/Tips")
	arg_1_0._txtInputTip = gohelper.findChildText(arg_1_0.viewGO, "Page2/Tips/txt_Tips")
	arg_1_0._goMail = gohelper.findChild(arg_1_0.viewGO, "Page1/Entrance0")
	arg_1_0._goMailRedPoint = gohelper.findChild(arg_1_0.viewGO, "Page1/Entrance0/#go_RedPoint")
	arg_1_0._btnMail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Page1/Entrance0/#btn_Entrance")
	arg_1_0._btnpage2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Page2/#btn_page2")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txt = ""
	arg_1_0._showTips = false
	arg_1_0._isswitching = false
	arg_1_0._showTipTime = 5
	arg_1_0._isFirstEnter = false
	arg_1_0._lastStrLen = 0
	arg_1_0._onceGetReward = false
	arg_1_0.longPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._btnBack.gameObject)

	arg_1_0.longPress:SetLongPressTime({
		0.5,
		99999
	})

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBack:AddClickListener(arg_2_0._btnBackOnClick, arg_2_0)
	arg_2_0.longPress:AddLongPressListener(arg_2_0._onBtnBackLongPress, arg_2_0)
	arg_2_0._btnOK:AddClickListener(arg_2_0._btnOKOnClick, arg_2_0)
	arg_2_0._btntypemechine:AddClickListener(arg_2_0._btnTypeMechineOnClick, arg_2_0)
	arg_2_0._btnMail:AddClickListener(arg_2_0.onClickMailBtn, arg_2_0)
	arg_2_0._btnpage2:AddClickListener(arg_2_0._btnTypeMechineOnClick, arg_2_0)
	arg_2_0._inputname:AddOnValueChanged(arg_2_0._inputValueChanged, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.checkNeedRefreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.checkNeedRefreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity2ndController.instance, Activity2ndEvent.InputErrorOrHasReward, arg_2_0.refreshShowTips, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.onReceivePVBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0.longPress:RemoveLongPressListener()
	arg_3_0._btnOK:RemoveClickListener()
	arg_3_0._btntypemechine:RemoveClickListener()
	arg_3_0._btnMail:RemoveClickListener()
	arg_3_0._btnpage2:RemoveClickListener()
	arg_3_0._inputname:RemoveOnValueChanged()
	arg_3_0._btnpvrewarditem:RemoveClickListener()
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.checkNeedRefreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0.checkNeedRefreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity2ndController.instance, Activity2ndEvent.InputErrorOrHasReward, arg_3_0.refreshShowTips, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.onReceivePVBtn, arg_3_0)
end

function var_0_0._btnPVRewardOnClick(arg_4_0)
	local var_4_0 = Activity2ndEnum.ActivityId.V2a8_PVPopupReward

	if arg_4_0:checkCanGet(var_4_0) then
		Activity101Rpc.instance:sendGet101BonusRequest(var_4_0, 1)
	end
end

function var_0_0._onBtnBackLongPress(arg_5_0)
	arg_5_0._txt = ""

	arg_5_0._inputname:SetText(arg_5_0._txt)

	arg_5_0._lastStrLen = string.len(arg_5_0._txt)
end

function var_0_0._btnBackOnClick(arg_6_0)
	arg_6_0._txt = string.sub(arg_6_0._txt, 1, -2)

	arg_6_0._inputname:SetText(arg_6_0._txt)

	arg_6_0._lastStrLen = string.len(arg_6_0._txt)
end

function var_0_0._btnOKOnClick(arg_7_0)
	Activity2ndController.instance:trySendText(arg_7_0._txt)
end

function var_0_0._btnTypewriter(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.str
	local var_8_1 = arg_8_1.anim

	if string.len(arg_8_0._txt) < 20 then
		arg_8_0._txt = arg_8_0._txt .. var_8_0
	else
		local var_8_2 = luaLang("Activity2ndCollectionPageView_EnterMaxStr")

		arg_8_0:refreshShowTips(var_8_2)

		return
	end

	arg_8_0._inputname:SetText(arg_8_0._txt)
	var_8_1:Update(0)
	var_8_1:Play("click", 0, 0)

	arg_8_0._lastStrLen = string.len(arg_8_0._txt)

	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
end

function var_0_0._btnTypeMechineOnClick(arg_9_0)
	if arg_9_0._isswitching then
		return
	end

	Activity2ndModel.instance:changeShowTypeMechine()
	arg_9_0:switchTyepMechine()
end

function var_0_0.switchTyepMechine(arg_10_0)
	arg_10_0._showTypeMechine = Activity2ndModel.instance:getShowTypeMechine()

	local var_10_0 = arg_10_0._showTypeMechine and var_0_0.InAnim or var_0_0.OutAnim

	arg_10_0._animator:Play(var_10_0, 0, 0)

	arg_10_0._isswitching = true

	local var_10_1 = ActivityHelper.getActivityStatus(Activity2ndEnum.ActivityId.V2a8_PVPopupReward) == ActivityEnum.ActivityStatus.Normal
	local var_10_2 = arg_10_0:checkReceied(Activity2ndEnum.ActivityId.V2a8_PVPopupReward)

	gohelper.setActive(arg_10_0._gopvreward, not arg_10_0._showTypeMechine and var_10_1 and not var_10_2)
	gohelper.setActive(arg_10_0._goPage1, not arg_10_0._showTypeMechine)
	gohelper.setActive(arg_10_0._goPage2, arg_10_0._showTypeMechine)

	if arg_10_0._showTypeMechine then
		AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_start)
		AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)
	end

	arg_10_0:_initShowTips()

	arg_10_0._txt = ""

	arg_10_0._inputname:SetText(arg_10_0._txt)

	arg_10_0._lastStrLen = string.len(arg_10_0._txt)

	TaskDispatcher.runDelay(arg_10_0._afteranim, arg_10_0, 0.5)
end

function var_0_0._afteranim(arg_11_0)
	arg_11_0._isswitching = false

	TaskDispatcher.cancelTask(arg_11_0._afteranim, arg_11_0)
	arg_11_0:_checkFirstEnter()
end

function var_0_0._inputValueChanged(arg_12_0)
	local var_12_0 = arg_12_0._inputname:GetText()

	if arg_12_0._lastStrLen == 0 then
		local var_12_1 = string.sub(var_12_0, -1)
		local var_12_2 = arg_12_0._btnDict[string.upper(var_12_1)]

		if var_12_2 and var_12_2.anim then
			var_12_2.anim:Update(0)
			var_12_2.anim:Play("click", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
		end
	elseif string.len(var_12_0) > arg_12_0._lastStrLen then
		local var_12_3 = string.sub(var_12_0, -1)
		local var_12_4 = arg_12_0._btnDict[string.upper(var_12_3)]

		if var_12_4 and var_12_4.anim then
			var_12_4.anim:Update(0)
			var_12_4.anim:Play("click", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_click)
		end
	end

	arg_12_0._txt = string.upper(var_12_0)

	arg_12_0._inputname:SetText(arg_12_0._txt)

	arg_12_0._lastStrLen = string.len(var_12_0)
end

function var_0_0._initShowTips(arg_13_0)
	arg_13_0._showTips = false

	TaskDispatcher.cancelTask(arg_13_0._endShowTip, arg_13_0)
	gohelper.setActive(arg_13_0._goInputTip, false)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._activityItemList = {}

	gohelper.setActive(arg_14_0._goPage1, not arg_14_0._showTypeMechine)
	gohelper.setActive(arg_14_0._goPage2, arg_14_0._showTypeMechine)
	arg_14_0:_initTypewriter()
	arg_14_0:_initActivityBtn()
	arg_14_0:_initPVBtn()
end

function var_0_0._initPVBtn(arg_15_0)
	arg_15_0._gopvreward = gohelper.findChild(arg_15_0.viewGO, "#go_topright")
	arg_15_0._gopvrewardreddot = gohelper.findChild(arg_15_0.viewGO, "#go_topright/#go_RedPoint")
	arg_15_0._txtpvreward = gohelper.findChildText(arg_15_0.viewGO, "#go_topright/#txt_task")
	arg_15_0._gopvrewarditem = gohelper.findChild(arg_15_0.viewGO, "#go_topright/#go_rewarditem/go_icon")
	arg_15_0._gopvrewardcanget = gohelper.findChild(arg_15_0.viewGO, "#go_topright/#go_rewarditem/go_canget")
	arg_15_0._gopvrewardreceive = gohelper.findChild(arg_15_0.viewGO, "#go_topright/#go_rewarditem/go_receive")
	arg_15_0._btnpvrewarditem = gohelper.findChildButtonWithAudio(arg_15_0.viewGO, "#go_topright/#go_rewarditem/#btn_click")
	arg_15_0._pvconfig = ActivityConfig.instance:getActivityCo(Activity2ndEnum.ActivityId.V2a8_PVPopupReward)
	arg_15_0._pvrewardconfig = ActivityConfig.instance:getNorSignActivityCo(Activity2ndEnum.ActivityId.V2a8_PVPopupReward, 1)
	arg_15_0._txtpvreward.text = arg_15_0._pvconfig.actDesc .. " (0/1)"
	arg_15_0.goitemcomp = IconMgr.instance:getCommonPropItemIcon(arg_15_0._gopvrewarditem)

	local var_15_0 = string.split(arg_15_0._pvrewardconfig.bonus, "#")

	if var_15_0 and #var_15_0 > 0 then
		arg_15_0.goitemcomp:setMOValue(var_15_0[1], var_15_0[2], var_15_0[3], nil, true)
		arg_15_0.goitemcomp:isShowQuality(false)
		arg_15_0.goitemcomp:isShowCount(false)
	end

	arg_15_0._btnpvrewarditem:AddClickListener(arg_15_0._btnPVRewardOnClick, arg_15_0)
	gohelper.setActive(arg_15_0._btnpvrewarditem.gameObject, false)
	gohelper.setActive(arg_15_0._gopvreward, false)
end

function var_0_0._initTypewriter(arg_16_0)
	arg_16_0._btnList = {}
	arg_16_0._btnDict = {}

	for iter_16_0 = 1, 3 do
		local var_16_0 = gohelper.findChild(arg_16_0.viewGO, "Page2/Keyboard/Row" .. iter_16_0).transform
		local var_16_1 = var_16_0.childCount
		local var_16_2 = Activity196Enum.Typewriter[iter_16_0]

		for iter_16_1 = 1, var_16_1 do
			local var_16_3 = arg_16_0:getUserDataTb_()
			local var_16_4 = var_16_0:GetChild(iter_16_1 - 1)
			local var_16_5 = SLFramework.UGUI.ButtonWrap.Get(var_16_4.gameObject)
			local var_16_6 = string.sub(var_16_2, iter_16_1, iter_16_1)
			local var_16_7 = var_16_4.gameObject:GetComponent(typeof(UnityEngine.Animator))

			var_16_5:AddClickListener(arg_16_0._btnTypewriter, arg_16_0, {
				str = var_16_6,
				anim = var_16_7
			})

			var_16_3.btn = var_16_5
			var_16_3.name = "Btn" .. var_16_6
			var_16_3.anim = var_16_7
			var_16_7.enabled = true

			table.insert(arg_16_0._btnList, var_16_3)

			arg_16_0._btnDict[string.upper(var_16_6)] = var_16_3
		end
	end

	gohelper.setActive(arg_16_0._goInputTip, false)
end

function var_0_0._checkFirstEnter(arg_17_0)
	if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.FirstEnterTypewriter, 0) == 1 then
		local var_17_0 = math.random(1, 4)
		local var_17_1 = luaLang(Activity2ndEnum.RandomType[var_17_0])

		arg_17_0:refreshShowTips(var_17_1)
	else
		arg_17_0:refreshShowTips(luaLang(Activity2ndEnum.ShowTipsType.FirstEnter))
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.FirstEnterTypewriter, 1)
	end
end

function var_0_0._initActivityBtn(arg_18_0)
	for iter_18_0 = 1, #Activity2ndEnum.ActivityOrder do
		local var_18_0 = arg_18_0._activityItemList[iter_18_0]
		local var_18_1 = Activity2ndEnum.ActivityOrder[iter_18_0]
		local var_18_2 = ActivityConfig.instance:getActivityCo(var_18_1)

		if not var_18_0 then
			local var_18_3 = arg_18_0:getUserDataTb_()

			var_18_3.actId = var_18_1
			var_18_3.index = iter_18_0
			var_18_3.redDotId = var_18_2 and var_18_2.redDotId

			local var_18_4 = gohelper.findChild(arg_18_0.viewGO, "Page1/Entrance" .. iter_18_0 .. "/root")

			var_18_3.go = var_18_4
			var_18_3.btn = gohelper.findChildButtonWithAudio(var_18_4, "#btn_Entrance")
			var_18_3.txtname = gohelper.findChildText(var_18_4, "#btn_Entrance/txt_Entrance")

			var_18_3.btn:AddClickListener(arg_18_0._activityBtnOnClick, arg_18_0, var_18_3)

			var_18_3.gotip = gohelper.findChild(var_18_4, "Tips")
			var_18_3.txttip = gohelper.findChildText(var_18_4, "Tips/#txt_Tips")
			var_18_3.golimittime = gohelper.findChild(var_18_4, "LimitTime")
			var_18_3.txtlimittime = gohelper.findChildText(var_18_4, "LimitTime/#txt_Time")
			var_18_3.canvasGroup = gohelper.onceAddComponent(var_18_3.btn.gameObject, gohelper.Type_CanvasGroup)
			var_18_3.goRedPoint = gohelper.findChild(var_18_4, "#go_RedPoint")

			table.insert(arg_18_0._activityItemList, var_18_3)
		end
	end
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0._centerActId = arg_20_0.viewParam.actId
	arg_20_0._showTypeMechine = Activity2ndModel.instance:getShowTypeMechine()

	arg_20_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_unfold)
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)
end

function var_0_0.checkNeedRefreshUI(arg_21_0, arg_21_1)
	arg_21_0:refreshUI()
	arg_21_0:checkCloseActivityView()
	arg_21_0:checkNeedPlayAudio(arg_21_1)
end

function var_0_0.checkNeedPlayAudio(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(Activity2ndEnum.ActivityViewName) do
		if arg_22_1 == iter_22_1 then
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.play_ui_fuleyuan_typewriter_loop)

			break
		end
	end
end

function var_0_0.checkCloseActivityView(arg_23_0)
	local var_23_0 = true

	for iter_23_0, iter_23_1 in pairs(Activity2ndEnum.ActivityId) do
		local var_23_1 = ActivityHelper.getActivityStatus(iter_23_1)

		if var_23_1 ~= ActivityEnum.ActivityStatus.NotOnLine and var_23_1 ~= ActivityEnum.ActivityStatus.Expired then
			var_23_0 = false

			break
		end
	end

	if var_23_0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function var_0_0.refreshUI(arg_24_0)
	arg_24_0:refreshCenterActUI()
	arg_24_0:refreshActivityUI()

	if not arg_24_0._onceGetReward then
		arg_24_0:refreshPVBtn()
	end
end

function var_0_0.refreshPVBtn(arg_25_0)
	local var_25_0 = Activity2ndEnum.ActivityId.V2a8_PVPopupReward
	local var_25_1 = ActivityHelper.getActivityStatus(var_25_0) == ActivityEnum.ActivityStatus.Normal

	if not var_25_1 then
		return
	end

	arg_25_0:_cangetPVReward()

	local var_25_2 = arg_25_0:checkReceied(var_25_0)

	gohelper.setActive(arg_25_0._gopvreward, not var_25_1 or not var_25_2)

	local var_25_3 = ActivityConfig.instance:getActivityCo(var_25_0)
	local var_25_4 = var_25_3 and var_25_3.redDotId

	if var_25_1 and var_25_4 then
		RedDotController.instance:addRedDot(arg_25_0._gopvrewardreddot, var_25_4, var_25_0)
	end
end

function var_0_0._cangetPVReward(arg_26_0)
	gohelper.setActive(arg_26_0._gopvrewardcanget, true)
	gohelper.setActive(arg_26_0._gopvrewardreceive, false)
	gohelper.setActive(arg_26_0._btnpvrewarditem.gameObject, true)

	arg_26_0._txtpvreward.text = arg_26_0._pvconfig.actDesc .. " (1/1)"
end

function var_0_0.refreshCenterActUI(arg_27_0)
	arg_27_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(Activity196Enum.ActId)
end

function var_0_0.refreshActivityUI(arg_28_0)
	arg_28_0.playedActTagAudio = false
	arg_28_0.playedActUnlockAudio = false

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._activityItemList) do
		arg_28_0:refreshActivityItem(iter_28_1)
	end

	arg_28_0:setActiveMailItem()
end

function var_0_0.setActiveMailItem(arg_29_0)
	local var_29_0 = ActivityHelper.getActivityStatus(Activity2ndEnum.ActivityId.MailActivty) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_29_0._goMail, var_29_0)

	local var_29_1 = ActivityConfig.instance:getActivityCo(Activity2ndEnum.ActivityId.MailActivty)
	local var_29_2 = var_29_1 and var_29_1.redDotId

	if var_29_0 and var_29_2 then
		RedDotController.instance:addRedDot(arg_29_0._goMailRedPoint, var_29_2, Activity2ndEnum.ActivityId.MailActivty)
	end
end

function var_0_0.refreshActivityItem(arg_30_0, arg_30_1)
	local var_30_0 = ActivityHelper.getActivityStatus(arg_30_1.actId)
	local var_30_1 = var_30_0 == ActivityEnum.ActivityStatus.Normal

	if arg_30_1.golimittime then
		gohelper.setActive(arg_30_1.golimittime, var_30_1)
	end

	arg_30_1.canvasGroup.alpha = var_30_1 and 1 or 0.5

	local var_30_2 = ActivityModel.instance:getActivityInfo()[arg_30_1.actId]

	if not var_30_2 then
		return
	end

	if var_30_0 == ActivityEnum.ActivityStatus.NotOpen then
		gohelper.setActive(arg_30_1.gotip, true)

		if arg_30_1.txttip then
			arg_30_1.txttip.text = string.format(luaLang("ShortenAct_TaskItem_remain_open"), var_30_2:getRemainTimeStr2ByOpenTime())
		end
	elseif var_30_0 == ActivityEnum.ActivityStatus.Expired or var_30_0 == ActivityEnum.ActivityStatus.NotOnLine then
		gohelper.setActive(arg_30_1.gotip, true)

		if arg_30_1.txttip then
			arg_30_1.txttip.text = luaLang("ended")
		end
	elseif var_30_0 == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(arg_30_1.gotip, false)

		if arg_30_1.txtlimittime then
			if var_30_0 == ActivityEnum.ActivityStatus.Normal then
				arg_30_1.txtlimittime.text = var_30_2:getRemainTimeStr2ByEndTime()
			else
				arg_30_1.txtlimittime.text = ""
			end
		end

		if arg_30_1.txtname then
			arg_30_1.txtname.text = var_30_2.config.name
		end
	end

	if var_30_1 and arg_30_1.redDotId and arg_30_1.redDotId ~= 0 then
		if arg_30_1.actId == Activity2ndEnum.ActivityId.AnnualReview then
			arg_30_0._annualRed = RedDotController.instance:addRedDot(arg_30_1.goRedPoint, arg_30_1.redDotId, nil, arg_30_0._checkFirstClickRed, arg_30_0)
		elseif arg_30_1.actId == Activity2ndEnum.ActivityId.ActiveActivity then
			RedDotController.instance:addRedDot(arg_30_1.goRedPoint, arg_30_1.redDotId, nil, nil, nil)
		else
			RedDotController.instance:addRedDot(arg_30_1.goRedPoint, arg_30_1.redDotId, arg_30_1.actId, nil, nil)
		end
	end
end

function var_0_0._activityBtnOnClick(arg_31_0, arg_31_1)
	if not (arg_31_0["checkActivityCanClickFunc" .. arg_31_1.index] or arg_31_0.defaultCheckActivityCanClick)(arg_31_0, arg_31_1) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local var_31_0 = arg_31_0["onClickActivity" .. arg_31_1.index]

	if var_31_0 then
		var_31_0(arg_31_0, arg_31_1.actId)

		if arg_31_1.actId ~= Activity2ndEnum.ActivityId.AnnualReview then
			AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
		end
	end

	ActivityEnterMgr.instance:enterActivity(arg_31_1.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_31_1.actId
	})
end

function var_0_0.defaultCheckActivityCanClick(arg_32_0, arg_32_1)
	local var_32_0, var_32_1, var_32_2 = ActivityHelper.getActivityStatusAndToast(arg_32_1.actId)

	if var_32_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_32_1 then
			GameFacade.showToastWithTableParam(var_32_1, var_32_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function var_0_0.refreshShowTips(arg_33_0, arg_33_1)
	if arg_33_0._showTips then
		return
	end

	arg_33_0._showTips = true
	arg_33_0._txtInputTip.text = arg_33_1

	gohelper.setActive(arg_33_0._goInputTip, true)
	TaskDispatcher.runDelay(arg_33_0._endShowTip, arg_33_0, arg_33_0._showTipTime)
end

function var_0_0._endShowTip(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._endShowTip, arg_34_0)

	arg_34_0._showTips = false

	gohelper.setActive(arg_34_0._goInputTip, false)
end

function var_0_0.onClickMailBtn(arg_35_0)
	local var_35_0 = {
		actId = Activity2ndEnum.ActivityId.MailActivty
	}

	Activity2ndController.instance:statButtonClick(Activity2ndEnum.ActivityId.MailActivty)
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
	ViewMgr.instance:openView(ViewName.Activity2ndMailView, var_35_0)
end

function var_0_0.onClickActivity1(arg_36_0, arg_36_1)
	Activity2ndController.instance:statButtonClick(arg_36_1)
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()

	local var_36_0 = Activity125Config.instance:getH5BaseUrl(arg_36_1)

	WebViewController.instance:simpleOpenWebBrowser(var_36_0)

	if GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Activity2ndAnnualReview, 1)
		arg_36_0:_checkFirstClickRed(arg_36_0._annualRed)
	end
end

function var_0_0.onClickActivity2(arg_37_0, arg_37_1)
	local function var_37_0()
		local var_38_0 = {
			actId = arg_37_1
		}

		ViewMgr.instance:openView(ViewName.Activity2ndShowSkinView, var_38_0)
	end

	Activity101Rpc.instance:sendGet101InfosRequest(arg_37_1, var_37_0, arg_37_0)
	Activity2ndController.instance:statButtonClick(arg_37_1)
end

function var_0_0.onClickActivity3(arg_39_0, arg_39_1)
	local function var_39_0()
		local var_40_0 = {
			actId = arg_39_1
		}

		ViewMgr.instance:openView(ViewName.Activity2ndTakePhotosView, var_40_0)
	end

	Activity2ndController.instance:statButtonClick(arg_39_1)
	Activity125Rpc.instance:sendGetAct125InfosRequest(arg_39_1, var_39_0, arg_39_0)
end

function var_0_0.onClickActivity4(arg_41_0, arg_41_1)
	local var_41_0 = {
		actId = arg_41_1
	}

	Activity2ndController.instance:statButtonClick(arg_41_1)
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectCharacterView, var_41_0)
end

function var_0_0.onClickActivity5(arg_42_0, arg_42_1)
	local function var_42_0()
		local var_43_0 = {
			actId = arg_42_1
		}

		ViewMgr.instance:openView(ViewName.Activity197View, var_43_0)
	end

	Activity2ndController.instance:statButtonClick(arg_42_1)
	Activity197Rpc.instance:sendGet197InfoRequest(arg_42_1, var_42_0, arg_42_0)
end

function var_0_0.checkReceied(arg_44_0, arg_44_1)
	return (ActivityType101Model.instance:isType101RewardGet(arg_44_1, 1))
end

function var_0_0.checkCanGet(arg_45_0, arg_45_1)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_45_1, 1))
end

function var_0_0.onReceivePVBtn(arg_46_0)
	local var_46_0 = Activity2ndEnum.ActivityId.V2a8_PVPopupReward

	if arg_46_0:checkReceied(var_46_0) then
		gohelper.setActive(arg_46_0._gopvrewardcanget, false)
		gohelper.setActive(arg_46_0._gopvrewardreceive, true)
		gohelper.setActive(arg_46_0._btnpvrewarditem.gameObject, false)

		arg_46_0._onceGetReward = true
	end
end

function var_0_0._checkFirstClickRed(arg_47_0, arg_47_1)
	arg_47_1:defaultRefreshDot()

	if not arg_47_1.show then
		arg_47_1.show = Activity2ndModel.instance:checkAnnualReviewShowRed()

		arg_47_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.onDestroyView(arg_48_0)
	return
end

function var_0_0.onClose(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._endShowTip, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._afteranim, arg_49_0)

	if arg_49_0._btnList and #arg_49_0._btnList > 0 then
		for iter_49_0, iter_49_1 in ipairs(arg_49_0._btnList) do
			iter_49_1.btn:RemoveClickListener()
		end
	end

	if arg_49_0._activityItemList and #arg_49_0._activityItemList > 0 then
		for iter_49_2, iter_49_3 in ipairs(arg_49_0._activityItemList) do
			iter_49_3.btn:RemoveClickListener()
		end
	end

	Activity2ndModel.instance:cleanShowTypeMechine()
	AudioMgr.instance:trigger(AudioEnum2_8.ui_activity_2_8_fuleyuan.stop_ui_fuleyuan_typewriter_loop)
end

return var_0_0
