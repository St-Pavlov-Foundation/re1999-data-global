module("modules.logic.tower.view.assistboss.TowerBossSkillTipsView", package.seeall)

slot0 = class("TowerBossSkillTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	slot0._gopassiveskilltip = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip")
	slot0._goeffectdesc = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	slot0._goeffectdescitem = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	slot0._gomask1 = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	slot0._simageshadow = gohelper.findChildSingleImage(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	slot0._btnclosepassivetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")
	slot0._passiveskillitems = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(slot4))
		slot5.desc = gohelper.findChildTextMesh(slot5.go, "desctxt")
		slot5.hyperLinkClick = SkillHelper.addHyperLinkClick(slot5.desc, slot0._onHyperLinkClick, slot0)
		slot5.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot5.desc.gameObject, FixTmpBreakLine)
		slot5.on = gohelper.findChild(slot5.go, "#go_passiveskills/passiveskill/on")
		slot5.unlocktxt = gohelper.findChildText(slot5.go, "#go_passiveskills/passiveskill/unlocktxt")
		slot5.canvasgroup = gohelper.onceAddComponent(slot5.go, typeof(UnityEngine.CanvasGroup))
		slot5.connectline = gohelper.findChild(slot5.go, "line")
		slot0._passiveskillitems[slot4] = slot5
	end

	slot0._skillEffectDescItems = slot0:getUserDataTb_()
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnclosepassivetip, slot0._btnclosepassivetipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnclosepassivetip)
end

function slot0._editableInitView(slot0)
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(slot1), slot0.setTipPosCallback, slot0)
end

slot0.LeftWidth = 470
slot0.RightWidth = 190
slot0.TopHeight = 292
slot0.Interval = 10

function slot0.setTipPosCallback(slot0, slot1, slot2)
	slot0.rectTrPassive = slot0.rectTrPassive or slot0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)
	slot5, slot6 = recthelper.uiPosToScreenPos2(slot0.rectTrPassive)
	slot7, slot8 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(slot5, slot6, slot1, CameraMgr.instance:getUICamera(), nil, )
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot12 = slot7

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= GameUtil.getViewSize() / 2 + slot7 - uv0.LeftWidth - uv0.Interval and slot12 - uv0.LeftWidth - uv0.Interval or slot12 + uv0.RightWidth + uv0.Interval + slot10, slot8 + uv0.TopHeight)
end

function slot0._btnclosepassivetipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.bossId = slot0.viewParam.bossId
	slot0.bossMo = TowerAssistBossModel.instance:getById(slot0.bossId)
	slot0.config = TowerConfig.instance:getAssistBossConfig(slot0.bossId)
end

function slot0.refreshView(slot0)
	slot0:refreshPassiveSkill()
end

function slot0.refreshPassiveSkill(slot0)
	slot0._txtpassivename.text = slot0.config.passiveSkillName

	for slot6 = 1, #TowerConfig.instance:getPassiveSKills(slot0.bossId) do
	end

	slot3 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion({
		[slot6] = FightConfig.instance:getSkillEffectDesc(slot0.config.name, lua_skill.configDict[slot1[slot6][1]])
	})
	slot4 = {}
	slot5 = {}

	for slot10, slot11 in ipairs(slot0._passiveskillitems) do
		if slot1[slot10] and slot1[slot10][1] then
			gohelper.setActive(slot11.go, true)

			slot13 = TowerConfig.instance:isSkillActive(slot0.bossId, slot12, slot0.bossMo and slot0.bossMo.level or 0)
			slot14 = lua_skill.configDict[slot12]

			for slot18, slot19 in ipairs(slot3[slot10]) do
				if HeroSkillModel.instance:canShowSkillTag(SkillConfig.instance:getSkillEffectDescCo(slot19).name) and not slot5[slot21] then
					slot5[slot21] = true

					if slot20.isSpecialCharacter == 1 then
						table.insert(slot4, {
							desc = SkillHelper.buildDesc(slot20.desc),
							title = slot20.name
						})
					end
				end
			end

			slot15 = SkillHelper.buildDesc(slot2[slot10])

			if not slot13 then
				slot11.unlocktxt.text = formatLuaLang("towerboss_skill_get", TowerConfig.instance:getPassiveSkillActiveLev(slot0.bossId, slot12))
			else
				slot11.unlocktxt.text = formatLuaLang("towerboss_skill_order", GameUtil.getRomanNums(slot10))
			end

			slot11.canvasgroup.alpha = slot13 and 1 or 0.5

			gohelper.setActive(slot11.on, slot13)

			slot11.desc.text = slot15

			slot11.fixTmpBreakLine:refreshTmpContent(slot11.desc)
			gohelper.setActive(slot11.go, true)
			gohelper.setActive(slot11.connectline, slot10 ~= #slot1)
		else
			gohelper.setActive(slot11.go, false)
		end
	end

	slot0:_showSkillEffectDesc(slot4)
end

function slot0._showSkillEffectDesc(slot0, slot1)
	gohelper.setActive(slot0._goeffectdesc, slot1 and #slot1 > 0)

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = slot0:_getSkillEffectDescItem(slot5)
		slot7.desc.text = slot6.desc
		slot7.title.text = SkillHelper.removeRichTag(slot6.title)

		slot7.fixTmpBreakLine:refreshTmpContent(slot7.desc)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._skillEffectDescItems do
		gohelper.setActive(slot0._passiveskillitems[slot5].go, false)
	end
end

function slot0._getSkillEffectDescItem(slot0, slot1)
	if not slot0._skillEffectDescItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goeffectdescitem, "descitem" .. slot1)
		slot2.desc = gohelper.findChildText(slot2.go, "effectdesc")
		slot2.title = gohelper.findChildText(slot2.go, "titlebg/bg/name")
		slot2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.desc.gameObject, FixTmpBreakLine)
		slot2.hyperLinkClick = SkillHelper.addHyperLinkClick(slot2.desc, slot0._onHyperLinkClick, slot0)

		table.insert(slot0._skillEffectDescItems, slot1, slot2)
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
