module("modules.logic.bossrush.view.FightViewBossHpBossRushActionOpItem", package.seeall)

local var_0_0 = class("FightViewBossHpBossRushActionOpItem", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.ForbidBossRushHpChannelSkillOpItem, arg_2_0._onForbidBossRushHpChannelSkillOpItem)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0._onForbidBossRushHpChannelSkillOpItem(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._data then
		arg_6_0:refreshUI(arg_6_0.viewGO, arg_6_1)
	end
end

function var_0_0.refreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.viewGO = arg_7_1
	arg_7_0._data = arg_7_2

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "root/noAct")
	local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "root/act")
	local var_7_2 = arg_7_2.skillId

	gohelper.setActive(var_7_1, var_7_2 ~= 0)
	gohelper.setActive(var_7_0, var_7_2 == 0)

	if var_7_2 == 0 then
		return
	end

	local var_7_3 = gohelper.findChild(arg_7_0.viewGO, "root/act/round")
	local var_7_4 = gohelper.findChildText(arg_7_0.viewGO, "root/act/round/num")
	local var_7_5 = gohelper.findChild(arg_7_0.viewGO, "root/act/forbid")

	gohelper.setActive(var_7_5, arg_7_2.isChannelPosedSkill and arg_7_2.forbidden)
	gohelper.setActive(var_7_3, arg_7_2.isChannelSkill)

	var_7_4.text = arg_7_2.round or 0

	if not arg_7_0.opItemView then
		arg_7_0.opItemView = arg_7_0:com_openSubView(FightBossRushHpTrackAIUseCardsItem, var_7_1)
	end

	local var_7_6 = FightCardInfoData.New(FightDef_pb.CardInfo())

	var_7_6.uid = arg_7_0.PARENT_VIEW._bossEntityMO.uid
	var_7_6.skillId = var_7_2

	arg_7_0.opItemView:onRefreshItemData(var_7_6)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
