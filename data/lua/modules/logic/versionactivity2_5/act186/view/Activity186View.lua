module("modules.logic.versionactivity2_5.act186.view.Activity186View", package.seeall)

local var_0_0 = class("Activity186View", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnShop")
	arg_1_0.goShopCanget = gohelper.findChild(arg_1_0.viewGO, "root/btnShop/canGet")
	arg_1_0.goShopTime = gohelper.findChild(arg_1_0.viewGO, "root/btnShop/time")
	arg_1_0.txtShopTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnShop/time/txt")
	arg_1_0.btnNewYear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnNewYear")

	gohelper.setActive(arg_1_0.btnNewYear, false)

	arg_1_0.goNewYearFinish = gohelper.findChild(arg_1_0.viewGO, "root/btnNewYear/finish")
	arg_1_0.goNewYearLock = gohelper.findChild(arg_1_0.viewGO, "root/btnNewYear/lock")
	arg_1_0.txtNewYearLock = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnNewYear/lock/txt")
	arg_1_0.goNewYearTime = gohelper.findChild(arg_1_0.viewGO, "root/btnNewYear/time")
	arg_1_0.txtNewYearTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnNewYear/time/txt")
	arg_1_0.btnYuanxiao = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnYuanxiao")
	arg_1_0.goYuanxiaoFinish = gohelper.findChild(arg_1_0.viewGO, "root/btnYuanxiao/finish")
	arg_1_0.goYuanxiaoLock = gohelper.findChild(arg_1_0.viewGO, "root/btnYuanxiao/lock")
	arg_1_0.txtYuanxiaoLock = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnYuanxiao/lock/txt")
	arg_1_0.goYuanxiaoTime = gohelper.findChild(arg_1_0.viewGO, "root/btnYuanxiao/time")
	arg_1_0.txtYuanxiaoTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnYuanxiao/time/txt")
	arg_1_0.btnMainActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnMainActivity")
	arg_1_0.btnGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnGame")
	arg_1_0.btnAvg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnAvg")
	arg_1_0.txtStage = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnMainActivity/stage/Text")
	arg_1_0.txtStageName = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/btnMainActivity/txt")
	arg_1_0.goNewYearReddot = gohelper.findChild(arg_1_0.viewGO, "root/btnNewYear/reddot")
	arg_1_0.goYuanxiaoReddot = gohelper.findChild(arg_1_0.viewGO, "root/btnYuanxiao/reddot")
	arg_1_0.goMainActivityReddot = gohelper.findChild(arg_1_0.viewGO, "root/btnMainActivity/reddot")
	arg_1_0.newYearReddot = RedDotController.instance:addNotEventRedDot(arg_1_0.goNewYearReddot, arg_1_0._onRefreshNewYearRed, arg_1_0)
	arg_1_0.yuanxiaoReddot = RedDotController.instance:addRedDot(arg_1_0.goYuanxiaoReddot, RedDotEnum.DotNode.V2a5_Act187, 0)
	arg_1_0.mainActivityReddot = RedDotController.instance:addRedDot(arg_1_0.goMainActivityReddot, RedDotEnum.DotNode.V2a5_Act186Task, 0)
	arg_1_0.mainActivityAnim = gohelper.findChildComponent(arg_1_0.viewGO, "root/btnMainActivity", gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnShop, arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnNewYear, arg_2_0.onClickBtnNewYear, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnYuanxiao, arg_2_0.onClickBtnYuanxiao, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMainActivity, arg_2_0.onClickBtnMainActivity, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnGame, arg_2_0.onClickBtnGame, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAvg, arg_2_0.onClickBtnAvg, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, arg_2_0.onFinishGame, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.GetOnceBonus, arg_2_0.onGetOnceBonus, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0.onRefreshRed, arg_2_0)
	arg_2_0:addEventCb(Activity186Controller.instance, Activity186Event.RefreshRed, arg_2_0.onRefreshRed, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshRed(arg_5_0)
	arg_5_0.newYearReddot:refreshRedDot()
	arg_5_0.yuanxiaoReddot:refreshDot()
	arg_5_0.mainActivityReddot:refreshDot()
end

function var_0_0.onClickBtnAvg(arg_6_0)
	if not arg_6_0.actMo then
		return
	end

	if not arg_6_0.actMo:isCanShowAvgBtn() then
		return
	end

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 1)

	local var_6_0 = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.AvgStoryId)

	StoryController.instance:playStory(var_6_0, nil, arg_6_0.onStoryEnd, arg_6_0)
end

function var_0_0.onClickBtnGame(arg_7_0)
	Activity186Controller.instance:checkEnterGame(arg_7_0.actId, true)
end

function var_0_0.onClickBtnYuanxiao(arg_8_0)
	Activity187Controller.instance:openAct187View()
end

function var_0_0.onClickBtnMainActivity(arg_9_0)
	Activity186Controller.instance:openTaskView(arg_9_0.actId)
end

function var_0_0.onClickBtnNewYear(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_Act186Sign)

	if var_10_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_10_1 then
			GameFacade.showToast(var_10_1, var_10_2)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.Activity186SignView, {
		actId = arg_10_0.actId
	})
end

function var_0_0._btngotoOnClick(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_FurnaceTreasure)

	if var_11_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_11_1 then
			GameFacade.showToast(var_11_1, var_11_2)
		end

		return
	end

	local var_11_3 = FurnaceTreasureConfig.instance:getJumpId(ActivityEnum.Activity.V2a5_FurnaceTreasure)

	if var_11_3 and var_11_3 ~= 0 then
		GameFacade.jump(var_11_3)
	end
end

function var_0_0.onGetOnceBonus(arg_12_0)
	arg_12_0:_showDeadline()
end

function var_0_0.onFinishGame(arg_13_0)
	arg_13_0:refreshView()
end

function var_0_0.onUpdateInfo(arg_14_0)
	arg_14_0:refreshView()
	arg_14_0:refreshMainActivityAnim()
end

function var_0_0.onUpdateParam(arg_15_0)
	arg_15_0:refreshParam()
	arg_15_0:refreshView()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0.isFirstEnterView = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 0) == 0

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 1)
	arg_16_0:refreshParam()
	arg_16_0:refreshView()

	if not arg_16_0.isFirstEnterView then
		arg_16_0:checkGame()
	end

	arg_16_0:_showDeadline()
	arg_16_0:refreshMainActivityAnim()
end

function var_0_0.refreshParam(arg_17_0)
	arg_17_0.actId = arg_17_0.viewParam.actId
	arg_17_0.actMo = Activity186Model.instance:getById(arg_17_0.actId)
end

function var_0_0.refreshView(arg_18_0)
	arg_18_0:_refreshGameBtn()
end

function var_0_0._refreshGameBtn(arg_19_0)
	if not arg_19_0.actMo then
		return
	end

	local var_19_0 = arg_19_0.actMo:hasGameCanPlay()

	arg_19_0:setGameVisable(var_19_0)
end

function var_0_0.setGameVisable(arg_20_0, arg_20_1)
	if arg_20_0.gameVisable == arg_20_1 then
		return
	end

	arg_20_0.gameVisable = arg_20_1

	gohelper.setActive(arg_20_0.btnGame, arg_20_1)
end

function var_0_0.refreshStageName(arg_21_0, arg_21_1)
	arg_21_0.txtStage.text = formatLuaLang("Activity186View_txtStage", GameUtil.getNum2Chinese(arg_21_1))
	arg_21_0.txtStageName.text = luaLang(string.format("activity186view_txt_stage%s", arg_21_1))
end

function var_0_0.checkGame(arg_22_0)
	Activity186Controller.instance:checkEnterGame(arg_22_0.actId)
end

function var_0_0._showDeadline(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._onRefreshTime, arg_23_0)
	TaskDispatcher.runRepeat(arg_23_0._onRefreshTime, arg_23_0, 1)
	arg_23_0:_onRefreshTime()
end

function var_0_0._onRefreshTime(arg_24_0)
	arg_24_0:_refreshShopTime()
	arg_24_0:_refreshAvgBtn()
	arg_24_0:_refreshNewYearTime()
	arg_24_0:_refreshYuanxiaoTime()
	arg_24_0:_refreshGameBtn()
end

function var_0_0._refreshAvgBtn(arg_25_0)
	local var_25_0 = arg_25_0.actMo:isCanShowAvgBtn()

	arg_25_0:setAvgVisable(var_25_0)

	if arg_25_0.actMo:isCanPlayAvgStory() then
		arg_25_0:onClickBtnAvg()
	end
end

function var_0_0._refreshShopTime(arg_26_0)
	local var_26_0 = ActivityHelper.getActivityStatus(ActivityEnum.Activity.V2a5_FurnaceTreasure)
	local var_26_1 = false

	if var_26_0 == ActivityEnum.ActivityStatus.Normal then
		local var_26_2 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure)

		if var_26_2 then
			for iter_26_0, iter_26_1 in pairs(var_26_2.infos) do
				if iter_26_1.value > 0 then
					var_26_1 = true

					break
				end
			end
		end
	end

	gohelper.setActive(arg_26_0.goShopCanget, var_26_1)
	gohelper.setActive(arg_26_0.goShopTime, not var_26_1)

	if not var_26_1 then
		arg_26_0.txtShopTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_FurnaceTreasure, true)
	end
end

function var_0_0._refreshNewYearTime(arg_27_0)
	local var_27_0 = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.V2a5_Act186Sign) * 0.001 - ServerTime.now()

	if var_27_0 > 0 then
		local var_27_1 = math.ceil(var_27_0 / TimeUtil.OneDaySecond)
		local var_27_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), var_27_1)

		arg_27_0.txtNewYearLock.text = var_27_2

		gohelper.setActive(arg_27_0.goNewYearLock, true)
		gohelper.setActive(arg_27_0.goNewYearFinish, false)
		gohelper.setActive(arg_27_0.goNewYearTime, false)
	else
		gohelper.setActive(arg_27_0.goNewYearLock, false)

		local var_27_3 = ActivityModel.instance:getActEndTime(ActivityEnum.Activity.V2a5_Act186Sign) * 0.001 - ServerTime.now() <= 0

		gohelper.setActive(arg_27_0.goNewYearFinish, var_27_3)
		gohelper.setActive(arg_27_0.goNewYearTime, not var_27_3)

		if not var_27_3 then
			arg_27_0.txtNewYearTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_Act186Sign, true)
		end
	end
end

function var_0_0._refreshYuanxiaoTime(arg_28_0)
	local var_28_0 = Activity187Model.instance:getAct187Id()
	local var_28_1 = ActivityModel.instance:getActStartTime(var_28_0) * 0.001 - ServerTime.now()

	if var_28_1 > 0 then
		local var_28_2 = math.ceil(var_28_1 / TimeUtil.OneDaySecond)
		local var_28_3 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), var_28_2)

		arg_28_0.txtYuanxiaoLock.text = var_28_3

		gohelper.setActive(arg_28_0.goYuanxiaoLock, true)
		gohelper.setActive(arg_28_0.goYuanxiaoFinish, false)
		gohelper.setActive(arg_28_0.goYuanxiaoTime, false)
	else
		gohelper.setActive(arg_28_0.goYuanxiaoLock, false)

		local var_28_4 = ActivityModel.instance:getActEndTime(var_28_0) * 0.001 - ServerTime.now() <= 0

		gohelper.setActive(arg_28_0.goYuanxiaoFinish, var_28_4)
		gohelper.setActive(arg_28_0.goYuanxiaoTime, not var_28_4)

		if not var_28_4 then
			arg_28_0.txtYuanxiaoTime.text = ActivityHelper.getActivityRemainTimeStr(var_28_0, true)
		end
	end
end

function var_0_0.setAvgVisable(arg_29_0, arg_29_1)
	if arg_29_0.avgVisable == arg_29_1 then
		return
	end

	arg_29_0.avgVisable = arg_29_1

	gohelper.setActive(arg_29_0.btnAvg, arg_29_1)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function var_0_0.onStoryEnd(arg_30_0)
	Activity186Rpc.instance:sendGetAct186OnceBonusRequest(arg_30_0.actId)
	ViewMgr.instance:openView(ViewName.Activity186GiftView)
end

function var_0_0._onRefreshNewYearRed(arg_31_0)
	return Activity186Model.instance:isShowSignRed()
end

function var_0_0.refreshMainActivityAnim(arg_32_0)
	if not arg_32_0.actMo then
		return
	end

	local var_32_0 = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, 0)
	local var_32_1 = arg_32_0.actMo.currentStage

	if var_32_0 ~= var_32_1 then
		Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, var_32_1)
		arg_32_0:refreshStageName(var_32_0 ~= 0 and var_32_0 or 1)
		arg_32_0.mainActivityAnim:Play("refresh")
		TaskDispatcher.runDelay(arg_32_0._refreshRealStage, arg_32_0, 0.17)
	else
		arg_32_0:_refreshRealStage()
		arg_32_0.mainActivityAnim:Play("idle")
	end
end

function var_0_0._refreshRealStage(arg_33_0)
	if not arg_33_0.actMo then
		return
	end

	arg_33_0:refreshStageName(arg_33_0.actMo.currentStage)
end

function var_0_0.onClose(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._onRefreshTime, arg_34_0)
end

function var_0_0.onDestroyView(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onRefreshTime, arg_35_0)
	ViewMgr.instance:closeView(ViewName.Activity186TaskView)
	ViewMgr.instance:closeView(ViewName.Activity186SignView)
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

return var_0_0
