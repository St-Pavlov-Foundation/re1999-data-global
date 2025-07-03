module("modules.logic.tower.model.TowerAssistBossTalentListModel", package.seeall)

local var_0_0 = class("TowerAssistBossTalentListModel", ListScrollModel)

function var_0_0.initBoss(arg_1_0, arg_1_1)
	arg_1_0.bossId = arg_1_1
	arg_1_0.selectTalentId = nil
end

function var_0_0.refreshList(arg_2_0)
	if #arg_2_0._scrollViews == 0 then
		return
	end

	local var_2_0 = TowerAssistBossModel.instance:getById(arg_2_0.bossId)

	if not var_2_0 then
		return
	end

	local var_2_1 = var_2_0:getTalentTree():getList()

	arg_2_0:setList(var_2_1)
end

function var_0_0.getSelectTalent(arg_3_0)
	return arg_3_0.selectTalentId
end

function var_0_0.isSelectTalent(arg_4_0, arg_4_1)
	return arg_4_0.selectTalentId == arg_4_1
end

function var_0_0.setSelectTalent(arg_5_0, arg_5_1)
	if arg_5_0:isSelectTalent(arg_5_1) then
		return
	end

	arg_5_0.selectTalentId = arg_5_1

	arg_5_0:refreshList()
	TowerController.instance:dispatchEvent(TowerEvent.SelectTalentItem)
end

function var_0_0.isTalentCanReset(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or arg_6_0.selectTalentId

	if not arg_6_1 then
		return false
	end

	local var_6_0 = TowerAssistBossModel.instance:getById(arg_6_0.bossId)

	if not var_6_0:isActiveTalent(arg_6_1) then
		return false
	end

	local var_6_1 = var_6_0:getTalentTree():getNode(arg_6_1)

	if not var_6_1 then
		return false
	end

	if not var_6_1:isLeafNode() then
		return false
	end

	return true
end

function var_0_0.setAutoTalentState(arg_7_0, arg_7_1)
	arg_7_0.isAutoTalent = arg_7_1
end

function var_0_0.getAutoTalentState(arg_8_0)
	return arg_8_0.isAutoTalent
end

var_0_0.instance = var_0_0.New()

return var_0_0
