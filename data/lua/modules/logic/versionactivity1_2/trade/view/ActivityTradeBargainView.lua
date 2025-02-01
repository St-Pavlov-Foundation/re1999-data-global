module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainView", package.seeall)

slot0 = class("ActivityTradeBargainView", BaseView)

function slot0.onInitView(slot0)
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobar = gohelper.findChild(slot0.viewGO, "#go_bar")
	slot0._btndaily = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bar/#btn_daily")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bar/#btn_reward")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gotalkarea = gohelper.findChild(slot0.viewGO, "left/#go_talkarea")
	slot0._animtalkarea = slot0._gotalkarea:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "left/layout/#go_lefttop/#txt_date")
	slot0._txtcurprogress = gohelper.findChildText(slot0.viewGO, "#go_progress/horizontal/#txt_curprogress")

	gohelper.setActive(slot0._gotalkarea, false)

	slot0._txtchatinfo = gohelper.findChildText(slot0.viewGO, "left/#go_talkarea/txt_chatinfo")
	slot0._goDot = gohelper.findChild(slot0._gotalkarea, "vx_dot")
	slot0._simagebossicon = gohelper.findChildSingleImage(slot0.viewGO, "left/#go_boss/#simage_bossicon")
	slot0._goleftBottom = gohelper.findChild(slot0.viewGO, "left/layout/#go_leftbottom")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")

	slot0:_overseasInit()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndaily:AddClickListener(slot0._btndailyOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.BargainStatusChange, slot0.onBargainStatusChanged, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, slot0.updateView, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.PlayTalk, slot0.playTalk, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.updateView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndaily:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.BargainStatusChange, slot0.onBargainStatusChanged, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, slot0.updateView, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.PlayTalk, slot0.playTalk, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.updateView, slot0)
end

slot0.TabNum = 2

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("bg"))
	slot0._simagebossicon:LoadImage(ResUrl.getVersionTradeBargainBg("img_juese"))

	slot0._selectTabs = slot0:getUserDataTb_()
	slot0._unselectTabs = slot0:getUserDataTb_()
	slot0._selectTabs[1] = gohelper.findChild(slot0._btndaily.gameObject, "go_selected")
	slot0._unselectTabs[1] = gohelper.findChild(slot0._btndaily.gameObject, "go_unselected")
	slot0._selectTabs[2] = gohelper.findChild(slot0._btnreward.gameObject, "go_selected")
	slot0._unselectTabs[2] = gohelper.findChild(slot0._btnreward.gameObject, "go_unselected")
	slot0._gorewardreddot1 = gohelper.findChild(slot0._btnreward.gameObject, "go_selected/txt_titlecn/go_reddot1")
	slot0._gorewardreddot2 = gohelper.findChild(slot0._btnreward.gameObject, "go_unselected/txt_titlecn/go_reddot2")

	RedDotController.instance:addRedDot(slot0._gorewardreddot1, RedDotEnum.DotNode.TradeReward)
	RedDotController.instance:addRedDot(slot0._gorewardreddot2, RedDotEnum.DotNode.TradeReward)
end

function slot0._overseasInit(slot0)
	slot0._txtchatinfo = gohelper.findChildText(slot0.viewGO, "left/#go_talkarea/scroll/info/txt_chatinfo")
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebossicon:UnLoadImage()

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.onOpen(slot0)
	slot0:onRefreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:onRefreshView()
end

function slot0.onRefreshView(slot0)
	slot0.actId = slot0.viewParam and slot0.viewParam.actId

	slot0.viewContainer:setActId(slot0.actId)
	slot0:changeTab(slot0.viewParam and slot0.viewParam.tabIndex or 1)
	slot0:updateView()
end

function slot0.updateView(slot0)
	slot0._txtdate.text = formatLuaLang("versionactivity_1_2_117daytxt", Activity117Model.instance:getRemainDay(slot0.actId))
	slot0._txtcurprogress.text = tostring(Activity117Model.instance:getCurrentScore(slot0.actId))
end

function slot0.onClose(slot0)
	Activity117Model.instance:setSelectOrder(slot0.actId)
	Activity117Model.instance:setInQuote(slot0.actId)
end

function slot0.onSwitchTab(slot0, slot1)
	for slot5 = 1, uv0.TabNum do
		gohelper.setActive(slot0._selectTabs[slot5], slot1 == slot5)
		gohelper.setActive(slot0._unselectTabs[slot5], slot1 ~= slot5)
	end

	slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)

	if not slot0.playContent then
		slot0.playContent = true

		slot0:playTalk(slot0.actId, Activity117Config.instance:getTalkCo(slot0.actId, Activity117Enum.PriceType.Talk) and slot2.content1)
	end
end

function slot0.playTalk(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.actId then
		return
	end

	gohelper.setActive(slot0._gotalkarea, true)

	if slot2 then
		slot0._animtalkarea:Play(UIAnimationName.Open)
		gohelper.setActive(slot0._goDot, slot3 and true or false)

		if slot0.tweenId then
			ZProj.TweenHelper.KillById(slot0.tweenId)

			slot0.tweenId = nil
		end

		slot0._txtchatinfo.text = ""

		if not string.nilorempty(slot2) then
			slot0.tweenId = ZProj.TweenHelper.DOText(slot0._txtchatinfo, slot2, 2)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_auctionhouses_lvhutooth)
	else
		slot0._animtalkarea:Play(UIAnimationName.Close)
	end
end

function slot0.onBargainStatusChanged(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	if Activity117Model.instance:isSelectOrder(slot0.actId) == slot0.isSelect then
		return
	end

	slot0.isSelect = slot2

	if slot0.isSelect then
		slot0._anim:Play("go")
	else
		slot0._anim:Play("back")
	end
end

function slot0._btndailyOnClick(slot0)
	slot0:changeTab(Activity117Enum.OpenTab.Daily)
end

function slot0._btnrewardOnClick(slot0)
	slot0:changeTab(Activity117Enum.OpenTab.Reward)
end

function slot0.changeTab(slot0, slot1)
	if slot0.tabIndex == slot1 then
		return
	end

	slot0.tabIndex = slot1

	slot0:onSwitchTab(slot1)
end

function slot0._onDailyRefresh(slot0)
	if slot0.actId then
		Activity117Controller.instance:initAct(slot0.actId)
	end
end

return slot0
