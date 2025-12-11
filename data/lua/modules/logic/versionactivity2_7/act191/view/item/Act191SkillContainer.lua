module("modules.logic.versionactivity2_7.act191.view.item.Act191SkillContainer", package.seeall)

local var_0_0 = class("Act191SkillContainer", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goskills = gohelper.findChild(arg_1_1, "line/go_skills")
	arg_1_0._skillitems = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		local var_1_0 = gohelper.findChild(arg_1_0._goskills, "skillicon" .. tostring(iter_1_0))
		local var_1_1 = {
			icon = gohelper.findChildSingleImage(var_1_0, "imgIcon"),
			tag = gohelper.findChildSingleImage(var_1_0, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(var_1_0, "bg", AudioEnum.UI.Play_ui_role_description),
			index = iter_1_0
		}

		var_1_1.btn:AddClickListener(arg_1_0._onSkillCardClick, arg_1_0, var_1_1.index)

		arg_1_0._skillitems[iter_1_0] = var_1_1
	end
end

function var_0_0.onDestroy(arg_2_0)
	for iter_2_0 = 1, 3 do
		arg_2_0._skillitems[iter_2_0].btn:RemoveClickListener()
		arg_2_0._skillitems[iter_2_0].icon:UnLoadImage()
		arg_2_0._skillitems[iter_2_0].tag:UnLoadImage()
	end
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0._roleId = arg_3_1.id
	arg_3_0._heroId = arg_3_1.roleId
	arg_3_0._heroName = arg_3_1.name

	arg_3_0:_refreshSkillUI()
end

function var_0_0._refreshSkillUI(arg_4_0)
	if arg_4_0._roleId then
		local var_4_0 = Activity191Config.instance:getHeroSkillIdDic(arg_4_0._roleId, true)

		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			local var_4_1 = lua_skill.configDict[iter_4_1]

			if var_4_1 then
				arg_4_0._skillitems[iter_4_0].icon:LoadImage(ResUrl.getSkillIcon(var_4_1.icon))
				arg_4_0._skillitems[iter_4_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_4_1.showTag))
			else
				logError(string.format("heroID : %s, skillId not found : %s", arg_4_0._roleId, iter_4_1))
			end

			gohelper.setActive(arg_4_0._skillitems[iter_4_0].tag.gameObject, iter_4_0 ~= 3)
		end
	end
end

function var_0_0._onSkillCardClick(arg_5_0, arg_5_1)
	if arg_5_0._roleId then
		local var_5_0 = {}
		local var_5_1 = Activity191Config.instance:getHeroSkillIdDic(arg_5_0._roleId)

		var_5_0.super = arg_5_1 == 3
		var_5_0.skillIdList = var_5_1[arg_5_1]
		var_5_0.monsterName = arg_5_0._heroName
		var_5_0.skillIndex = arg_5_1

		ViewMgr.instance:openView(ViewName.SkillTipView, var_5_0)
	end
end

return var_0_0
