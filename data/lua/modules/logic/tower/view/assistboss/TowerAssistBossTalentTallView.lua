module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallView", package.seeall)

local var_0_0 = class("TowerAssistBossTalentTallView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_Empty")
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.viewGO, "#scroll_Descr")
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_Descr/Viewport/Content/#go_Item")

	gohelper.setActive(arg_1_0.goItem, false)

	arg_1_0.items = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshParam()
	arg_6_0:refreshView()
end

function var_0_0.refreshParam(arg_7_0)
	arg_7_0.bossId = arg_7_0.viewParam.bossId
	arg_7_0.bossMo = TowerAssistBossModel.instance:getBoss(arg_7_0.bossId)
	arg_7_0.talentTree = arg_7_0.bossMo:getTalentTree()
end

function var_0_0.refreshView(arg_8_0)
	arg_8_0:refreshList()
end

function var_0_0.refreshList(arg_9_0)
	local var_9_0 = arg_9_0.talentTree:getActiveTalentList()
	local var_9_1 = #var_9_0
	local var_9_2 = var_9_1 == 0

	gohelper.setActive(arg_9_0.goScroll, not var_9_2)
	gohelper.setActive(arg_9_0.goEmpty, var_9_2)

	if not var_9_2 then
		local var_9_3 = #arg_9_0.items
		local var_9_4 = math.max(var_9_3, var_9_1)

		for iter_9_0 = 1, var_9_4 do
			arg_9_0:getItem(iter_9_0):onUpdateMO(var_9_0[iter_9_0])
		end
	end
end

function var_0_0.getItem(arg_10_0, arg_10_1)
	if not arg_10_0.items[arg_10_1] then
		local var_10_0 = gohelper.cloneInPlace(arg_10_0.goItem, tostring(arg_10_1))
		local var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_0, TowerAssistBossTalentTallItem)

		arg_10_0.items[arg_10_1] = var_10_1
	end

	return arg_10_0.items[arg_10_1]
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
