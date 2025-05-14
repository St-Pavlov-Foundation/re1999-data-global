module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillSelectModel", package.seeall)

local var_0_0 = class("SkillEditorToolAutoPlaySkillSelectModel", ListScrollModel)

function var_0_0.selectAll(arg_1_0)
	arg_1_0._selectList = SkillEditorToolAutoPlaySkillModel.instance:getList()

	arg_1_0:setList(arg_1_0._selectList)
end

function var_0_0.cancelSelectAll(arg_2_0)
	if not arg_2_0._selectList or #arg_2_0._selectList == 0 then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._selectList) do
		arg_2_0:remove(iter_2_1)
	end

	arg_2_0._selectList = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
