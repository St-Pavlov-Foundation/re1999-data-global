module("modules.logic.rouge.dlc.101.controller.RougeDLCController101", package.seeall)

local var_0_0 = class("RougeDLCController101", BaseController)

function var_0_0.openRougeLimiterView(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.RougeLimiterView, arg_1_1, arg_1_2)
end

function var_0_0.openRougeLimiterLockedTipsView(arg_2_0, arg_2_1, arg_2_2)
	ViewMgr.instance:openView(ViewName.RougeLimiterLockedTipsView, arg_2_1, arg_2_2)
end

function var_0_0.openRougeLimiterOverView(arg_3_0, arg_3_1, arg_3_2)
	ViewMgr.instance:openView(ViewName.RougeLimiterOverView, arg_3_1, arg_3_2)
end

function var_0_0.openRougeLimiterBuffView(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:openView(ViewName.RougeLimiterBuffView, arg_4_1, arg_4_2)
end

function var_0_0.openRougeDangerousView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:openView(ViewName.RougeDangerousView, arg_5_1, arg_5_2)
end

function var_0_0.openRougeLimiterResultView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.RougeLimiterResultView, arg_6_1, arg_6_2)
end

function var_0_0.openRougeFactionLockedTips(arg_7_0, arg_7_1, arg_7_2)
	ViewMgr.instance:openView(ViewName.RougeFactionLockedTips, arg_7_1, arg_7_2)
end

function var_0_0.unlockLimiterBuff(arg_8_0, arg_8_1)
	local var_8_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_8_1)

	if not var_8_0 then
		return
	end

	if var_8_0.needEmblem > RougeDLCModel101.instance:getTotalEmblemCount() then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	local var_8_1 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeLimiterUnlockBuffRequest(var_8_1, arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UnlockLimiterBuff)
end

function var_0_0.speedupLimiterBuff(arg_9_0, arg_9_1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(arg_9_1) then
		return
	end

	local var_9_0 = RougeDLCModel101.instance:getTotalEmblemCount()
	local var_9_1 = RougeDLCModel101.instance:getLimiterBuffCD(arg_9_1)

	if var_9_0 < RougeDLCHelper101.getLimiterBuffSpeedupCost(var_9_1) then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	local var_9_2 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeLimiterSpeedUpBuffCdRequest(var_9_2, arg_9_1)
end

function var_0_0.onGetUnlockLimiterBuffInfo(arg_10_0, arg_10_1)
	local var_10_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_10_1)

	if not var_10_0 then
		return
	end

	local var_10_1 = RougeDLCModel101.instance:getLimiterMo()

	var_10_1:updateTotalEmblemCount(-var_10_0.needEmblem)
	var_10_1:unlockLimiterBuff(arg_10_1)
	var_0_0.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, arg_10_1)
	var_0_0.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function var_0_0.onGetSpeedupLimiterBuffInfo(arg_11_0, arg_11_1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(arg_11_1) then
		return
	end

	local var_11_0 = RougeDLCModel101.instance:getLimiterMo()
	local var_11_1 = var_11_0:getBuffCDRound(arg_11_1)
	local var_11_2 = RougeDLCHelper101.getLimiterBuffSpeedupCost(var_11_1)

	var_11_0:updateTotalEmblemCount(-var_11_2)
	var_11_0:speedupLimiterBuff(arg_11_1)
	var_0_0.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, arg_11_1)
	var_0_0.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function var_0_0.try2SaveLimiterSetting(arg_12_0)
	if not RougeDLCModel101.instance:isModifySelectLimiterGroup() then
		return
	end

	local var_12_0 = RougeOutsideModel.instance:season()
	local var_12_1 = RougeDLCModel101.instance:getLimiterClientMo()

	RougeOutsideRpc.instance:sendRougeLimiterSettingSaveRequest(var_12_0, var_12_1)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
