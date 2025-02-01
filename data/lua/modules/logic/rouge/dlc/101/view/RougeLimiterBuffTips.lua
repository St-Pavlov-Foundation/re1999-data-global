module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffTips", package.seeall)

slot0 = class("RougeLimiterBuffTips", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._txtbuffname = gohelper.findChildText(slot0.viewGO, "#txt_buffname")
	slot0._txtbuffdec = gohelper.findChildText(slot0.viewGO, "buffdecView/Viewport/#txt_buffdec")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_equip")
	slot0._btnunequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_unequip")
	slot0._btncostunlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_costunlock")
	slot0._txtunlocknum = gohelper.findChildText(slot0.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum/#image_icon")
	slot0._btnspeedup = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnContain/#btn_speedup")
	slot0._txtspeedupnum = gohelper.findChildText(slot0.viewGO, "btnContain/#btn_speedup/#txt_speedupnum")
	slot0._btnclosebuffdec = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closebuffdec")
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, slot0._onUpdateBuffState, slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnunequip:AddClickListener(slot0._btnunequipOnClick, slot0)
	slot0._btncostunlock:AddClickListener(slot0._btncostunlockOnClick, slot0)
	slot0._btnspeedup:AddClickListener(slot0._btnspeedupOnClick, slot0)
	slot0._btnclosebuffdec:AddClickListener(slot0._btnclosebuffdecOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnequip:RemoveClickListener()
	slot0._btnunequip:RemoveClickListener()
	slot0._btncostunlock:RemoveClickListener()
	slot0._btnspeedup:RemoveClickListener()
	slot0._btnclosebuffdec:RemoveClickListener()
end

function slot0._btnequipOnClick(slot0)
	RougeDLCModel101.instance:try2EquipBuff(slot0._buffId)

	if slot0._buffCo and slot0._buffCo.blank == 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.EquipedBlankLimiterBuff)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.EquipedNormalLimiterBuff)
	end
end

function slot0._btnunequipOnClick(slot0)
	RougeDLCModel101.instance:try2UnEquipBuff(slot0._buffId)
end

function slot0._btncostunlockOnClick(slot0)
	RougeDLCController101.instance:unlockLimiterBuff(slot0._buffId)
end

function slot0._btnspeedupOnClick(slot0)
	RougeDLCController101.instance:speedupLimiterBuff(slot0._buffId)
end

function slot0._btnclosebuffdecOnClick(slot0)
	gohelper.setActive(slot0.viewGO, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.CloseBuffDescTips)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0._buffId = slot1
	slot0._buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(slot0._buffId)

	gohelper.setActive(slot0.viewGO, slot0._buffCo and slot2)

	if not slot0._buffCo or not slot2 then
		return
	end

	slot0:_refreshBuffInfo()
	slot0:_refreshBuffStateUI()
end

function slot0._refreshBuffInfo(slot0)
	slot0._txtbuffname.text = slot0._buffCo and slot0._buffCo.title
	slot0._txtbuffdec.text = slot0._buffCo and slot0._buffCo.desc
end

function slot0._refreshBuffStateUI(slot0)
	slot1 = RougeDLCModel101.instance:getLimiterBuffState(slot0._buffId)

	slot0:refreshButtons(slot1)
	slot0:executeBuffStateCallBack(slot1)
end

function slot0.refreshButtons(slot0, slot1)
	gohelper.setActive(slot0._btncostunlock.gameObject, slot1 == RougeDLCEnum101.BuffState.Locked)
	gohelper.setActive(slot0._btnequip.gameObject, slot1 == RougeDLCEnum101.BuffState.Unlocked)
	gohelper.setActive(slot0._btnunequip.gameObject, slot1 == RougeDLCEnum101.BuffState.Equiped)
	gohelper.setActive(slot0._btnspeedup.gameObject, slot1 == RougeDLCEnum101.BuffState.CD)
end

function slot0.executeBuffStateCallBack(slot0, slot1)
	if not slot0:getBuffStateCallBack(slot1) then
		return
	end

	slot2(slot0)
end

function slot0.getBuffStateCallBack(slot0, slot1)
	if not slot0._stateCallBackMap then
		slot0._stateCallBackMap = {
			[RougeDLCEnum101.BuffState.Locked] = slot0.onBuffLocked,
			[RougeDLCEnum101.BuffState.CD] = slot0.onBuffCD
		}
	end

	return slot0._stateCallBackMap and slot0._stateCallBackMap[slot1]
end

slot1 = "#D6D2C9"
slot2 = "#BF2E11"
slot3 = "#D6D2C9"
slot4 = "#BF2E11"

function slot0.onBuffLocked(slot0)
	slot1 = slot0._buffCo and slot0._buffCo.needEmblem
	slot0._txtunlocknum.text = string.format("<%s>-%s</color>", slot1 <= RougeDLCModel101.instance:getTotalEmblemCount() and uv0 or uv1, slot1)
end

function slot0.onBuffCD(slot0)
	slot0._txtspeedupnum.text = string.format("<%s>-%s</color>", RougeDLCHelper101.getLimiterBuffSpeedupCost(RougeDLCModel101.instance:getLimiterBuffCD(slot0._buffId)) <= RougeDLCModel101.instance:getTotalEmblemCount() and uv0 or uv1, slot2)
end

function slot0._onUpdateBuffState(slot0, slot1)
	if slot0._buffId == slot1 then
		slot0:_refreshBuffStateUI()
	end
end

return slot0
