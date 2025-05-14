module("modules.logic.seasonver.act166.view2_4.Season166_2_4InformationMainView", package.seeall)

local var_0_0 = class("Season166_2_4InformationMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.reportItems = {}
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Reward/#btn_Reward")
	arg_1_0.txtRewardNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "Reward/#txt_RewardNum")
	arg_1_0.slider = gohelper.findChildImage(arg_1_0.viewGO, "Reward/#go_Slider")
	arg_1_0.gorewardReddot = gohelper.findChild(arg_1_0.viewGO, "Reward/#go_rewardReddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnReward, arg_2_0.onClickReward, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, arg_2_0.onInformationUpdate, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, arg_2_0.onAnalyInfoSuccess, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnGetInfoBonus, arg_2_0.onGetInfoBonus, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnGetInformationBonus, arg_2_0.onGetInformationBonus, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.ClickInfoReportItem, arg_2_0.setLocalUnlockState, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.localUnlockStateTab = arg_4_0:getUserDataTb_()
end

function var_0_0.onClickReward(arg_5_0)
	ViewMgr.instance:openView(ViewName.Season166InformationRewardView, {
		actId = arg_5_0.actId
	})
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onAnalyInfoSuccess(arg_7_0)
	arg_7_0:refreshUI()
end

function var_0_0.onGetInfoBonus(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onInformationUpdate(arg_9_0)
	arg_9_0:refreshUI()
end

function var_0_0.onGetInformationBonus(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId

	arg_11_0:refreshUI()
	RedDotController.instance:addRedDot(arg_11_0.gorewardReddot, RedDotEnum.DotNode.Season166InfoBigReward)
end

function var_0_0.refreshUI(arg_12_0)
	if not arg_12_0.actId then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.Season166InformationAnalyView) then
		return
	end

	arg_12_0:refreshReport()

	local var_12_0, var_12_1 = Season166Model.instance:getActInfo(arg_12_0.actId):getBonusNum()

	arg_12_0.txtRewardNum.text = string.format("<color=#de9754>%s</color>/%s", var_12_0, var_12_1)
	arg_12_0.slider.fillAmount = var_12_0 / var_12_1

	arg_12_0:refreshItemUnlockState()
end

function var_0_0.refreshReport(arg_13_0)
	local var_13_0 = Season166Config.instance:getSeasonInfos(arg_13_0.actId) or {}

	for iter_13_0 = 1, math.max(#var_13_0, #arg_13_0.reportItems) do
		local var_13_1 = arg_13_0.reportItems[iter_13_0]

		if not var_13_1 then
			local var_13_2 = gohelper.findChild(arg_13_0.viewGO, string.format("Report%s", iter_13_0))

			if var_13_2 then
				var_13_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, Season166_2_4InformationReportItem)
				arg_13_0.reportItems[iter_13_0] = var_13_1
			end
		end

		if var_13_1 then
			var_13_1:refreshUI(var_13_0[iter_13_0])
		end
	end
end

function var_0_0.refreshItemUnlockState(arg_14_0)
	local var_14_0 = Season166Model.instance:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)
	local var_14_1 = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey)
	local var_14_2 = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.reportItems) do
		if GameUtil.getTabLen(var_14_0) == 0 then
			iter_14_1:refreshUnlockState(Season166Enum.LockState)

			arg_14_0.localUnlockStateTab[iter_14_0] = Season166Enum.LockState
		else
			local var_14_3 = var_14_0[iter_14_0]

			iter_14_1:refreshUnlockState(var_14_3)

			arg_14_0.localUnlockStateTab[iter_14_0] = var_14_3
		end

		iter_14_1:refreshUnlockAnimState(var_14_1)
		iter_14_1:refreshFinishAnimState(var_14_2)
	end

	arg_14_0:saveUnlockState()
end

function var_0_0.saveUnlockState(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.localUnlockStateTab) do
		local var_15_1 = string.format("%s|%s", iter_15_0, iter_15_1)

		table.insert(var_15_0, var_15_1)
	end

	local var_15_2 = cjson.encode(var_15_0)

	Season166Controller.instance:savePlayerPrefs(Season166Enum.InforMainLocalSaveKey, var_15_2)
end

function var_0_0.setLocalUnlockState(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.infoId
	local var_16_1 = arg_16_1.unlockState

	arg_16_0.localUnlockStateTab[var_16_0] = var_16_1

	arg_16_0:saveUnlockState()
end

function var_0_0._onViewClose(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.Season166InformationAnalyView then
		arg_17_0:refreshUI()
	end
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:saveUnlockState()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
