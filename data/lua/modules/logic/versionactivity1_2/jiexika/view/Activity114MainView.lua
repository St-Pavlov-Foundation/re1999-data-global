module("modules.logic.versionactivity1_2.jiexika.view.Activity114MainView", package.seeall)

slot0 = class("Activity114MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._sliderAttentionNow = gohelper.findChildImage(slot0.viewGO, "#go_time/attentionBar/#image_attention")
	slot0._sliderAttention = gohelper.findChildImage(slot0.viewGO, "#go_time/attentionBar/#image_attention2")
	slot0._btnattrtips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_attr/#go_attrdetail/attrtitle/#btn_attrtips")
	slot0._goattrtips = gohelper.findChild(slot0.viewGO, "#go_attrtips")
	slot0._btncloseattrtips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_attrtips/#btn_closeTips")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnattrtips:AddClickListener(slot0._openTips, slot0)
	slot0._btncloseattrtips:AddClickListener(slot0._closeTips, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnAttentionUpdate, slot0.updateAttention, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, slot0.onEventEnd, slot0)
	slot0.viewContainer:registerCallback(Activity114Event.EduSelectAttrChange, slot0.updateAttention, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnattrtips:RemoveClickListener()
	slot0._btncloseattrtips:RemoveClickListener()
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnAttentionUpdate, slot0.updateAttention, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, slot0.onEventEnd, slot0)
	slot0.viewContainer:unregisterCallback(Activity114Event.EduSelectAttrChange, slot0.updateAttention, slot0)
end

function slot0._openTips(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)
	gohelper.setActive(slot0._goattrtips, true)
end

function slot0._closeTips(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_close)
	gohelper.setActive(slot0._goattrtips, false)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	slot0._viewAnim:Play("open", 0, 0)
	slot0:addChildView(Activity114TimeView.New())
	slot0:addChildView(Activity114AttrView.New("#go_attr"))
	slot0:addChildView(Activity114OperView.New("#go_oper"))
	slot0:addChildView(Activity114EduOperView.New("#go_eduSelect"))
	gohelper.setActive(slot0._goattrtips, false)
	slot0._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_youce.png"))

	if not Activity114Model.instance.serverData.isEnterSchool then
		Activity114Model.instance.serverData.isEnterSchool = true

		Activity114Rpc.instance:enterSchool(Activity114Model.instance.id)
	end

	slot0:updateAttention()
	slot0:onEventEnd(true)
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.onEventEnd(slot0, slot1)
	slot2 = Activity114Model.instance.preEventType
	slot3 = Activity114Model.instance.preResult
	Activity114Model.instance.preEventType = nil
	Activity114Model.instance.preResult = nil

	if not Activity114Model.instance.serverData.isEnterSchool then
		slot0.viewContainer:switchTab(Activity114Enum.TabIndex.EnterView)
		Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.WeekEndGuideId)))

		return
	end

	if Activity114Model.instance.serverData.checkEventId > 0 then
		slot4 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.checkEventId)

		Activity114Model.instance:buildFlowAndSkipWork({
			type = slot4.config.eventType,
			eventId = slot4.config.id
		})

		return
	end

	if Activity114Model.instance.serverData.testEventId > 0 then
		slot4 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.testEventId)

		Activity114Model.instance:buildFlowAndSkipWork({
			type = slot4.config.eventType,
			eventId = slot4.config.id
		})

		return
	end

	if not Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round) then
		logError(string.format("没有回合天数配置？？？day:%d round:%d", Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round))

		return
	end

	if not Activity114Model.instance.serverData.isReadRoundStory and Activity114Model.instance.serverData.week == 1 and not string.nilorempty(slot4.preStoryId) then
		Activity114Model.instance:beginStoryFlow()

		return
	end

	if slot4.type == Activity114Enum.RoundType.KeyDay then
		if string.nilorempty(slot4.eventId) then
			logError("关键天事件没配？？" .. Activity114Model.instance.serverData.day .. "#" .. Activity114Model.instance.serverData.round)

			return
		end

		slot7 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, string.splitToNumber(slot4.eventId, "#")[Activity114Model.instance.serverData.week] or slot5[1])

		Activity114Model.instance:beginEvent({
			type = slot7.config.eventType,
			eventId = slot7.config.id
		})

		return
	end

	if not slot1 then
		slot0:_playOpenAnim()
	end

	Activity114Controller.instance:dispatchEvent(Activity114Event.OnEventEndWithResult, slot2, slot3)
end

function slot0.updateAttention(slot0)
	slot1, slot2 = nil
	slot2 = Activity114Model.instance.serverData.attention / 100

	if Activity114Model.instance.eduSelectAttr then
		slot2 = (Activity114Model.instance.serverData.attention + (Activity114Config.instance:getEduEventCo(Activity114Model.instance.id, Activity114Model.instance.eduSelectAttr) and slot3.successVerify[Activity114Enum.AddAttrType.Attention] or 0)) / 100
	end

	if slot1 > slot2 then
		slot1 = slot2
		slot2 = slot1
	end

	slot0._sliderAttentionNow.fillAmount = slot2
	slot0._sliderAttention.fillAmount = slot1
end

function slot0._playOpenAnim(slot0)
	Activity114Model.instance.isPlayingOpenAnim = true

	slot0.viewContainer:dispatchEvent(Activity114Event.MainViewAnimBegin)
	slot0._viewAnim:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(function ()
		Activity114Model.instance.isPlayingOpenAnim = false

		uv0.viewContainer:dispatchEvent(Activity114Event.MainViewAnimEnd)
	end, nil, 0.833)
end

function slot0.onClose(slot0)
	Activity114Model.instance.isPlayingOpenAnim = false

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Close)
	slot0._viewAnim:Play(UIAnimationName.Close, 0, 0)
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
end

return slot0
