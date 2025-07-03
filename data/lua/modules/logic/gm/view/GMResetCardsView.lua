module("modules.logic.gm.view.GMResetCardsView", package.seeall)

local var_0_0 = class("GMResetCardsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._btnOK = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnOK")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnOK:AddClickListener(arg_2_0._onClickOK, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnOK:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = FightDataHelper.handCardMgr.handCard

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		table.insert(var_4_0, {
			oldEntityId = iter_4_1.uid,
			oldSkillId = iter_4_1.skillId
		})
	end

	GMResetCardsModel.instance:getModel1():setList(var_4_0)

	local var_4_2 = {}
	local var_4_3 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	for iter_4_2, iter_4_3 in ipairs(var_4_3) do
		local var_4_4 = iter_4_3:getMO()

		for iter_4_4, iter_4_5 in ipairs(var_4_4.skillGroup1) do
			table.insert(var_4_2, {
				entityId = iter_4_3.id,
				skillId = iter_4_5
			})
		end

		for iter_4_6, iter_4_7 in ipairs(var_4_4.skillGroup2) do
			table.insert(var_4_2, {
				entityId = iter_4_3.id,
				skillId = iter_4_7
			})
		end

		table.insert(var_4_2, {
			entityId = iter_4_3.id,
			skillId = var_4_4.exSkill
		})
	end

	GMResetCardsModel.instance:getModel2():setList(var_4_2)
end

function var_0_0._onClickOK(arg_5_0)
	local var_5_0 = GMResetCardsModel.instance:getModel1()
	local var_5_1 = ""
	local var_5_2 = var_5_0:getCount()

	for iter_5_0, iter_5_1 in ipairs(var_5_0:getList()) do
		var_5_1 = var_5_1 .. (iter_5_1.newSkillId or iter_5_1.oldSkillId)

		if iter_5_0 < var_5_2 then
			var_5_1 = var_5_1 .. "#"
		end
	end

	GMRpc.instance:sendGMRequest("fight resetCards " .. var_5_1)
	arg_5_0:closeThis()
end

return var_0_0
