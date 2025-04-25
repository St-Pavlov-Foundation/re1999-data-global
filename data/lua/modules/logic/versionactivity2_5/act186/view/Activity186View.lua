module("modules.logic.versionactivity2_5.act186.view.Activity186View", package.seeall)

slot0 = class("Activity186View", BaseView)

function slot0.onInitView(slot0)
	slot0.btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnShop")
	slot0.goShopCanget = gohelper.findChild(slot0.viewGO, "root/btnShop/canGet")
	slot0.goShopTime = gohelper.findChild(slot0.viewGO, "root/btnShop/time")
	slot0.txtShopTime = gohelper.findChildTextMesh(slot0.viewGO, "root/btnShop/time/txt")
	slot0.btnNewYear = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnNewYear")

	gohelper.setActive(slot0.btnNewYear, false)

	slot0.goNewYearFinish = gohelper.findChild(slot0.viewGO, "root/btnNewYear/finish")
	slot0.goNewYearLock = gohelper.findChild(slot0.viewGO, "root/btnNewYear/lock")
	slot0.txtNewYearLock = gohelper.findChildTextMesh(slot0.viewGO, "root/btnNewYear/lock/txt")
	slot0.goNewYearTime = gohelper.findChild(slot0.viewGO, "root/btnNewYear/time")
	slot0.txtNewYearTime = gohelper.findChildTextMesh(slot0.viewGO, "root/btnNewYear/time/txt")
	slot0.btnYuanxiao = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnYuanxiao")
	slot0.goYuanxiaoFinish = gohelper.findChild(slot0.viewGO, "root/btnYuanxiao/finish")
	slot0.goYuanxiaoLock = gohelper.findChild(slot0.viewGO, "root/btnYuanxiao/lock")
	slot0.txtYuanxiaoLock = gohelper.findChildTextMesh(slot0.viewGO, "root/btnYuanxiao/lock/txt")
	slot0.goYuanxiaoTime = gohelper.findChild(slot0.viewGO, "root/btnYuanxiao/time")
	slot0.txtYuanxiaoTime = gohelper.findChildTextMesh(slot0.viewGO, "root/btnYuanxiao/time/txt")
	slot0.btnMainActivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnMainActivity")
	slot0.btnGame = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnGame")
	slot0.btnAvg = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btnAvg")
	slot0.txtStage = gohelper.findChildTextMesh(slot0.viewGO, "root/btnMainActivity/stage/Text")
	slot0.txtStageName = gohelper.findChildTextMesh(slot0.viewGO, "root/btnMainActivity/txt")
	slot0.goNewYearReddot = gohelper.findChild(slot0.viewGO, "root/btnNewYear/reddot")
	slot0.goYuanxiaoReddot = gohelper.findChild(slot0.viewGO, "root/btnYuanxiao/reddot")
	slot0.goMainActivityReddot = gohelper.findChild(slot0.viewGO, "root/btnMainActivity/reddot")
	slot0.newYearReddot = RedDotController.instance:addNotEventRedDot(slot0.goNewYearReddot, slot0._onRefreshNewYearRed, slot0)
	slot0.yuanxiaoReddot = RedDotController.instance:addRedDot(slot0.goYuanxiaoReddot, RedDotEnum.DotNode.V2a5_Act187, 0)
	slot0.mainActivityReddot = RedDotController.instance:addRedDot(slot0.goMainActivityReddot, RedDotEnum.DotNode.V2a5_Act186Task, 0)
	slot0.mainActivityAnim = gohelper.findChildComponent(slot0.viewGO, "root/btnMainActivity", gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnShop, slot0._btngotoOnClick, slot0)
	slot0:addClickCb(slot0.btnNewYear, slot0.onClickBtnNewYear, slot0)
	slot0:addClickCb(slot0.btnYuanxiao, slot0.onClickBtnYuanxiao, slot0)
	slot0:addClickCb(slot0.btnMainActivity, slot0.onClickBtnMainActivity, slot0)
	slot0:addClickCb(slot0.btnGame, slot0.onClickBtnGame, slot0)
	slot0:addClickCb(slot0.btnAvg, slot0.onClickBtnAvg, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, slot0.onFinishGame, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, slot0.onUpdateInfo, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.GetOnceBonus, slot0.onGetOnceBonus, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0.onRefreshRed, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.RefreshRed, slot0.onRefreshRed, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshRed(slot0)
	slot0.newYearReddot:refreshRedDot()
	slot0.yuanxiaoReddot:refreshDot()
	slot0.mainActivityReddot:refreshDot()
end

function slot0.onClickBtnAvg(slot0)
	if not slot0.actMo then
		return
	end

	if not slot0.actMo:isCanShowAvgBtn() then
		return
	end

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 1)
	StoryController.instance:playStory(Activity186Config.instance:getConstNum(Activity186Enum.ConstId.AvgStoryId), nil, slot0.onStoryEnd, slot0)
end

function slot0.onClickBtnGame(slot0)
	Activity186Controller.instance:checkEnterGame(slot0.actId, true)
end

function slot0.onClickBtnYuanxiao(slot0)
	Activity187Controller.instance:openAct187View()
end

function slot0.onClickBtnMainActivity(slot0)
	Activity186Controller.instance:openTaskView(slot0.actId)
end

function slot0.onClickBtnNewYear(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_Act186Sign)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.Activity186SignView, {
		actId = slot0.actId
	})
end

function slot0._btngotoOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(ActivityEnum.Activity.V2a5_FurnaceTreasure)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	if FurnaceTreasureConfig.instance:getJumpId(ActivityEnum.Activity.V2a5_FurnaceTreasure) and slot4 ~= 0 then
		GameFacade.jump(slot4)
	end
end

function slot0.onGetOnceBonus(slot0)
	slot0:_showDeadline()
end

function slot0.onFinishGame(slot0)
	slot0:refreshView()
end

function slot0.onUpdateInfo(slot0)
	slot0:refreshView()
	slot0:refreshMainActivityAnim()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0.isFirstEnterView = Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 0) == 0

	Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.FirstEnterView, 1)
	slot0:refreshParam()
	slot0:refreshView()

	if not slot0.isFirstEnterView then
		slot0:checkGame()
	end

	slot0:_showDeadline()
	slot0:refreshMainActivityAnim()
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.actMo = Activity186Model.instance:getById(slot0.actId)
end

function slot0.refreshView(slot0)
	slot0:_refreshGameBtn()
end

function slot0._refreshGameBtn(slot0)
	if not slot0.actMo then
		return
	end

	slot0:setGameVisable(slot0.actMo:hasGameCanPlay())
end

function slot0.setGameVisable(slot0, slot1)
	if slot0.gameVisable == slot1 then
		return
	end

	slot0.gameVisable = slot1

	gohelper.setActive(slot0.btnGame, slot1)
end

function slot0.refreshStageName(slot0, slot1)
	slot0.txtStage.text = formatLuaLang("Activity186View_txtStage", GameUtil.getNum2Chinese(slot1))
	slot0.txtStageName.text = luaLang(string.format("activity186view_txt_stage%s", slot1))
end

function slot0.checkGame(slot0)
	Activity186Controller.instance:checkEnterGame(slot0.actId)
end

function slot0._showDeadline(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshTime, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshTime, slot0, 1)
	slot0:_onRefreshTime()
end

function slot0._onRefreshTime(slot0)
	slot0:_refreshShopTime()
	slot0:_refreshAvgBtn()
	slot0:_refreshNewYearTime()
	slot0:_refreshYuanxiaoTime()
	slot0:_refreshGameBtn()
end

function slot0._refreshAvgBtn(slot0)
	slot0:setAvgVisable(slot0.actMo:isCanShowAvgBtn())

	if slot0.actMo:isCanPlayAvgStory() then
		slot0:onClickBtnAvg()
	end
end

function slot0._refreshShopTime(slot0)
	slot2 = false

	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.V2a5_FurnaceTreasure) == ActivityEnum.ActivityStatus.Normal and RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a6FurnaceTreasure) then
		for slot7, slot8 in pairs(slot3.infos) do
			if slot8.value > 0 then
				slot2 = true

				break
			end
		end
	end

	gohelper.setActive(slot0.goShopCanget, slot2)
	gohelper.setActive(slot0.goShopTime, not slot2)

	if not slot2 then
		slot0.txtShopTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_FurnaceTreasure, true)
	end
end

function slot0._refreshNewYearTime(slot0)
	if ActivityModel.instance:getActStartTime(ActivityEnum.Activity.V2a5_Act186Sign) * 0.001 - ServerTime.now() > 0 then
		slot0.txtNewYearLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), math.ceil(slot2 / TimeUtil.OneDaySecond))

		gohelper.setActive(slot0.goNewYearLock, true)
		gohelper.setActive(slot0.goNewYearFinish, false)
		gohelper.setActive(slot0.goNewYearTime, false)
	else
		gohelper.setActive(slot0.goNewYearLock, false)

		slot4 = ActivityModel.instance:getActEndTime(ActivityEnum.Activity.V2a5_Act186Sign) * 0.001 - ServerTime.now() <= 0

		gohelper.setActive(slot0.goNewYearFinish, slot4)
		gohelper.setActive(slot0.goNewYearTime, not slot4)

		if not slot4 then
			slot0.txtNewYearTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V2a5_Act186Sign, true)
		end
	end
end

function slot0._refreshYuanxiaoTime(slot0)
	if ActivityModel.instance:getActStartTime(Activity187Model.instance:getAct187Id()) * 0.001 - ServerTime.now() > 0 then
		slot0.txtYuanxiaoLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), math.ceil(slot3 / TimeUtil.OneDaySecond))

		gohelper.setActive(slot0.goYuanxiaoLock, true)
		gohelper.setActive(slot0.goYuanxiaoFinish, false)
		gohelper.setActive(slot0.goYuanxiaoTime, false)
	else
		gohelper.setActive(slot0.goYuanxiaoLock, false)

		slot5 = ActivityModel.instance:getActEndTime(slot1) * 0.001 - ServerTime.now() <= 0

		gohelper.setActive(slot0.goYuanxiaoFinish, slot5)
		gohelper.setActive(slot0.goYuanxiaoTime, not slot5)

		if not slot5 then
			slot0.txtYuanxiaoTime.text = ActivityHelper.getActivityRemainTimeStr(slot1, true)
		end
	end
end

function slot0.setAvgVisable(slot0, slot1)
	if slot0.avgVisable == slot1 then
		return
	end

	slot0.avgVisable = slot1

	gohelper.setActive(slot0.btnAvg, slot1)
	Activity186Controller.instance:dispatchEvent(Activity186Event.RefreshRed)
end

function slot0.onStoryEnd(slot0)
	Activity186Rpc.instance:sendGetAct186OnceBonusRequest(slot0.actId)
	ViewMgr.instance:openView(ViewName.Activity186GiftView)
end

function slot0._onRefreshNewYearRed(slot0)
	return Activity186Model.instance:isShowSignRed()
end

function slot0.refreshMainActivityAnim(slot0)
	if not slot0.actMo then
		return
	end

	if Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, 0) ~= slot0.actMo.currentStage then
		Activity186Controller.instance:setPlayerPrefs(Activity186Enum.LocalPrefsKey.MainActivityStageAnim, slot2)
		slot0:refreshStageName(slot1 ~= 0 and slot1 or 1)
		slot0.mainActivityAnim:Play("refresh")
		TaskDispatcher.runDelay(slot0._refreshRealStage, slot0, 0.17)
	else
		slot0:_refreshRealStage()
		slot0.mainActivityAnim:Play("idle")
	end
end

function slot0._refreshRealStage(slot0)
	if not slot0.actMo then
		return
	end

	slot0:refreshStageName(slot0.actMo.currentStage)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshTime, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshTime, slot0)
	ViewMgr.instance:closeView(ViewName.Activity186TaskView)
	ViewMgr.instance:closeView(ViewName.Activity186SignView)
	ViewMgr.instance:closeView(ViewName.Activity186EffectView)
end

return slot0
