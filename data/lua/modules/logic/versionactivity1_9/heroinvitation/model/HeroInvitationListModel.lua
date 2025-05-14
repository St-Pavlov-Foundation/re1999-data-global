module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationListModel", package.seeall)

local var_0_0 = class("HeroInvitationListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	local var_1_0 = HeroInvitationConfig.instance:getInvitationList()

	arg_1_0.count = #var_1_0
	arg_1_0.finishCount = 0

	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if HeroInvitationModel.instance:getInvitationState(iter_1_1.id) == HeroInvitationEnum.InvitationState.Finish then
			arg_1_0.finishCount = arg_1_0.finishCount + 1
		end

		table.insert(var_1_1, iter_1_1)
	end

	table.sort(var_1_1, SortUtil.keyLower("id"))
	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
