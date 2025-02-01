module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardView", package.seeall)

slot0 = class("EliminateLevelRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btnresult = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_result")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#btn_result/#go_reward")
	slot0._txtClick = gohelper.findChildText(slot0.viewGO, "#txt_Click")
	slot0._txtcontinue = gohelper.findChildText(slot0.viewGO, "#txt_continue")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "#go_Tips")
	slot0._scrollTips = gohelper.findChildScrollRect(slot0.viewGO, "#go_Tips/#scroll_Tips")
	slot0._goLayoutGroup = gohelper.findChild(slot0.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup")
	slot0._goTipsItem = gohelper.findChild(slot0.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup/#go_TipsItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnresult:AddClickListener(slot0._btnresultOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnresult:RemoveClickListener()
end

function slot0._btnresultOnClick(slot0)
	if slot0._canClose then
		ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	else
		slot0:openRewardTip()
	end
end

function slot0._editableInitView(slot0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._resultData = EliminateTeamChessModel.instance:getWarFightResult()

	slot0:refreshViewByResult()

	slot0._canClose = false

	gohelper.setActive(slot0._goTips, slot0._canClose)
	gohelper.setActive(slot0._goreward, not slot0._canClose)
	gohelper.setActive(slot0._txtClick.gameObject, not slot0._canClose)
	gohelper.setActive(slot0._txtcontinue.gameObject, slot0._canClose)
	gohelper.setActive(slot0._btnresult, not slot0._canClose)
end

function slot0.refreshViewByResult(slot0)
	for slot5, slot6 in pairs(slot0._resultData:getResultInfo()) do
		if slot5 == "unlockCharacterIds" then
			slot0:refreshCharacterResult(slot6)
		end

		if slot5 == "unlockChessPieceIds" then
			slot0:refreshPieceResult(slot6)
		end

		if slot5 == "unlockSlotIds" then
			slot0:refreshSlotResult(slot6)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_reward_fall)
end

function slot0.refreshCharacterResult(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if EliminateConfig.instance:getTeamChessCharacterConfig(slot6) ~= nil then
			slot0:refreshTipInfo(slot6, EliminateTeamChessEnum.ResultRewardType.character)
		end
	end
end

function slot0.refreshPieceResult(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if EliminateConfig.instance:getSoldierChessConfig(slot6) ~= nil then
			slot0:refreshTipInfo(slot6, EliminateTeamChessEnum.ResultRewardType.chessPiece)
		end
	end
end

function slot0.refreshSlotResult(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:refreshTipInfo(slot6, EliminateTeamChessEnum.ResultRewardType.slot)
	end
end

function slot0.refreshTipInfo(slot0, slot1, slot2)
	if slot0._rewardItem == nil then
		slot0._rewardItem = slot0:getUserDataTb_()
	end

	slot3 = gohelper.clone(slot0._goTipsItem, slot0._goLayoutGroup)
	slot5 = gohelper.findChildImage(slot3, "#go_chessTip/Info/#go_HaveChess/image_ChessBG")
	slot6 = gohelper.findChildImage(slot3, "#go_chessTip/Info/#go_HaveChess/#image_Chess")
	slot9 = gohelper.findChildText(slot3, "#go_chessTip/Info/#go_Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	slot10 = gohelper.findChildSingleImage(slot3, "#go_chessTip/Info/#go_Role/Role/#simage_Role")
	slot12 = gohelper.findChild(slot3, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	slot13 = gohelper.findChildText(slot3, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	slot15 = gohelper.findChildText(slot3, "#go_chessTip/Info/#txt_ChessName")
	slot17 = gohelper.findChildImage(slot3, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillBG/GameObject/#image_RoleSkill")
	slot18 = gohelper.findChildText(slot3, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillEnergyBG/#txt_RoleCostNum")
	slot19 = gohelper.findChildText(slot3, "#go_chessTip/Scroll View/Viewport/Content/#txt_Descr")
	slot20 = slot2 == EliminateTeamChessEnum.ResultRewardType.slot
	slot21 = slot2 == EliminateTeamChessEnum.ResultRewardType.character
	slot22 = slot2 == EliminateTeamChessEnum.ResultRewardType.chessPiece

	gohelper.setActive(gohelper.findChild(slot3, "#go_chessTip/Info/#go_HaveChess"), slot22)
	gohelper.setActive(gohelper.findChild(slot3, "#go_chessTip/Info/#go_Add"), slot20)
	gohelper.setActive(gohelper.findChild(slot3, "#go_chessTip/Info/#go_Resource"), slot20)
	gohelper.setActive(gohelper.findChildImage(slot3, "#go_chessTip/Info/image_Fire").gameObject, slot22)
	gohelper.setActive(gohelper.findChild(slot3, "#go_chessTip/Info/#go_Role"), slot21)
	gohelper.setActive(gohelper.findChild(slot3, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill"), slot21)

	slot23 = ""
	slot24 = ""

	if slot20 then
		slot24 = luaLang("eliminate_teamchess_new_slot_name")
		slot23 = luaLang("eliminate_teamchess_new_slot_desc")
	end

	if slot21 then
		slot25 = EliminateConfig.instance:getTeamChessCharacterConfig(slot1)
		slot24 = slot25.name
		slot27 = EliminateConfig.instance:getMainCharacterSkillConfig(slot25.passiveSkillIds)

		if not string.nilorempty(EliminateConfig.instance:getMainCharacterSkillConfig(slot25.activeSkillIds).desc) then
			slot23 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_activeSkill_desc"), slot26.desc) .. "\n"
		end

		if not string.nilorempty(slot27.desc) then
			slot23 = slot23 .. GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_passiveSkill_desc"), slot27.desc)
		end

		if not string.nilorempty(slot26 and slot26.icon or "") then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot17, slot28, false)
		end

		slot18.text = slot26.cost

		if not string.nilorempty(slot25.resPic) then
			slot10:LoadImage(ResUrl.getHeadIconSmall(slot25.resPic))
		end

		slot9.text = slot25.hp
	end

	if slot22 then
		slot25 = EliminateConfig.instance:getSoldierChessConfig(slot1)
		slot23 = EliminateConfig.instance:getSoldierChessDesc(slot1)
		slot24 = slot25.name
		slot13.text = slot25.defaultPower
		slot26, slot27 = EliminateConfig.instance:getSoldierChessConfigConst(slot1)
		slot0._resourceItem = slot0:getUserDataTb_()

		for slot31, slot32 in ipairs(slot26) do
			slot33 = slot32[1]
			slot35 = gohelper.clone(slot12, slot11, slot33)

			UISpriteSetMgr.instance:setV2a2EliminateSprite(gohelper.findChildImage(slot35, "#image_ResourceQuality"), EliminateTeamChessEnum.ResourceTypeToImagePath[slot33], false)

			gohelper.findChildText(slot35, "#image_ResourceQuality/#txt_ResourceNum").text = slot32[2]

			gohelper.setActive(slot35, true)
			table.insert(slot0._resourceItem, slot35)
		end

		if slot25 and not string.nilorempty(slot25.resPic) then
			UISpriteSetMgr.instance:setV2a2ChessSprite(slot6, slot25.resPic, false)
		end

		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot5, "v2a2_eliminate_infochess_qualitybg_0" .. slot25.level, false)
	end

	slot19.text = EliminateLevelModel.instance.formatString(slot23)
	slot15.text = slot24

	gohelper.setActive(slot3, true)
	table.insert(slot0._rewardItem, slot3)
end

function slot0.openRewardTip(slot0)
	gohelper.setActive(slot0._goTips, true)
	gohelper.setActive(slot0._txtClick.gameObject, false)
	gohelper.setActive(slot0._txtcontinue.gameObject, true)
	gohelper.setActive(slot0._goreward, false)

	slot0._canClose = true
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	ViewMgr.instance:openView(ViewName.EliminateLevelResultView)
end

return slot0
