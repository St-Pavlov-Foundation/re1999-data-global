module("modules.logic.toughbattle.view.ToughBattleEnemyInfoView", package.seeall)

slot0 = class("ToughBattleEnemyInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._imgenemy = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_enemy")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "root/title/titletxt")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "root/#txt_desc")
	slot0._txtrecommend = gohelper.findChildTextMesh(slot0.viewGO, "root/#go_recommend/recommend_txt")
	slot0._recommenditem = gohelper.findChild(slot0.viewGO, "root/#go_recommend/recommend_txt/#go_iconlist/#simage_icon")
	slot0._imgskillicon = gohelper.findChildImage(slot0.viewGO, "root/role/#simage_rolehead")
	slot0._btnskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/role/#btn_skill")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_closebtn")
	slot0._btnchallenge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_challengebtn")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnchallenge:AddClickListener(slot0.enterFight, slot0)
	slot0._btnskill:AddClickListener(slot0.onClickSkill, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnchallenge:RemoveClickListener()
	slot0._btnskill:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	slot1 = slot0.viewParam
	slot2 = slot1.episodeId
	slot3 = DungeonConfig.instance:getEpisodeCO(slot2)
	slot0._txttitle.text = slot3.name
	slot0._txtdesc.text = slot3.desc

	slot0._imgenemy:LoadImage("singlebg/toughbattle_singlebg/toughbattle_monster" .. slot1.sort .. ".png")
	UISpriteSetMgr.instance:setToughBattleRoleSprite(slot0._imgskillicon, "roleheadpic0" .. slot1.sort)

	slot4 = slot0:getRecommendList(slot2)

	gohelper.CreateObjList(slot0, slot0.onCreateItem, slot4, slot0._recommenditem.transform.parent.gameObject, slot0._recommenditem)

	slot0._txtrecommend.text = #slot4 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")
end

function slot0.onOpenFinish(slot0)
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideOpenBossInfoView, slot0.viewParam.id)
end

function slot0.onCreateItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setFightSprite(gohelper.findChildImage(slot1, ""), FightFailView.CareerToImageName[slot2])
end

function slot0.getRecommendList(slot0, slot1)
	slot2 = {}

	if lua_battle.configDict[DungeonConfig.instance:getEpisodeBattleId(slot1)] and not string.nilorempty(slot4.monsterGroupIds) then
		slot2 = FightHelper.getAttributeCounter(string.splitToNumber(slot4.monsterGroupIds, "#"), false)
	end

	return slot2
end

function slot0.onClickSkill(slot0)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = slot0.viewParam
	})
end

function slot0.enterFight(slot0)
	slot2 = slot0.viewParam.episodeId

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.ToughBattleSkillView then
		gohelper.setActive(slot0.viewGO, false)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.ToughBattleSkillView then
		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imgenemy:UnLoadImage()
end

return slot0
