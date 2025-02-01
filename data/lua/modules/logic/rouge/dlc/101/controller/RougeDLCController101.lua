module("modules.logic.rouge.dlc.101.controller.RougeDLCController101", package.seeall)

slot0 = class("RougeDLCController101", BaseController)

function slot0.openRougeLimiterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeLimiterView, slot1, slot2)
end

function slot0.openRougeLimiterLockedTipsView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeLimiterLockedTipsView, slot1, slot2)
end

function slot0.openRougeLimiterOverView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeLimiterOverView, slot1, slot2)
end

function slot0.openRougeLimiterBuffView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeLimiterBuffView, slot1, slot2)
end

function slot0.openRougeDangerousView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeDangerousView, slot1, slot2)
end

function slot0.openRougeLimiterResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeLimiterResultView, slot1, slot2)
end

function slot0.openRougeFactionLockedTips(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeFactionLockedTips, slot1, slot2)
end

function slot0.unlockLimiterBuff(slot0, slot1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	if RougeDLCModel101.instance:getTotalEmblemCount() < slot2.needEmblem then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	RougeOutsideRpc.instance:sendRougeLimiterUnlockBuffRequest(RougeOutsideModel.instance:season(), slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UnlockLimiterBuff)
end

function slot0.speedupLimiterBuff(slot0, slot1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	if RougeDLCModel101.instance:getTotalEmblemCount() < RougeDLCHelper101.getLimiterBuffSpeedupCost(RougeDLCModel101.instance:getLimiterBuffCD(slot1)) then
		GameFacade.showToast(ToastEnum.LackEmblem)

		return
	end

	RougeOutsideRpc.instance:sendRougeLimiterSpeedUpBuffCdRequest(RougeOutsideModel.instance:season(), slot1)
end

function slot0.onGetUnlockLimiterBuffInfo(slot0, slot1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	slot3 = RougeDLCModel101.instance:getLimiterMo()

	slot3:updateTotalEmblemCount(-slot2.needEmblem)
	slot3:unlockLimiterBuff(slot1)
	uv0.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, slot1)
	uv0.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function slot0.onGetSpeedupLimiterBuffInfo(slot0, slot1)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	slot3 = RougeDLCModel101.instance:getLimiterMo()

	slot3:updateTotalEmblemCount(-RougeDLCHelper101.getLimiterBuffSpeedupCost(slot3:getBuffCDRound(slot1)))
	slot3:speedupLimiterBuff(slot1)
	uv0.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, slot1)
	uv0.instance:dispatchEvent(RougeDLCEvent101.UpdateEmblem)
end

function slot0.try2SaveLimiterSetting(slot0)
	if not RougeDLCModel101.instance:isModifySelectLimiterGroup() then
		return
	end

	RougeOutsideRpc.instance:sendRougeLimiterSettingSaveRequest(RougeOutsideModel.instance:season(), RougeDLCModel101.instance:getLimiterClientMo())
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
