module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardView", package.seeall)

local var_0_0 = class("EliminateLevelRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnresult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_result")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#btn_result/#go_reward")
	arg_1_0._txtClick = gohelper.findChildText(arg_1_0.viewGO, "#txt_Click")
	arg_1_0._txtcontinue = gohelper.findChildText(arg_1_0.viewGO, "#txt_continue")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_Tips")
	arg_1_0._scrollTips = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_Tips/#scroll_Tips")
	arg_1_0._goLayoutGroup = gohelper.findChild(arg_1_0.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup")
	arg_1_0._goTipsItem = gohelper.findChild(arg_1_0.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup/#go_TipsItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnresult:AddClickListener(arg_2_0._btnresultOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnresult:RemoveClickListener()
end

function var_0_0._btnresultOnClick(arg_4_0)
	if arg_4_0._canClose then
		ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	else
		arg_4_0:openRewardTip()
	end
end

function var_0_0._editableInitView(arg_5_0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._resultData = EliminateTeamChessModel.instance:getWarFightResult()

	arg_7_0:refreshViewByResult()

	arg_7_0._canClose = false

	gohelper.setActive(arg_7_0._goTips, arg_7_0._canClose)
	gohelper.setActive(arg_7_0._goreward, not arg_7_0._canClose)
	gohelper.setActive(arg_7_0._txtClick.gameObject, not arg_7_0._canClose)
	gohelper.setActive(arg_7_0._txtcontinue.gameObject, arg_7_0._canClose)
	gohelper.setActive(arg_7_0._btnresult, not arg_7_0._canClose)
end

function var_0_0.refreshViewByResult(arg_8_0)
	local var_8_0 = arg_8_0._resultData:getResultInfo()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if iter_8_0 == "unlockCharacterIds" then
			arg_8_0:refreshCharacterResult(iter_8_1)
		end

		if iter_8_0 == "unlockChessPieceIds" then
			arg_8_0:refreshPieceResult(iter_8_1)
		end

		if iter_8_0 == "unlockSlotIds" then
			arg_8_0:refreshSlotResult(iter_8_1)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_reward_fall)
end

function var_0_0.refreshCharacterResult(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if EliminateConfig.instance:getTeamChessCharacterConfig(iter_9_1) ~= nil then
			arg_9_0:refreshTipInfo(iter_9_1, EliminateTeamChessEnum.ResultRewardType.character)
		end
	end
end

function var_0_0.refreshPieceResult(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if EliminateConfig.instance:getSoldierChessConfig(iter_10_1) ~= nil then
			arg_10_0:refreshTipInfo(iter_10_1, EliminateTeamChessEnum.ResultRewardType.chessPiece)
		end
	end
end

function var_0_0.refreshSlotResult(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0:refreshTipInfo(iter_11_1, EliminateTeamChessEnum.ResultRewardType.slot)
	end
end

function var_0_0.refreshTipInfo(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._rewardItem == nil then
		arg_12_0._rewardItem = arg_12_0:getUserDataTb_()
	end

	local var_12_0 = gohelper.clone(arg_12_0._goTipsItem, arg_12_0._goLayoutGroup)
	local var_12_1 = gohelper.findChild(var_12_0, "#go_chessTip/Info/#go_HaveChess")
	local var_12_2 = gohelper.findChildImage(var_12_0, "#go_chessTip/Info/#go_HaveChess/image_ChessBG")
	local var_12_3 = gohelper.findChildSingleImage(var_12_0, "#go_chessTip/Info/#go_HaveChess/#image_Chess")
	local var_12_4 = gohelper.findChild(var_12_0, "#go_chessTip/Info/#go_Add")
	local var_12_5 = gohelper.findChild(var_12_0, "#go_chessTip/Info/#go_Role")
	local var_12_6 = gohelper.findChildText(var_12_0, "#go_chessTip/Info/#go_Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	local var_12_7 = gohelper.findChildSingleImage(var_12_0, "#go_chessTip/Info/#go_Role/Role/#simage_Role")
	local var_12_8 = gohelper.findChild(var_12_0, "#go_chessTip/Info/#go_Resource")
	local var_12_9 = gohelper.findChild(var_12_0, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	local var_12_10 = gohelper.findChildText(var_12_0, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	local var_12_11 = gohelper.findChildImage(var_12_0, "#go_chessTip/Info/image_Fire")
	local var_12_12 = gohelper.findChildText(var_12_0, "#go_chessTip/Info/#txt_ChessName")
	local var_12_13 = gohelper.findChild(var_12_0, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill")
	local var_12_14 = gohelper.findChildImage(var_12_0, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillBG/GameObject/#image_RoleSkill")
	local var_12_15 = gohelper.findChildText(var_12_0, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillEnergyBG/#txt_RoleCostNum")
	local var_12_16 = gohelper.findChildText(var_12_0, "#go_chessTip/Scroll View/Viewport/Content/#txt_Descr")
	local var_12_17 = arg_12_2 == EliminateTeamChessEnum.ResultRewardType.slot
	local var_12_18 = arg_12_2 == EliminateTeamChessEnum.ResultRewardType.character
	local var_12_19 = arg_12_2 == EliminateTeamChessEnum.ResultRewardType.chessPiece

	gohelper.setActive(var_12_1, var_12_19)
	gohelper.setActive(var_12_4, var_12_17)
	gohelper.setActive(var_12_8, var_12_17)
	gohelper.setActive(var_12_11.gameObject, var_12_19)
	gohelper.setActive(var_12_5, var_12_18)
	gohelper.setActive(var_12_13, var_12_18)

	local var_12_20 = ""
	local var_12_21 = ""

	if var_12_17 then
		var_12_21 = luaLang("eliminate_teamchess_new_slot_name")
		var_12_20 = luaLang("eliminate_teamchess_new_slot_desc")
	end

	if var_12_18 then
		local var_12_22 = EliminateConfig.instance:getTeamChessCharacterConfig(arg_12_1)

		var_12_21 = var_12_22.name

		local var_12_23 = EliminateConfig.instance:getMainCharacterSkillConfig(var_12_22.activeSkillIds)
		local var_12_24 = EliminateConfig.instance:getMainCharacterSkillConfig(var_12_22.passiveSkillIds)

		if not string.nilorempty(var_12_23.desc) then
			var_12_20 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_activeSkill_desc"), var_12_23.desc) .. "\n"
		end

		if not string.nilorempty(var_12_24.desc) then
			var_12_20 = var_12_20 .. GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_passiveSkill_desc"), var_12_24.desc)
		end

		local var_12_25 = var_12_23 and var_12_23.icon or ""

		if not string.nilorempty(var_12_25) then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_12_14, var_12_25, false)
		end

		var_12_15.text = var_12_23.cost

		if not string.nilorempty(var_12_22.resPic) then
			var_12_7:LoadImage(ResUrl.getHeadIconSmall(var_12_22.resPic))
		end

		var_12_6.text = var_12_22.hp
	end

	if var_12_19 then
		local var_12_26 = EliminateConfig.instance:getSoldierChessConfig(arg_12_1)

		var_12_20 = EliminateConfig.instance:getSoldierChessDesc(arg_12_1)
		var_12_21 = var_12_26.name
		var_12_10.text = var_12_26.defaultPower

		local var_12_27, var_12_28 = EliminateConfig.instance:getSoldierChessConfigConst(arg_12_1)

		arg_12_0._resourceItem = arg_12_0:getUserDataTb_()

		for iter_12_0, iter_12_1 in ipairs(var_12_27) do
			local var_12_29 = iter_12_1[1]
			local var_12_30 = iter_12_1[2]
			local var_12_31 = gohelper.clone(var_12_9, var_12_8, var_12_29)
			local var_12_32 = gohelper.findChildImage(var_12_31, "#image_ResourceQuality")
			local var_12_33 = gohelper.findChildText(var_12_31, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_12_32, EliminateTeamChessEnum.ResourceTypeToImagePath[var_12_29], false)

			var_12_33.text = var_12_30

			gohelper.setActive(var_12_31, true)
			table.insert(arg_12_0._resourceItem, var_12_31)
		end

		if var_12_26 and not string.nilorempty(var_12_26.resPic) then
			SurvivalUnitIconHelper.instance:setNpcIcon(var_12_3, var_12_26.resPic)
		end

		UISpriteSetMgr.instance:setV2a2EliminateSprite(var_12_2, "v2a2_eliminate_infochess_qualitybg_0" .. var_12_26.level, false)
	end

	var_12_16.text = EliminateLevelModel.instance.formatString(var_12_20)
	var_12_12.text = var_12_21

	gohelper.setActive(var_12_0, true)
	table.insert(arg_12_0._rewardItem, var_12_0)
end

function var_0_0.openRewardTip(arg_13_0)
	gohelper.setActive(arg_13_0._goTips, true)
	gohelper.setActive(arg_13_0._txtClick.gameObject, false)
	gohelper.setActive(arg_13_0._txtcontinue.gameObject, true)
	gohelper.setActive(arg_13_0._goreward, false)

	arg_13_0._canClose = true
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	ViewMgr.instance:openView(ViewName.EliminateLevelResultView)
end

return var_0_0
