module("modules.logic.rouge.view.RougeTalentView", package.seeall)

slot0 = class("RougeTalentView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTypeIcon = gohelper.findChildSingleImage(slot0.viewGO, "Left/Top/#simage_TypeIcon")
	slot0._txtType = gohelper.findChildText(slot0.viewGO, "Left/Top/#txt_Type")
	slot0._txtLv = gohelper.findChildText(slot0.viewGO, "Left/Top/#txt_Lv")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Left/Top/#txt_Num")
	slot0._imageslider = gohelper.findChildImage(slot0.viewGO, "Left/Top/Slider/#image_slider")
	slot0._txtDescr1 = gohelper.findChildText(slot0.viewGO, "Left/Skill/#scroll_desc_overseas/viewport/Layout/#txt_Descr1")
	slot0._txtDescr2 = gohelper.findChildText(slot0.viewGO, "Left/Skill/#scroll_desc_overseas/viewport/Layout/#txt_Descr2")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "Left/Card/Layout/#go_detail")
	slot0._imageskillicon = gohelper.findChildImage(slot0.viewGO, "Left/Card/Layout/#go_detail/#image_skillicon")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "Left/Card/Layout/#go_detail/#txt_dec2")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "Left/Card/Layout/#go_skillitem")
	slot0._scrollTree = gohelper.findChildScrollRect(slot0.viewGO, "Tree/#scroll_Tree")
	slot0._simageTypeIcon2 = gohelper.findChildSingleImage(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	slot0._goNormal = gohelper.findChild(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Normal")
	slot0._goSpecial = gohelper.findChild(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Special")
	slot0._goBranch = gohelper.findChild(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#go_Branch")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._setBtnStatus(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot2, not slot1)
	gohelper.setActive(slot3, slot1)
end

function slot0._editableInitView(slot0)
	slot0._imagePointGo1 = gohelper.findChild(slot0._txtDescr1.gameObject, "image_Point")
	slot0._imagePointGo2 = gohelper.findChild(slot0._txtDescr2.gameObject, "image_Point")
	slot0._imageTypeIcon = gohelper.findChildImage(slot0.viewGO, "Left/Top/#simage_TypeIcon")
	slot0._imageTypeIcon2 = gohelper.findChildImage(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch/#simage_TypeIcon2")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "Tree/#scroll_Tree/Viewport/Branch")

	gohelper.setActive(slot0._godetail, false)

	slot0._skillItemList = slot0:getUserDataTb_()
end

function slot0._initIcon(slot0)
	slot4 = string.format("%s_light", lua_rouge_style.configDict[slot0._rougeInfo.season][slot0._rougeInfo.style].icon)

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageTypeIcon, slot4)
	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageTypeIcon2, slot4)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._season = RougeConfig1.instance:season()
	slot0._rougeInfo = RougeModel.instance:getRougeInfo()
	slot0._styleConfig = RougeConfig1.instance:getStyleConfig(RougeModel.instance:getStyle())
	slot0._txtType.text = slot0._styleConfig.name
	slot0._txtLv.text = string.format("Lv.%s", slot0._rougeInfo.teamLevel)
	slot0._txtDescr1.text = slot0._styleConfig.passiveSkillDescs
	slot0._txtDescr2.text = slot0._styleConfig.passiveSkillDescs2

	gohelper.setActive(slot0._imagePointGo1, not string.nilorempty(slot0._styleConfig.passiveSkillDescs))
	gohelper.setActive(slot0._imagePointGo2, not string.nilorempty(slot0._styleConfig.passiveSkillDescs2))
	slot0:_initLevel()

	slot0._nextLevel = math.min(slot0._rougeInfo.teamLevel + 1, slot0._maxLevelConfig.level)
	slot2 = slot0._levelList[slot0._nextLevel]
	slot3 = slot0._rougeInfo.teamExp
	slot0._txtNum.text = string.format("<color=#b67a45>%s</color>/%s", slot3, slot2.exp)
	slot0._imageslider.fillAmount = slot3 / slot2.exp
	slot0._moveContent = true

	slot0:_initTalentList()
	slot0:_initSkill()
	slot0:_initIcon()
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeTalentInfo, slot0._onUpdateRougeTalentInfo, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
end

function slot0._onTouchScreenUp(slot0)
	if slot0._showTips then
		slot0._showTips = false

		return
	end

	gohelper.setActive(slot0._godetail, false)
	slot0:_refreshAllBtnStatus()
end

function slot0._initLevel(slot0)
	slot0._levelList = {}

	for slot6, slot7 in ipairs(lua_rouge_level.configDict[slot0._season]) do
		if 0 <= slot7.level then
			slot2 = slot7.level
			slot0._maxLevelConfig = slot7
		end

		slot0._levelList[slot7.level] = slot7
	end
end

function slot0._initTalentList(slot0)
	slot0._talentCompList = slot0:getUserDataTb_()
	slot0._groupMap = slot0:getUserDataTb_()
	slot1 = slot0._rougeInfo.talentInfo
	slot0._costTalentPoint = tonumber(RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentCost))
	slot5 = {
		[slot10] = true
	}

	for slot9, slot10 in ipairs(string.splitToNumber(RougeConfig1.instance:getConstValueByID(RougeEnum.Const.TalentBigNode), "#")) do
		-- Nothing
	end

	slot6 = 1
	slot7 = nil

	while slot6 <= #slot1 do
		slot9 = slot6 + 1
		slot6 = slot9 + 1
		slot10 = slot9 / 2
		slot12 = slot1[slot9]

		if not slot1[slot6] or not slot12 then
			return
		end

		gohelper.setActive(gohelper.cloneInPlace(slot0._goBranch), true)

		slot15 = gohelper.clone(slot5[slot10] and slot0._goSpecial or slot0._goNormal, slot13)

		gohelper.setActive(slot15, true)

		slot16 = slot15:GetComponent(typeof(UnityEngine.Animator))
		slot19 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot15, "Left"), RougeTalentItem)
		slot20 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot15, "Right"), RougeTalentItem)

		table.insert(slot0._talentCompList, slot19)
		table.insert(slot0._talentCompList, slot20)

		slot0._groupMap[slot19] = slot16
		slot0._groupMap[slot20] = slot16

		slot19:setSpecial(slot14)
		slot20:setSpecial(slot14)
		slot19:setInfo(slot0, slot8, slot11, slot20, slot7)
		slot20:setInfo(slot0, slot9, slot12, slot19, slot7)

		slot7 = {
			slot19,
			slot20
		}
	end

	slot0:_onUpdateRougeTalentInfo()
end

function slot0._onUpdateRougeTalentInfo(slot0)
	slot2 = slot0._rougeInfo.talentPoint
	slot7 = 1

	for slot11, slot12 in ipairs(slot0._talentCompList) do
		if not nil then
			slot3 = slot0._rougeInfo.talentInfo[slot11]
			slot5 = slot12
		else
			slot4 = slot13
			slot6 = slot12
		end

		if slot5 and slot6 then
			slot5:updateInfo(slot3)
			slot6:updateInfo(slot4)
			slot5:updateState(slot0._costTalentPoint <= slot2)
			slot6:updateState(slot0._costTalentPoint <= slot2)

			if slot5:isRootPlayCloseAnim() or slot6:isRootPlayCloseAnim() then
				slot0._groupMap[slot5]:Play("close", 0, 0)
			end

			if slot5:isRootPlayOpenAnim() or slot6:isRootPlayOpenAnim() then
				slot0._groupMap[slot5]:Play("open", 0, 0)
			end

			if slot5:needCostTalentPoint() or slot6:needCostTalentPoint() then
				slot2 = slot2 - slot0._costTalentPoint
			end

			if slot0._moveContent and slot7 > 4 and (slot5:canActivated() or slot6:canActivated()) then
				slot0._moveContent = false

				recthelper.setAnchorY(slot0._gocontent.transform, (slot7 - 4 + 1) * 180)
			end

			slot5, slot6 = nil
			slot7 = slot7 + 1
		end
	end
end

function slot0._initSkill(slot0)
	slot3 = {}

	for slot7, slot8 in ipairs(RougeDLCHelper.getAllCurrentUseStyleSkills(slot0._styleConfig.id)) do
		slot9 = slot0:_getOrCreateSkillItem(slot7)

		if not string.nilorempty(RougeOutsideModel.instance:config():getSkillCo(slot8.type, slot8.skillId) and slot10.icon) then
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagenormalicon, slot11, true)
			UISpriteSetMgr.instance:setRouge2Sprite(slot9.imagselecticon, slot11 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", slot8.type, slot8.skillId))
		end

		slot0["_skillDesc" .. slot7] = slot10 and slot10.desc
		slot0["_skillIcon" .. slot7] = slot10 and slot10.icon

		gohelper.setActive(slot9.viewGO, true)

		slot3[slot9] = true
	end

	for slot7, slot8 in ipairs(slot0._skillItemList) do
		if not slot3[slot8] then
			gohelper.setActive(slot8.viewGO, false)
		end
	end
end

function slot0._getOrCreateSkillItem(slot0, slot1)
	if not (slot0._skillItemList and slot0._skillItemList[slot1]) then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goskillitem, "item_" .. slot1)
		slot2.gonormal = gohelper.findChild(slot2.viewGO, "go_normal")
		slot2.imagenormalicon = gohelper.findChildImage(slot2.viewGO, "go_normal/image_icon")
		slot2.goselect = gohelper.findChild(slot2.viewGO, "go_select")
		slot2.imagselecticon = gohelper.findChildImage(slot2.viewGO, "go_select/image_icon")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnskillOnClick, slot0, slot1)
		table.insert(slot0._skillItemList, slot2)
	end

	return slot2
end

function slot0._btnskillOnClick(slot0, slot1)
	slot0._showTips = true
	slot0._txtdec2.text = slot0["_skillDesc" .. slot1]

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imageskillicon, slot0["_skillIcon" .. slot1], true)
	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._godetail, true)
	gohelper.setAsLastSibling(slot0._godetail)
	slot0:_refreshAllBtnStatus(slot1)
end

function slot0._refreshAllBtnStatus(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._skillItemList) do
		slot0:_setBtnStatus(slot1 == slot5, slot6.gonormal, slot6.goselect)
	end
end

function slot0._removeAllSkillClickListener(slot0)
	if slot0._skillItemList then
		for slot4, slot5 in pairs(slot0._skillItemList) do
			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end
end

function slot0.setTalentCompSelected(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._talentCompList) do
		slot6:setSelected(slot6 == slot1)
	end
end

function slot0.activeTalent(slot0, slot1)
	slot0._tmpActiveTalentId = slot1 and slot1._talentId

	RougeRpc.instance:sendActiveTalentRequest(slot0._season, slot1._index - 1, slot0.activeTalentCb, slot0)
end

function slot0.activeTalentCb(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	RougeStatController.instance:trackUpdateTalent(slot0._tmpActiveTalentId)

	slot0._tmpActiveTalentId = nil
end

function slot0.onClose(slot0)
	slot0._tmpActiveTalentId = nil

	slot0:_removeAllSkillClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouchScreenUp, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
