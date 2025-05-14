module("modules.logic.fight.view.preview.SkillEditorSkillSelectView", package.seeall)

local var_0_0 = class("SkillEditorSkillSelectView")

function var_0_0.ctor(arg_1_0)
	arg_1_0._curSkillId = nil
	arg_1_0._attackerId = nil
	arg_1_0._entityMO = nil
	arg_1_0._clickMask = nil
	arg_1_0._skillIds = {}
	arg_1_0._skillItemGOs = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._selectSkillGO = gohelper.findChild(arg_2_1, "btnSelectSkill")
	arg_2_0._txtSelect = gohelper.findChildText(arg_2_1, "btnSelectSkill/Text")
	arg_2_0._skillsGO = gohelper.findChild(arg_2_1, "selectSkills")
	arg_2_0._skillItemPrefab = gohelper.findChild(arg_2_1, "selectSkills/skill")
	arg_2_0._clickMask = gohelper.findChildClick(arg_2_1, "selectSkills/ClickMask")

	arg_2_0._clickMask:AddClickListener(arg_2_0._onClickMask, arg_2_0)
	gohelper.setActive(arg_2_0._skillItemPrefab, false)
end

function var_0_0.dispose(arg_3_0)
	arg_3_0._clickMask:RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._skillItemGOs) do
		SLFramework.UGUI.UIClickListener.Get(iter_3_1):RemoveClickListener()
	end
end

function var_0_0.show(arg_4_0)
	gohelper.setActive(arg_4_0._skillsGO, true)
	arg_4_0:_updateSelect()
end

function var_0_0.hide(arg_5_0)
	gohelper.setActive(arg_5_0._skillsGO, false)
end

function var_0_0.getSelectSkillId(arg_6_0)
	return arg_6_0._curSkillId
end

function var_0_0.setAttacker(arg_7_0, arg_7_1)
	local var_7_0 = FightDataHelper.entityMgr:getById(arg_7_0._attackerId)

	arg_7_0._attackerId = arg_7_1
	arg_7_0._entityMO = FightDataHelper.entityMgr:getById(arg_7_0._attackerId)
	arg_7_0._skillIds = {}

	if var_7_0 then
		if var_7_0.modelId == arg_7_0._entityMO.modelId then
			-- block empty
		else
			arg_7_0._curSkillId = nil
		end
	else
		arg_7_0._curSkillId = nil
	end

	local var_7_1 = arg_7_0:_getEntitySkillCOList(arg_7_0._entityMO)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = iter_7_1.id
		local var_7_3 = FightConfig.instance:getSkinSkillTimeline(arg_7_0._entityMO.skin, var_7_2)

		table.insert(arg_7_0._skillIds, var_7_2)

		if not arg_7_0._curSkillId then
			arg_7_0._curSkillId = var_7_2
			SkillEditorView.selectSkillId[arg_7_1] = arg_7_0._curSkillId
		end

		local var_7_4 = arg_7_0._skillItemGOs[iter_7_0]

		if not var_7_4 then
			var_7_4 = gohelper.clone(arg_7_0._skillItemPrefab, arg_7_0._skillsGO, "skill" .. iter_7_0)

			table.insert(arg_7_0._skillItemGOs, var_7_4)
		end

		SLFramework.UGUI.UIClickListener.Get(var_7_4):AddClickListener(arg_7_0._onClickSkillItem, arg_7_0, var_7_2)
		gohelper.setActive(var_7_4, true)

		local var_7_5 = gohelper.findChildText(var_7_4, "Text")
		local var_7_6 = string.split(var_7_3, "_")
		local var_7_7 = arg_7_0:_getStrengthenTag(arg_7_0._entityMO.modelId, var_7_2) or ""

		var_7_5.text = var_7_2 .. "\n" .. iter_7_1.name .. "\n" .. var_7_6[#var_7_6] .. var_7_7
	end

	for iter_7_2 = #var_7_1 + 1, #arg_7_0._skillItemGOs do
		gohelper.setActive(arg_7_0._skillItemGOs[iter_7_2], false)
	end

	arg_7_0:_updateSelect()
end

local var_0_1 = {
	"skillGroup1",
	"skillGroup2",
	"skillEx",
	"passiveSkill"
}

function var_0_0._getStrengthenTag(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = lua_skill_ex_level.configDict[arg_8_1]

	if var_8_0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			for iter_8_2, iter_8_3 in ipairs(var_0_1) do
				local var_8_1 = iter_8_1[iter_8_3]
				local var_8_2 = string.splitToNumber(var_8_1, "|")

				if tabletool.indexOf(var_8_2, arg_8_2) then
					return "塑造" .. iter_8_1.skillLevel
				end
			end
		end
	end
end

function var_0_0._getEntitySkillCOList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.skillIds) do
		local var_9_2 = lua_skill.configDict[iter_9_1]
		local var_9_3 = FightConfig.instance:getSkinSkillTimeline(arg_9_1.skin, iter_9_1)

		if var_9_2 and not string.nilorempty(var_9_3) then
			var_9_0[var_9_2.skillEffect] = true

			table.insert(var_9_1, var_9_2)
		end
	end

	local var_9_4 = tostring(arg_9_1.modelId)

	for iter_9_2, iter_9_3 in ipairs(lua_skill.configList) do
		local var_9_5 = tostring(iter_9_3.id)
		local var_9_6 = iter_9_3.timeline

		if string.find(var_9_5, var_9_4) == 1 and not string.nilorempty(var_9_6) and not var_9_0[iter_9_3.skillEffect] then
			var_9_0[iter_9_3.skillEffect] = true

			table.insert(var_9_1, iter_9_3)
		end
	end

	return var_9_1
end

function var_0_0._onClickMask(arg_10_0)
	gohelper.setActive(arg_10_0._skillsGO, false)
end

function var_0_0._onClickSkillItem(arg_11_0, arg_11_1)
	TaskDispatcher.cancelTask(arg_11_0.hide, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.hide, arg_11_0, 0.2)

	arg_11_0._curSkillId = arg_11_1
	SkillEditorView.selectSkillId[arg_11_0._attackerId] = arg_11_0._curSkillId

	arg_11_0:_updateSelect()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectSkill, arg_11_0._entityMO, arg_11_1)
end

function var_0_0._updateSelect(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._skillIds) do
		local var_12_0 = arg_12_0._skillItemGOs[iter_12_0]

		if var_12_0 then
			local var_12_1 = gohelper.findChild(var_12_0, "imgSelect")

			gohelper.setActive(var_12_1, iter_12_1 == arg_12_0._curSkillId)
		end
	end

	local var_12_2 = lua_skill.configDict[arg_12_0._curSkillId]

	if var_12_2 then
		local var_12_3 = FightConfig.instance:getSkinSkillTimeline(arg_12_0._entityMO.skin, arg_12_0._curSkillId)
		local var_12_4 = string.split(var_12_3, "_")

		arg_12_0._txtSelect.text = arg_12_0._curSkillId .. "\n" .. var_12_2.name .. "\n" .. var_12_4[#var_12_4]
	else
		arg_12_0._txtSelect.text = "None"
	end
end

return var_0_0
