module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderCard", package.seeall)

slot0 = class("AutoChessLeaderCard", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.config = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goMesh = gohelper.findChild(slot1, "Leader/Mesh")
	slot0._simageRole = gohelper.findChildSingleImage(slot1, "Leader/Mesh/role")
	slot0._imageRole = gohelper.findChildImage(slot1, "Leader/Mesh/role")
	slot0._txtName = gohelper.findChildText(slot1, "Leader/namebg/#txt_Name")
	slot0._txtHp = gohelper.findChildText(slot1, "hp/#txt_Hp")
	slot0._simageSkill = gohelper.findChildSingleImage(slot1, "#simage_Skill")
	slot0._txtSkillDesc = gohelper.findChildText(slot1, "scroll_desc/viewport/content/#txt_SkillDesc")
	slot0._goTip = gohelper.findChild(slot1, "#go_Tip")
	slot0._btnCloseTip = gohelper.findChildButtonWithAudio(slot1, "#go_Tip/#btn_CloseTip")
	slot0._txtTipTitle = gohelper.findChildText(slot1, "#go_Tip/#txt_TipTitle")
	slot0._txtTip = gohelper.findChildText(slot1, "#go_Tip/scroll_tips/viewport/#txt_Tip")

	slot0:addClickCb(slot0._btnCloseTip, slot0._btnCloseTipOnClick, slot0)

	slot0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(slot0._txtSkillDesc, slot0.clcikHyperLink, slot0)
end

function slot0.setData(slot0, slot1)
	if slot1.leaderId then
		slot0.config = lua_auto_chess_master.configDict[slot1.leaderId]

		slot0:refreshUI()
	else
		slot0:refreshByMaster(slot1.leader)
	end
end

function slot0.onDestroy(slot0)
end

function slot0.refreshUI(slot0)
	slot0.meshComp:setData(slot0.config.image, false, true)

	slot0._txtName.text = slot0.config.name
	slot0._txtHp.text = slot0.config.hp

	slot0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(slot0.config.skillIcon, "skillicon"))
	slot0:refreshSkillDesc()
end

function slot0.refreshSkillDesc(slot0)
	slot2 = slot0.config.skillLockDesc

	if AutoChessHelper.getLeaderSkillEffect(slot0.config.skillId)[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
		slot1 = GameUtil.getSubPlaceholderLuaLangOneParam(slot0.config.skillDesc, tonumber(slot3[2]))
	elseif slot3[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
		slot1 = GameUtil.getSubPlaceholderLuaLangOneParam(slot1, tonumber(slot3[2]))
	elseif slot3[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
		slot1 = GameUtil.getSubPlaceholderLuaLangOneParam(slot1, tonumber(slot3[2]))
	end

	slot0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		"",
		AutoChessHelper.buildSkillDesc(slot1),
		slot2
	}))
end

function slot0.clcikHyperLink(slot0, slot1, slot2)
	if AutoChessConfig.instance:getSkillEffectDesc(tonumber(slot1)) then
		slot0._txtTipTitle.text = slot3.name
		slot0._txtTip.text = slot3.desc

		gohelper.setActive(slot0._goTip, true)
	end
end

function slot0._btnCloseTipOnClick(slot0)
	gohelper.setActive(slot0._goTip, false)
end

function slot0.refreshByMaster(slot0, slot1)
	slot0.chessMo = AutoChessModel.instance:getChessMo()
	slot0.config = lua_auto_chess_master.configDict[slot1.id]

	slot0.meshComp:setData(slot0.config.image, slot1.teamType == AutoChessEnum.TeamType.Enemy, true)

	slot0._txtName.text = slot0.config.name
	slot0._txtHp.text = slot0.config.hp

	slot0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(slot0.config.skillIcon, "skillicon"))
	slot0:refreshSkillDesc2(slot1)
end

function slot0.refreshSkillDesc2(slot0, slot1)
	slot4 = slot0.config.skillLockDesc

	if AutoChessHelper.getLeaderSkillEffect(slot1.skill.id)[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
		slot6 = AutoChessHelper.getBuyChessCntByType(slot0.chessMo.buyInfos, "Forest")
		slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(slot0.config.skillDesc, tonumber(slot5[2]) + tonumber(slot5[5]) * math.floor(slot6 / tonumber(slot5[4])))
		slot3 = GameUtil.getSubPlaceholderLuaLangOneParam(slot0.config.skillProgressDesc, tonumber(slot5[4]) - slot6 % tonumber(slot5[4]))
	elseif slot5[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
		slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(slot2, tonumber(slot5[2]) + tonumber(slot5[3]) * (slot0.chessMo.sceneRound - 1))
	elseif slot5[1] == AutoChessStrEnum.SkillEffect.DigTreasure then
		slot6 = 0

		for slot10, slot11 in ipairs(slot1.skill.abilities) do
			if slot11.type == slot5[1] then
				slot6 = slot11.extraInt1
			end
		end

		slot3 = GameUtil.getSubPlaceholderLuaLangOneParam(slot3, slot6)
	elseif slot5[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
		if slot0.chessMo.sceneRound < tonumber(slot5[3]) then
			slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(slot2, tonumber(slot5[2]))
			slot3 = GameUtil.getSubPlaceholderLuaLangOneParam(slot3, slot7 - slot6)
		else
			slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(slot2, tonumber(slot5[2]) + tonumber(slot5[4]))
			slot3 = ""
		end
	end

	if slot1.skill.unlock then
		slot4 = ""
	end

	slot0._txtSkillDesc.text = string.trim(GameUtil.getSubPlaceholderLuaLang(luaLang("AutoChessLeaderCard_txtSkillDesc"), {
		AutoChessHelper.buildSkillDesc(slot2),
		slot3,
		slot4
	}))
end

return slot0
