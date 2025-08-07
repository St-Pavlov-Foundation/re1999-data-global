module("modules.logic.sp01.act205.view.Act205GameStartView", package.seeall)

local var_0_0 = class("Act205GameStartView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtGameName = gohelper.findChildText(arg_1_0.viewGO, "Info/#txt_GameName")
	arg_1_0._txtGameDesc = gohelper.findChildText(arg_1_0.viewGO, "Info/Scroll View/Viewport/#txt_GameDesc")
	arg_1_0._simageGamePic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Info/#simage_GamePic")
	arg_1_0._txtTargetDesc = gohelper.findChildText(arg_1_0.viewGO, "Target/Scroll View/Viewport/#txt_TargetDesc")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Start")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_normal")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_lock")
	arg_1_0._gogameTimes = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_gameTimes")
	arg_1_0._txtgameTimes = gohelper.findChildText(arg_1_0.viewGO, "#btn_Start/#go_gameTimes/#txt_gameTimes")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0:addEventCb(Act205Controller.instance, Act205Event.OnDailyRefresh, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Act205Controller.instance, Act205Event.OnFinishGame, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, Act205Event.OnInfoUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, arg_2_0.refreshUI, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.checkViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0:removeEventCb(Act205Controller.instance, Act205Event.OnDailyRefresh, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Act205Controller.instance, Act205Event.OnFinishGame, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, Act205Event.OnInfoUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnInfoUpdate, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(AssassinChaseController.instance, AssassinChaseEvent.OnGetReward, arg_3_0.refreshUI, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.checkViewClose, arg_3_0)
end

function var_0_0._btnStartOnClick(arg_4_0)
	if arg_4_0.gameStageId == Act205Enum.GameStageId.Chase then
		AssassinChaseController.instance:openAssassinChaseView(arg_4_0.activityId)
	else
		if not Act205Model.instance:isGameStageOpen(arg_4_0.gameStageId, true) then
			return
		elseif arg_4_0.curGameTimes <= 0 then
			GameFacade.showToast(ToastEnum.Act205DailyRefresh)

			return
		end

		if arg_4_0.gameStageId == Act205Enum.GameStageId.Ocean then
			Act205Controller.instance:openOceanSelectView({
				gameStageId = arg_4_0.gameStageId
			})
		elseif arg_4_0.gameStageId == Act205Enum.GameStageId.Card then
			Act205CardController.instance:enterCardGame()
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.titleGOMap = arg_5_0:getUserDataTb_()

	for iter_5_0 = Act205Enum.GameStageId.Card, Act205Enum.GameStageId.Chase do
		arg_5_0.titleGOMap[iter_5_0] = gohelper.findChild(arg_5_0.viewGO, "Info/Title/#go_Title" .. iter_5_0)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.activityId = arg_7_0.viewParam.activityId
	arg_7_0.gameStageId = arg_7_0.viewParam.gameStageId

	if arg_7_0.gameStageId == Act205Enum.GameStageId.Chase then
		AssassinChaseModel.instance:setCurActivityId(arg_7_0.activityId)

		arg_7_0.stageConfig = AssassinChaseConfig.instance:getDescConfig(arg_7_0.activityId, arg_7_0.gameStageId)
	else
		Act205Model.instance:setGameStageId(arg_7_0.gameStageId)

		arg_7_0.stageConfig = Act205Config.instance:getStageConfig(arg_7_0.activityId, arg_7_0.gameStageId)
	end

	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0
	local var_8_1

	if arg_8_0.gameStageId == Act205Enum.GameStageId.Chase then
		local var_8_2 = AssassinChaseConfig.instance:getConstConfig(AssassinChaseEnum.ConstId.TotalGameTime)
		local var_8_3 = tostring(var_8_2.value)
		local var_8_4 = AssassinChaseModel.instance:getActInfo(arg_8_0.activityId)
		local var_8_5 = AssassinChaseModel.instance:isActOpen(arg_8_0.activityId, false, false)
		local var_8_6 = AssassinChaseModel.instance:isActOpen(arg_8_0.activityId, false, true)
		local var_8_7 = var_8_5 or var_8_6 and var_8_4:canGetBonus()

		gohelper.setActive(arg_8_0._gogameTimes, var_8_5)

		if var_8_5 then
			var_8_0 = var_8_4:isSelect() and 0 or var_8_3
			arg_8_0._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_canPlayGameTimes"), var_8_0, var_8_3)
		end

		gohelper.setActive(arg_8_0._golock, not var_8_7)
		gohelper.setActive(arg_8_0._gonormal, var_8_7)
	else
		local var_8_8 = arg_8_0.stageConfig.times

		gohelper.setActive(arg_8_0._gogameTimes, true)

		local var_8_9 = Act205Model.instance:getGameInfoMo(arg_8_0.activityId, arg_8_0.gameStageId)

		var_8_0 = var_8_9 and var_8_9.haveGameCount or 0
		arg_8_0._txtgameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_canPlayGameTimes"), var_8_0, var_8_8)

		gohelper.setActive(arg_8_0._golock, var_8_0 <= 0 or not var_8_9)
		gohelper.setActive(arg_8_0._gonormal, var_8_0 > 0 and var_8_9)
	end

	arg_8_0._txtGameName.text = arg_8_0.stageConfig.name
	arg_8_0._txtGameDesc.text = arg_8_0.stageConfig.desc
	arg_8_0._txtTargetDesc.text = arg_8_0.stageConfig.targetDesc
	arg_8_0.curGameTimes = var_8_0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.titleGOMap) do
		gohelper.setActive(iter_8_1, iter_8_0 == arg_8_0.gameStageId)
	end

	arg_8_0._simageGamePic:LoadImage(ResUrl.getV2a9ActSingleBg("gamestart_pic0" .. arg_8_0.gameStageId))
	arg_8_0:refreshOceanNewUnlockRedDot()
end

function var_0_0.refreshOceanNewUnlockRedDot(arg_9_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a9_Act205OceanOpen, 0) then
		Activity204Controller.instance:setPlayerPrefs(PlayerPrefsKey.Activity204OceanOpenReddot, 1)
		Activity204Controller.instance:checkOceanNewOpenRedDot()
	end
end

function var_0_0.checkViewClose(arg_10_0)
	local var_10_0 = true

	if arg_10_0.gameStageId == Act205Enum.GameStageId.Chase then
		local var_10_1 = AssassinChaseModel.instance:getActInfo(arg_10_0.activityId)
		local var_10_2 = AssassinChaseModel.instance:isActOpen(arg_10_0.activityId, false, false)
		local var_10_3 = AssassinChaseModel.instance:isActOpen(arg_10_0.activityId, false, true)

		var_10_0 = var_10_2 or var_10_3 and var_10_1:canGetBonus()
	else
		var_10_0 = Act205Model.instance:isGameStageOpen(arg_10_0.gameStageId, false)
	end

	if not var_10_0 then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simageGamePic:UnLoadImage()
end

return var_0_0
