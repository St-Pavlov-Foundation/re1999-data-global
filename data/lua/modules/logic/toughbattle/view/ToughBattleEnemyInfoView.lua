module("modules.logic.toughbattle.view.ToughBattleEnemyInfoView", package.seeall)

local var_0_0 = class("ToughBattleEnemyInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imgenemy = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_enemy")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/title/titletxt")
	arg_1_0._txtdesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#txt_desc")
	arg_1_0._txtrecommend = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#go_recommend/recommend_txt")
	arg_1_0._recommenditem = gohelper.findChild(arg_1_0.viewGO, "root/#go_recommend/recommend_txt/#go_iconlist/#simage_icon")
	arg_1_0._imgskillicon = gohelper.findChildImage(arg_1_0.viewGO, "root/role/#simage_rolehead")
	arg_1_0._btnskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/role/#btn_skill")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_closebtn")
	arg_1_0._btnchallenge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_challengebtn")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnchallenge:AddClickListener(arg_2_0.enterFight, arg_2_0)
	arg_2_0._btnskill:AddClickListener(arg_2_0.onClickSkill, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnchallenge:RemoveClickListener()
	arg_3_0._btnskill:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	local var_4_0 = arg_4_0.viewParam
	local var_4_1 = var_4_0.episodeId
	local var_4_2 = DungeonConfig.instance:getEpisodeCO(var_4_1)

	arg_4_0._txttitle.text = var_4_2.name
	arg_4_0._txtdesc.text = var_4_2.desc

	arg_4_0._imgenemy:LoadImage("singlebg/toughbattle_singlebg/toughbattle_monster" .. var_4_0.sort .. ".png")
	UISpriteSetMgr.instance:setToughBattleRoleSprite(arg_4_0._imgskillicon, "roleheadpic0" .. var_4_0.sort)

	local var_4_3 = arg_4_0:getRecommendList(var_4_1)

	gohelper.CreateObjList(arg_4_0, arg_4_0.onCreateItem, var_4_3, arg_4_0._recommenditem.transform.parent.gameObject, arg_4_0._recommenditem)

	arg_4_0._txtrecommend.text = #var_4_3 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")
end

function var_0_0.onOpenFinish(arg_5_0)
	local var_5_0 = arg_5_0.viewParam.id

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideOpenBossInfoView, var_5_0)
end

function var_0_0.onCreateItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildImage(arg_6_1, "")

	UISpriteSetMgr.instance:setFightSprite(var_6_0, FightFailView.CareerToImageName[arg_6_2])
end

function var_0_0.getRecommendList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = DungeonConfig.instance:getEpisodeBattleId(arg_7_1)
	local var_7_2 = lua_battle.configDict[var_7_1]

	if var_7_2 and not string.nilorempty(var_7_2.monsterGroupIds) then
		local var_7_3 = string.splitToNumber(var_7_2.monsterGroupIds, "#")

		var_7_0 = FightHelper.getAttributeCounter(var_7_3, false)
	end

	return var_7_0
end

function var_0_0.onClickSkill(arg_8_0)
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = arg_8_0.viewParam
	})
end

function var_0_0.enterFight(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.episodeId
	local var_9_1 = DungeonConfig.instance:getEpisodeCO(var_9_0)

	DungeonFightController.instance:enterFight(var_9_1.chapterId, var_9_0)
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._onOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.ToughBattleSkillView then
		gohelper.setActive(arg_11_0.viewGO, false)
	end
end

function var_0_0._onCloseViewFinish(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.ToughBattleSkillView then
		gohelper.setActive(arg_12_0.viewGO, true)
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._imgenemy:UnLoadImage()
end

return var_0_0
