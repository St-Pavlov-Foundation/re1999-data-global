module("modules.logic.toughbattle.view.ToughBattleFightSuccView", package.seeall)

slot0 = class("ToughBattleFightSuccView", FightSuccView)

function slot0.onInitView(slot0)
	slot0._goalcontent = gohelper.findChild(slot0.viewGO, "goalcontent")
	slot0._gotoughbattle = gohelper.findChild(slot0.viewGO, "#go_toughbattle")
	slot0._gotoughbattlerole = gohelper.findChild(slot0.viewGO, "#go_toughbattle_role")
	slot0._txtdiffcult = gohelper.findChildText(slot0.viewGO, "#go_toughbattle/info/txt_difficulty/#txt_diff")
	slot0._txtround = gohelper.findChildText(slot0.viewGO, "#go_toughbattle/info/txt_order/#txt_num")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_toughbattle/desc/#txt_desc")
	slot0._simagetoughbattlerole = gohelper.findChildImage(slot0.viewGO, "#go_toughbattle_role/role/#simage_rolehead")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_toughbattle_role/role/#btn_click")

	uv0.super.onInitView(slot0)
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0.onClickSkill, slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	uv0.super.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	gohelper.setActive(slot0._gotoughbattle, false)
	gohelper.setActive(slot0._gotoughbattlerole, false)
	slot0:setToughInfo()
end

function slot0.setToughInfo(slot0)
	if ToughBattleConfig.instance:isActStage2EpisodeId(slot0._curEpisodeId) then
		gohelper.setActive(slot0._goalcontent, false)
		gohelper.setActive(slot0._gotoughbattle, true)

		slot0._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. (ToughBattleConfig.instance:getCoByEpisodeId(slot0._curEpisodeId) and slot1.difficulty or 1))
		slot0._txtround.text = FightResultModel.instance.totalRound or 0
		slot0._txtdesc.text = ToughBattleConfig.instance:getRoundDesc(FightResultModel.instance.totalRound or 0)
	else
		gohelper.setActive(slot0._gotoughbattlerole, true)
		UISpriteSetMgr.instance:setToughBattleRoleSprite(slot0._simagetoughbattlerole, "roleheadpic0" .. ToughBattleConfig.instance:getCoByEpisodeId(slot0._curEpisodeId).sort)
	end
end

function slot0.onClickSkill(slot0)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = ToughBattleConfig.instance:getCoByEpisodeId(slot0._curEpisodeId)
	})
end

function slot0._addItem(slot0, slot1, ...)
	if slot1.bonusTag == FightEnum.FightBonusTag.FirstBonus then
		slot1.bonusTag = FightEnum.FightBonusTag.TimeFirstBonus
	end

	return uv0.super._addItem(slot0, slot1, ...)
end

return slot0
