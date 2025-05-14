module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTipsView", package.seeall)

local var_0_0 = class("V1a6_CachotRoomTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtRoomInfo = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_tips/#txt_mapname")
	arg_1_0._txtRoomNameEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_tips/#txt_mapnameen")
	arg_1_0._tipsAnim = arg_1_0._gotips:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.viewContainer:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, arg_2_0.showRoomInfo, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, arg_3_0.showRoomInfo, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._gotips, false)
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.LoadingView or arg_5_1 == ViewName.V1a6_CachotLoadingView or arg_5_1 == ViewName.V1a6_CachotLayerChangeView then
		arg_5_0:showRoomInfo()
	end
end

function var_0_0.showRoomInfo(arg_6_0)
	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		return
	end

	gohelper.setActive(arg_6_0._gotips, true)
	arg_6_0._tipsAnim:Play("go_mapname_in", 0, 0)

	local var_6_0 = V1a6_CachotModel.instance:getRogueInfo().room
	local var_6_1 = lua_rogue_room.configDict[var_6_0]
	local var_6_2, var_6_3 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(var_6_0)

	arg_6_0._txtRoomInfo.text = string.format("%s（%d/%d）", var_6_1.name, var_6_2, var_6_3)
	arg_6_0._txtRoomNameEn.text = var_6_1.nameEn

	TaskDispatcher.cancelTask(arg_6_0.playHideTipsGo, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.hideTipsGo, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.playHideTipsGo, arg_6_0, 4.167)
end

function var_0_0.playHideTipsGo(arg_7_0)
	if not arg_7_0._tipsAnim then
		return
	end

	arg_7_0._tipsAnim:Play("go_mapname_out", 0, 0)
	TaskDispatcher.runDelay(arg_7_0.hideTipsGo, arg_7_0, 0.433)
end

function var_0_0.hideTipsGo(arg_8_0)
	gohelper.setActive(arg_8_0._gotips, false)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.playHideTipsGo, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.hideTipsGo, arg_9_0)
end

return var_0_0
