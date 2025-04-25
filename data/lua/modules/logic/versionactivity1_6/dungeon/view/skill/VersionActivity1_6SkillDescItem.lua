module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillDescItem", package.seeall)

slot0 = class("VersionActivity1_6SkillDescItem", UserDataDispose)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._skillCfg = slot2
	slot0.go = slot1
	slot0.parentView = slot3
	slot0.txtlv = gohelper.findChildText(slot1, "descripteitem/#txt_skillevel")
	slot0.txtskillDesc = gohelper.findChildText(slot1, "descripteitem/#txt_descripte")
	slot0.canvasGroup = gohelper.onceAddComponent(slot0.txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	slot0.txtlvcanvasGroup = gohelper.onceAddComponent(slot0.txtlv.gameObject, gohelper.Type_CanvasGroup)
	slot0.goCurLvFlag = gohelper.findChild(slot1, "descripteitem/#go_curlevel")
	slot0.vx = gohelper.findChild(slot1, "descripteitem/vx")
	slot0.txtCostNum = gohelper.findChildText(slot1, "descripteitem/#txt_descripte/Prop/#txt_Num")
	slot0.imageCostIcon = gohelper.findChildImage(slot1, "descripteitem/#txt_descripte/Prop/#simage_Prop")

	gohelper.setActive(slot0.vx, false)

	slot0._needUseSkillEffDescList = {}
	slot0._needUseSkillEffDescList2 = {}
end

function slot0.refreshInfo(slot0)
	slot1 = slot0._skillCfg.level
	slot3 = slot0._skillCfg.attrs
	slot4 = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[slot1]
	slot0.lv = slot1
	slot0.txtlv.text = slot0._skillCfg.level
	slot0._hyperLinkClick = slot0.txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot5 = ""

	if slot0._skillCfg.skillId and slot2 ~= 0 then
		slot5 = FightConfig.instance:getSkillEffectDesc(nil, FightConfig.instance:getSkillEffectCO(slot2))
	elseif slot3 then
		slot6 = string.splitToNumber(slot3, "#")
		slot8 = slot6[2]
		slot9 = lua_skill_effect.configDict[slot6[1]]
		slot5 = slot0._skillCfg.skillAttrDesc
	end

	slot5 = slot0:_buildLinkTag(HeroSkillModel.instance:formatDescWithColor(slot5, "#deaa79", "#7e99d0"))
	slot0.height = GameUtil.getTextHeightByLine(slot0.txtskillDesc, slot5, 28, -3) + 42

	recthelper.setHeight(slot0.go.transform, slot0.height)

	slot0.txtskillDesc.text = slot5
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.txtskillDesc.gameObject, FixTmpBreakLine)

	slot0._fixTmpBreakLine:refreshTmpContent(slot0.txtskillDesc)

	if Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillCfg.type, slot0._skillCfg.level) then
		slot0.txtCostNum.text = string.splitToNumber(slot7.cost, "#")[3]
	end

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imageCostIcon, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill) and slot8.icon))
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if not slot0._needUseSkillEffDescList[slot0._needUseSkillEffDescList2[tonumber(slot1)]] then
		return
	end

	slot0.parentView:showBuffContainer(SkillConfig.instance:processSkillDesKeyWords(slot1), slot0._needUseSkillEffDescList[slot1], slot2)
end

function slot0._buildLinkTag(slot0, slot1)
	slot1 = string.gsub(string.gsub(slot1, "】", "]"), "【", "[")
	slot4 = {}
	slot5 = nil

	for slot9, slot10 in function ()
		return string.find(uv0, "[%[%]]", uv1)
	end, nil,  do
		slot5 = string.sub(slot1, 0, slot9 - 1)

		if (0 + 1) % 2 == 0 then
			slot5 = (not slot0:_buildSkillEffDescCo(slot5) or string.format("<u><link=%s>[%s]</link></u>", slot11, SkillConfig.instance:processSkillDesKeyWords(slot5))) and string.format("[%s]", slot5)
		end

		table.insert(slot4, slot5)

		slot2 = slot10 + 1
	end

	table.insert(slot4, string.sub(slot1, slot2))

	return table.concat(slot4)
end

function slot0._buildSkillEffDescCo(slot0, slot1)
	for slot5, slot6 in ipairs(lua_skill_eff_desc.configList) do
		if slot6.name == slot1 then
			if SkillHelper.canShowTag(slot6) then
				if not tabletool.indexOf(slot0._needUseSkillEffDescList2, slot1) then
					slot0._needUseSkillEffDescList2[#slot0._needUseSkillEffDescList2 + 1] = slot1
				end

				slot0._needUseSkillEffDescList[slot1] = slot6.desc

				return slot7
			else
				return nil
			end
		end
	end
end

return slot0
