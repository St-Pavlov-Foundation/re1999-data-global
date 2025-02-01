module("modules.logic.meilanni.view.MeilanniEntrustView", package.seeall)

slot0 = class("MeilanniEntrustView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_bg1")
	slot0._txtexhibitsname = gohelper.findChildText(slot0.viewGO, "#go_bg/#txt_exhibitsname")
	slot0._txtexhibitsdesc = gohelper.findChildText(slot0.viewGO, "#go_bg/scroll_exhibits/Viewport/#txt_exhibitsdesc")
	slot0._txtactioninfo = gohelper.findChildText(slot0.viewGO, "#go_bg/#txt_actioninfo")
	slot0._simageexhibitsicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_bg/#simage_exhibitsicon")
	slot0._txttrustee = gohelper.findChildText(slot0.viewGO, "#go_bg/#txt_trustee")
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "#go_bg/#txt_date")
	slot0._gonodetail = gohelper.findChild(slot0.viewGO, "#go_nodetail")
	slot0._btnaccept = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_nodetail/#btn_accept")
	slot0._btnacceptagain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_nodetail/#btn_acceptagain")
	slot0._gobossdetail = gohelper.findChild(slot0.viewGO, "#go_bossdetail")
	slot0._btncloseboss = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_bossdetail/#btn_closeboss")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#go_bossdetail/#simage_mask")
	slot0._txtbossname = gohelper.findChildText(slot0.viewGO, "#go_bossdetail/#txt_bossname")
	slot0._simagebossicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_bossdetail/#simage_bossicon")
	slot0._scrollproperty = gohelper.findChildScrollRect(slot0.viewGO, "#go_bossdetail/#scroll_property")
	slot0._gopropertyitem = gohelper.findChild(slot0.viewGO, "#go_bossdetail/#scroll_property/Viewport/Content/#go_propertyitem")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnaccept:AddClickListener(slot0._btnacceptOnClick, slot0)
	slot0._btnacceptagain:AddClickListener(slot0._btnacceptagainOnClick, slot0)
	slot0._btncloseboss:AddClickListener(slot0._btnclosebossOnClick, slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnaccept:RemoveClickListener()
	slot0._btnacceptagain:RemoveClickListener()
	slot0._btncloseboss:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
	if slot0._showExcludeRules then
		return
	end

	slot0:closeThis()
end

function slot0._btnclosebossOnClick(slot0)
	if slot0._showExcludeRules then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	gohelper.setActive(slot0._gobossdetail, false)
	gohelper.setActive(slot0._gonodetail, true)

	if slot0._showBoss then
		return
	end

	slot0._settlementAnimator:Play("appear")
	slot0._acceptAgainAnimator:Play("appear")
	slot0._acceptAnimator:Play("appear")
end

function slot0._btncloseOnClick(slot0)
	if slot0._showExcludeRules then
		return
	end

	slot0:closeThis()
end

function slot0._btnacceptOnClick(slot0)
	slot0:_onAccept()
end

function slot0._btnacceptagainOnClick(slot0)
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, slot0._mapId)
end

function slot0._onAccept(slot0)
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, slot0._mapId)
end

function slot0._checkEnterMapStory(slot0)
	gohelper.setActive(slot0.viewGO, false)

	for slot5, slot6 in ipairs(MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.enterMap)) do
		if slot6[2] == slot0._mapId and not StoryModel.instance:isStoryFinished(slot6[1].story) then
			if MeilanniMainView.getOpenDayAndFinishMapStory() then
				StoryController.instance:playStories({
					slot9,
					slot8
				})
			else
				StoryController.instance:playStory(slot8)
			end

			return
		end
	end

	gohelper.setActive(slot0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		gohelper.setActive(slot0.viewGO, true)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	end
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnaccept.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(slot0._btnacceptagain.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	slot0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("bg_beijing5"))
	slot0._simagemask:LoadImage(ResUrl.getMeilanniIcon("bg_yinying"))

	slot0._acceptAgainAnimator = gohelper.findChild(slot0._btnacceptagain.gameObject, "acceptagain"):GetComponent(typeof(UnityEngine.Animator))
	slot0._acceptAnimator = gohelper.findChild(slot0._btnaccept.gameObject, "accept"):GetComponent(typeof(UnityEngine.Animator))
	slot0._acceptClick = SLFramework.UGUI.UIClickListener.Get(slot0._btnaccept.gameObject)

	slot0._acceptClick:AddClickDownListener(slot0._acceptClickDown, slot0)
	slot0._acceptClick:AddClickUpListener(slot0._acceptClickUp, slot0)

	slot0._acceptAgainClick = SLFramework.UGUI.UIClickListener.Get(slot0._btnacceptagain.gameObject)

	slot0._acceptAgainClick:AddClickDownListener(slot0._acceptAgainClickDown, slot0)
	slot0._acceptAgainClick:AddClickUpListener(slot0._acceptAgainClickUp, slot0)
end

function slot0._acceptAgainClickDown(slot0)
	slot0._acceptAgainAnimator:Play("clickdown")
end

function slot0._acceptAgainClickUp(slot0)
	slot0._acceptAgainAnimator:Play("clickup")
end

function slot0._acceptClickDown(slot0)
	slot0._acceptAnimator:Play("clickdown")
end

function slot0._acceptClickUp(slot0)
	slot0._acceptAnimator:Play("clickup")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._mapId = slot0.viewParam.mapId
	slot0._showExhibits = slot0.viewParam.showExhibits

	slot0:_checkEnterMapStory()

	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot0._mapConfig = lua_activity108_map.configDict[slot0._mapId]
	slot0._ruleGoList = slot0:getUserDataTb_()
	slot0._txtexhibitsdesc.text = slot0._mapConfig.content
	slot0._txtexhibitsname.text = slot0._mapConfig.title
	slot0._txttrustee.text = slot0._mapConfig.consignor
	slot0._txtactioninfo.text = slot0._mapConfig.actContent
	slot1 = not slot0._mapInfo or not slot0._mapInfo:checkFinish()

	gohelper.setActive(slot0._btnaccept.gameObject, slot1)
	gohelper.setActive(slot0._btnacceptagain.gameObject, not slot1)

	if slot0._showExhibits then
		gohelper.setActive(slot0._btnaccept.gameObject, false)
	end

	if slot0._mapId <= 102 then
		slot0._txtdate.text = formatLuaLang("meilanni_total_day", MeilanniConfig.instance:getLastEpisode(slot0._mapId).day)
	else
		slot0._txtdate.text = formatLuaLang("meilanni_total_day2", slot2.day)
	end

	slot0._simageexhibitsicon:LoadImage(ResUrl.getMeilanniIcon(slot0._mapConfig.exhibits))
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._resetMap(slot0)
	slot0:closeThis()
	MeilanniController.instance:openMeilanniView({
		mapId = slot0._mapId
	})
end

function slot0.onClose(slot0)
	slot0._simageexhibitsicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._acceptClick:RemoveClickDownListener()
	slot0._acceptClick:RemoveClickUpListener()
	slot0._acceptAgainClick:RemoveClickDownListener()
	slot0._acceptAgainClick:RemoveClickUpListener()
end

return slot0
