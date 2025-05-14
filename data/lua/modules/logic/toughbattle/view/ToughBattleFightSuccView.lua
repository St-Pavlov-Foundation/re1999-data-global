module("modules.logic.toughbattle.view.ToughBattleFightSuccView", package.seeall)

local var_0_0 = class("ToughBattleFightSuccView", FightSuccView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goalcontent = gohelper.findChild(arg_1_0.viewGO, "goalcontent")
	arg_1_0._gotoughbattle = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle")
	arg_1_0._gotoughbattlerole = gohelper.findChild(arg_1_0.viewGO, "#go_toughbattle_role")
	arg_1_0._txtdiffcult = gohelper.findChildText(arg_1_0.viewGO, "#go_toughbattle/info/txt_difficulty/#txt_diff")
	arg_1_0._txtround = gohelper.findChildText(arg_1_0.viewGO, "#go_toughbattle/info/txt_order/#txt_num")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_toughbattle/desc/#txt_desc")
	arg_1_0._simagetoughbattlerole = gohelper.findChildImage(arg_1_0.viewGO, "#go_toughbattle_role/role/#simage_rolehead")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_toughbattle_role/role/#btn_click")

	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0.onClickSkill, arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	var_0_0.super.removeEvents(arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._gotoughbattle, false)
	gohelper.setActive(arg_4_0._gotoughbattlerole, false)
	arg_4_0:setToughInfo()
end

function var_0_0.setToughInfo(arg_5_0)
	if ToughBattleConfig.instance:isActStage2EpisodeId(arg_5_0._curEpisodeId) then
		gohelper.setActive(arg_5_0._goalcontent, false)
		gohelper.setActive(arg_5_0._gotoughbattle, true)

		local var_5_0 = ToughBattleConfig.instance:getCoByEpisodeId(arg_5_0._curEpisodeId)
		local var_5_1 = var_5_0 and var_5_0.difficulty or 1

		arg_5_0._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. var_5_1)
		arg_5_0._txtround.text = FightResultModel.instance.totalRound or 0
		arg_5_0._txtdesc.text = ToughBattleConfig.instance:getRoundDesc(FightResultModel.instance.totalRound or 0)
	else
		gohelper.setActive(arg_5_0._gotoughbattlerole, true)

		local var_5_2 = ToughBattleConfig.instance:getCoByEpisodeId(arg_5_0._curEpisodeId)

		UISpriteSetMgr.instance:setToughBattleRoleSprite(arg_5_0._simagetoughbattlerole, "roleheadpic0" .. var_5_2.sort)
	end
end

function var_0_0.onClickSkill(arg_6_0)
	local var_6_0 = ToughBattleConfig.instance:getCoByEpisodeId(arg_6_0._curEpisodeId)

	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = var_6_0
	})
end

function var_0_0._addItem(arg_7_0, arg_7_1, ...)
	if arg_7_1.bonusTag == FightEnum.FightBonusTag.FirstBonus then
		arg_7_1.bonusTag = FightEnum.FightBonusTag.TimeFirstBonus
	end

	return var_0_0.super._addItem(arg_7_0, arg_7_1, ...)
end

return var_0_0
