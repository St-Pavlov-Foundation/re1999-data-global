module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyResultView", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goAnalyze = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Analyze/#txt_Desc")
	arg_1_0._simageAbstractSystem = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem")
	arg_1_0._imagePlanetSun = gohelper.findChildImage(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#image_PlanetSun")
	arg_1_0._goshuixing = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_shuixing")
	arg_1_0._gojinxing = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_jinxing")
	arg_1_0._goyueliang = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_yueliang")
	arg_1_0._gohuoxing = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_huoxing")
	arg_1_0._gomuxing = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_muxing")
	arg_1_0._gotuxing = gohelper.findChild(arg_1_0.viewGO, "#go_Analyze/#simage_AbstractSystem/#go_tuxing")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "#go_Rewards")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Rewards/#scroll_Rewards")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_Rewards/#scroll_Rewards/Viewport/#go_content")
	arg_1_0._btnAstrologyAgain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Rewards/#btn_AstrologyAgain")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Rewards/#btn_Claim")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_Rewards/#btn_Claim/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAstrologyAgain:AddClickListener(arg_2_0._btnAstrologyAgainOnClick, arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAstrologyAgain:RemoveClickListener()
	arg_3_0._btnClaim:RemoveClickListener()
end

function var_0_0._btnAstrologyAgainOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg1, MsgBoxEnum.BoxType.Yes_No, function()
		Activity126Rpc.instance:sendResetProgressRequest(VersionActivity1_3Enum.ActivityId.Act310)
	end)
end

function var_0_0._btnClaimOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity126_msg3, MsgBoxEnum.BoxType.Yes_No, function()
		local var_7_0 = Activity126Model.instance:receiveHoroscope()

		Activity126Rpc.instance:sendGetHoroscopeRequest(VersionActivity1_3Enum.ActivityId.Act310, var_7_0)
	end)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0:_initPlanets()
	arg_8_0:addEventCb(Activity126Controller.instance, Activity126Event.onResetProgressReply, arg_8_0._onResetProgressReply, arg_8_0)
	arg_8_0:addEventCb(Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, arg_8_0._onGetHoroscopeReply, arg_8_0)
	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.Activity1_3RedDot5)
end

function var_0_0._initPlanets(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(VersionActivity1_3AstrologyEnum.Planet) do
		if iter_9_1 >= VersionActivity1_3AstrologyEnum.Planet.shuixing then
			local var_9_0 = arg_9_0["_go" .. iter_9_0]
			local var_9_1 = VersionActivity1_3AstrologyModel.instance:getPlanetMo(iter_9_1)

			arg_9_0:_rotate(var_9_0, var_9_1.angle)
		end
	end
end

function var_0_0._rotate(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = (360 - arg_10_2) * Mathf.Deg2Rad
	local var_10_1 = math.abs(recthelper.getAnchorY(arg_10_1.transform))
	local var_10_2 = var_10_1 * Mathf.Cos(var_10_0)
	local var_10_3 = var_10_1 * Mathf.Sin(var_10_0)

	recthelper.setAnchor(arg_10_1.transform, var_10_2, var_10_3)
end

function var_0_0._onGetHoroscopeReply(arg_11_0)
	arg_11_0:_checkResult()
end

function var_0_0._onResetProgressReply(arg_12_0)
	arg_12_0.viewContainer:switchTab(1)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_checkResult()
	arg_14_0:_showRewardList()
	arg_14_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("open", 0, 0)
end

function var_0_0._checkResult(arg_15_0)
	local var_15_0 = Activity126Model.instance:receiveGetHoroscope()
	local var_15_1 = var_15_0 and var_15_0 > 0

	gohelper.setActive(arg_15_0._btnAstrologyAgain, not var_15_1)
	gohelper.setActive(arg_15_0._btnClaim, not var_15_1)
end

function var_0_0._showRewardList(arg_16_0)
	local var_16_0 = Activity126Model.instance:receiveHoroscope()

	if not var_16_0 or var_16_0 <= 0 then
		return
	end

	gohelper.destroyAllChildren(arg_16_0._gocontent)

	local var_16_1 = Activity126Config.instance:getHoroscopeConfig(VersionActivity1_3Enum.ActivityId.Act310, var_16_0)
	local var_16_2 = GameUtil.splitString2(var_16_1.bonus, true)

	for iter_16_0, iter_16_1 in ipairs(var_16_2) do
		IconMgr.instance:getCommonPropItemIcon(arg_16_0._gocontent):setMOValue(iter_16_1[1], iter_16_1[2], iter_16_1[3])
	end

	arg_16_0._txtDesc.text = var_16_1.desc
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
