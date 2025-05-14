module("modules.logic.versionactivity1_2.jiexika.view.Activity114MainView", package.seeall)

local var_0_0 = class("Activity114MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._sliderAttentionNow = gohelper.findChildImage(arg_1_0.viewGO, "#go_time/attentionBar/#image_attention")
	arg_1_0._sliderAttention = gohelper.findChildImage(arg_1_0.viewGO, "#go_time/attentionBar/#image_attention2")
	arg_1_0._btnattrtips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_attr/#go_attrdetail/attrtitle/#btn_attrtips")
	arg_1_0._goattrtips = gohelper.findChild(arg_1_0.viewGO, "#go_attrtips")
	arg_1_0._btncloseattrtips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_attrtips/#btn_closeTips")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnattrtips:AddClickListener(arg_2_0._openTips, arg_2_0)
	arg_2_0._btncloseattrtips:AddClickListener(arg_2_0._closeTips, arg_2_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, arg_2_0.updateAttention, arg_2_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, arg_2_0.onEventEnd, arg_2_0)
	arg_2_0.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, arg_2_0.updateAttention, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnattrtips:RemoveClickListener()
	arg_3_0._btncloseattrtips:RemoveClickListener()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, arg_3_0.updateAttention, arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, arg_3_0.onEventEnd, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, arg_3_0.updateAttention, arg_3_0)
end

function var_0_0._openTips(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	gohelper.setActive(arg_4_0._goattrtips, true)
end

function var_0_0._closeTips(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(arg_5_0._goattrtips, false)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	arg_7_0._viewAnim:Play("open", 0, 0)
	arg_7_0:addChildView(Activity114TimeView.New())
	arg_7_0:addChildView(Activity114AttrView.New("#go_attr"))
	arg_7_0:addChildView(Activity114OperView.New("#go_oper"))
	arg_7_0:addChildView(Activity114EduOperView.New("#go_eduSelect"))
	gohelper.setActive(arg_7_0._goattrtips, false)
	arg_7_0._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_youce.png"))

	if not Activity114Model.instance.serverData.isEnterSchool then
		Activity114Model.instance.serverData.isEnterSchool = true

		Activity114Rpc.instance:enterSchool(Activity114Model.instance.id)
	end

	arg_7_0:updateAttention()
	arg_7_0:onEventEnd(true)
end

function var_0_0.onOpenFinish(arg_8_0)
	arg_8_0._viewAnim.enabled = true
end

function var_0_0.onEventEnd(arg_9_0, arg_9_1)
	local var_9_0 = Activity114Model.instance.preEventType
	local var_9_1 = Activity114Model.instance.preResult

	Activity114Model.instance.preEventType = nil
	Activity114Model.instance.preResult = nil

	if not Activity114Model.instance.serverData.isEnterSchool then
		arg_9_0.viewContainer:switchTab(Activity114Enum.TabIndex.EnterView)

		local var_9_2 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.WeekEndGuideId)

		Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(var_9_2))

		return
	end

	if Activity114Model.instance.serverData.checkEventId > 0 then
		local var_9_3 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.checkEventId)
		local var_9_4 = {
			type = var_9_3.config.eventType,
			eventId = var_9_3.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(var_9_4)

		return
	end

	if Activity114Model.instance.serverData.testEventId > 0 then
		local var_9_5 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.testEventId)
		local var_9_6 = {
			type = var_9_5.config.eventType,
			eventId = var_9_5.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(var_9_6)

		return
	end

	local var_9_7 = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

	if not var_9_7 then
		logError(string.format("没有回合天数配置？？？day:%d round:%d", Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round))

		return
	end

	if not Activity114Model.instance.serverData.isReadRoundStory and Activity114Model.instance.serverData.week == 1 and not string.nilorempty(var_9_7.preStoryId) then
		Activity114Model.instance:beginStoryFlow()

		return
	end

	if var_9_7.type == Activity114Enum.RoundType.KeyDay then
		if string.nilorempty(var_9_7.eventId) then
			logError("关键天事件没配？？" .. Activity114Model.instance.serverData.day .. "#" .. Activity114Model.instance.serverData.round)

			return
		end

		local var_9_8 = string.splitToNumber(var_9_7.eventId, "#")
		local var_9_9 = var_9_8[Activity114Model.instance.serverData.week] or var_9_8[1]
		local var_9_10 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, var_9_9)
		local var_9_11 = {
			type = var_9_10.config.eventType,
			eventId = var_9_10.config.id
		}

		Activity114Model.instance:beginEvent(var_9_11)

		return
	end

	if not arg_9_1 then
		arg_9_0:_playOpenAnim()
	end

	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventEndWithResult, var_9_0, var_9_1)
end

function var_0_0.updateAttention(arg_10_0)
	local var_10_0
	local var_10_1
	local var_10_2 = Activity114Model.instance.serverData.attention / 100
	local var_10_3 = var_10_2

	if Activity114Model.instance.eduSelectAttr then
		local var_10_4 = Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr)
		local var_10_5 = var_10_4 and var_10_4.successVerify[Activity114Enum.AddAttrType.Attention] or 0

		var_10_3 = (Activity114Model.instance.serverData.attention + var_10_5) / 100
	end

	if var_10_3 < var_10_2 then
		var_10_3, var_10_2 = var_10_2, var_10_3
	end

	arg_10_0._sliderAttentionNow.fillAmount = var_10_3
	arg_10_0._sliderAttention.fillAmount = var_10_2
end

function var_0_0._playOpenAnim(arg_11_0)
	Activity114Model.instance.isPlayingOpenAnim = true

	arg_11_0.viewContainer:dispatchEvent(Activity114Event.MainViewAnimBegin)
	arg_11_0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(function()
		Activity114Model.instance.isPlayingOpenAnim = false

		arg_11_0.viewContainer:dispatchEvent(Activity114Event.MainViewAnimEnd)
	end, nil, 0.833)
end

function var_0_0.onClose(arg_13_0)
	Activity114Model.instance.isPlayingOpenAnim = false

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	arg_13_0._viewAnim:Play(UIAnimationName.Close, 0, 0)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagerightbg:UnLoadImage()
end

return var_0_0
