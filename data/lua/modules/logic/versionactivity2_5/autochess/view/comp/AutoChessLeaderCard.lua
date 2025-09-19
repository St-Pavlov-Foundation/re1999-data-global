module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderCard", package.seeall)

local var_0_0 = class("AutoChessLeaderCard", LuaCompBase)

var_0_0.ShowType = {
	HandBook = 1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goMesh = gohelper.findChild(arg_1_1, "Leader/Mesh")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "Leader/namebg/#txt_Name")
	arg_1_0._txtHp = gohelper.findChildText(arg_1_1, "hp/#txt_Hp")
	arg_1_0._simageSkill = gohelper.findChildSingleImage(arg_1_1, "#simage_Skill")
	arg_1_0._txtSkillDesc = gohelper.findChildText(arg_1_1, "scroll_desc/viewport/content/#txt_SkillDesc")
	arg_1_0._goTip = gohelper.findChild(arg_1_1, "#go_Tip")
	arg_1_0._btnCloseTip = gohelper.findChildButtonWithAudio(arg_1_1, "#go_Tip/#btn_CloseTip")
	arg_1_0._txtTipTitle = gohelper.findChildText(arg_1_1, "#go_Tip/#txt_TipTitle")
	arg_1_0._txtTip = gohelper.findChildText(arg_1_1, "#go_Tip/scroll_tips/viewport/#txt_Tip")

	arg_1_0:addClickCb(arg_1_0._btnCloseTip, arg_1_0._btnCloseTipOnClick, arg_1_0)

	arg_1_0._btnCheck = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_check")

	arg_1_0:addClickCb(arg_1_0._btnCheck, arg_1_0._onClickCheck, arg_1_0)

	arg_1_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(arg_1_0._txtSkillDesc, arg_1_0.clcikHyperLink, arg_1_0)

	arg_1_0.goChess = gohelper.findChild(arg_1_1, "Chess")
	arg_1_0.txtChessSkill = gohelper.findChildText(arg_1_0.goChess, "scroll_desc/viewport/content/txt_ChessSkill")
	arg_1_0.imageChessBg = gohelper.findChildImage(arg_1_0.goChess, "chess/image_ChessBg")
	arg_1_0.goChessMesh = gohelper.findChild(arg_1_0.goChess, "chess/Mesh")
	arg_1_0.txtChessName = gohelper.findChildText(arg_1_0.goChess, "chess/txt_ChessName")
	arg_1_0.goChessHp = gohelper.findChild(arg_1_0.goChess, "go_ChessHp")
	arg_1_0.txtChessHp = gohelper.findChildText(arg_1_0.goChess, "go_ChessHp/txt_ChessHp")
	arg_1_0.goChessAttack = gohelper.findChild(arg_1_0.goChess, "go_ChessAttack")
	arg_1_0.txtChessAttack = gohelper.findChildText(arg_1_0.goChess, "go_ChessAttack/txt_ChessAttack")
	arg_1_0.chessMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goChessMesh, AutoChessMeshComp)
end

function var_0_0.setData(arg_2_0, arg_2_1)
	if arg_2_1.leaderId then
		arg_2_0.config = lua_auto_chess_master.configDict[arg_2_1.leaderId]

		arg_2_0:refreshCommon(false)
		arg_2_0:refreshSkillDesc()
	else
		arg_2_0.chessMo = AutoChessModel.instance:getChessMo()

		local var_2_0 = arg_2_1.leader

		arg_2_0.config = lua_auto_chess_master.configDict[var_2_0.id]

		local var_2_1 = var_2_0.teamType == AutoChessEnum.TeamType.Enemy

		arg_2_0:refreshCommon(var_2_1)
		arg_2_0:refreshSkillDesc2(var_2_0)
	end

	arg_2_0._param = arg_2_1

	if arg_2_1.type == var_0_0.ShowType.HandBook then
		arg_2_0:refreshHandbook()
	end
end

function var_0_0.refreshCommon(arg_3_0, arg_3_1)
	arg_3_0.meshComp:setData(arg_3_0.config.image, arg_3_1, true)

	arg_3_0._txtName.text = arg_3_0.config.name
	arg_3_0._txtHp.text = arg_3_0.config.hp

	arg_3_0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(arg_3_0.config.skillIcon, "skillicon"))

	if arg_3_0.config.spUdimo == 0 or not lua_auto_chess.configDict[arg_3_0.config.spUdimo] then
		gohelper.setActive(arg_3_0.goChess, false)
	else
		local var_3_0 = AutoChessConfig.instance:getChessCfgById(arg_3_0.config.spUdimo, 1)

		arg_3_0.chessMeshComp:setData(var_3_0.image, arg_3_1)

		if var_3_0.type == AutoChessStrEnum.ChessType.Support then
			UISpriteSetMgr.instance:setAutoChessSprite(arg_3_0.imageChessBg, "v2a5_autochess_quality2_" .. var_3_0.levelFromMall)
			gohelper.setActive(arg_3_0.goChessHp, false)
			gohelper.setActive(arg_3_0.goChessAttack, false)
		else
			UISpriteSetMgr.instance:setAutoChessSprite(arg_3_0.imageChessBg, "v2a5_autochess_quality1_" .. var_3_0.levelFromMall)
			gohelper.setActive(arg_3_0.goChessHp, true)
			gohelper.setActive(arg_3_0.goChessAttack, true)

			arg_3_0.txtChessAttack.text = var_3_0.attack
			arg_3_0.txtChessHp.text = var_3_0.hp
		end

		arg_3_0.txtChessName.text = var_3_0.name
		arg_3_0.txtChessSkill.text = var_3_0.skillDesc

		gohelper.setActive(arg_3_0.goChess, true)
	end
end

function var_0_0.refreshSkillDesc(arg_4_0)
	local var_4_0 = arg_4_0.config.skillDesc
	local var_4_1 = arg_4_0.config.skillLockDesc
	local var_4_2 = AutoChessHelper.getLeaderSkillEffect(arg_4_0.config.skillId)

	if var_4_2 then
		if var_4_2[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
			var_4_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_4_0, tonumber(var_4_2[2]))
		elseif var_4_2[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
			var_4_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_4_0, tonumber(var_4_2[2]))
		elseif var_4_2[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
			var_4_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_4_0, tonumber(var_4_2[2]))
		end
	end

	arg_4_0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		"",
		AutoChessHelper.buildSkillDesc(var_4_0),
		var_4_1
	}))
end

function var_0_0.refreshHandbook(arg_5_0)
	gohelper.setActive(arg_5_0._btnCheck.gameObject, true)
	gohelper.setActive(arg_5_0.goChess, false)
end

function var_0_0.clcikHyperLink(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._param.type == var_0_0.ShowType.HandBook then
		recthelper.setAnchor(arg_6_0._goTip.transform, 0, 99)
	end

	local var_6_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_6_1))

	if var_6_0 then
		arg_6_0._txtTipTitle.text = var_6_0.name
		arg_6_0._txtTip.text = var_6_0.desc

		gohelper.setActive(arg_6_0._goTip, true)
	end
end

function var_0_0._btnCloseTipOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._goTip, false)
end

function var_0_0._onClickCheck(arg_8_0)
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = arg_8_0.config.id
	})
end

function var_0_0.refreshSkillDesc2(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.config.skillDesc
	local var_9_1 = arg_9_0.config.skillProgressDesc
	local var_9_2 = arg_9_1.skill.unlock and "" or arg_9_0.config.skillLockDesc
	local var_9_3 = AutoChessHelper.getLeaderSkillEffect(arg_9_1.skill.id)

	if var_9_3 then
		if var_9_3[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
			local var_9_4 = AutoChessHelper.getBuyChessCntByType(arg_9_0.chessMo.buyInfos, "Forest")
			local var_9_5 = math.floor(var_9_4 / tonumber(var_9_3[4]))
			local var_9_6 = var_9_4 % tonumber(var_9_3[4])

			var_9_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_0, tonumber(var_9_3[2]) + tonumber(var_9_3[5]) * var_9_5)
			var_9_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_1, tonumber(var_9_3[4]) - var_9_6)
		elseif var_9_3[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
			local var_9_7 = arg_9_0.chessMo.sceneRound

			var_9_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_0, tonumber(var_9_3[2]) + tonumber(var_9_3[3]) * (var_9_7 - 1))
		elseif var_9_3[1] == AutoChessStrEnum.SkillEffect.DigTreasure or var_9_3[1] == AutoChessStrEnum.SkillEffect.DigTreasureSP then
			local var_9_8 = 0

			for iter_9_0, iter_9_1 in ipairs(arg_9_1.skill.abilities) do
				if iter_9_1.type == var_9_3[1] then
					var_9_8 = iter_9_1.extraInt1

					break
				end
			end

			var_9_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_1, var_9_8)
		elseif var_9_3[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
			local var_9_9 = arg_9_0.chessMo.sceneRound
			local var_9_10 = tonumber(var_9_3[3])

			if var_9_9 < var_9_10 then
				var_9_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_0, tonumber(var_9_3[2]))
				var_9_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_1, var_9_10 - var_9_9)
			else
				var_9_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_0, tonumber(var_9_3[2]) + tonumber(var_9_3[4]))
				var_9_1 = ""
			end
		elseif var_9_3[1] == AutoChessStrEnum.SkillEffect.MasterTransfigurationBuyChess then
			local var_9_11 = AutoChessHelper.getBuyChessCnt(arg_9_0.chessMo.buyInfos, tonumber(var_9_3[3]))

			var_9_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_1, tonumber(var_9_3[4] - var_9_11))
		end
	end

	arg_9_0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		AutoChessHelper.buildSkillDesc(var_9_0),
		var_9_1,
		var_9_2
	}))
end

return var_0_0
