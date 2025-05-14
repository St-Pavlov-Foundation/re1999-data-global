module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderCard", package.seeall)

local var_0_0 = class("AutoChessLeaderCard", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.config = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goMesh = gohelper.findChild(arg_2_1, "Leader/Mesh")
	arg_2_0._simageRole = gohelper.findChildSingleImage(arg_2_1, "Leader/Mesh/role")
	arg_2_0._imageRole = gohelper.findChildImage(arg_2_1, "Leader/Mesh/role")
	arg_2_0._txtName = gohelper.findChildText(arg_2_1, "Leader/namebg/#txt_Name")
	arg_2_0._txtHp = gohelper.findChildText(arg_2_1, "hp/#txt_Hp")
	arg_2_0._simageSkill = gohelper.findChildSingleImage(arg_2_1, "#simage_Skill")
	arg_2_0._txtSkillDesc = gohelper.findChildText(arg_2_1, "scroll_desc/viewport/content/#txt_SkillDesc")
	arg_2_0._goTip = gohelper.findChild(arg_2_1, "#go_Tip")
	arg_2_0._btnCloseTip = gohelper.findChildButtonWithAudio(arg_2_1, "#go_Tip/#btn_CloseTip")
	arg_2_0._txtTipTitle = gohelper.findChildText(arg_2_1, "#go_Tip/#txt_TipTitle")
	arg_2_0._txtTip = gohelper.findChildText(arg_2_1, "#go_Tip/scroll_tips/viewport/#txt_Tip")

	arg_2_0:addClickCb(arg_2_0._btnCloseTip, arg_2_0._btnCloseTipOnClick, arg_2_0)

	arg_2_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(arg_2_0._txtSkillDesc, arg_2_0.clcikHyperLink, arg_2_0)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	if arg_3_1.leaderId then
		arg_3_0.config = lua_auto_chess_master.configDict[arg_3_1.leaderId]

		arg_3_0:refreshUI()
	else
		arg_3_0:refreshByMaster(arg_3_1.leader)
	end
end

function var_0_0.onDestroy(arg_4_0)
	return
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0.meshComp:setData(arg_5_0.config.image, false, true)

	arg_5_0._txtName.text = arg_5_0.config.name
	arg_5_0._txtHp.text = arg_5_0.config.hp

	arg_5_0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(arg_5_0.config.skillIcon, "skillicon"))
	arg_5_0:refreshSkillDesc()
end

function var_0_0.refreshSkillDesc(arg_6_0)
	local var_6_0 = arg_6_0.config.skillDesc
	local var_6_1 = arg_6_0.config.skillLockDesc
	local var_6_2 = AutoChessHelper.getLeaderSkillEffect(arg_6_0.config.skillId)

	if var_6_2[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
		var_6_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_6_0, tonumber(var_6_2[2]))
	elseif var_6_2[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
		var_6_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_6_0, tonumber(var_6_2[2]))
	elseif var_6_2[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
		var_6_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_6_0, tonumber(var_6_2[2]))
	end

	arg_6_0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		"",
		AutoChessHelper.buildSkillDesc(var_6_0),
		var_6_1
	}))
end

function var_0_0.clcikHyperLink(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_7_1))

	if var_7_0 then
		arg_7_0._txtTipTitle.text = var_7_0.name
		arg_7_0._txtTip.text = var_7_0.desc

		gohelper.setActive(arg_7_0._goTip, true)
	end
end

function var_0_0._btnCloseTipOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._goTip, false)
end

function var_0_0.refreshByMaster(arg_9_0, arg_9_1)
	arg_9_0.chessMo = AutoChessModel.instance:getChessMo()

	local var_9_0 = arg_9_1.teamType == AutoChessEnum.TeamType.Enemy

	arg_9_0.config = lua_auto_chess_master.configDict[arg_9_1.id]

	arg_9_0.meshComp:setData(arg_9_0.config.image, var_9_0, true)

	arg_9_0._txtName.text = arg_9_0.config.name
	arg_9_0._txtHp.text = arg_9_0.config.hp

	arg_9_0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(arg_9_0.config.skillIcon, "skillicon"))
	arg_9_0:refreshSkillDesc2(arg_9_1)
end

function var_0_0.refreshSkillDesc2(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.config.skillDesc
	local var_10_1 = arg_10_0.config.skillProgressDesc
	local var_10_2 = arg_10_0.config.skillLockDesc
	local var_10_3 = AutoChessHelper.getLeaderSkillEffect(arg_10_1.skill.id)

	if var_10_3[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
		local var_10_4 = AutoChessHelper.getBuyChessCntByType(arg_10_0.chessMo.buyInfos, "Forest")
		local var_10_5 = math.floor(var_10_4 / tonumber(var_10_3[4]))
		local var_10_6 = var_10_4 % tonumber(var_10_3[4])

		var_10_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_0, tonumber(var_10_3[2]) + tonumber(var_10_3[5]) * var_10_5)
		var_10_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_1, tonumber(var_10_3[4]) - var_10_6)
	elseif var_10_3[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
		local var_10_7 = arg_10_0.chessMo.sceneRound

		var_10_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_0, tonumber(var_10_3[2]) + tonumber(var_10_3[3]) * (var_10_7 - 1))
	elseif var_10_3[1] == AutoChessStrEnum.SkillEffect.DigTreasure then
		local var_10_8 = 0

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.skill.abilities) do
			if iter_10_1.type == var_10_3[1] then
				var_10_8 = iter_10_1.extraInt1
			end
		end

		var_10_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_1, var_10_8)
	elseif var_10_3[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
		local var_10_9 = arg_10_0.chessMo.sceneRound
		local var_10_10 = tonumber(var_10_3[3])

		if var_10_9 < var_10_10 then
			var_10_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_0, tonumber(var_10_3[2]))
			var_10_1 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_1, var_10_10 - var_10_9)
		else
			var_10_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_10_0, tonumber(var_10_3[2]) + tonumber(var_10_3[4]))
			var_10_1 = ""
		end
	end

	if arg_10_1.skill.unlock then
		var_10_2 = ""
	end

	arg_10_0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		AutoChessHelper.buildSkillDesc(var_10_0),
		var_10_1,
		var_10_2
	}))
end

return var_0_0
