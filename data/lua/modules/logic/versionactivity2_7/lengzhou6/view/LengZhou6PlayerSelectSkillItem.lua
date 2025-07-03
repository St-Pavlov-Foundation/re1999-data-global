module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6PlayerSelectSkillItem", package.seeall)

local var_0_0 = class("LengZhou6PlayerSelectSkillItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._txtSkillDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_SkillDescr")
	arg_1_0._txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "#txt_SkillDescr/#txt_SkillName")
	arg_1_0._imageSkillIIcon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_SkillDescr/Skill/SkillIconMask/#image_SkillIIcon")
	arg_1_0._imageSkillSmallIcon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_SkillDescr/Skill/#image_SkillSmallIcon/#txt_num")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "#txt_SkillDescr/#txt_Round")
	arg_1_0._goClick = gohelper.findChild(arg_1_0.viewGO, "#txt_SkillDescr/#go_Click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._skillGoClick = SLFramework.UGUI.UIClickListener.Get(arg_5_0._goClick)

	arg_5_0._skillGoClick:AddClickListener(arg_5_0._select, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	if arg_6_0._skillGoClick then
		arg_6_0._skillGoClick:RemoveClickListener()

		arg_6_0._skillGoClick = nil
	end
end

function var_0_0._select(arg_7_0)
	if arg_7_0._skillId == nil then
		return
	end

	if LengZhou6GameModel.instance:isSelectSkill(arg_7_0._skillId) then
		return
	end

	LengZhou6GameModel.instance:setPlayerSelectSkillId(arg_7_0._selectIndex, arg_7_0._skillId)
	arg_7_0:refreshSelect()
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.PlayerSelectFinish, arg_7_0._selectIndex, arg_7_0._skillId)
end

function var_0_0.initSkill(arg_8_0, arg_8_1)
	arg_8_0._skillId = arg_8_1
	arg_8_0._config = LengZhou6Config.instance:getEliminateBattleSkill(arg_8_1)

	if arg_8_0._config ~= nil then
		arg_8_0:initItem()
		arg_8_0:refreshSelect()
	end
end

function var_0_0.initSelectIndex(arg_9_0, arg_9_1)
	arg_9_0._selectIndex = arg_9_1
end

function var_0_0.refreshSelect(arg_10_0)
	local var_10_0 = LengZhou6GameModel.instance:isSelectSkill(arg_10_0._skillId)

	gohelper.setActive(arg_10_0._goSelected, var_10_0)
end

function var_0_0.initItem(arg_11_0)
	if arg_11_0._config.type == LengZhou6Enum.SkillType.active then
		arg_11_0._txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), arg_11_0._config.cd)
	else
		arg_11_0._txtRound.text = luaLang("lengZhou6_skill_round_end")
	end

	arg_11_0._txtSkillDescr.text = arg_11_0._config.desc

	local var_11_0 = arg_11_0._config.icon

	if var_11_0 ~= nil then
		local var_11_1 = string.split(var_11_0, "#")

		UISpriteSetMgr.instance:setHisSaBethSprite(arg_11_0._imageSkillIIcon, var_11_1[1])

		local var_11_2 = var_11_1[2] ~= nil

		if var_11_2 then
			UISpriteSetMgr.instance:setHisSaBethSprite(arg_11_0._imageSkillSmallIcon, var_11_1[2])
		end

		gohelper.setActive(arg_11_0._imageSkillSmallIcon.gameObject, var_11_2)
	end

	local var_11_3 = arg_11_0._config.effect

	if var_11_3 ~= nil then
		local var_11_4 = string.split(var_11_3, "#")

		if var_11_4[1] == LengZhou6Enum.SkillEffect.DealsDamage then
			local var_11_5 = tonumber(var_11_4[2])

			arg_11_0._txtnum.text = var_11_5
		end

		gohelper.setActive(arg_11_0._txtnum.gameObject, var_11_4[1] == LengZhou6Enum.SkillEffect.DealsDamage)
	end

	arg_11_0._txtSkillName.text = arg_11_0._config.name
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
