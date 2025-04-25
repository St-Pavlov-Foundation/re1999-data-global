module("modules.logic.main.view.MainThumbnailView", package.seeall)

slot0 = class("MainThumbnailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._goplayerinfo = gohelper.findChild(slot0.viewGO, "#go_playerinfo")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "#simage_signature")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_playerinfo/#txt_name")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_playerinfo/#txt_level")
	slot0._txtid = gohelper.findChildText(slot0.viewGO, "#go_playerinfo/#txt_id")
	slot0._gobanner = gohelper.findChild(slot0.viewGO, "#go_banner")
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_banner/#go_slider")
	slot0._gobannerscroll = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannerscroll")
	slot0._gobannercontent = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannercontent")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._golightspinecontrol = gohelper.findChild(slot0.viewGO, "#go_lightspinecontrol")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switch")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_playerinfo/#btn_detail")
	slot0._goplayinforeddotparent = gohelper.findChild(slot0.viewGO, "#go_playerinfo/#btn_detail/#go_playinforeddot")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "btns/#go_scroll")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "btns/#go_content")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnblank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_blank")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnblank:AddClickListener(slot0._btnblankOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnswitch:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnblank:RemoveClickListener()
end

function slot0._btnblankOnClick(slot0)
	if slot0._animator.enabled or slot0._cameraAnimator.enabled then
		if not slot0._checkCloseTime then
			slot0._checkCloseTime = Time.realtimeSinceStartup

			return
		end

		if Time.realtimeSinceStartup - slot0._checkCloseTime <= 2 then
			return
		end
	end

	slot0:closeThis()
end

function slot0._btndetailOnClick(slot0)
	PlayerController.instance:openPlayerView(PlayerModel.instance:getPlayinfo(), true)
end

function slot0._btnswitchOnClick(slot0)
	UIBlockMgr.instance:startBlock("MainThumbnailView_CloseAnim")
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play(UIAnimationName.Close, slot0.onPlayCloseTransitionFinish, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 0.3)
end

function slot0.onPlayCloseTransitionFinish(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayCloseTransitionFinish, slot0)
	UIBlockMgr.instance:endBlock("MainThumbnailView_CloseAnim")
	ViewMgr.instance:openTabView(ViewName.MainSwitchView, nil, , 1)
end

function slot0._editableInitView(slot0)
	slot0:_onChangePlayerName()

	slot0._txtlevel.text = string.format("<size=19>Lv</size>.%s", PlayerModel.instance:getPlayinfo().level)
	slot0._txtid.text = string.format("ID:%s", PlayerModel.instance:getPlayinfo().userId)

	slot0._simageleftbg:LoadImage(ResUrl.getMainImage("bg_hd"))

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()

	slot0:RefreshSignature()
	gohelper.addUIClickAudio(slot0._btndetail.gameObject, AudioEnum.UI.Play_UI_Magazines)
end

function slot0._getFormatStr(slot0, slot1)
	if string.nilorempty(slot1) then
		return ""
	end

	slot2 = GameUtil.utf8sub(slot1, 1, 1)
	slot3 = ""

	if GameUtil.utf8len(slot1) >= 2 then
		slot3 = GameUtil.utf8sub(slot1, 2, GameUtil.utf8len(slot1) - 1)
	end

	return string.format("<size=62>%s</size>%s", slot2, slot3)
end

function slot0.onUpdate(slot0)
end

function slot0.RefreshSignature(slot0)
	if not HeroModel.instance:getByHeroId(CharacterSwitchListModel.instance:getMainHero()) then
		return
	end

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot2.config.signature))
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.MainThumbnailSignature, slot0.RefreshSignature, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, slot0._onChangePlayerName, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._freshBtns, slot0)

	slot0.playerInfoRedDot = RedDotController.instance:addNotEventRedDot(slot0._goplayinforeddotparent, PlayerModel.isHasAssistReward, PlayerModel.instance)

	slot0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0.refreshRedDot, slot0)
	slot0:_freshBtns()
end

function slot0._freshBtns(slot0)
	slot0:_checkActivityImgVisible()
end

function slot0._checkActivityImgVisible(slot0)
	slot1 = ActivityModel.showActivityEffect()
	slot3 = true

	if ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot7, slot8 in ipairs(slot2.mainThumbnailView) do
			if gohelper.findChild(slot0.viewGO, slot8) then
				gohelper.setActive(slot9, slot1)

				slot3 = slot1
			end
		end
	end

	gohelper.setActive(slot0._simageleftbg, slot3)
end

function slot0.refreshRedDot(slot0)
	if not slot0.playerInfoRedDot then
		return
	end

	slot0.playerInfoRedDot:refreshRedDot()
end

function slot0._onChangePlayerName(slot0)
	slot0._txtname.text = slot0:_getFormatStr(PlayerModel.instance:getPlayinfo().name)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("MainThumbnailView_CloseAnim")
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.MainThumbnailSignature, slot0.RefreshSignature, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagesignature:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
end

return slot0
