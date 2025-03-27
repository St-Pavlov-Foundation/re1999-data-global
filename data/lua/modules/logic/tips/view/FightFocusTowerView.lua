module("modules.logic.tips.view.FightFocusTowerView", package.seeall)

slot0 = class("FightFocusTowerView", BaseRoleStoryView)

function slot0.onInit(slot0)
	slot0.resPathList = {
		mainRes = "ui/viewres/fight/fightfocustowerview.prefab"
	}
end

function slot0.onInitView(slot0)
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.txtLev = gohelper.findChildTextMesh(slot0.viewGO, "root/left/boss/lev")
	slot0.imgCareer = gohelper.findChildImage(slot0.viewGO, "root/right/info/career")
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "root/right/info/name")
	slot0.btnTalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/btnTalent")
	slot0.txtPassiveName = gohelper.findChildTextMesh(slot0.viewGO, "root/right/info/passiveskill/bg/#txt_passivename")
	slot0.passiveSkillItems = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, string.format("root/right/info/passiveskill/#go_passiveskills/passiveskill%s", slot4))
		slot5.goOff = gohelper.findChild(slot5.go, "off")
		slot5.goOn = gohelper.findChild(slot5.go, "on")
		slot0.passiveSkillItems[slot4] = slot5
	end

	slot0.btnSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon")
	slot0.skillIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/imgIcon")
	slot0.skillTagIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	slot0.goTagIcon = gohelper.findChild(slot0.viewGO, "root/right/info/#go_skill/line/go_skills/skillicon/tagIcon")
	slot0.btnPassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/info/passiveskill/#btn_passiveskill")
	slot0.goTagItem = gohelper.findChild(slot0.viewGO, "root/right/info/base/scroll_tag/Viewport/Content/#txt_tag")
	slot0.tagItems = {}
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnSkill, slot0.onBtnActiveSkillClick, slot0)
	slot0:addClickCb(slot0.btnTalent, slot0.onBtnTalentClick, slot0)
	slot0:addClickCb(slot0.btnPassiveskill, slot0.onBtnPassiveskillClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnSkill)
	slot0:removeClickCb(slot0.btnTalent)
	slot0:removeClickCb(slot0.btnPassiveskill)
end

function slot0.onBtnActiveSkillClick(slot0)
	if not slot0.skillIdList then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerSkillTipView, {
		skillIdList = slot0.skillIdList,
		monsterName = slot0.config.name,
		super = true
	})
end

function slot0.onBtnPassiveskillClick(slot0)
	if not slot0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerBossSkillTipsView, {
		bossId = slot0.bossId
	})
end

function slot0.onBtnTalentClick(slot0)
	if not slot0.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = slot0.bossId
	})
end

function slot0.onShow(slot0)
	slot0.bossMo = TowerAssistBossModel.instance:getById(slot0.bossId)
	slot0.config = TowerConfig.instance:getAssistBossConfig(slot0.bossId)

	slot0:refreshView()
end

function slot0.refreshView(slot0)
	slot1 = slot0.bossMo and slot0.bossMo.level or 1
	slot0.txtLev.text = tostring(slot1)
	slot0.txtName.text = slot0.config.name

	UISpriteSetMgr.instance:setCommonSprite(slot0.imgCareer, string.format("lssx_%s", slot0.config.career))
	gohelper.setActive(slot0.btnBase, #TowerConfig.instance:getHeroGroupAddAttr(slot0.bossId, 0, slot1) > 0)
	slot0:refreshPassiveSkill()
	slot0:refreshActiveSkill()
	slot0:refreshTags()
end

function slot0.refreshPassiveSkill(slot0)
	slot0.txtPassiveName.text = slot0.config.passiveSkillName

	for slot6, slot7 in ipairs(slot0.passiveSkillItems) do
		if TowerConfig.instance:getPassiveSKills(slot0.bossId)[slot6] then
			gohelper.setActive(slot7.go, true)
			gohelper.setActive(slot7.goOn, TowerConfig.instance:isSkillActive(slot0.bossId, slot8[1], slot0.bossMo and slot0.bossMo.level or 1))
		else
			gohelper.setActive(slot7.go, false)
		end
	end
end

function slot0.refreshActiveSkill(slot0)
	slot2 = (GameUtil.splitString2(slot0.config.activeSkills, true) or {})[1]
	slot0.skillIdList = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot0.skillIdList, slot7[1])
	end

	if not lua_skill.configDict[slot2[1]] then
		return
	end

	slot0.skillIcon:LoadImage(ResUrl.getSkillIcon(slot3.icon))
	slot0.skillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot3.showTag))
	gohelper.setActive(slot0.goTagIcon, false)
end

function slot0.refreshTags(slot0)
	slot1 = string.split(slot0.config.tag, "#") or {}

	for slot7 = 1, math.max(#slot0.tagItems, #slot1) do
		if not slot0.tagItems[slot7] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0.goTagItem)
			slot8.txt = slot8.go:GetComponent(gohelper.Type_TextMesh)
			slot0.tagItems[slot7] = slot8
		end

		if slot1[slot7] then
			slot8.txt.text = slot1[slot7]
		end

		gohelper.setActive(slot8.go, slot1[slot7] ~= nil)
	end
end

function slot0.onHide(slot0)
end

function slot0.show(slot0, slot1)
	if slot0.isShow and not slot1 then
		return
	end

	slot0.isShow = true

	if not slot0.viewGO then
		slot0:_loadPrefab()

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	if slot1 then
		slot0.anim:Play("open")
	else
		slot0.anim:Play("switch")
	end

	slot0:onShow()
end

function slot0.hide(slot0, slot1)
	if not slot0.isShow and not slot1 then
		return
	end

	slot0.isShow = false

	if not slot0.viewGO then
		return
	end

	if slot1 then
		slot0.anim:Play("close")
	else
		gohelper.setActive(slot0.viewGO, false)
	end

	slot0:onHide()
end

function slot0.onDestroyView(slot0)
	slot0.skillIcon:UnLoadImage()
	slot0.skillTagIcon:UnLoadImage()
end

return slot0
