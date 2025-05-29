module("modules.logic.main.view.MainThumbnailView", package.seeall)

local var_0_0 = class("MainThumbnailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._goplayerinfo = gohelper.findChild(arg_1_0.viewGO, "#go_playerinfo")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_signature")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_playerinfo/#txt_name")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_playerinfo/#txt_level")
	arg_1_0._txtid = gohelper.findChildText(arg_1_0.viewGO, "#go_playerinfo/#txt_id")
	arg_1_0._gobanner = gohelper.findChild(arg_1_0.viewGO, "#go_banner")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_slider")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannerscroll")
	arg_1_0._gobannercontent = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannercontent")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_playerinfo/#btn_detail")
	arg_1_0._goplayinforeddotparent = gohelper.findChild(arg_1_0.viewGO, "#go_playerinfo/#btn_detail/#go_playinforeddot")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "btns/#go_scroll")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "btns/#go_content")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnblank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_blank")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnblank:AddClickListener(arg_2_0._btnblankOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnblank:RemoveClickListener()
end

function var_0_0._btnblankOnClick(arg_4_0)
	if arg_4_0._animator.enabled or arg_4_0._cameraAnimator.enabled then
		if not arg_4_0._checkCloseTime then
			arg_4_0._checkCloseTime = Time.realtimeSinceStartup

			return
		end

		if Time.realtimeSinceStartup - arg_4_0._checkCloseTime <= 2 then
			return
		end
	end

	arg_4_0:closeThis()
end

function var_0_0._btndetailOnClick(arg_5_0)
	local var_5_0 = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(var_5_0, true)
end

function var_0_0._btnswitchOnClick(arg_6_0)
	UIBlockMgr.instance:startBlock("MainThumbnailView_CloseAnim")
	SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO):Play(UIAnimationName.Close, arg_6_0.onPlayCloseTransitionFinish, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onPlayCloseTransitionFinish, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.onPlayCloseTransitionFinish, arg_6_0, 0.3)
end

function var_0_0.onPlayCloseTransitionFinish(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onPlayCloseTransitionFinish, arg_7_0)
	UIBlockMgr.instance:endBlock("MainThumbnailView_CloseAnim")
	ViewMgr.instance:openTabView(ViewName.MainSwitchView, nil, nil, 1)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:_onChangePlayerName()

	arg_8_0._txtlevel.text = string.format("<size=19>Lv</size>.%s", PlayerModel.instance:getPlayinfo().level)
	arg_8_0._txtid.text = string.format("ID:%s", PlayerModel.instance:getPlayinfo().userId)

	arg_8_0._simageleftbg:LoadImage(ResUrl.getMainImage("bg_hd"))

	arg_8_0._animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_8_0._simagelogoGo = gohelper.findChild(arg_8_0.viewGO, "#simage_logo")
	arg_8_0._simageactbgGo = gohelper.findChild(arg_8_0.viewGO, "#simage_actbg")

	arg_8_0:RefreshSignature()
	gohelper.addUIClickAudio(arg_8_0._btndetail.gameObject, AudioEnum.UI.Play_UI_Magazines)
end

function var_0_0._getFormatStr(arg_9_0, arg_9_1)
	if string.nilorempty(arg_9_1) then
		return ""
	end

	local var_9_0 = GameUtil.utf8sub(arg_9_1, 1, 1)
	local var_9_1 = ""

	if GameUtil.utf8len(arg_9_1) >= 2 then
		var_9_1 = GameUtil.utf8sub(arg_9_1, 2, GameUtil.utf8len(arg_9_1) - 1)
	end

	return string.format("<size=62>%s</size>%s", var_9_0, var_9_1)
end

function var_0_0.onUpdate(arg_10_0)
	return
end

function var_0_0.RefreshSignature(arg_11_0)
	local var_11_0 = CharacterSwitchListModel.instance:getMainHero()
	local var_11_1 = HeroModel.instance:getByHeroId(var_11_0)

	if not var_11_1 then
		return
	end

	arg_11_0._simagesignature:LoadImage(ResUrl.getSignature(var_11_1.config.signature))
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.MainThumbnailSignature, arg_12_0.RefreshSignature, arg_12_0)
	arg_12_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, arg_12_0._onChangePlayerName, arg_12_0)
	arg_12_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_12_0._freshBtns, arg_12_0)

	arg_12_0.playerInfoRedDot = RedDotController.instance:addNotEventRedDot(arg_12_0._goplayinforeddotparent, PlayerModel.isHasAssistReward, PlayerModel.instance)

	arg_12_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_12_0.refreshRedDot, arg_12_0)
	arg_12_0:_freshBtns()
end

function var_0_0._freshBtns(arg_13_0)
	arg_13_0:_checkActivityImgVisible()
end

function var_0_0._checkActivityImgVisible(arg_14_0)
	local var_14_0 = ActivityModel.showActivityEffect()
	local var_14_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_14_2 = true

	if var_14_1 then
		for iter_14_0, iter_14_1 in ipairs(var_14_1.mainThumbnailView) do
			local var_14_3 = gohelper.findChild(arg_14_0.viewGO, iter_14_1)

			if var_14_3 then
				gohelper.setActive(var_14_3, var_14_0)

				var_14_2 = var_14_0
			end
		end
	end

	local var_14_4 = var_14_0 and var_14_1.isShowLogo or false
	local var_14_5 = var_14_0 and var_14_1.mainThumbnailViewActBg or false

	gohelper.setActive(arg_14_0._simageleftbg, var_14_2)
	gohelper.setActive(arg_14_0._simagelogoGo, var_14_4)
	gohelper.setActive(arg_14_0._simageactbgGo, var_14_5)
end

function var_0_0.refreshRedDot(arg_15_0)
	if not arg_15_0.playerInfoRedDot then
		return
	end

	arg_15_0.playerInfoRedDot:refreshRedDot()
end

function var_0_0._onChangePlayerName(arg_16_0)
	local var_16_0 = PlayerModel.instance:getPlayinfo().name

	arg_16_0._txtname.text = arg_16_0:_getFormatStr(var_16_0)
end

function var_0_0.onClose(arg_17_0)
	UIBlockMgr.instance:endBlock("MainThumbnailView_CloseAnim")
	arg_17_0:removeEventCb(CharacterController.instance, CharacterEvent.MainThumbnailSignature, arg_17_0.RefreshSignature, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simagesignature:UnLoadImage()
	arg_18_0._simageleftbg:UnLoadImage()
end

return var_0_0
