module("modules.logic.meilanni.view.MeilanniEntrustView", package.seeall)

local var_0_0 = class("MeilanniEntrustView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_bg1")
	arg_1_0._txtexhibitsname = gohelper.findChildText(arg_1_0.viewGO, "#go_bg/#txt_exhibitsname")
	arg_1_0._txtexhibitsdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_bg/scroll_exhibits/Viewport/#txt_exhibitsdesc")
	arg_1_0._txtactioninfo = gohelper.findChildText(arg_1_0.viewGO, "#go_bg/#txt_actioninfo")
	arg_1_0._simageexhibitsicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_exhibitsicon")
	arg_1_0._txttrustee = gohelper.findChildText(arg_1_0.viewGO, "#go_bg/#txt_trustee")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "#go_bg/#txt_date")
	arg_1_0._gonodetail = gohelper.findChild(arg_1_0.viewGO, "#go_nodetail")
	arg_1_0._btnaccept = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_nodetail/#btn_accept")
	arg_1_0._btnacceptagain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_nodetail/#btn_acceptagain")
	arg_1_0._gobossdetail = gohelper.findChild(arg_1_0.viewGO, "#go_bossdetail")
	arg_1_0._btncloseboss = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_bossdetail/#btn_closeboss")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bossdetail/#simage_mask")
	arg_1_0._txtbossname = gohelper.findChildText(arg_1_0.viewGO, "#go_bossdetail/#txt_bossname")
	arg_1_0._simagebossicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bossdetail/#simage_bossicon")
	arg_1_0._scrollproperty = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_bossdetail/#scroll_property")
	arg_1_0._gopropertyitem = gohelper.findChild(arg_1_0.viewGO, "#go_bossdetail/#scroll_property/Viewport/Content/#go_propertyitem")
	arg_1_0._btnclose1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnaccept:AddClickListener(arg_2_0._btnacceptOnClick, arg_2_0)
	arg_2_0._btnacceptagain:AddClickListener(arg_2_0._btnacceptagainOnClick, arg_2_0)
	arg_2_0._btncloseboss:AddClickListener(arg_2_0._btnclosebossOnClick, arg_2_0)
	arg_2_0._btnclose1:AddClickListener(arg_2_0._btnclose1OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnaccept:RemoveClickListener()
	arg_3_0._btnacceptagain:RemoveClickListener()
	arg_3_0._btncloseboss:RemoveClickListener()
	arg_3_0._btnclose1:RemoveClickListener()
end

function var_0_0._btnclose1OnClick(arg_4_0)
	if arg_4_0._showExcludeRules then
		return
	end

	arg_4_0:closeThis()
end

function var_0_0._btnclosebossOnClick(arg_5_0)
	if arg_5_0._showExcludeRules then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	gohelper.setActive(arg_5_0._gobossdetail, false)
	gohelper.setActive(arg_5_0._gonodetail, true)

	if arg_5_0._showBoss then
		return
	end

	arg_5_0._settlementAnimator:Play("appear")
	arg_5_0._acceptAgainAnimator:Play("appear")
	arg_5_0._acceptAnimator:Play("appear")
end

function var_0_0._btncloseOnClick(arg_6_0)
	if arg_6_0._showExcludeRules then
		return
	end

	arg_6_0:closeThis()
end

function var_0_0._btnacceptOnClick(arg_7_0)
	arg_7_0:_onAccept()
end

function var_0_0._btnacceptagainOnClick(arg_8_0)
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, arg_8_0._mapId)
end

function var_0_0._onAccept(arg_9_0)
	Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, arg_9_0._mapId)
end

function var_0_0._checkEnterMapStory(arg_10_0)
	gohelper.setActive(arg_10_0.viewGO, false)

	local var_10_0 = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.enterMap)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1[2] == arg_10_0._mapId then
			local var_10_1 = iter_10_1[1].story

			if not StoryModel.instance:isStoryFinished(var_10_1) then
				local var_10_2 = MeilanniMainView.getOpenDayAndFinishMapStory()

				if var_10_2 then
					StoryController.instance:playStories({
						var_10_2,
						var_10_1
					})
				else
					StoryController.instance:playStory(var_10_1)
				end

				return
			end
		end
	end

	gohelper.setActive(arg_10_0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.StoryView then
		gohelper.setActive(arg_11_0.viewGO, true)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
	end
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.addUIClickAudio(arg_12_0._btnaccept.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	gohelper.addUIClickAudio(arg_12_0._btnacceptagain.gameObject, AudioEnum.UI.UI_checkpoint_Insight_Click)
	arg_12_0._simagebg1:LoadImage(ResUrl.getMeilanniIcon("bg_beijing5"))
	arg_12_0._simagemask:LoadImage(ResUrl.getMeilanniIcon("bg_yinying"))

	arg_12_0._acceptAgainAnimator = gohelper.findChild(arg_12_0._btnacceptagain.gameObject, "acceptagain"):GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._acceptAnimator = gohelper.findChild(arg_12_0._btnaccept.gameObject, "accept"):GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._acceptClick = SLFramework.UGUI.UIClickListener.Get(arg_12_0._btnaccept.gameObject)

	arg_12_0._acceptClick:AddClickDownListener(arg_12_0._acceptClickDown, arg_12_0)
	arg_12_0._acceptClick:AddClickUpListener(arg_12_0._acceptClickUp, arg_12_0)

	arg_12_0._acceptAgainClick = SLFramework.UGUI.UIClickListener.Get(arg_12_0._btnacceptagain.gameObject)

	arg_12_0._acceptAgainClick:AddClickDownListener(arg_12_0._acceptAgainClickDown, arg_12_0)
	arg_12_0._acceptAgainClick:AddClickUpListener(arg_12_0._acceptAgainClickUp, arg_12_0)
end

function var_0_0._acceptAgainClickDown(arg_13_0)
	arg_13_0._acceptAgainAnimator:Play("clickdown")
end

function var_0_0._acceptAgainClickUp(arg_14_0)
	arg_14_0._acceptAgainAnimator:Play("clickup")
end

function var_0_0._acceptClickDown(arg_15_0)
	arg_15_0._acceptAnimator:Play("clickdown")
end

function var_0_0._acceptClickUp(arg_16_0)
	arg_16_0._acceptAnimator:Play("clickup")
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._mapId = arg_18_0.viewParam.mapId
	arg_18_0._showExhibits = arg_18_0.viewParam.showExhibits

	arg_18_0:_checkEnterMapStory()

	arg_18_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_18_0._mapId)
	arg_18_0._mapConfig = lua_activity108_map.configDict[arg_18_0._mapId]
	arg_18_0._ruleGoList = arg_18_0:getUserDataTb_()
	arg_18_0._txtexhibitsdesc.text = arg_18_0._mapConfig.content
	arg_18_0._txtexhibitsname.text = arg_18_0._mapConfig.title
	arg_18_0._txttrustee.text = arg_18_0._mapConfig.consignor
	arg_18_0._txtactioninfo.text = arg_18_0._mapConfig.actContent

	local var_18_0 = not arg_18_0._mapInfo or not arg_18_0._mapInfo:checkFinish()

	gohelper.setActive(arg_18_0._btnaccept.gameObject, var_18_0)
	gohelper.setActive(arg_18_0._btnacceptagain.gameObject, not var_18_0)

	if arg_18_0._showExhibits then
		gohelper.setActive(arg_18_0._btnaccept.gameObject, false)
	end

	local var_18_1 = MeilanniConfig.instance:getLastEpisode(arg_18_0._mapId)

	if arg_18_0._mapId <= 102 then
		arg_18_0._txtdate.text = formatLuaLang("meilanni_total_day", var_18_1.day)
	else
		arg_18_0._txtdate.text = formatLuaLang("meilanni_total_day2", var_18_1.day)
	end

	arg_18_0._simageexhibitsicon:LoadImage(ResUrl.getMeilanniIcon(arg_18_0._mapConfig.exhibits))
	arg_18_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_18_0._resetMap, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_18_0._onCloseView, arg_18_0)
end

function var_0_0._resetMap(arg_19_0)
	arg_19_0:closeThis()
	MeilanniController.instance:openMeilanniView({
		mapId = arg_19_0._mapId
	})
end

function var_0_0.onClose(arg_20_0)
	arg_20_0._simageexhibitsicon:UnLoadImage()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg1:UnLoadImage()
	arg_21_0._simagemask:UnLoadImage()
	arg_21_0._acceptClick:RemoveClickDownListener()
	arg_21_0._acceptClick:RemoveClickUpListener()
	arg_21_0._acceptAgainClick:RemoveClickDownListener()
	arg_21_0._acceptAgainClick:RemoveClickUpListener()
end

return var_0_0
