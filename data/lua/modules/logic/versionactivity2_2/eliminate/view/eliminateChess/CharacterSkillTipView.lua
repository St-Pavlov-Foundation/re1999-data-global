module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipView", package.seeall)

slot0 = class("CharacterSkillTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._gochessTip = gohelper.findChild(slot0.viewGO, "#go_chessTip")
	slot0._imageRoleSkill = gohelper.findChildImage(slot0.viewGO, "#go_chessTip/Info/image/#image_RoleSkill")
	slot0._goSkillEnergyBG = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG")
	slot0._txtRoleCostNum = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG/#txt_RoleCostNum")
	slot0._txtSkillName = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Info/#txt_SkillName")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	slot0._btnclick2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click_2")
	slot0._gochessTip2 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2")
	slot0._imageChessQualityBG = gohelper.findChildImage(slot0.viewGO, "#go_chessTip_2/Info/#image_ChessQualityBG")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "#go_chessTip_2/Info/#image_Chess")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/#go_Resource")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "#go_chessTip_2/Info/image_Fire/#txt_FireNum")
	slot0._goStar1 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star1")
	slot0._goStar2 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star2")
	slot0._goStar3 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star3")
	slot0._goStar4 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star4")
	slot0._goStar5 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star5")
	slot0._goStar6 = gohelper.findChild(slot0.viewGO, "#go_chessTip_2/Info/Stars/#go_Star6")
	slot0._txtChessName = gohelper.findChildText(slot0.viewGO, "#go_chessTip_2/Info/#txt_ChessName")
	slot0._txtchessDescr = gohelper.findChildText(slot0.viewGO, "#go_chessTip_2/Scroll View/Viewport/#txt_chess_Descr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnclick2:AddClickListener(slot0._btnclick2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnclick2:RemoveClickListener()
end

function slot0._btnclick2OnClick(slot0)
	slot0:hideSoliderInfo()
end

function slot0._btnclickOnClick(slot0)
	if slot0._clickBgCb then
		slot0._clickBgCb(slot0._clickBgCbTarget)
	end

	slot0:hideView()
end

function slot0._editableInitView(slot0)
	slot0._chessTipAni = slot0._gochessTip:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam
	slot0._showType = slot1.showType
	slot3 = slot1.forecastChess
	slot4 = slot1.point

	if slot0._showType == EliminateLevelEnum.skillShowType.skill then
		slot0:setSkillId(slot1.skillId)
	end

	if slot0._showType == EliminateLevelEnum.skillShowType.forecast then
		slot0:setForecastChess(slot3)
	end

	slot0:setChessTip2Active(false)
	slot0:setPoint(slot4)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.setSkillId(slot0, slot1)
	slot0._skillId = slot1
	slot0._txtSkillName.text = EliminateConfig.instance:getMainCharacterSkillConfig(slot1) and slot2.name or ""
	slot0._txtDescr.text = slot2 and EliminateLevelModel.instance.formatString(slot2.desc) or ""
	slot0._txtRoleCostNum.text = slot2 and slot2.cost or ""

	if not string.nilorempty(slot2 and slot2.icon or "") then
		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageRoleSkill, slot3, false)
	end

	slot0:refreshShowByType()
end

function slot0.setForecastChess(slot0, slot1)
	if not string.nilorempty(EliminateConfig.instance:getSoldierChessConfig(slot1[1].chessId) and slot4.resPic or "") then
		UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageRoleSkill, slot5, false)
		gohelper.setActive(slot0._goEnemySkill, true)
	end

	slot7 = ""

	for slot12 = 1, #slot1 do
		slot14 = slot1[slot12].chessId
		slot7 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("CharacterSkillTipView_chess_residue_round_fmt"), slot2.round - EliminateLevelModel.instance:getRoundNumber(), string.format(luaLang("CharacterSkillTipView_txtDescr_overseas"), slot14, EliminateConfig.instance:getSoldierChessConfig(slot14).name)) .. "\n"
	end

	slot0._txtDescr.text = slot7

	gohelper.onceAddComponent(slot0._txtDescr.gameObject, typeof(ZProj.TMPHyperLinkClick)):SetClickListener(slot0.txtClick, slot0)
	slot0:refreshShowByType()
end

function slot0.txtClick(slot0, slot1, slot2)
	if slot0._showType == EliminateLevelEnum.skillShowType.skill then
		return
	end

	slot0:showSoliderInfo(tonumber(slot1))
end

function slot0.refreshShowByType(slot0)
	gohelper.setActive(slot0._txtSkillName.gameObject, slot0._showType == EliminateLevelEnum.skillShowType.skill)
	gohelper.setActive(slot0._goSkillEnergyBG, slot0._showType == EliminateLevelEnum.skillShowType.skill)
end

function slot0.showSoliderInfo(slot0, slot1)
	slot0:showSoliderInfoByClick(slot1)
end

function slot0.hideSoliderInfo(slot0)
	slot0:setChessTip2Active(false)
end

function slot0.setChessTip2Active(slot0, slot1)
	gohelper.setActive(slot0._btnclick2, slot1)
	gohelper.setActive(slot0._gochessTip2, slot1)
end

function slot0.showSoliderInfoByClick(slot0, slot1)
	if EliminateConfig.instance:getSoldierChessConfig(slot1) == nil then
		return
	end

	UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot2.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. slot2.level, false)

	slot0._txtFireNum.text = slot2.defaultPower
	slot0._txtChessName.text = slot2.name
	slot0._txtchessDescr.text = EliminateLevelModel.instance.formatString(EliminateConfig.instance:getSoldierChessDesc(slot1))
	slot4, slot5 = EliminateConfig.instance:getSoldierChessConfigConst(slot1)

	if slot0._resourceItem then
		for slot9 = 1, #slot0._resourceItem do
			slot10 = slot0._resourceItem[slot9]

			gohelper.setActive(slot10, false)
			gohelper.destroy(slot10)
		end

		tabletool.clear(slot0._resourceItem)
	else
		slot0._resourceItem = slot0:getUserDataTb_()
	end

	if not slot4 then
		return
	end

	for slot9, slot10 in ipairs(slot4) do
		slot11 = slot10[1]
		slot13 = gohelper.clone(slot0._goResourceItem, slot0._goResource, slot11)

		UISpriteSetMgr.instance:setV2a2EliminateSprite(gohelper.findChildImage(slot13, "#image_ResourceQuality"), EliminateTeamChessEnum.ResourceTypeToImagePath[slot11], false)

		gohelper.findChildText(slot13, "#image_ResourceQuality/#txt_ResourceNum").text = slot10[2]

		gohelper.setActive(slot13, true)
		table.insert(slot0._resourceItem, slot13)
	end

	slot0:setChessTip2Active(true)
end

function slot0.setClickBgCb(slot0, slot1, slot2)
	slot0._clickBgCb = slot1
	slot0._clickBgCbTarget = slot2
end

function slot0.setPoint(slot0, slot1)
	if not gohelper.isNil(slot1) then
		slot2, slot3, slot4 = transformhelper.getPos(slot1.transform)
		slot5, slot6 = recthelper.worldPosToAnchorPosXYZ(slot2, slot3, slot4, slot0.viewGO.transform)

		recthelper.setAnchor(slot0._gochessTip.transform, slot5, slot6)
		gohelper.setActive(slot0._gochessTip, true)
	end
end

function slot0.hideView(slot0)
	if slot0._chessTipAni then
		slot0._chessTipAni:Play("close")
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.33)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
