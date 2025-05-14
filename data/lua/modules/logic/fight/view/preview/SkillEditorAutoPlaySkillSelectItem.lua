module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillSelectItem", package.seeall)

local var_0_0 = class("SkillEditorAutoPlaySkillSelectItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._text = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_1, "imgRemove")
	arg_1_0._btnUseSkin = gohelper.findChildButtonWithAudio(arg_1_1, "btn_skin")
	arg_1_0._goNoUseImg = gohelper.findChild(arg_1_1, "btn_skin/nouse")
	arg_1_0._goUseImg = gohelper.findChild(arg_1_1, "btn_skin/use")

	gohelper.setActive(arg_1_1, true)
	gohelper.setActive(arg_1_0._goNoUseImg, true)
	gohelper.setActive(arg_1_0._goUseImg, false)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
	arg_2_0._btnUseSkin:AddClickListener(arg_2_0._openSelectScroll, arg_2_0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._SelectAutoPlaySkin, arg_2_0._selectSkin, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._btnUseSkin:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._SelectAutoPlaySkin, arg_3_0._selectSkin, arg_3_0)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_1.co

	if arg_4_1.type == SkillEditorMgr.SelectType.Hero then
		arg_4_0._text.text = var_4_0.skinId .. (var_4_0.name and "\n" .. var_4_0.name or "")
	elseif arg_4_1.type == SkillEditorMgr.SelectType.Monster then
		local var_4_1 = FightConfig.instance:getSkinCO(var_4_0.skinId)
		local var_4_2 = var_4_1 and var_4_1.name or nil

		if not var_4_1 then
			logError("皮肤表找不到id,怪物模型id：", var_4_0.skinId)
		end

		arg_4_0._text.text = var_4_0.skinId .. (var_4_2 and "\n" .. var_4_2 or "")
	elseif arg_4_1.type == SkillEditorMgr.SelectType.Group then
		local var_4_3 = string.splitToNumber(var_4_0.monster, "#")
		local var_4_4 = lua_monster.configDict[var_4_3[1]]

		for iter_4_0 = 2, #var_4_3 do
			if tabletool.indexOf(string.splitToNumber(var_4_0.bossId, "#"), var_4_3[iter_4_0]) then
				var_4_4 = lua_monster.configDict[var_4_3[iter_4_0]]

				break
			end
		end

		arg_4_0._text.text = var_4_0.id .. (var_4_4 and var_4_4.name and "\n" .. var_4_4.name or "")
	else
		arg_4_0._text.text = var_4_0.id .. (var_4_0.name and "\n" .. var_4_0.name or "")
	end
end

function var_0_0._openSelectScroll(arg_5_0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._OpenAutoPlaySkin, arg_5_0._mo)
end

function var_0_0._selectSkin(arg_6_0, arg_6_1)
	if arg_6_0._mo.co.id == arg_6_1.roleid then
		local var_6_0 = arg_6_0._mo.skinId ~= arg_6_1.skinid

		gohelper.setActive(arg_6_0._goNoUseImg, not var_6_0)
		gohelper.setActive(arg_6_0._goUseImg, var_6_0)

		if var_6_0 then
			arg_6_0._mo.skinId = arg_6_1.skinid
		else
			arg_6_0._mo.skinId = arg_6_0._mo.co.skinId
		end

		SkillEditorToolAutoPlaySkillSelectModel.instance:addAt(arg_6_0._mo, arg_6_0._index)
	end
end

function var_0_0._onClickThis(arg_7_0)
	SkillEditorToolAutoPlaySkillSelectModel.instance:removeAt(arg_7_0._index)
end

return var_0_0
