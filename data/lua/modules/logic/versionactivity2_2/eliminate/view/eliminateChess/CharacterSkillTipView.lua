module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipView", package.seeall)

local var_0_0 = class("CharacterSkillTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._gochessTip = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip")
	arg_1_0._imageRoleSkill = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip/Info/image/#image_RoleSkill")
	arg_1_0._goSkillEnergyBG = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG")
	arg_1_0._txtRoleCostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG/#txt_RoleCostNum")
	arg_1_0._txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Info/#txt_SkillName")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnclick2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click_2")
	arg_1_0._gochessTip2 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2")
	arg_1_0._imageChessQualityBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip_2/Info/#image_ChessQualityBG")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip_2/Info/#image_Chess")
	arg_1_0._goResource = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/#go_Resource")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip_2/Info/image_Fire/#txt_FireNum")
	arg_1_0._goStar1 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star1")
	arg_1_0._goStar2 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star2")
	arg_1_0._goStar3 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star3")
	arg_1_0._goStar4 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star4")
	arg_1_0._goStar5 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star5")
	arg_1_0._goStar6 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star6")
	arg_1_0._txtChessName = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip_2/Info/#txt_ChessName")
	arg_1_0._txtchessDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip_2/Scroll View/Viewport/#txt_chess_Descr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnclick2:AddClickListener(arg_2_0._btnclick2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnclick2:RemoveClickListener()
end

function var_0_0._btnclick2OnClick(arg_4_0)
	arg_4_0:hideSoliderInfo()
end

function var_0_0._btnclickOnClick(arg_5_0)
	if arg_5_0._clickBgCb then
		arg_5_0._clickBgCb(arg_5_0._clickBgCbTarget)
	end

	arg_5_0:hideView()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._chessTipAni = arg_6_0._gochessTip:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam

	arg_8_0._showType = var_8_0.showType

	local var_8_1 = var_8_0.skillId
	local var_8_2 = var_8_0.forecastChess
	local var_8_3 = var_8_0.point

	if arg_8_0._showType == EliminateLevelEnum.skillShowType.skill then
		arg_8_0:setSkillId(var_8_1)
	end

	if arg_8_0._showType == EliminateLevelEnum.skillShowType.forecast then
		arg_8_0:setForecastChess(var_8_2)
	end

	arg_8_0:setChessTip2Active(false)
	arg_8_0:setPoint(var_8_3)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
end

function var_0_0.setSkillId(arg_10_0, arg_10_1)
	arg_10_0._skillId = arg_10_1

	local var_10_0 = EliminateConfig.instance:getMainCharacterSkillConfig(arg_10_1)

	arg_10_0._txtSkillName.text = var_10_0 and var_10_0.name or ""
	arg_10_0._txtDescr.text = var_10_0 and EliminateLevelModel.instance.formatString(var_10_0.desc) or ""
	arg_10_0._txtRoleCostNum.text = var_10_0 and var_10_0.cost or ""

	local var_10_1 = var_10_0 and var_10_0.icon or ""

	if not string.nilorempty(var_10_1) then
		UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_10_0._imageRoleSkill, var_10_1, false)
	end

	arg_10_0:refreshShowByType()
end

function var_0_0.setForecastChess(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1[1]
	local var_11_1 = var_11_0.chessId
	local var_11_2 = EliminateConfig.instance:getSoldierChessConfig(var_11_1)
	local var_11_3 = var_11_2 and var_11_2.resPic or ""

	if not string.nilorempty(var_11_3) then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_11_0._imageRoleSkill, var_11_3, false)
		gohelper.setActive(arg_11_0._goEnemySkill, true)
	end

	local var_11_4 = EliminateLevelModel.instance:getRoundNumber()
	local var_11_5 = ""
	local var_11_6 = luaLang("CharacterSkillTipView_chess_residue_round_fmt")

	for iter_11_0 = 1, #arg_11_1 do
		local var_11_7 = arg_11_1[iter_11_0].chessId
		local var_11_8 = EliminateConfig.instance:getSoldierChessConfig(var_11_7)
		local var_11_9 = var_11_0.round - var_11_4
		local var_11_10 = string.format(luaLang("CharacterSkillTipView_txtDescr_overseas"), var_11_7, var_11_8.name)

		var_11_5 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_11_6, var_11_9, var_11_10) .. "\n"
	end

	arg_11_0._txtDescr.text = var_11_5

	gohelper.onceAddComponent(arg_11_0._txtDescr.gameObject, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(arg_11_0.txtClick, arg_11_0)
	arg_11_0:refreshShowByType()
end

function var_0_0.txtClick(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._showType == EliminateLevelEnum.skillShowType.skill then
		return
	end

	arg_12_0:showSoliderInfo(tonumber(arg_12_1))
end

function var_0_0.refreshShowByType(arg_13_0)
	gohelper.setActive(arg_13_0._txtSkillName.gameObject, arg_13_0._showType == EliminateLevelEnum.skillShowType.skill)
	gohelper.setActive(arg_13_0._goSkillEnergyBG, arg_13_0._showType == EliminateLevelEnum.skillShowType.skill)
end

function var_0_0.showSoliderInfo(arg_14_0, arg_14_1)
	arg_14_0:showSoliderInfoByClick(arg_14_1)
end

function var_0_0.hideSoliderInfo(arg_15_0)
	arg_15_0:setChessTip2Active(false)
end

function var_0_0.setChessTip2Active(arg_16_0, arg_16_1)
	gohelper.setActive(arg_16_0._btnclick2, arg_16_1)
	gohelper.setActive(arg_16_0._gochessTip2, arg_16_1)
end

function var_0_0.showSoliderInfoByClick(arg_17_0, arg_17_1)
	local var_17_0 = EliminateConfig.instance:getSoldierChessConfig(arg_17_1)

	if var_17_0 == nil then
		return
	end

	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_17_0._imageChess, var_17_0.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_17_0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. var_17_0.level, false)

	arg_17_0._txtFireNum.text = var_17_0.defaultPower
	arg_17_0._txtChessName.text = var_17_0.name

	local var_17_1 = EliminateConfig.instance:getSoldierChessDesc(arg_17_1)

	arg_17_0._txtchessDescr.text = EliminateLevelModel.instance.formatString(var_17_1)

	local var_17_2, var_17_3 = EliminateConfig.instance:getSoldierChessConfigConst(arg_17_1)

	if arg_17_0._resourceItem then
		for iter_17_0 = 1, #arg_17_0._resourceItem do
			local var_17_4 = arg_17_0._resourceItem[iter_17_0]

			gohelper.setActive(var_17_4, false)
			gohelper.destroy(var_17_4)
		end

		tabletool.clear(arg_17_0._resourceItem)
	else
		arg_17_0._resourceItem = arg_17_0:getUserDataTb_()
	end

	if not var_17_2 then
		return
	end

	for iter_17_1, iter_17_2 in ipairs(var_17_2) do
		local var_17_5 = iter_17_2[1]
		local var_17_6 = iter_17_2[2]
		local var_17_7 = gohelper.clone(arg_17_0._goResourceItem, arg_17_0._goResource, var_17_5)
		local var_17_8 = gohelper.findChildImage(var_17_7, "#image_ResourceQuality")
		local var_17_9 = gohelper.findChildText(var_17_7, "#image_ResourceQuality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(var_17_8, EliminateTeamChessEnum.ResourceTypeToImagePath[var_17_5], false)

		var_17_9.text = var_17_6

		gohelper.setActive(var_17_7, true)
		table.insert(arg_17_0._resourceItem, var_17_7)
	end

	arg_17_0:setChessTip2Active(true)
end

function var_0_0.setClickBgCb(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._clickBgCb = arg_18_1
	arg_18_0._clickBgCbTarget = arg_18_2
end

function var_0_0.setPoint(arg_19_0, arg_19_1)
	if not gohelper.isNil(arg_19_1) then
		local var_19_0, var_19_1, var_19_2 = transformhelper.getPos(arg_19_1.transform)
		local var_19_3, var_19_4 = recthelper.worldPosToAnchorPosXYZ(var_19_0, var_19_1, var_19_2, arg_19_0.viewGO.transform)

		recthelper.setAnchor(arg_19_0._gochessTip.transform, var_19_3, var_19_4)
		gohelper.setActive(arg_19_0._gochessTip, true)
	end
end

function var_0_0.hideView(arg_20_0)
	if arg_20_0._chessTipAni then
		arg_20_0._chessTipAni:Play("close")
		TaskDispatcher.runDelay(arg_20_0.closeThis, arg_20_0, 0.33)
	end
end

function var_0_0.onDestroyView(arg_21_0)
	return
end

return var_0_0
