module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainView", package.seeall)

local var_0_0 = class("ActivityTradeBargainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobar = gohelper.findChild(arg_1_0.viewGO, "#go_bar")
	arg_1_0._btndaily = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bar/#btn_daily")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bar/#btn_reward")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gotalkarea = gohelper.findChild(arg_1_0.viewGO, "left/#go_talkarea")
	arg_1_0._animtalkarea = arg_1_0._gotalkarea:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "left/layout/#go_lefttop/#txt_date")
	arg_1_0._txtcurprogress = gohelper.findChildText(arg_1_0.viewGO, "#go_progress/horizontal/#txt_curprogress")

	gohelper.setActive(arg_1_0._gotalkarea, false)

	arg_1_0._txtchatinfo = gohelper.findChildText(arg_1_0.viewGO, "left/#go_talkarea/txt_chatinfo")
	arg_1_0._goDot = gohelper.findChild(arg_1_0._gotalkarea, "vx_dot")
	arg_1_0._simagebossicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#go_boss/#simage_bossicon")
	arg_1_0._goleftBottom = gohelper.findChild(arg_1_0.viewGO, "left/layout/#go_leftbottom")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")

	arg_1_0:_overseasInit()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndaily:AddClickListener(arg_2_0._btndailyOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity117Controller.instance, Activity117Event.BargainStatusChange, arg_2_0.onBargainStatusChanged, arg_2_0)
	arg_2_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, arg_2_0.updateView, arg_2_0)
	arg_2_0:addEventCb(Activity117Controller.instance, Activity117Event.PlayTalk, arg_2_0.playTalk, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_2_0.updateView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndaily:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0:removeEventCb(Activity117Controller.instance, Activity117Event.BargainStatusChange, arg_3_0.onBargainStatusChanged, arg_3_0)
	arg_3_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, arg_3_0.updateView, arg_3_0)
	arg_3_0:removeEventCb(Activity117Controller.instance, Activity117Event.PlayTalk, arg_3_0.playTalk, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_3_0.updateView, arg_3_0)
end

var_0_0.TabNum = 2

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("bg"))
	arg_4_0._simagebossicon:LoadImage(ResUrl.getVersionTradeBargainBg("img_juese"))

	arg_4_0._selectTabs = arg_4_0:getUserDataTb_()
	arg_4_0._unselectTabs = arg_4_0:getUserDataTb_()
	arg_4_0._selectTabs[1] = gohelper.findChild(arg_4_0._btndaily.gameObject, "go_selected")
	arg_4_0._unselectTabs[1] = gohelper.findChild(arg_4_0._btndaily.gameObject, "go_unselected")
	arg_4_0._selectTabs[2] = gohelper.findChild(arg_4_0._btnreward.gameObject, "go_selected")
	arg_4_0._unselectTabs[2] = gohelper.findChild(arg_4_0._btnreward.gameObject, "go_unselected")
	arg_4_0._gorewardreddot1 = gohelper.findChild(arg_4_0._btnreward.gameObject, "go_selected/txt_titlecn/go_reddot1")
	arg_4_0._gorewardreddot2 = gohelper.findChild(arg_4_0._btnreward.gameObject, "go_unselected/txt_titlecn/go_reddot2")

	RedDotController.instance:addRedDot(arg_4_0._gorewardreddot1, RedDotEnum.DotNode.TradeReward)
	RedDotController.instance:addRedDot(arg_4_0._gorewardreddot2, RedDotEnum.DotNode.TradeReward)
end

function var_0_0._overseasInit(arg_5_0)
	arg_5_0._txtchatinfo = gohelper.findChildText(arg_5_0.viewGO, "left/#go_talkarea/scroll/info/txt_chatinfo")
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._simagebg:UnLoadImage()
	arg_6_0._simagebossicon:UnLoadImage()

	if arg_6_0.tweenId then
		ZProj.TweenHelper.KillById(arg_6_0.tweenId)

		arg_6_0.tweenId = nil
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:onRefreshView()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:onRefreshView()
end

function var_0_0.onRefreshView(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam and arg_9_0.viewParam.actId

	arg_9_0.viewContainer:setActId(arg_9_0.actId)

	local var_9_0 = arg_9_0.viewParam and arg_9_0.viewParam.tabIndex or 1

	arg_9_0:changeTab(var_9_0)
	arg_9_0:updateView()
end

function var_0_0.updateView(arg_10_0)
	local var_10_0 = Activity117Model.instance:getRemainDay(arg_10_0.actId)

	arg_10_0._txtdate.text = formatLuaLang("versionactivity_1_2_117daytxt", var_10_0)
	arg_10_0._txtcurprogress.text = tostring(Activity117Model.instance:getCurrentScore(arg_10_0.actId))
end

function var_0_0.onClose(arg_11_0)
	Activity117Model.instance:setSelectOrder(arg_11_0.actId)
	Activity117Model.instance:setInQuote(arg_11_0.actId)
end

function var_0_0.onSwitchTab(arg_12_0, arg_12_1)
	for iter_12_0 = 1, var_0_0.TabNum do
		gohelper.setActive(arg_12_0._selectTabs[iter_12_0], arg_12_1 == iter_12_0)
		gohelper.setActive(arg_12_0._unselectTabs[iter_12_0], arg_12_1 ~= iter_12_0)
	end

	arg_12_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_12_1)

	if not arg_12_0.playContent then
		arg_12_0.playContent = true

		local var_12_0 = Activity117Config.instance:getTalkCo(arg_12_0.actId, Activity117Enum.PriceType.Talk)

		arg_12_0:playTalk(arg_12_0.actId, var_12_0 and var_12_0.content1)
	end
end

function var_0_0.playTalk(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 ~= arg_13_0.actId then
		return
	end

	gohelper.setActive(arg_13_0._gotalkarea, true)

	if arg_13_2 then
		arg_13_0._animtalkarea:Play(UIAnimationName.Open)
		gohelper.setActive(arg_13_0._goDot, arg_13_3 and true or false)

		if arg_13_0.tweenId then
			ZProj.TweenHelper.KillById(arg_13_0.tweenId)

			arg_13_0.tweenId = nil
		end

		arg_13_0._txtchatinfo.text = ""

		if not string.nilorempty(arg_13_2) then
			arg_13_0.tweenId = ZProj.TweenHelper.DOText(arg_13_0._txtchatinfo, arg_13_2, 2)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_auctionhouses_lvhutooth)
	else
		arg_13_0._animtalkarea:Play(UIAnimationName.Close)
	end
end

function var_0_0.onBargainStatusChanged(arg_14_0, arg_14_1)
	if arg_14_1 ~= arg_14_0.actId then
		return
	end

	local var_14_0 = Activity117Model.instance:isSelectOrder(arg_14_0.actId)

	if var_14_0 == arg_14_0.isSelect then
		return
	end

	arg_14_0.isSelect = var_14_0

	if arg_14_0.isSelect then
		arg_14_0._anim:Play("go")
	else
		arg_14_0._anim:Play("back")
	end
end

function var_0_0._btndailyOnClick(arg_15_0)
	arg_15_0:changeTab(Activity117Enum.OpenTab.Daily)
end

function var_0_0._btnrewardOnClick(arg_16_0)
	arg_16_0:changeTab(Activity117Enum.OpenTab.Reward)
end

function var_0_0.changeTab(arg_17_0, arg_17_1)
	if arg_17_0.tabIndex == arg_17_1 then
		return
	end

	arg_17_0.tabIndex = arg_17_1

	arg_17_0:onSwitchTab(arg_17_1)
end

function var_0_0._onDailyRefresh(arg_18_0)
	if arg_18_0.actId then
		Activity117Controller.instance:initAct(arg_18_0.actId)
	end
end

return var_0_0
