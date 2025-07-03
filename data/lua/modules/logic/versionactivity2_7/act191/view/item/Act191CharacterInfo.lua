module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterInfo", package.seeall)

local var_0_0 = class("Act191CharacterInfo", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0.goSkill = gohelper.findChild(arg_1_1, "go_characterinfo/go_skill")
	arg_1_0.txtPassiveName = gohelper.findChildText(arg_1_1, "go_characterinfo/passiveskill/bg/txt_passivename")
	arg_1_0.btnPassiveSkill = gohelper.findChildButtonWithAudio(arg_1_1, "go_characterinfo/passiveskill/btn_passiveskill")

	arg_1_0:addClickCb(arg_1_0.btnPassiveSkill, arg_1_0.onClickPassiveSkill, arg_1_0)

	for iter_1_0 = 1, 5 do
		local var_1_0 = gohelper.findChild(arg_1_1, "go_characterinfo/attribute/go_attribute/attribute" .. iter_1_0)

		arg_1_0["txtAttr" .. iter_1_0] = gohelper.findChildText(var_1_0, "txt_attribute")
		arg_1_0["txtAttrName" .. iter_1_0] = gohelper.findChildText(var_1_0, "name")
	end

	arg_1_0.goPassiveSkill = gohelper.findChild(arg_1_1, "go_characterinfo/passiveskill/go_passiveskills")

	for iter_1_1 = 1, 3 do
		arg_1_0["goPassiveSkill" .. iter_1_1] = gohelper.findChild(arg_1_0.goPassiveSkill, "passiveskill" .. iter_1_1)
	end

	arg_1_0._detailPassiveTables = {}
	arg_1_0.goDetail = gohelper.findChild(arg_1_1, "go_detailView")
	arg_1_0.btnCloseDetail = gohelper.findChildButtonWithAudio(arg_1_0.goDetail, "btn_detailClose")
	arg_1_0.goDetailItem = gohelper.findChild(arg_1_0.goDetail, "scroll_content/viewport/content/go_detailpassiveitem")

	arg_1_0:addClickCb(arg_1_0.btnCloseDetail, arg_1_0.onClickCloseDetail, arg_1_0)

	arg_1_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goSkill, Act191SkillContainer)
end

function var_0_0.onDestroy(arg_2_0)
	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.config = arg_3_1
	arg_3_0.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(arg_3_1.id)

	local var_3_0 = lua_activity191_template.configDict[arg_3_1.id]

	for iter_3_0 = 1, 5 do
		local var_3_1 = Activity191Enum.AttrIdList[iter_3_0]
		local var_3_2 = HeroConfig.instance:getHeroAttributeCO(var_3_1).name

		arg_3_0["txtAttrName" .. iter_3_0].text = var_3_2
		arg_3_0["txtAttr" .. iter_3_0].text = var_3_0[Activity191Config.AttrIdToFieldName[var_3_1]]
	end

	local var_3_3 = lua_skill.configDict[arg_3_0.passiveSkillIds[1]]

	if var_3_3 then
		arg_3_0.txtPassiveName.text = var_3_3.name
	end

	local var_3_4

	if arg_3_1.type == Activity191Enum.CharacterType.Hero then
		var_3_4 = #SkillConfig.instance:getheroranksCO(arg_3_1.roleId) - 1
	else
		var_3_4 = 0
	end

	for iter_3_1 = 1, 3 do
		local var_3_5 = arg_3_0["goPassiveSkill" .. iter_3_1]

		gohelper.setActive(var_3_5, iter_3_1 <= var_3_4)
	end

	arg_3_0._skillContainer:onUpdateMO(arg_3_1)
end

function var_0_0.onClickPassiveSkill(arg_4_0)
	if arg_4_0.config.type == Activity191Enum.CharacterType.Hero then
		local var_4_0 = {
			id = arg_4_0.config.id,
			tipPos = Vector2.New(851, -59)
		}

		var_4_0.buffTipsX = 1603
		var_4_0.anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		}

		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, var_4_0)
	else
		arg_4_0:refreshPassiveDetail()
		gohelper.setActive(arg_4_0.goDetail, true)
	end
end

function var_0_0.refreshPassiveDetail(arg_5_0)
	local var_5_0 = #arg_5_0.passiveSkillIds

	for iter_5_0 = 1, var_5_0 do
		local var_5_1 = tonumber(arg_5_0.passiveSkillIds[iter_5_0])
		local var_5_2 = lua_skill.configDict[var_5_1]

		if var_5_2 then
			local var_5_3 = arg_5_0._detailPassiveTables[iter_5_0]

			if not var_5_3 then
				local var_5_4 = gohelper.cloneInPlace(arg_5_0.goDetailItem, "item" .. iter_5_0)

				var_5_3 = arg_5_0:getUserDataTb_()
				var_5_3.go = var_5_4
				var_5_3.name = gohelper.findChildText(var_5_4, "title/txt_name")
				var_5_3.icon = gohelper.findChildSingleImage(var_5_4, "title/simage_icon")
				var_5_3.desc = gohelper.findChildText(var_5_4, "txt_desc")

				SkillHelper.addHyperLinkClick(var_5_3.desc, arg_5_0.onClickHyperLink, arg_5_0)

				var_5_3.line = gohelper.findChild(var_5_4, "txt_desc/image_line")

				table.insert(arg_5_0._detailPassiveTables, var_5_3)
			end

			var_5_3.name.text = var_5_2.name
			var_5_3.desc.text = SkillHelper.getSkillDesc(arg_5_0.config.name, var_5_2)

			gohelper.setActive(var_5_3.go, true)
			gohelper.setActive(var_5_3.line, iter_5_0 < var_5_0)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_5_1))
		end
	end

	for iter_5_1 = var_5_0 + 1, #arg_5_0._detailPassiveTables do
		gohelper.setActive(arg_5_0._detailPassiveTables[iter_5_1].go, false)
	end
end

function var_0_0.onClickCloseDetail(arg_6_0)
	gohelper.setActive(arg_6_0.goDetail, false)
end

function var_0_0.onClickHyperLink(arg_7_0, arg_7_1)
	local var_7_0 = Vector2.New(40, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_7_1, var_7_0)
end

return var_0_0
