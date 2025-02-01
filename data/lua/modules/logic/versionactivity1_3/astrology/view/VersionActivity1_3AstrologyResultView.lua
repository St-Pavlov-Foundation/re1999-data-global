module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyResultView", package.seeall)

slot0 = class("VersionActivity1_3AstrologyResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._goAnalyze = gohelper.findChild(slot0.viewGO, "#go_Analyze")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_Analyze/#txt_Desc")
	slot0._simageAbstractSystem = gohelper.findChildSingleImage(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem")
	slot0._imagePlanetSun = gohelper.findChildImage(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#image_PlanetSun")
	slot0._goshuixing = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_shuixing")
	slot0._gojinxing = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_jinxing")
	slot0._goyueliang = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_yueliang")
	slot0._gohuoxing = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_huoxing")
	slot0._gomuxing = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_muxing")
	slot0._gotuxing = gohelper.findChild(slot0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_tuxing")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "#go_Rewards")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_Rewards/#scroll_Rewards")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_Rewards/#scroll_Rewards/Viewport/#go_content")
	slot0._btnAstrologyAgain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Rewards/#btn_AstrologyAgain")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Rewards/#btn_Claim")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_Rewards/#btn_Claim/#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnAstrologyAgain:AddClickListener(slot0._btnAstrologyAgainOnClick, slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAstrologyAgain:RemoveClickListener()
	slot0._btnClaim:RemoveClickListener()
end

function slot0._btnAstrologyAgainOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg1, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity126Rpc.instance:sendResetProgressRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end)
end

function slot0._btnClaimOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg3, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity126Rpc.instance:sendGetHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, Activity126Model.instance:receiveHoroscope())
	end)
end

function slot0._editableInitView(slot0)
	slot0:_initPlanets()
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, slot0._onResetProgressReply, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, slot0._onGetHoroscopeReply, slot0)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.Activity1_3RedDot5)
end

function slot0._initPlanets(slot0)
	for slot4, slot5 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		if VersionActivity1_3AstrologyEnum.Planet.shuixing <= slot5 then
			slot0:_rotate(slot0["_go" .. slot4], VersionActivity1_3AstrologyModel.instance:getPlanetMo(slot5).angle)
		end
	end
end

function slot0._rotate(slot0, slot1, slot2)
	slot3 = (360 - slot2) * Mathf.Deg2Rad
	slot4 = math.abs(recthelper.getAnchorY(slot1.transform))

	recthelper.setAnchor(slot1.transform, slot4 * Mathf.Cos(slot3), slot4 * Mathf.Sin(slot3))
end

function slot0._onGetHoroscopeReply(slot0)
	slot0:_checkResult()
end

function slot0._onResetProgressReply(slot0)
	slot0.viewContainer:switchTab(1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_checkResult()
	slot0:_showRewardList()
	slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)
end

function slot0._checkResult(slot0)
	slot2 = Activity126Model.instance:receiveGetHoroscope() and slot1 > 0

	gohelper.setActive(slot0._btnAstrologyAgain, not slot2)
	gohelper.setActive(slot0._btnClaim, not slot2)
end

function slot0._showRewardList(slot0)
	if not Activity126Model.instance:receiveHoroscope() or slot1 <= 0 then
		return
	end

	gohelper.destroyAllChildren(slot0._gocontent)

	for slot7, slot8 in ipairs(GameUtil.splitString2(Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, slot1).bonus, true)) do
		IconMgr.instance:getCommonPropItemIcon(slot0._gocontent):setMOValue(slot8[1], slot8[2], slot8[3])
	end

	slot0._txtDesc.text = slot2.desc
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
