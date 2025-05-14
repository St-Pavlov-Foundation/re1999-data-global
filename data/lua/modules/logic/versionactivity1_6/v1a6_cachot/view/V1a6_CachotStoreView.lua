module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreView", package.seeall)

local var_0_0 = class("V1a6_CachotStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnexit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_exit")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._onClickExit, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, arg_3_0._refreshView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
	arg_4_0:_refreshView()
end

function var_0_0._refreshView(arg_5_0)
	V1a6_CachotStoreListModel.instance:setList(V1a6_CachotModel.instance:getGoodsInfos() or {})
end

function var_0_0._onClickExit(arg_6_0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_6_0.viewParam.eventId, arg_6_0.closeThis, arg_6_0)
end

return var_0_0
