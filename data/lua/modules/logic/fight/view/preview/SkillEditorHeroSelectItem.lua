module("modules.logic.fight.view.preview.SkillEditorHeroSelectItem", package.seeall)

local var_0_0 = class("SkillEditorHeroSelectItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._text = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._text1 = gohelper.findChildText(arg_1_1, "imgSelect/Text")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "imgSelect")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_1.co

	if SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		arg_4_0._text.text = var_4_0.skinId .. (var_4_0.name and "\n" .. var_4_0.name or "")
		arg_4_0._text1.text = var_4_0.skinId .. (var_4_0.name and "\n" .. var_4_0.name or "")
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Monster then
		local var_4_1 = FightConfig.instance:getSkinCO(var_4_0.skinId)
		local var_4_2 = var_4_1 and var_4_1.name or nil

		if not var_4_1 then
			logError("皮肤表找不到id,怪物模型id：", var_4_0.skinId)
		end

		arg_4_0._text.text = var_4_0.skinId .. (var_4_2 and "\n" .. var_4_2 or "")
		arg_4_0._text1.text = var_4_0.skinId .. (var_4_2 and "\n" .. var_4_2 or "")
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Group then
		local var_4_3 = string.splitToNumber(var_4_0.monster, "#")
		local var_4_4 = lua_monster.configDict[var_4_3[1]]

		for iter_4_0 = 2, #var_4_3 do
			if tabletool.indexOf(string.splitToNumber(var_4_0.bossId, "#"), var_4_3[iter_4_0]) then
				var_4_4 = lua_monster.configDict[var_4_3[iter_4_0]]

				break
			end
		end

		arg_4_0._text.text = var_4_0.id .. (var_4_4 and var_4_4.name and "\n" .. var_4_4.name or "")
		arg_4_0._text1.text = var_4_0.id .. (var_4_4 and var_4_4.name and "\n" .. var_4_4.name or "")
	else
		arg_4_0._text.text = var_4_0.id .. (var_4_0.name and "\n" .. var_4_0.name or "")
		arg_4_0._text1.text = var_4_0.id .. (var_4_0.name and "\n" .. var_4_0.name or "")
	end
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._selectGO, arg_5_1)
end

function var_0_0._onClickThis(arg_6_0)
	arg_6_0._view:selectCell(arg_6_0._mo.id, true)

	local var_6_0 = SkillEditorHeroSelectModel.instance.selectType
	local var_6_1 = SkillEditorHeroSelectModel.instance.side
	local var_6_2 = SkillEditorHeroSelectModel.instance.stancePosId
	local var_6_3, var_6_4 = SkillEditorMgr.instance:getTypeInfo(var_6_1)
	local var_6_5 = arg_6_0._mo.co
	local var_6_6 = arg_6_0._mo.co.id

	if var_6_0 == SkillEditorMgr.SelectType.Group then
		var_6_4.ids = {}
		var_6_4.skinIds = {}
		var_6_4.groupId = var_6_6

		local var_6_7 = lua_monster_group.configDict[var_6_6]
		local var_6_8 = string.splitToNumber(var_6_7.monster, "#")

		for iter_6_0, iter_6_1 in ipairs(var_6_8) do
			local var_6_9 = lua_monster.configDict[iter_6_1]

			if var_6_9 then
				local var_6_10 = FightConfig.instance:getSkinCO(var_6_9.skinId)

				if not var_6_10 or string.nilorempty(var_6_10.spine) then
					GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, var_6_5.skinId or var_6_5.id)

					return
				end

				table.insert(var_6_4.ids, iter_6_1)
				table.insert(var_6_4.skinIds, var_6_9.skinId)
			end
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectStance, var_6_1, var_6_7.stanceId, false)
	elseif var_6_0 == SkillEditorMgr.SelectType.SubHero then
		SkillEditorMgr.instance:addSubHero(arg_6_0._mo.co.id, arg_6_0._mo.co.skinId)

		return
	else
		local var_6_11 = var_6_4.ids[1]
		local var_6_12 = var_6_0 == SkillEditorMgr.SelectType.Hero and arg_6_0._mo.co or lua_monster.configDict[var_6_6]
		local var_6_13 = FightConfig.instance:getSkinCO(var_6_12.skinId)

		if not var_6_13 or string.nilorempty(var_6_13.spine) then
			GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, var_6_12.skinId or var_6_12.id)

			return
		end

		if var_6_2 then
			var_6_4.ids[var_6_2] = var_6_6
			var_6_4.skinIds[var_6_2] = var_6_12.skinId
		else
			for iter_6_2, iter_6_3 in ipairs(var_6_4.ids) do
				if iter_6_3 == var_6_11 or var_6_3 ~= var_6_0 then
					var_6_4.ids[iter_6_2] = var_6_6
					var_6_4.skinIds[iter_6_2] = var_6_12.skinId
				end
			end
		end

		var_6_4.groupId = nil
	end

	SkillEditorMgr.instance:setTypeInfo(var_6_1, var_6_0, var_6_4.ids, var_6_4.skinIds, var_6_4.groupId)
	SkillEditorMgr.instance:refreshInfo(var_6_1)
	SkillEditorMgr.instance:rebuildEntitys(var_6_1)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, var_6_1)
end

return var_0_0
