module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffTips", package.seeall)

local var_0_0 = class("RougeLimiterBuffTips", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtbuffname = gohelper.findChildText(arg_1_0.viewGO, "#txt_buffname")
	arg_1_0._txtbuffdec = gohelper.findChildText(arg_1_0.viewGO, "buffdecView/Viewport/#txt_buffdec")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_equip")
	arg_1_0._btnunequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_unequip")
	arg_1_0._btncostunlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_costunlock")
	arg_1_0._txtunlocknum = gohelper.findChildText(arg_1_0.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "btnContain/#btn_costunlock/#txt_unlocknum/#image_icon")
	arg_1_0._btnspeedup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnContain/#btn_speedup")
	arg_1_0._txtspeedupnum = gohelper.findChildText(arg_1_0.viewGO, "btnContain/#btn_speedup/#txt_speedupnum")
	arg_1_0._btnclosebuffdec = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closebuffdec")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateBuffState, arg_2_0._onUpdateBuffState, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnunequip:AddClickListener(arg_2_0._btnunequipOnClick, arg_2_0)
	arg_2_0._btncostunlock:AddClickListener(arg_2_0._btncostunlockOnClick, arg_2_0)
	arg_2_0._btnspeedup:AddClickListener(arg_2_0._btnspeedupOnClick, arg_2_0)
	arg_2_0._btnclosebuffdec:AddClickListener(arg_2_0._btnclosebuffdecOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnunequip:RemoveClickListener()
	arg_3_0._btncostunlock:RemoveClickListener()
	arg_3_0._btnspeedup:RemoveClickListener()
	arg_3_0._btnclosebuffdec:RemoveClickListener()
end

function var_0_0._btnequipOnClick(arg_4_0)
	RougeDLCModel101.instance:try2EquipBuff(arg_4_0._buffId)

	if arg_4_0._buffCo and arg_4_0._buffCo.blank == 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.EquipedBlankLimiterBuff)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.EquipedNormalLimiterBuff)
	end
end

function var_0_0._btnunequipOnClick(arg_5_0)
	RougeDLCModel101.instance:try2UnEquipBuff(arg_5_0._buffId)
end

function var_0_0._btncostunlockOnClick(arg_6_0)
	RougeDLCController101.instance:unlockLimiterBuff(arg_6_0._buffId)
end

function var_0_0._btnspeedupOnClick(arg_7_0)
	RougeDLCController101.instance:speedupLimiterBuff(arg_7_0._buffId)
end

function var_0_0._btnclosebuffdecOnClick(arg_8_0)
	gohelper.setActive(arg_8_0.viewGO, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.CloseBuffDescTips)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._buffId = arg_9_1
	arg_9_0._buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(arg_9_0._buffId)

	gohelper.setActive(arg_9_0.viewGO, arg_9_0._buffCo and arg_9_2)

	if not arg_9_0._buffCo or not arg_9_2 then
		return
	end

	arg_9_0:_refreshBuffInfo()
	arg_9_0:_refreshBuffStateUI()
end

function var_0_0._refreshBuffInfo(arg_10_0)
	arg_10_0._txtbuffname.text = arg_10_0._buffCo and arg_10_0._buffCo.title
	arg_10_0._txtbuffdec.text = arg_10_0._buffCo and arg_10_0._buffCo.desc
end

function var_0_0._refreshBuffStateUI(arg_11_0)
	local var_11_0 = RougeDLCModel101.instance:getLimiterBuffState(arg_11_0._buffId)

	arg_11_0:refreshButtons(var_11_0)
	arg_11_0:executeBuffStateCallBack(var_11_0)
end

function var_0_0.refreshButtons(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 == RougeDLCEnum101.BuffState.Locked
	local var_12_1 = arg_12_1 == RougeDLCEnum101.BuffState.Unlocked
	local var_12_2 = arg_12_1 == RougeDLCEnum101.BuffState.Equiped
	local var_12_3 = arg_12_1 == RougeDLCEnum101.BuffState.CD

	gohelper.setActive(arg_12_0._btncostunlock.gameObject, var_12_0)
	gohelper.setActive(arg_12_0._btnequip.gameObject, var_12_1)
	gohelper.setActive(arg_12_0._btnunequip.gameObject, var_12_2)
	gohelper.setActive(arg_12_0._btnspeedup.gameObject, var_12_3)
end

function var_0_0.executeBuffStateCallBack(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getBuffStateCallBack(arg_13_1)

	if not var_13_0 then
		return
	end

	var_13_0(arg_13_0)
end

function var_0_0.getBuffStateCallBack(arg_14_0, arg_14_1)
	if not arg_14_0._stateCallBackMap then
		arg_14_0._stateCallBackMap = {
			[RougeDLCEnum101.BuffState.Locked] = arg_14_0.onBuffLocked,
			[RougeDLCEnum101.BuffState.CD] = arg_14_0.onBuffCD
		}
	end

	return arg_14_0._stateCallBackMap and arg_14_0._stateCallBackMap[arg_14_1]
end

local var_0_1 = "#D6D2C9"
local var_0_2 = "#BF2E11"
local var_0_3 = "#D6D2C9"
local var_0_4 = "#BF2E11"

function var_0_0.onBuffLocked(arg_15_0)
	local var_15_0 = arg_15_0._buffCo and arg_15_0._buffCo.needEmblem
	local var_15_1 = var_15_0 <= RougeDLCModel101.instance:getTotalEmblemCount() and var_0_3 or var_0_4

	arg_15_0._txtunlocknum.text = string.format("<%s>-%s</color>", var_15_1, var_15_0)
end

function var_0_0.onBuffCD(arg_16_0)
	local var_16_0 = RougeDLCModel101.instance:getLimiterBuffCD(arg_16_0._buffId)
	local var_16_1 = RougeDLCHelper101.getLimiterBuffSpeedupCost(var_16_0)
	local var_16_2 = var_16_1 <= RougeDLCModel101.instance:getTotalEmblemCount() and var_0_1 or var_0_2

	arg_16_0._txtspeedupnum.text = string.format("<%s>-%s</color>", var_16_2, var_16_1)
end

function var_0_0._onUpdateBuffState(arg_17_0, arg_17_1)
	if arg_17_0._buffId == arg_17_1 then
		arg_17_0:_refreshBuffStateUI()
	end
end

return var_0_0
