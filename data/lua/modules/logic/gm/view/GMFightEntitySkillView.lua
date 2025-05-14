module("modules.logic.gm.view.GMFightEntitySkillView", package.seeall)

local var_0_0 = class("GMFightEntitySkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._input = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "skill/add/input")
	arg_1_0._btnAdd = gohelper.findChildButton(arg_1_0.viewGO, "skill/add/btnAdd")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._onClickAddSkill, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAdd:RemoveClickListener()
end

function var_0_0._onClickAddSkill(arg_4_0)
	local var_4_0 = tonumber(arg_4_0._input:GetText())
	local var_4_1 = lua_skill.configDict[var_4_0]
	local var_4_2 = GMFightEntityModel.instance.entityMO

	if tabletool.indexOf(var_4_2.skillList, var_4_0) then
		GameFacade.showToast(ToastEnum.IconId, "skill has exist")
	elseif var_4_1 then
		GMRpc.instance:sendGMRequest(string.format("fightAddPassiveSkill %s %s", tostring(var_4_2.id), tostring(var_4_0)))
		var_4_2:addPassiveSkill(var_4_0)
		GMFightEntityModel.instance:setEntityMO(var_4_2)

		local var_4_3 = FightLocalDataMgr.instance.entityMgr:getById(var_4_2.id)

		if var_4_3 then
			FightEntityDataHelper.copyEntityMO(var_4_2, var_4_3)
		end
	else
		GameFacade.showToast(ToastEnum.IconId, "skill not exist")
	end
end

return var_0_0
