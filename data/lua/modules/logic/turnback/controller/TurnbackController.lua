module("modules.logic.turnback.controller.TurnbackController", package.seeall)

local var_0_0 = class("TurnbackController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, arg_3_0._onUpdateTaskList, arg_3_0)
	arg_3_0:registerCallback(TurnbackEvent.AdditionCountChange, arg_3_0._onAdditionCountChange, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._dailyRefresh, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._dailyRefresh(arg_5_0)
	if TurnbackModel.instance:isInOpenTime() then
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	else
		ViewMgr.instance:closeView(ViewName.TurnbackNewBeginnerView)
		ViewMgr.instance:closeView(ViewName.TurnbackBeginnerView)
	end
end

function var_0_0.hasPlayedStoryVideo(arg_6_0, arg_6_1)
	local var_6_0 = TurnbackConfig.instance:getTurnbackCo(arg_6_1)

	if not var_6_0 then
		return true
	end

	if var_6_0.startStory == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(var_6_0.startStory)
end

function var_0_0.checkFirstOpenLatter(arg_7_0, arg_7_1)
	local var_7_0 = string.format("%s#%s#%s", PlayerPrefsKey.TurnbackSigninLatterFirstOpen, arg_7_1, PlayerModel.instance:getPlayinfo().userId)
	local var_7_1 = PlayerPrefsHelper.getString(var_7_0, "")

	if string.nilorempty(var_7_1) then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = arg_7_1
		})
		PlayerPrefsHelper.setString(var_7_0, "opened")
	end
end

function var_0_0.openTurnbackBeginnerView(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.turnbackId
	local var_8_1 = TurnbackModel.instance:getCurTurnbackMo():isNewType()

	if GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackSubModules(var_8_0)) > 0 then
		if var_8_1 then
			ViewMgr.instance:openView(ViewName.TurnbackNewBeginnerView, arg_8_1)
		else
			ViewMgr.instance:openView(ViewName.TurnbackBeginnerView, arg_8_1)
		end
	else
		GameFacade.showToast(ToastEnum.ActivityNormalView)
	end
end

function var_0_0._onUpdateTaskList(arg_9_0, arg_9_1)
	if not TurnbackModel.instance:getCurTurnbackMo() then
		return
	end

	if TurnbackTaskModel.instance:updateInfo(arg_9_1.taskInfo) then
		if not TurnbackModel.instance:isNewType() then
			TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance.curTaskLoopType)
		else
			TurnbackTaskModel.instance:refreshListNewTaskList()
		end

		var_0_0.instance:dispatchEvent(TurnbackEvent.RefreshTaskRedDot)
	end
end

function var_0_0.setSignInList(arg_10_0)
	TurnbackSignInModel.instance:setSignInList()
end

function var_0_0._onAdditionCountChange(arg_11_0)
	local var_11_0, var_11_1 = TurnbackModel.instance:getAdditionCountInfo()
	local var_11_2 = string.format("%s/%s", var_11_0, var_11_1)

	GameFacade.showToast(ToastEnum.TurnBackAdditionTimesChange, var_11_2)
end

function var_0_0._checkCustomShowRedDotData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:defaultRefreshDot()

	if not arg_12_1.show then
		local var_12_0 = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_12_2).reddotId
		local var_12_1 = RedDotConfig.instance:getRedDotCO(var_12_0)

		if not var_12_1 then
			return
		end

		arg_12_1.show = arg_12_0:checkIsShowCustomRedDot(arg_12_2)

		local var_12_2 = var_12_0 ~= 0 and var_12_1.style or RedDotEnum.Style.Normal

		arg_12_1:showRedDot(var_12_2)
	end
end

function var_0_0.checkIsShowCustomRedDot(arg_13_0, arg_13_1)
	local var_13_0 = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_13_1).reddotId
	local var_13_1 = RedDotConfig.instance:getRedDotCO(var_13_0)

	if not var_13_1 then
		return
	end

	local var_13_2 = TurnbackModel.instance:getCurTurnbackId()

	if var_13_1.canLoad == 0 then
		local var_13_3 = var_13_2 .. "_" .. arg_13_1

		return TimeUtil.getDayFirstLoginRed(var_13_3)
	end

	return false
end

function var_0_0.refreshRemainTime(arg_14_0, arg_14_1)
	local var_14_0, var_14_1, var_14_2 = TurnbackModel.instance:getRemainTime(arg_14_1)
	local var_14_3 = string.format("%02d", var_14_0)
	local var_14_4 = string.format("%02d", var_14_1)
	local var_14_5 = string.format("%02d", var_14_2)
	local var_14_6 = ""

	if var_14_0 >= 1 then
		var_14_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_day_hour"), {
			var_14_3,
			var_14_4
		})
	elseif var_14_0 == 0 and var_14_1 >= 1 then
		var_14_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_hour_minute"), {
			var_14_4,
			var_14_5
		})
	elseif var_14_0 == 0 and var_14_1 < 1 and var_14_2 >= 1 then
		var_14_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_minute"), {
			var_14_5
		})
	elseif var_14_0 == 0 and var_14_1 < 1 and var_14_2 < 1 then
		var_14_6 = luaLang("lessOneMinute")
	elseif var_14_0 < 0 or not TurnbackModel.instance:isInOpenTime() then
		var_14_6 = luaLang("turnback_end")
	end

	return var_14_6
end

function var_0_0.showPopupView(arg_15_0, arg_15_1)
	if arg_15_1 ~= nil then
		local var_15_0 = {
			dataList = arg_15_1
		}
		local var_15_1 = MaterialRpc.receiveMaterial(var_15_0)

		if var_15_1 and #var_15_1 > 0 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_15_1)
		end
	end
end

local var_0_1 = PlayerPrefsKey.PlayerPrefsKey.TurnbackOnlineTaskUnlock .. "#"

function var_0_0.isPlayFirstUnlockToday(arg_16_0, arg_16_1)
	local var_16_0 = var_0_1 .. tostring(PlayerModel.instance:getPlayinfo().userId) .. arg_16_1
	local var_16_1 = ServerTime.nowInLocal()
	local var_16_2 = os.date("*t", var_16_1)

	if PlayerPrefsHelper.hasKey(var_16_0) then
		local var_16_3 = tonumber(PlayerPrefsHelper.getString(var_16_0, var_16_1))

		var_16_2.hour = 5
		var_16_2.min = 0
		var_16_2.sec = 0

		local var_16_4 = os.time(var_16_2)

		if var_16_3 and TimeUtil.getDiffDay(var_16_1, var_16_3) < 1 and (var_16_1 - var_16_4) * (var_16_3 - var_16_4) > 0 then
			return false
		end
	end

	return true
end

function var_0_0.savePlayUnlockAnim(arg_17_0, arg_17_1)
	local var_17_0 = var_0_1 .. tostring(PlayerModel.instance:getPlayinfo().userId) .. arg_17_1
	local var_17_1 = ServerTime.nowInLocal()

	PlayerPrefsHelper.setString(var_17_0, tostring(var_17_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
