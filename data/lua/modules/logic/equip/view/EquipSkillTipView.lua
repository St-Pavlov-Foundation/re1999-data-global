module("modules.logic.equip.view.EquipSkillTipView", package.seeall)

local var_0_0 = class("EquipSkillTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "#go_skill")
	arg_1_0._btnclosedetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_skill/#btn_closedetail")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_skill/Scroll View/Viewport/#go_content")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/attributename/#txt_attributelv")
	arg_1_0._txtmeshcurlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/#go_suiteffect/#txt_meshcurlevel")
	arg_1_0._txtmeshalllevel = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_skill/Scroll View/Viewport/#go_content/allleveldesc/#txtmesh_alllevel")
	arg_1_0._gocharacter = gohelper.findChild(arg_1_0.viewGO, "#go_character")
	arg_1_0._scrollcharacter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_character/#scroll_character")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_character/#txt_title")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosedetail:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnclosedetailOnClick(arg_5_0)
	arg_5_0:hideCharacter()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._hyperLinkClick = gohelper.onceAddComponent(arg_6_0._txtmeshalllevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	arg_6_0._hyperLinkClick:SetClickListener(arg_6_0._onHyperLinkClick, arg_6_0)

	arg_6_0._hyperLinkClick2 = gohelper.onceAddComponent(arg_6_0._txtmeshcurlevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	arg_6_0._hyperLinkClick2:SetClickListener(arg_6_0._onHyperLinkClick, arg_6_0)
end

function var_0_0._onHyperLinkClick(arg_7_0)
	arg_7_0:showCharacter()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._equipMO = arg_9_0.viewParam[1]
	arg_9_0._equipId = arg_9_0._equipMO and arg_9_0._equipMO.config.id or arg_9_0.viewParam[2]
	arg_9_0._showCharacter = arg_9_0.viewParam[3]
	arg_9_0._characterScreenPos = arg_9_0.viewParam[4]
	arg_9_0._config = arg_9_0._equipMO and arg_9_0._equipMO.config or EquipConfig.instance:getEquipCo(arg_9_0._equipId)
	arg_9_0._breakLv = arg_9_0._equipMO and arg_9_0._equipMO.breakLv or EquipConfig.instance:getMaxBreakLevel()
	arg_9_0._level = arg_9_0._equipMO and arg_9_0._equipMO.level or EquipConfig.instance:getMaxLevel(arg_9_0._breakLv)
	arg_9_0._refineLv = arg_9_0._equipMO and arg_9_0._equipMO.refineLv or 1
	arg_9_0._equipSkillCo = EquipConfig.instance:getEquipSkillCfg(arg_9_0._config.skillType, arg_9_0._refineLv)

	gohelper.setActive(arg_9_0._gocharacter, false)
	gohelper.setActive(arg_9_0._goskill, false)
	gohelper.setActive(arg_9_0._btnclosedetail.gameObject, false)

	if arg_9_0._showCharacter then
		arg_9_0:showCharacter()
	else
		arg_9_0:showSkill()
	end

	NavigateMgr.instance:addEscape(ViewName.EquipSkillTipView, arg_9_0._btncloseOnClick, arg_9_0)
end

function var_0_0.showCharacter(arg_10_0)
	gohelper.setActive(arg_10_0._gocharacter, true)

	arg_10_0._txttitle.text = string.format(luaLang("equip_suitable_characters"), arg_10_0._config.feature)

	if not string.nilorempty(arg_10_0._config.cardGroup) then
		local var_10_0 = string.split(arg_10_0._config.cardGroup, "|")
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			table.insert(var_10_1, {
				id = tonumber(iter_10_1)
			})
		end

		EquipSkillCharacterListModel.instance:setList(var_10_1)
	end

	if arg_10_0._characterScreenPos then
		local var_10_2 = recthelper.screenPosToAnchorPos(arg_10_0._characterScreenPos, arg_10_0.viewGO.transform)

		recthelper.setAnchor(arg_10_0._gocharacter.transform, var_10_2.x, var_10_2.y)
	end

	gohelper.setActive(arg_10_0._btnclosedetail.gameObject, true)
end

function var_0_0.hideCharacter(arg_11_0)
	gohelper.setActive(arg_11_0._gocharacter, false)
	gohelper.setActive(arg_11_0._btnclosedetail.gameObject, false)
end

function var_0_0.showSkill(arg_12_0)
	gohelper.setActive(arg_12_0._goskill, true)
	arg_12_0:showCurLevel()
	arg_12_0:showAllLevel()
end

function var_0_0.showCurLevel(arg_13_0)
	local var_13_0 = EquipConfig.instance:getEquipSkillCfg(arg_13_0._config.skillType, arg_13_0._refineLv)
	local var_13_1 = string.format("%s", HeroSkillModel.instance:spotSkillAttribute(var_13_0.baseDesc))

	arg_13_0._txtattributelv.text = var_13_0.skillLv + 1
	arg_13_0._txtmeshcurlevel.text = var_13_1
end

function var_0_0.showAllLevel(arg_14_0)
	local var_14_0 = arg_14_0._config.skillType

	if var_14_0 <= 0 then
		return
	end

	local var_14_1 = arg_14_0._txtmeshalllevel.preferredHeight
	local var_14_2 = ""

	arg_14_0._curSkillCfg = EquipConfig.instance:getEquipSkillCfg(var_14_0, arg_14_0._refineLv)

	for iter_14_0, iter_14_1 in pairs(lua_equip_skill.configDict[var_14_0]) do
		if iter_14_0 > 0 then
			local var_14_3 = string.format("Lv.%s:%s", iter_14_0 + 1, HeroSkillModel.instance:spotSkillAttribute(iter_14_1.upDesc))

			if not LuaUtil.isEmptyStr(iter_14_1.spUpDesc) then
				var_14_3 = string.format("%s\n<#4b93d6><u><link='%s'>[%s]</link></u></color>:%s", var_14_3, iter_14_0, arg_14_0._config.feature, HeroSkillModel.instance:spotSkillAttribute(iter_14_1.spUpDesc))
			end

			if iter_14_1 == arg_14_0._curSkillCfg then
				var_14_3 = string.format("<#805e00>%s</color>", var_14_3)
			end

			if var_14_2 == "" then
				var_14_2 = var_14_3
			else
				var_14_2 = string.format("%s\n%s", var_14_2, var_14_3)
			end
		end
	end

	arg_14_0._txtmeshalllevel.text = var_14_2

	local var_14_4 = arg_14_0._txtmeshalllevel.preferredHeight - var_14_1
	local var_14_5 = recthelper.getHeight(arg_14_0._gocontent.transform)

	recthelper.setHeight(arg_14_0._gocontent.transform, var_14_5 + var_14_4)
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
