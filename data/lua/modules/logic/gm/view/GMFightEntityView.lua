module("modules.logic.gm.view.GMFightEntityView", package.seeall)

local var_0_0 = class("GMFightEntityView", BaseView)

var_0_0.Evt_OnGetEntityDetailInfos = GameUtil.getEventId()
var_0_0.Evt_SelectHero = GameUtil.getEventId()

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	GMFightEntityModel.instance:onOpen()

	local var_4_0 = GMFightEntityModel.instance:getList()[1]

	if var_4_0 then
		arg_4_0.viewContainer.entityListView:setSelect(var_4_0)
	end
end

function var_0_0.onClose(arg_5_0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return var_0_0
