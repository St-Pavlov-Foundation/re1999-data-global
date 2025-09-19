module("modules.logic.versionactivity2_8.act197.view.Activity197View", package.seeall)

local var_0_0 = class("Activity197View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagepage = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_page")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "Left")
	arg_1_0._gopointcontent = gohelper.findChild(arg_1_0.viewGO, "Left/Point")
	arg_1_0._gopointitem = gohelper.findChild(arg_1_0.viewGO, "Left/Point/#go_pointitem")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_reward")
	arg_1_0._gorewarditemcontent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_reward/Viewport/Content/")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_reward/Viewport/Content/#go_rewarditem")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "Left/indexBG/#txt_index")
	arg_1_0._btnKey = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Summon")
	arg_1_0._txtusekey = gohelper.findChildText(arg_1_0.viewGO, "Left/#btn_Summon/#txt_usepower")
	arg_1_0._btnswitchLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_switchLeft")
	arg_1_0._btnswitchRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_switchRight")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._scrollDesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Right/#scroll_Desc")
	arg_1_0._txtDec = gohelper.findChildText(arg_1_0.viewGO, "Right/#scroll_Desc/Viewport/#txt_Dec")
	arg_1_0._imageboxprogress = gohelper.findChildImage(arg_1_0.viewGO, "Right/Computer/go_Unknown_Progress/#image_progress")
	arg_1_0._goprogressunknown = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Unknown_Progress/image_dec2")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "Right/Progress/#image_progress")
	arg_1_0._btnSearch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Progress/#btn_Search")
	arg_1_0._txtusebubble = gohelper.findChildText(arg_1_0.viewGO, "Right/Progress/#btn_Search/#txt_usepower")
	arg_1_0._goExtraTips = gohelper.findChild(arg_1_0.viewGO, "#go_ExtraTips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_ExtraTips/#txt_Tips")
	arg_1_0._govxkey = gohelper.findChild(arg_1_0.viewGO, "vx_glow")
	arg_1_0._govxbubble = gohelper.findChild(arg_1_0.viewGO, "vx_light")
	arg_1_0._govxFresh = gohelper.findChild(arg_1_0.viewGO, "Left/vx_fresh")
	arg_1_0._leftAnimator = arg_1_0._goleft:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goCanGet = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Canget")
	arg_1_0._btnCanGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Computer/go_Canget/#btn_canget")
	arg_1_0._goHasGet = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Hasget")
	arg_1_0._goUnknown = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Unknown")
	arg_1_0._goUnknownProgress = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Unknown_Progress")
	arg_1_0._btntoptips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tips")
	arg_1_0._gotoptips = gohelper.findChild(arg_1_0.viewGO, "#btn_tips/go_tips")
	arg_1_0._btnclosetoptips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tips/go_tips/#btn_close")
	arg_1_0._btnbottomtips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Progress/#btn_tips")
	arg_1_0._gobottomtips = gohelper.findChild(arg_1_0.viewGO, "Right/Progress/#btn_tips/go_tips")
	arg_1_0._btnclosebottomtips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Progress/#btn_tips/go_tips/#btn_close")
	arg_1_0._goreddotKey = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_Summon/#go_reddot")
	arg_1_0._goreddotBubble = gohelper.findChild(arg_1_0.viewGO, "Right/Progress/#btn_Search/#go_reddot")
	arg_1_0._goreddotComputer = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/#go_reddot")
	arg_1_0._switchTime = 0.3
	arg_1_0._vxfreshTime = 0.6
	arg_1_0._vxItemGlowTime = 0.8
	arg_1_0._showTipsTime = 2
	arg_1_0._showtoptips = false
	arg_1_0._showbottomtips = false
	arg_1_0._isPlayAnim = false
	arg_1_0._sendMsgTime = 10

	gohelper.setActive(arg_1_0._gotoptips, false)

	arg_1_0._animComputer = gohelper.findChild(arg_1_0.viewGO, "Right/Computer/go_Unknown_Progress"):GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnKey:AddClickListener(arg_2_0._btnKeyOnClick, arg_2_0)
	arg_2_0._btnswitchLeft:AddClickListener(arg_2_0._btnswitchLeftOnClick, arg_2_0)
	arg_2_0._btnswitchRight:AddClickListener(arg_2_0._btnswitchRightOnClick, arg_2_0)
	arg_2_0._btnCanGet:AddClickListener(arg_2_0._btnCanGetOnClick, arg_2_0)
	arg_2_0._btnSearch:AddClickListener(arg_2_0._btnSearchOnClick, arg_2_0)
	arg_2_0._btntoptips:AddClickListener(arg_2_0._btntoptipsOnClick, arg_2_0)
	arg_2_0._btnclosetoptips:AddClickListener(arg_2_0._btnclosetoptipsOnClick, arg_2_0)
	arg_2_0._btnbottomtips:AddClickListener(arg_2_0._btnbottomtipsOnClick, arg_2_0)
	arg_2_0._btnclosebottomtips:AddClickListener(arg_2_0._btnclosebottomtipsOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity197Controller.instance, Activity197Event.UpdateSingleItem, arg_2_0.updateSingleRewardItem, arg_2_0)
	arg_2_0:addEventCb(Activity197Controller.instance, Activity197Event.onReceiveAct197Explore, arg_2_0._refreshBtn, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refreshBtn, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onRewardRefresh, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)

	arg_2_0._redDotKey = RedDotController.instance:addNotEventRedDot(arg_2_0._goreddotKey, arg_2_0.checkKeyReddot, arg_2_0)
	arg_2_0._redDotBubble = RedDotController.instance:addNotEventRedDot(arg_2_0._goreddotBubble, arg_2_0.checkBubbleReddot, arg_2_0)
	arg_2_0._redDotComputer = RedDotController.instance:addRedDot(arg_2_0._goreddotComputer, RedDotEnum.DotNode.ActiveActivityProgressReward)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnKey:RemoveClickListener()
	arg_3_0._btnswitchLeft:RemoveClickListener()
	arg_3_0._btnswitchRight:RemoveClickListener()
	arg_3_0._btnSearch:RemoveClickListener()
	arg_3_0._btnCanGet:RemoveClickListener()
	arg_3_0._btntoptips:RemoveClickListener()
	arg_3_0._btnclosetoptips:RemoveClickListener()
	arg_3_0._btnbottomtips:RemoveClickListener()
	arg_3_0._btnclosebottomtips:RemoveClickListener()
	arg_3_0:removeEventCb(Activity197Controller.instance, Activity197Event.UpdateSingleItem, arg_3_0.updateSingleRewardItem, arg_3_0)
	arg_3_0:removeEventCb(Activity197Controller.instance, Activity197Event.onReceiveAct197Explore, arg_3_0._refreshBtn, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refreshBtn, arg_3_0)
end

function var_0_0._btntoptipsOnClick(arg_4_0)
	arg_4_0._showtoptips = not arg_4_0._showtoptips

	gohelper.setActive(arg_4_0._gotoptips, arg_4_0._showtoptips)
end

function var_0_0._btnclosetoptipsOnClick(arg_5_0)
	arg_5_0._showtoptips = false

	gohelper.setActive(arg_5_0._gotoptips, arg_5_0._showtoptips)
end

function var_0_0._btnbottomtipsOnClick(arg_6_0)
	arg_6_0._showbottomtips = not arg_6_0._showbottomtips

	gohelper.setActive(arg_6_0._gobottomtips, arg_6_0._showbottomtips)
end

function var_0_0._btnclosebottomtipsOnClick(arg_7_0)
	arg_7_0._showbottomtips = false

	gohelper.setActive(arg_7_0._gobottomtips, arg_7_0._showbottomtips)
end

function var_0_0._btnswitchLeftOnClick(arg_8_0)
	if arg_8_0._isPlayAnim then
		return
	end

	local var_8_0 = arg_8_0._currentPoolId - 1

	if var_8_0 < 1 then
		return
	end

	arg_8_0._currentPoolId = var_8_0

	arg_8_0._leftAnimator:Play("left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	TaskDispatcher.runDelay(arg_8_0._onSwitchAnimFinish, arg_8_0, arg_8_0._switchTime)
end

function var_0_0._btnswitchRightOnClick(arg_9_0)
	if arg_9_0._isPlayAnim then
		return
	end

	local var_9_0 = arg_9_0._currentPoolId + 1

	if var_9_0 > Activity197Config.instance:getPoolCount() then
		return
	end

	if Activity197Model.instance:checkPoolOpen(var_9_0) then
		arg_9_0._currentPoolId = var_9_0

		arg_9_0._leftAnimator:Play("right", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		TaskDispatcher.runDelay(arg_9_0._onSwitchAnimFinish, arg_9_0, arg_9_0._switchTime)
	else
		GameFacade.showToast(ToastEnum.GetBigRewardUnlock)
	end
end

function var_0_0._onSwitchAnimFinish(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onSwitchAnimFinish, arg_10_0)
	arg_10_0:_refreshUI()

	arg_10_0._isPlayAnim = false
end

function var_0_0._btnSearchOnClick(arg_11_0)
	if arg_11_0._isPlayAnim then
		return
	end

	if Activity197Model.instance:canExplore() then
		arg_11_0:showGetKetProgress()
	else
		local var_11_0 = CurrencyConfig.instance:getCurrencyCo(Activity197Enum.BulbCurrency).name

		GameFacade.showToast(ToastEnum.V1a6CachotToast13, var_11_0)
	end
end

function var_0_0._btnKeyOnClick(arg_12_0)
	if arg_12_0._isPlayAnim then
		return
	end

	if Activity197Model.instance:checkPoolGetAllReward(arg_12_0._currentPoolId) then
		GameFacade.showToast(ToastEnum.HasReceiveAllReward)
	elseif Activity197Model.instance:canRummage() then
		arg_12_0:_getRewardAnim()
	else
		local var_12_0 = CurrencyConfig.instance:getCurrencyCo(Activity197Enum.KeyCurrency).name

		GameFacade.showToast(ToastEnum.V1a6CachotToast13, var_12_0)
	end
end

function var_0_0._btnClickTopNode(arg_13_0, arg_13_1)
	if arg_13_0._isPlayAnim then
		return
	end

	if arg_13_0._currentPoolId == arg_13_1 then
		return
	end

	if Activity197Model.instance:checkPoolOpen(arg_13_1) then
		local var_13_0 = arg_13_1 > arg_13_0._currentPoolId

		Activity197Model.instance:setCurrentPoolId(arg_13_1)

		arg_13_0._currentPoolId = arg_13_1

		if var_13_0 then
			arg_13_0._leftAnimator:Play("left", 0, 0)
			TaskDispatcher.runDelay(arg_13_0._onSwitchAnimFinish, arg_13_0, arg_13_0._switchTime)
		else
			arg_13_0._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(arg_13_0._onSwitchAnimFinish, arg_13_0, arg_13_0._switchTime)
		end

		arg_13_0._isPlayAnim = false
	else
		GameFacade.showToast(ToastEnum.GetBigRewardUnlock)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0._btnCanGetOnClick(arg_14_0)
	local var_14_0 = Activity197Config.instance:getStageConfig(arg_14_0._actId, 1)
	local var_14_1 = var_14_0 and var_14_0.globalTaskId or 0

	TaskRpc.instance:sendFinishTaskRequest(var_14_1)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._isShowTip = false

	gohelper.setActive(arg_15_0._gopointitem, false)
	gohelper.setActive(arg_15_0._gorewarditem, false)
	gohelper.setActive(arg_15_0._goExtraTips, false)

	arg_15_0._imageboxprogress.fillAmount = 0
	arg_15_0._imageprogress.fillAmount = 0

	arg_15_0:_initTopNode()
	arg_15_0:_initRewardItems()
end

function var_0_0._initTopNode(arg_16_0)
	arg_16_0._topnodeList = {}

	local var_16_0 = Activity197Config.instance:getPoolList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not arg_16_0._topnodeList[iter_16_0] then
			local var_16_1 = arg_16_0:getUserDataTb_()

			var_16_1.poolId = iter_16_1
			var_16_1.go = gohelper.clone(arg_16_0._gopointitem, arg_16_0._gopointcontent, "pool" .. iter_16_0)
			var_16_1.golocked = gohelper.findChild(var_16_1.go, "locked")
			var_16_1.gounlock = gohelper.findChild(var_16_1.go, "unlock")
			var_16_1.goselect = gohelper.findChild(var_16_1.go, "unlock/go_select")
			var_16_1.gogetall = gohelper.findChild(var_16_1.go, "unlock/go_allGet")
			var_16_1.btn = gohelper.findChildButton(var_16_1.go, "btn")

			var_16_1.btn:AddClickListener(arg_16_0._btnClickTopNode, arg_16_0, var_16_1.poolId)

			var_16_1.anim = var_16_1.go:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(var_16_1.go, true)
			table.insert(arg_16_0._topnodeList, var_16_1)
		end
	end
end

function var_0_0._initRewardItems(arg_17_0)
	arg_17_0._rewardItems = {}

	for iter_17_0 = 1, 12 do
		if not arg_17_0._rewardItems[iter_17_0] then
			local var_17_0 = arg_17_0:getUserDataTb_()

			var_17_0.gainId = iter_17_0
			var_17_0.go = gohelper.clone(arg_17_0._gorewarditem, arg_17_0._gorewarditemcontent, "reward" .. iter_17_0)
			var_17_0.goreceive = gohelper.findChild(var_17_0.go, "go_receive")
			var_17_0.gohasget = gohelper.findChild(var_17_0.go, "go_receive/go_hasget")
			var_17_0.goitem = gohelper.findChild(var_17_0.go, "go_icon")
			var_17_0.gofirstPrice = gohelper.findChild(var_17_0.go, "go_firstPrice")
			var_17_0.goitemcomp = IconMgr.instance:getCommonPropItemIcon(var_17_0.goitem)
			var_17_0.vxglow = gohelper.findChild(var_17_0.go, "vx_glow")
			var_17_0.animHasGet = var_17_0.gohasget:GetComponent(typeof(UnityEngine.Animator))

			gohelper.setActive(var_17_0.gofirstPrice, iter_17_0 == 1)
			gohelper.setActive(var_17_0.go, true)
			table.insert(arg_17_0._rewardItems, var_17_0)
		end
	end
end

function var_0_0._onFinishTask(arg_18_0)
	arg_18_0:_refreshComputer()

	arg_18_0._imageprogress.fillAmount = 1

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.ActiveActivityProgressReward,
		RedDotEnum.DotNode.ActiveActivity
	})
	arg_18_0:_refreshRedDot()
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._actId = arg_19_0.viewParam.actId
	arg_19_0._lastOpenPoolId = 1
	arg_19_0._currentPoolId = Activity197Model.instance:getLastOpenPoolId()

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, arg_19_0._onSendTaskBack, arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.ui_mail.play_ui_mail_open_1)
	arg_19_0:_getLastPoolId()
	arg_19_0:_refreshUI()
	arg_19_0:_checkNeedShowBubbleVx()
end

function var_0_0._getLastPoolId(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._topnodeList) do
		if Activity197Model.instance:checkPoolOpen(iter_20_1.poolId) then
			arg_20_0._lastOpenPoolId = iter_20_1.poolId
		end
	end
end

function var_0_0._refreshUI(arg_21_0)
	arg_21_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_21_0._actId)

	local var_21_0 = string.format("%03d", arg_21_0._currentPoolId)

	arg_21_0._txtindex.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("anniversary_activity_name"), var_21_0)

	local var_21_1 = arg_21_0._currentPoolId == Activity197Config.instance:getPoolCount()
	local var_21_2 = arg_21_0._currentPoolId == 1

	gohelper.setActive(arg_21_0._btnswitchRight.gameObject, not var_21_1)
	gohelper.setActive(arg_21_0._btnswitchLeft.gameObject, not var_21_2)
	arg_21_0:_refreshTopNodeList()
	arg_21_0:_refreshRewardItems()
	arg_21_0:_refreshProgress()
	arg_21_0:_refreshBtn()
end

function var_0_0._refreshRedDot(arg_22_0)
	if arg_22_0._redDotKey then
		arg_22_0._redDotKey:refreshRedDot()
	end

	if arg_22_0._redDotBubble then
		arg_22_0._redDotBubble:refreshRedDot()
	end
end

function var_0_0._refreshComputer(arg_23_0)
	local var_23_0 = Activity197Model.instance:checkBigRewardCanGet()
	local var_23_1 = Activity197Model.instance:checkBigRewardHasGet()

	gohelper.setActive(arg_23_0._goCanGet, var_23_0)
	gohelper.setActive(arg_23_0._goHasGet, var_23_1)
	gohelper.setActive(arg_23_0._goUnknown, not var_23_0 and not var_23_1)
	gohelper.setActive(arg_23_0._goUnknownProgress, not var_23_0 and not var_23_1)
end

function var_0_0._refreshTopNodeList(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._topnodeList) do
		local var_24_0 = Activity197Model.instance:checkPoolOpen(iter_24_1.poolId)

		if var_24_0 and iter_24_1.poolId > arg_24_0._lastOpenPoolId then
			arg_24_0._lastOpenPoolId = iter_24_1.poolId

			iter_24_1.anim:Play("unlock", 0, 0)

			arg_24_0._txtTips.text = luaLang("anniversary_activity_tip2")
			arg_24_0._currentPoolId = arg_24_0._lastOpenPoolId

			arg_24_0._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(arg_24_0._onSwitchAnimFinish, arg_24_0, arg_24_0._switchTime)
			arg_24_0:showGetKeyTip()
		end

		gohelper.setActive(iter_24_1.gounlock, var_24_0)
		gohelper.setActive(iter_24_1.golocked, not var_24_0)

		local var_24_1 = iter_24_1.poolId == arg_24_0._currentPoolId

		gohelper.setActive(iter_24_1.goselect, var_24_1)

		local var_24_2 = Activity197Model.instance:checkPoolGetAllReward(iter_24_1.poolId)

		if var_24_2 and not iter_24_1.allGet then
			iter_24_1.allGet = true

			iter_24_1.anim:Play("finish", 0, 0)

			arg_24_0._currentPoolId = arg_24_0._lastOpenPoolId

			arg_24_0._leftAnimator:Play("right", 0, 0)
			TaskDispatcher.runDelay(arg_24_0._onSwitchAnimFinish, arg_24_0, arg_24_0._switchTime)
		end

		gohelper.setActive(iter_24_1.gogetall, var_24_2)
	end
end

function var_0_0._refreshRewardItems(arg_25_0)
	local var_25_0 = Activity197Config.instance:getPoolConfigById(arg_25_0._currentPoolId)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._rewardItems) do
		local var_25_1 = var_25_0[iter_25_0]

		if var_25_1 and not string.nilorempty(var_25_1.bonus) then
			local var_25_2 = string.splitToNumber(var_25_1.bonus, "#")

			iter_25_1.goitemcomp:setMOValue(var_25_2[1], var_25_2[2], var_25_2[3], nil, true)
		end

		local var_25_3 = Activity197Model.instance:checkRewardReceied(arg_25_0._currentPoolId, iter_25_0)

		gohelper.setActive(iter_25_1.goreceive, var_25_3)
	end
end

function var_0_0.updateSingleRewardItem(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.poolId
	local var_26_1 = arg_26_1.gainId

	if var_26_0 ~= arg_26_0._currentPoolId then
		return
	end

	local var_26_2 = arg_26_0._rewardItems[var_26_1]

	function arg_26_0._onvxglowFinish()
		local var_27_0 = Activity197Model.instance:checkRewardReceied(arg_26_0._currentPoolId, var_26_1)

		gohelper.setActive(var_26_2.goreceive, var_27_0)
		var_26_2.animHasGet:Play("open", 0, 0)
		arg_26_0:_refreshTopNodeList()
	end

	gohelper.setActive(var_26_2.vxglow, true)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_pass)

	function arg_26_0._delayFunc()
		TaskDispatcher.cancelTask(arg_26_0._delayFunc, arg_26_0)
		gohelper.setActive(var_26_2.vxglow, false)
		Activity197Controller.instance:popupRewardView()

		arg_26_0._isPlayAnim = false
	end

	arg_26_0:_refreshRedDot()
	TaskDispatcher.runDelay(arg_26_0._delayFunc, arg_26_0, arg_26_0._vxItemGlowTime)
end

function var_0_0._onRewardRefresh(arg_29_0)
	if arg_29_0._onvxglowFinish then
		arg_29_0._onvxglowFinish(arg_29_0)

		arg_29_0._onvxglowFinish = nil
	end

	if arg_29_0._needShowTip then
		arg_29_0:showGetKeyTip()

		arg_29_0._needShowTip = false
	end
end

function var_0_0._refreshProgress(arg_30_0)
	if not Activity197Model.instance:checkStageOpen(arg_30_0._actId) then
		return
	end

	local var_30_0 = Activity197Config.instance:getStageConfig(arg_30_0._actId, 1)

	arg_30_0.remainsearchtime = TimeUtil.stringToTimestamp(var_30_0.endTime) - ServerTime.now()

	arg_30_0:_updateStageProgress()
	TaskDispatcher.cancelTask(arg_30_0._sendTaskRpc, arg_30_0)

	local var_30_1 = not Activity197Model.instance:checkBigRewardHasGet() and not Activity197Model.instance:checkBigRewardCanGet()

	if arg_30_0.remainsearchtime > 0 and var_30_1 then
		TaskDispatcher.runRepeat(arg_30_0._sendTaskRpc, arg_30_0, arg_30_0._sendMsgTime)
	end
end

function var_0_0._sendTaskRpc(arg_31_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity173
	}, arg_31_0._onSendTaskBack, arg_31_0)
end

function var_0_0._onSendTaskBack(arg_32_0)
	arg_32_0:_refreshProgress()
end

function var_0_0._updateStageProgress(arg_33_0)
	if Activity197Model.instance:checkBigRewardHasGet() then
		arg_33_0:_refreshComputer()

		arg_33_0._imageprogress.fillAmount = 1

		return
	end

	if Activity197Model.instance:checkBigRewardCanGet() then
		arg_33_0:_refreshComputer()
		arg_33_0:_refreshRedDot()

		arg_33_0._imageprogress.fillAmount = 1

		TaskDispatcher.cancelTask(arg_33_0._sendTaskRpc, arg_33_0)
	else
		arg_33_0._imageprogress.fillAmount = Activity197Model.instance:getStageProgress(arg_33_0._actId)
	end
end

function var_0_0._refreshBtn(arg_34_0)
	local var_34_0 = Activity197Config.instance:getRummageConsume()

	arg_34_0._txtusekey.text = "-" .. var_34_0

	local var_34_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.BulbCurrency)
	local var_34_2 = var_34_1 and var_34_1.quantity or 0

	arg_34_0._txtusebubble.text = "×" .. GameUtil.numberDisplay(var_34_2)

	local var_34_3 = Activity197Model.instance:checkPoolGetAllReward(arg_34_0._currentPoolId)

	gohelper.setActive(arg_34_0._btnKey.gameObject, not var_34_3)
	arg_34_0:_refreshRedDot()
end

function var_0_0.showGetKeyTip(arg_35_0)
	arg_35_0._isShowTip = true

	arg_35_0:_refreshBtn()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_open)
	gohelper.setActive(arg_35_0._goExtraTips, arg_35_0._isShowTip)
	TaskDispatcher.runDelay(arg_35_0.closeGetKeyTip, arg_35_0, arg_35_0._showTipsTime)
end

function var_0_0.closeGetKeyTip(arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.showGetKeyTip, arg_36_0)

	arg_36_0._isShowTip = false

	gohelper.setActive(arg_36_0._goExtraTips, arg_36_0._isShowTip)
end

function var_0_0.showGetKetProgress(arg_37_0)
	arg_37_0._isPlayAnim = true

	gohelper.setActive(arg_37_0._goUnknown, false)
	gohelper.setActive(arg_37_0._goUnknownProgress, true)
	arg_37_0._animComputer:Play("open", 0, 0)

	local var_37_0 = Activity197Model.instance:checkBigRewardCanGet()
	local var_37_1 = Activity197Model.instance:checkBigRewardHasGet()

	gohelper.setActive(arg_37_0._goprogressunknown, not var_37_0 and not var_37_1)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.play_ui_youyu_death)

	arg_37_0._txtTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("anniversary_activitytip_1"), Activity197Model.instance:getOnceExploreKeyCount())

	TaskDispatcher.runDelay(arg_37_0.flyKeyAnim, arg_37_0, arg_37_0._showTipsTime)
end

function var_0_0.flyKeyAnim(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.flyKeyAnim, arg_38_0)

	local var_38_0 = Activity197Model.instance:checkBigRewardCanGet()
	local var_38_1 = Activity197Model.instance:checkBigRewardHasGet()

	if var_38_0 or var_38_1 then
		gohelper.setActive(arg_38_0._goCanGet, var_38_0)
		gohelper.setActive(arg_38_0._goHasGet, var_38_1)
		gohelper.setActive(arg_38_0._goUnknown, not var_38_0 and not var_38_1)
		gohelper.setActive(arg_38_0._goUnknownProgress, not var_38_0 and not var_38_1)
	else
		gohelper.setActive(arg_38_0._goUnknown, true)
		gohelper.setActive(arg_38_0._goUnknownProgress, false)
	end

	Activity197Rpc.instance:sendAct197ExploreReqvest(arg_38_0._actId, Activity197Enum.FindType.All)
	gohelper.setActive(arg_38_0._govxkey, true)
	TaskDispatcher.runDelay(arg_38_0._vxkeyAnim, arg_38_0, 0.5)
end

function var_0_0._vxkeyAnim(arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._vxkeyAnim, arg_39_0)
	gohelper.setActive(arg_39_0._govxkey, false)

	arg_39_0._needShowTip = true
	arg_39_0._isPlayAnim = false
end

function var_0_0._getRewardAnim(arg_40_0)
	arg_40_0._isPlayAnim = true

	gohelper.setActive(arg_40_0._govxFresh, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_doom_disappear)
	TaskDispatcher.runDelay(arg_40_0._vxFreshAnim, arg_40_0, arg_40_0._vxfreshTime)
end

function var_0_0._vxFreshAnim(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._vxFreshAnim, arg_41_0)
	gohelper.setActive(arg_41_0._govxFresh, false)
	Activity197Rpc.instance:sendAct197RummageRequest(arg_41_0._actId, arg_41_0._currentPoolId)
end

function var_0_0._checkNeedShowBubbleVx(arg_42_0)
	if Activity197Model.instance:getShowBubbleVx() then
		TaskDispatcher.runDelay(arg_42_0._showBubbleVx, arg_42_0, 0.5)
	end
end

function var_0_0._showBubbleVx(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._showBubbleVx, arg_43_0)
	gohelper.setActive(arg_43_0._govxbubble, true)
	TaskDispatcher.runDelay(arg_43_0._vxBubbleAnim, arg_43_0, 0.5)
end

function var_0_0._vxBubbleAnim(arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._vxBubbleAnim, arg_44_0)
	gohelper.setActive(arg_44_0._govxbubble, false)
	Activity197Model.instance:resetShowBubbleVx()
end

function var_0_0.checkKeyReddot(arg_45_0)
	if Activity197Model.instance:checkAllPoolRewardGet() then
		return false
	end

	return Activity197Model.instance:canRummage()
end

function var_0_0.checkBubbleReddot(arg_46_0)
	if Activity197Model.instance:checkAllPoolRewardGet() then
		return false
	end

	return Activity197Model.instance:canExplore()
end

function var_0_0.onClose(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._sendTaskRpc, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._onSwitchAnimFinish, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._vxkeyAnim, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._vxFreshAnim, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._delayFunc, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._vxBubbleAnim, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._showBubbleVx, arg_47_0)

	if arg_47_0._topnodeList and #arg_47_0._topnodeList > 0 then
		for iter_47_0, iter_47_1 in ipairs(arg_47_0._topnodeList) do
			iter_47_1.btn:RemoveClickListener()
		end
	end
end

function var_0_0.onDestroyView(arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._sendTaskRpc, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0.showGetKeyTip, arg_48_0)
end

function var_0_0.onRefreshActivity(arg_49_0)
	local var_49_0 = ActivityHelper.getActivityStatus(arg_49_0._actId)

	if var_49_0 == ActivityEnum.ActivityStatus.NotOnLine or var_49_0 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return var_0_0
