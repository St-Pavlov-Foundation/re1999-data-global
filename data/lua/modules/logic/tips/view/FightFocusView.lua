module("modules.logic.tips.view.FightFocusView", package.seeall)

slot0 = class("FightFocusView", BaseViewExtended)

function slot0._onAttributeClick_overseas(slot0)
	if slot0.openFightAttributeTipView then
		return
	end

	slot0:closeAllTips()

	if slot0._entityMO:isCharacter() then
		ViewMgr.instance:openView(ViewName.FightAttributeTipView, {
			entityMO = slot0._entityMO,
			mo = slot0._entityMO.attrMO,
			data = slot0:_getHeroBaseAttr(slot0._entityMO:getCO()),
			isCharacter = slot0.isCharacter
		})

		slot0.openFightAttributeTipView = true
	else
		ViewMgr.instance:openView(ViewName.FightAttributeTipView, {
			entityMO = slot0._entityMO,
			mo = slot0._entityMO.attrMO,
			data = slot0:_getMontBaseAttr(slot0._entityMO:getCO()),
			isCharacter = slot0.isCharacter
		})

		slot0.openFightAttributeTipView = true
	end
end

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "fightinfocontainer/#btn_close")
	slot0._btnDetailClose = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_detailView/#btn_detailClose")
	slot0._goinfoView = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView")
	slot0._goinfoViewContent = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/#image_career")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/#txt_name")
	slot0._gostress = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_fightstressitem")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level/#image_dmgtype")
	slot0._goplayerpassive = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive")
	slot0._scrollenemypassive = gohelper.findChildScrollRect(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive")
	slot0._goenemyemptyskill = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/emptyskill")
	slot0._goenemypassive = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive")
	slot0._goenemypassiveitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	slot0._goenemypassiveSkill = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill")
	slot0._enemypassiveSkillPrefab = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/item")
	slot0._btnenemypassiveSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/btn_passiveclick")
	slot0._goresistance = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#go_resistance")
	slot0._txthp = gohelper.findChildText(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#txt_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#slider_hp")
	slot0._goattributeroot = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_attribute_root")
	slot0._btnattribute = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_attribute_root/#btn_attribute")
	slot0._scrollbuff = gohelper.findChildScrollRect(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff/Viewport/Content/buffitem")
	slot0._godetailView = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_detailView")
	slot0._goplayer = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player")
	slot0._goenemy = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/enemy")
	slot0._scrollplotenemypassive = gohelper.findChildScrollRect(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive")
	slot0._goplotenemypassive = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive")
	slot0._goplotenemypassiveitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	slot0._godetailpassiveitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem")
	slot0._btnplayerpassive = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/#btn_playerpassive")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "fightinfocontainer/#go_detailView/bg/#scroll_content")
	slot0._gobuffpassiveview = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_buffpassiveview")
	slot0._gobuffpassiveitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	slot0._gotargetframe = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_targetframe")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Bg")
	slot0._containerGO = gohelper.findChild(slot0.viewGO, "fightinfocontainer")
	slot0._noskill = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/noskill")
	slot0._skill = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/skill")
	slot0._goplayerequipinfo = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo")
	slot0._goequip = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip")
	slot0._txtequiplv = gohelper.findChildText(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#txt_equiplv")
	slot0._equipIconImage = gohelper.findChildImage(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	slot0._simageequipicon = gohelper.findChildSingleImage(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	slot0._goequipEmpty = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equipEmpty")
	slot0._btnclosebuffpassive = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_buffpassiveview/#btn_detailClose")

	gohelper.setActive(slot0._enemypassiveSkillPrefab, false)

	slot0._enemypassiveiconGOs = slot0:getUserDataTb_()
	slot0._enemybuffpassiveGOs = slot0:getUserDataTb_()
	slot0._passiveSkillImgs = slot0:getUserDataTb_()
	slot0._passiveiconImgs = slot0:getUserDataTb_()
	slot0._bossSkillInfos = {}
	slot0._isbuffviewopen = false
	slot0._canClickAttribute = false
	slot0._multiHpRoot = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG")
	slot0._multiHpItem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG/image_HpItem")
	slot0._btnSwitchEnemy = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy")
	slot0._btnSwitchMember = gohelper.findChildButton(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_member")
	slot0._switchEnemyNormal = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/normal")
	slot0._switchEnemySelect = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/select")
	slot0._switchMemberNormal = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_member/normal")
	slot0._switchMemberSelect = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_switch/#btn_member/select")
	slot0._btnBuffObj = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#btn_more")
	slot0._btnBuffMore = gohelper.getClickWithDefaultAudio(slot0._btnBuffObj)
	slot0._ani = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnDetailClose:AddClickListener(slot0._hideDetail, slot0)
	slot0._btnplayerpassive:AddClickListener(slot0._btnplayerpassiveOnClick, slot0)
	slot0._btnclosebuffpassive:AddClickListener(slot0._onCloseBuffPassive, slot0)
	slot0._btnattribute:AddClickListener(slot0._onAttributeClick, slot0)
	slot0._btnSwitchEnemy:AddClickListener(slot0._onSwitchEnemy, slot0)
	slot0._btnSwitchMember:AddClickListener(slot0._onSwitchMember, slot0)
	slot0._btnBuffMore:AddClickListener(slot0._onBtnBuffMore, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, slot0._onReceiveEntityInfoReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnDetailClose:RemoveClickListener()
	slot0._btnplayerpassive:RemoveClickListener()
	slot0._btnenemypassiveSkill:RemoveClickListener()
	slot0._btnclosebuffpassive:RemoveClickListener()
	slot0._btnattribute:RemoveClickListener()
	slot0._btnSwitchEnemy:RemoveClickListener()
	slot0._btnSwitchMember:RemoveClickListener()
	slot0._btnBuffMore:RemoveClickListener()
	slot0:_releasePassiveSkillGOs()
end

function slot0._releasePassiveSkillGOs(slot0)
	if #slot0._passiveSkillGOs then
		for slot4, slot5 in pairs(slot0._passiveSkillGOs) do
			slot5.btn:RemoveClickListener()
			gohelper.destroy(slot5.go)
		end
	end

	slot0._passiveSkillGOs = {}
end

function slot0._onSwitchEnemy(slot0)
	slot0:_onClickSwitchBtn(FightEnum.EntitySide.EnemySide)
end

function slot0._onSwitchMember(slot0)
	slot0:_onClickSwitchBtn(FightEnum.EntitySide.MySide)
end

function slot0._onClickSwitchBtn(slot0, slot1)
	slot0:closeAllTips()

	slot0._curSelectSide = slot1

	slot0:_refreshEntityList()

	slot0._curSelectId = slot0._entityList[1].id

	slot0:_refreshUI()
	slot0._ani:Play("switch", nil, )
end

function slot0._btncloseOnClick(slot0)
	if slot0.openEquipInfoTipView then
		ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

		slot0.openEquipInfoTipView = false

		return
	end

	if slot0.openFightAttributeTipView then
		ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

		slot0.openFightAttributeTipView = false

		return
	end

	if slot0._hadPopUp then
		slot0:_hideDetail()

		slot0._hadPopUp = false
	else
		slot0:closeThis()
	end
end

function slot0._onCloseBuffPassive(slot0)
	gohelper.setActive(slot0._gobuffpassiveview, false)

	slot0._isbuffviewopen = false
end

function slot0._btnplayerpassiveOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:_showPassiveDetail()
end

function slot0._btnenemypassiveOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:_showPassiveDetail()
end

function slot0.initScrollEnemyNode(slot0)
	slot0.enemyItemList = {}
	slot0.goScrollEnemy = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#scroll_enemy")
	slot0._entityScrollHeight = recthelper.getHeight(slot0.goScrollEnemy.transform)
	slot0.goScrollEnemyContent = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent")
	slot0.contentSizeFitter = slot0.goScrollEnemyContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	slot0.contentEnemyItem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent/enemyitem")

	gohelper.setActive(slot0.contentEnemyItem, false)
end

function slot0._editableInitView(slot0)
	slot0._equipIconImage.enabled = false

	gohelper.setActive(slot0._godetailView, false)
	slot0:initScrollEnemyNode()
	slot0._simagebg:LoadImage(ResUrl.getFightImage("fightfocus/full/bg_bossjieshao_mengban.png"))
	gohelper.setActive(slot0._goenemypassiveitem, false)
	gohelper.setActive(slot0._goexitem, false)
	gohelper.setActive(slot0._gobuffitem, false)

	slot4 = false

	gohelper.setActive(slot0._godetailpassiveitem, slot4)

	slot0._passiveSkillGOs = {}
	slot0._exItemTables = {}
	slot0._buffTables = {}
	slot0._detailPassiveTables = {}
	slot0._playerpassiveGOList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		table.insert(slot0._playerpassiveGOList, gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel" .. slot4))
	end

	slot0._txttalent = gohelper.findChildTextMesh(slot0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/talent/tmp_talent")
	slot0._txttalent.overflowMode = TMPro.TextOverflowModes.Ellipsis
	slot0._gosuperitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_superitem")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_skillitem")

	gohelper.setActive(slot0._gosuperitem, false)
	gohelper.setActive(slot0._goskillitem, false)

	slot0._superItemList = {}
	slot1 = nil

	for slot5 = 1, 3 do
		table.insert(slot0._superItemList, slot0:createSuperItem())
	end

	slot0._skillGOs = {}
	slot2 = nil

	for slot6 = 1, 3 do
		table.insert(slot0._skillGOs, slot0:createSkillItem())
	end

	slot0._godetailcontent = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "fightinfocontainer/#go_detailView/bg")
	slot0._onCloseNeedResetCamera = true
	slot0._hadPopUp = false
	slot0.openEquipInfoTipView = false
	slot0.openFightAttributeTipView = false

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)

	if DungeonModel.instance.curSendChapterId then
		slot0.isSimple = DungeonConfig.instance:getChapterCO(slot3) and slot4.type == DungeonEnum.ChapterType.Simple
	end

	slot0.resistanceComp = FightEntityResistanceComp.New(slot0._goresistance, slot0.viewContainer)

	slot0.resistanceComp:onInitView()

	slot0.stressComp = FightFocusStressComp.New()

	slot0.stressComp:init(slot0._gostress)
end

function slot0.createSuperItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gosuperitem)
	slot1.icon = gohelper.findChildSingleImage(slot1.go, "lv/imgIcon")
	slot1.btn = gohelper.findChildButtonWithAudio(slot1.go, "btn_click")

	slot1.btn:AddClickListener(function (slot0)
		uv0:_showSkillDetail(slot0.info)
	end, slot1)
	gohelper.setActive(slot1.go, false)

	return slot1
end

function slot0.createSkillItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._goskillitem)
	slot1.icon = gohelper.findChildSingleImage(slot1.go, "lv/imgIcon")
	slot1.tag = gohelper.findChildSingleImage(slot1.go, "tag/pos/tag/tagIcon")
	slot1.btn = gohelper.findChildButtonWithAudio(slot1.go, "btn_click")

	slot1.btn:AddClickListener(function (slot0)
		uv0:_showSkillDetail(slot0.info)
	end, slot1)
	gohelper.setActive(slot1.go, false)

	return slot1
end

function slot0._getEntityList(slot0)
	for slot6, slot7 in ipairs(FightDataHelper.entityMgr:getSpList(slot0._curSelectSide)) do
		table.insert(FightDataHelper.entityMgr:getNormalList(slot0._curSelectSide), slot7)
	end

	if FightModel.instance:isSeason2() and slot0._curSelectSide == FightEnum.EntitySide.MySide then
		for slot7, slot8 in ipairs(FightDataHelper.entityMgr:getSubList(slot0._curSelectSide)) do
			table.insert(slot1, slot8)
		end
	end

	for slot6 = #slot1, 1, -1 do
		if FightHelper.getEntity(slot1[slot6].id) and slot7.spine and slot7.spine.detectDisplayInScreen and not slot7.spine:detectDisplayInScreen() then
			table.remove(slot1, slot6)
		end
	end

	slot0:sortFightEntityList(slot1)

	return slot1
end

function slot0.sortFightEntityList(slot0, slot1)
	slot0.bossIdDict = {}

	if not FightModel.instance:getFightParam().monsterGroupIds then
		return
	end

	for slot6, slot7 in ipairs(slot2.monsterGroupIds) do
		if not string.nilorempty(lua_monster_group.configDict[slot7].bossId) then
			for slot13, slot14 in ipairs(string.splitToNumber(slot8, "#")) do
				slot0.bossIdDict[slot14] = true
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if uv0.bossIdDict[slot0.modelId] and not uv0.bossIdDict[slot1.modelId] then
			return true
		elseif not uv0.bossIdDict[slot0.modelId] and uv0.bossIdDict[slot1.modelId] then
			return false
		elseif uv0.bossIdDict[slot0.modelId] and uv0.bossIdDict[slot1.modelId] then
			return slot0.modelId < slot1.modelId
		elseif FightDataHelper.entityMgr:isSub(slot0.id) and not FightDataHelper.entityMgr:isSub(slot1.id) then
			return false
		elseif not slot2 and slot3 then
			return true
		elseif not slot2 and not slot3 then
			return slot0.modelId < slot1.modelId
		else
			return slot1.position < slot0.position
		end
	end)
end

function slot0.onOpen(slot0)
	slot0.subEntityList = {}
	slot0._attrEntityDic = {}
	slot0._group = slot0.viewParam and slot0.viewParam.group or HeroGroupModel.instance:getCurGroupMO()

	if FightModel.instance:isSeason2() then
		slot0._group = Season166HeroGroupModel.instance:getCurGroupMO()
	end

	slot0._setEquipInfo = slot0.viewParam and slot0.viewParam.setEquipInfo
	slot0._balanceHelper = slot0.viewParam and slot0.viewParam.balanceHelper or HeroGroupBalanceHelper

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, false)
	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	if slot0.viewParam and slot0.viewParam.entityId and FightHelper.getEntity(slot0.viewParam.entityId) then
		slot0._curSelectSide = slot1:getSide()
	else
		slot0._curSelectSide = FightEnum.EntitySide.EnemySide
	end

	slot0:_refreshEntityList()

	slot0._curSelectId = slot1 and slot1.id or slot0._entityList[1].id

	TaskDispatcher.runDelay(slot0._refreshUI, slot0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_roledetails)
	NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
end

function slot0._refreshEntityList(slot0)
	slot0._entityList = slot0:_getEntityList()

	gohelper.setActive(slot0._switchEnemyNormal, slot0._curSelectSide == FightEnum.EntitySide.MySide)
	gohelper.setActive(slot0._switchEnemySelect, slot0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(slot0._switchMemberNormal, slot0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(slot0._switchMemberSelect, slot0._curSelectSide == FightEnum.EntitySide.MySide)
	slot0:refreshScrollEnemy()
end

function slot0._refreshUI(slot0)
	if slot0._entityMO ~= FightDataHelper.entityMgr:getById(slot0._curSelectId) then
		slot0:_focusEntity(slot1)
	end

	slot0._entityMO = slot1

	if slot1:isCharacter() then
		slot0.isCharacter = true

		slot0:_refreshCharacterInfo(slot1)
	else
		if slot1.side == FightEnum.EntitySide.MySide then
			slot0.isCharacter = true
		else
			slot0.isCharacter = false
		end

		slot0:_refreshInfo(slot1:getCO())
	end

	gohelper.setActive(slot0._goplayer, slot0.isCharacter)
	gohelper.setActive(slot0._goenemy, not slot0.isCharacter)
	slot0:_refreshMO(slot1)
	slot0:_hideDetail()
	slot0:_detectBossMultiHp(slot1)
	slot0:refreshScrollEnemySelectStatus()
end

function slot0._refreshInfo(slot0, slot1)
	gohelper.setActive(slot0._btnattribute.gameObject, false)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1.career))

	slot0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(slot1[slot0.isSimple and "levelEasy" or "level"])
	slot0._txtname.text = FightConfig.instance:getNewMonsterConfig(slot1) and slot1.highPriorityName or slot1.name

	if isDebugBuild then
		logNormal(string.format("monster id=%d template=%d skillTemplate=%d", slot1.id, slot1.template, slot1.skillTemplate))
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot1.dmgType))

	slot4 = nil

	if slot0.isCharacter then
		if next(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id)) then
			slot0:_refreshPassiveSkill(slot4, slot0._goplotenemypassiveitem)
		end

		gohelper.setActive(slot0._scrollplotenemypassive.gameObject, true)
		gohelper.setActive(slot0._goplayerpassive, false)
	else
		slot0:_refreshPassiveSkill((not FightHelper.isBossId(slot0:_getBossId(), slot1.id) or FightConfig.instance:_filterSpeicalSkillIds(FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id), false)) and FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id), slot0._goenemypassiveitem)
		gohelper.setActive(slot0._goplayerpassive, false)
	end

	slot5 = {}
	slot6 = string.nilorempty(slot1.activeSkill)
	slot8 = slot6 and #slot1.uniqueSkill < 1

	if not slot6 then
		slot5 = string.split(slot1.activeSkill, "|")
	end

	gohelper.setActive(slot0._noskill, slot8)
	gohelper.setActive(slot0._skill, not slot8)

	slot10, slot11 = nil

	for slot15, slot16 in pairs(slot5) do
		slot20 = "#"
		slot10 = string.splitToNumber(slot16, slot20)

		for slot20 = 2, #slot10 do
			table.insert(slot9[slot11], slot10[slot20])
		end
	end

	slot0:_refreshSuper(slot1.uniqueSkill)
	slot0:_refreshSkill({
		[slot10[1]] = {}
	})
	slot0:_refreshAttrList(slot0:_getMontBaseAttr(slot1))
	slot0:_refreshResistance()
	slot0.stressComp:refreshStress(slot0._entityMO)
	gohelper.setActive(slot0._goplayerequipinfo, false)
end

function slot0._refreshResistance(slot0)
	if slot0.isCharacter then
		slot0.resistanceComp:refresh(nil)

		return
	end

	slot0.resistanceComp:refresh(slot0._entityMO:getResistanceDict())
end

function slot0._getBossId(slot0)
	slot2 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot1]

	return slot2 and not string.nilorempty(slot2.bossId) and slot2.bossId or nil
end

slot1 = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function slot0._onMonsterAttrItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = slot4:Find("icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("name"):GetComponent(gohelper.Type_TextMesh)

	if recthelper.getWidth(slot6.transform) < SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot6, HeroConfig.instance:getHeroAttributeCO(slot2.id).name) then
		slot6.overflowMode = TMPro.TextOverflowModes.Ellipsis
		slot0._canClickAttribute = true
	end

	slot6.text = slot7.name

	UISpriteSetMgr.instance:setCommonSprite(slot5, "icon_att_" .. slot7.id)

	slot10 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)

	if slot0.isCharacter then
		gohelper.setActive(slot10.gameObject, true)
		gohelper.setActive(slot4:Find("rate"):GetComponent(gohelper.Type_Image).gameObject, false)

		slot10.text = slot0._curAttrMO[uv0[slot3]]
	else
		gohelper.setActive(slot10.gameObject, false)
		gohelper.setActive(slot11.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(slot11, "sx_" .. slot2.value, true)
	end
end

function slot0._refreshCharacterInfo(slot0, slot1)
	gohelper.setActive(slot0._scrollplotenemypassive.gameObject, false)

	slot3 = slot1:getCO()

	slot0:_refreshHeroEquipInfo(slot1)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot3.career))

	slot0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(slot1.level)
	slot0._txtname.text = slot3.name

	if slot1:getTrialAttrCo() then
		slot0._txtname.text = slot2.name
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot3.dmgType))
	slot0:_refreshCharacterPassiveSkill(slot1)
	gohelper.setActive(slot0._goenemypassive, false)
	gohelper.setActive(slot0._noskill, false)
	gohelper.setActive(slot0._skill, true)

	slot4 = nil

	if tonumber(slot1.uid) < 0 or not PlayerModel.instance:isPlayerSelf(slot1.userId) then
		slot4 = slot1.exSkillLevel
	end

	slot6 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(slot3.id, nil, , slot4)

	if slot2 then
		slot6 = SkillConfig.instance:getHeroAllSkillIdDictByStr(slot2.activeSkill, slot2.uniqueSkill)
	end

	slot7 = slot6[3][1]
	slot6[3] = nil

	if slot1.exSkill and slot1.exSkill > 0 then
		slot7 = slot1.exSkill
	end

	if #slot1.skillGroup1 > 0 then
		slot6[1] = LuaUtil.deepCopySimple(slot1.skillGroup1)
	end

	if #slot1.skillGroup2 > 0 then
		slot6[2] = LuaUtil.deepCopySimple(slot1.skillGroup2)
	end

	slot0:_refreshSuper({
		slot7
	})
	slot0:_refreshSkill(slot6)
	slot0:_refreshAttrList(slot0:_getHeroBaseAttr(slot3))
	slot0.stressComp:refreshStress(slot0._entityMO)
end

function slot0._refreshHeroEquipInfo(slot0, slot1)
	slot2, slot3 = nil

	if tonumber(slot1.uid) < 0 then
		if tonumber(slot1.equipUid) > 0 then
			slot2 = EquipModel.instance:getEquip(slot1.equipUid)
		elseif tonumber(slot1.equipUid) < 0 then
			if lua_equip_trial.configDict[-tonumber(slot1.equipUid)] then
				EquipMO.New():initByTrialEquipCO(slot4)
			end
		elseif slot1.trialEquip and slot1.trialEquip.equipId > 0 then
			EquipMO.New():initByTrialCO({
				equipId = slot1.trialEquip.equipId,
				equipLv = slot1.trialEquip.equipLv,
				equipRefine = slot1.trialEquip.refineLv
			})
		end
	else
		slot4 = nil
		slot4 = (PlayerModel.instance:isPlayerSelf(slot1.userId) or slot1.uid) and HeroModel.instance:getByHeroId(slot1:getCO().id) and slot7.id
		slot6 = nil

		if slot0._group then
			for slot10, slot11 in pairs(slot0._group.heroList) do
				if slot4 and slot11 == slot4 then
					slot6 = slot0._group.equips[slot10 - 1].equipUid[1]
					slot3 = slot10
				end
			end
		end

		if tonumber(slot6) and tonumber(slot6) < 0 then
			if lua_equip_trial.configDict[-tonumber(slot6)] then
				EquipMO.New():initByTrialEquipCO(slot7)
			end
		else
			slot2 = EquipModel.instance:getEquip(slot6)
		end
	end

	if slot2 and slot0._balanceHelper.getIsBalanceMode() then
		slot4, slot5, slot6 = slot0._balanceHelper.getBalanceLv()

		if slot2.level < slot6 then
			slot7 = EquipMO.New()

			slot7:initByConfig(nil, slot2.equipId, slot6, slot2.refineLv)

			slot2 = slot7
		end
	end

	if slot2 and slot3 and slot0._setEquipInfo then
		slot2 = slot0._setEquipInfo[1](slot0._setEquipInfo[2], {
			posIndex = slot3,
			equipMO = slot2
		})
	end

	slot0.equipMO = slot2

	if slot0.equipMO then
		slot0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot0.equipMO.config.icon), slot0._equipIconLoaded, slot0)

		slot0._txtequiplv.text = string.format("Lv.%s", slot0.equipMO.level)
		slot0.equipClick = gohelper.getClick(slot0._simageequipicon.gameObject)

		slot0.equipClick:AddClickListener(slot0.onEquipClick, slot0)
	end

	gohelper.setActive(slot0._goequip, slot0.equipMO)
	gohelper.setActive(slot0._goplayerequipinfo, slot0.equipMO)
end

function slot0._equipIconLoaded(slot0)
	slot0._equipIconImage.enabled = true
end

function slot0.onEquipClick(slot0)
	if slot0.openEquipInfoTipView then
		return
	end

	slot0:closeAllTips()
	gohelper.setActive(slot0._godetailView, false)

	slot0.openEquipInfoTipView = true

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = slot0.equipMO,
		heroCo = slot0._entityMO:getCO()
	})
end

function slot0._refreshAttrList(slot0, slot1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	slot0._attrDataList = slot1
	slot0._curAttrMO = slot0._attrEntityDic[slot0._entityMO.id]

	if slot0._curAttrMO then
		gohelper.CreateObjList(slot0, slot0._onMonsterAttrItemShow, slot0._attrDataList, slot0._goattributeroot)
		gohelper.setActive(slot0._btnattribute.gameObject, true)
	else
		FightRpc.instance:sendEntityInfoRequest(slot0._entityMO.id)
	end
end

function slot0._onReceiveEntityInfoReply(slot0, slot1)
	slot0._attrEntityDic[slot1.entityInfo.uid] = slot1.entityInfo.attr
	slot0._curAttrMO = slot0._attrEntityDic[slot0._entityMO.id]

	if slot0._curAttrMO then
		gohelper.CreateObjList(slot0, slot0._onMonsterAttrItemShow, slot0._attrDataList, slot0._goattributeroot)
		gohelper.setActive(slot0._btnattribute.gameObject, true)
	end
end

function slot0._getHeroBaseAttr(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs({
		"atk",
		"technic",
		"def",
		"mdef"
	}) do
		table.insert(slot3, {
			id = HeroConfig.instance:getIDByAttrType(slot2[slot7]),
			value = HeroConfig.instance:getHeroAttrRate(slot1.id, slot8)
		})
	end

	return slot3
end

function slot0._getMontBaseAttr(slot0, slot1)
	slot3 = string.splitToNumber(lua_monster_skill_template.configDict[slot1.skillTemplate].template, "#")
	slot10 = slot3

	table.insert(slot3, 2, table.remove(slot10, 4))

	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		table.insert(slot5, {
			id = HeroConfig.instance:getIDByAttrType(({
				"atk",
				"technic",
				"def",
				"mdef"
			})[slot9]),
			value = slot10
		})
	end

	return slot5
end

function slot0._onAttributeClick(slot0)
	slot0:_onAttributeClick_overseas()
end

function slot0._refreshPassiveSkill(slot0, slot1, slot2)
	slot0:_releasePassiveSkillGOs()

	for slot6 = 1, #slot1 do
		if not slot0._passiveSkillGOs[slot6] then
			slot8 = gohelper.cloneInPlace(slot2, "item" .. slot6)
			slot7 = slot0:getUserDataTb_()
			slot7.go = slot8
			slot7.name = gohelper.findChildTextMesh(slot8, "tmp_talent")
			slot7.btn = gohelper.findChildButton(slot8, "#btn_enemypassive")

			table.insert(slot0._passiveSkillGOs, slot7)
		end

		slot7.btn:AddClickListener(slot0._btnenemypassiveOnClick, slot0)

		slot7.name.text = lua_skill.configDict[tonumber(slot1[slot6])].name

		gohelper.setActive(slot7.go, true)
	end

	for slot6 = #slot1 + 1, #slot0._passiveSkillGOs do
		gohelper.setActive(slot0._passiveSkillGOs[slot6].go, false)
	end

	gohelper.setActive(slot0._goenemypassive, #slot1 > 0)

	slot0._passiveSkillIds = slot1
	slot3 = slot0._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	slot6 = 200

	if math.ceil(#slot1 / 3) <= 2 then
		slot6 = 80 * slot5
	end

	slot3.minHeight = slot6
end

function slot0._refreshCharacterPassiveSkill(slot0, slot1)
	slot3, slot4 = SkillConfig.instance:getHeroExSkillLevelByLevel(slot1:getCO().id, slot1.level)
	slot5 = {}

	if slot0:getPassiveSkillList(slot1) and #slot6 > 0 then
		gohelper.setActive(slot0._goplayerpassive, true)

		slot0._txttalent.text = lua_skill.configDict[slot6[1]].name

		for slot11 = 1, #slot6 do
			slot12 = slot11 <= slot3

			gohelper.setActive(slot0._playerpassiveGOList[slot11], slot12)

			if slot12 then
				table.insert(slot5, FightHelper.getPassiveSkill(slot1.id, slot6[slot11]))
			end
		end

		for slot11 = #slot6 + 1, #slot0._playerpassiveGOList do
			gohelper.setActive(slot0._playerpassiveGOList[slot11], false)
		end
	end

	gohelper.setActive(slot0._goplayerpassive, #slot5 > 0)

	slot0._passiveSkillIds = slot5
end

function slot0.getPassiveSkillList(slot0, slot1)
	slot2 = {}
	slot3 = nil

	if slot1:getTrialAttrCo() then
		slot3 = slot1.modelId

		for slot9, slot10 in ipairs(string.splitToNumber(slot4.passiveSkill, "|")) do
			table.insert(slot2, slot10)
		end
	else
		slot11 = slot1.exSkillLevel

		for slot11, slot12 in ipairs(SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(slot1:getCO().id, slot11)) do
			table.insert(slot2, slot12.skillPassive)
		end
	end

	if FightModel.instance:getFightParam() and slot5:getCurEpisodeConfig() and slot6.type == DungeonEnum.EpisodeType.BossRush and BossRushConfig.instance:getEpisodeCoByEpisodeId(slot6.id) and slot7.enhanceRole == 1 then
		slot2 = slot0:exchangeHeroPassiveSkill(slot2, slot3)
	end

	return slot2
end

function slot0.exchangeHeroPassiveSkill(slot0, slot1, slot2)
	if not slot1 then
		return slot1
	end

	if not slot2 then
		return slot1
	end

	for slot6, slot7 in ipairs(lua_activity128_enhance.configList) do
		if slot7.characterId == slot2 then
			if FightStrUtil.splitString2(slot7.exchangeSkills, true) then
				for slot12, slot13 in ipairs(slot1) do
					for slot17, slot18 in ipairs(slot8) do
						if slot18[1] == slot13 then
							slot1[slot12] = slot18[2]
						end
					end
				end
			end

			return slot1
		end
	end

	return slot1
end

function slot0._refreshSkill(slot0, slot1)
	slot2, slot3, slot4 = nil

	for slot8 = 1, #slot1 do
		if slot8 > #slot0._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		slot2 = slot0._skillGOs[slot8]

		if not lua_skill.configDict[slot1[slot8][1]] then
			logError("技能表找不到id:" .. slot3)

			return
		end

		slot2.icon:LoadImage(ResUrl.getSkillIcon(slot4.icon))
		slot2.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot4.showTag))

		slot2.info = {
			super = false,
			skillIdList = slot1[slot8],
			skillIndex = slot8
		}

		gohelper.setActive(slot2.go, true)
	end

	for slot8 = #slot1 + 1, #slot0._skillGOs do
		gohelper.setActive(slot0._skillGOs[slot8].go, false)
	end
end

function slot0._refreshSuper(slot0, slot1)
	if slot1 and #slot1 > 0 then
		slot2, slot3, slot4 = nil

		for slot8 = 1, #slot1 do
			if not slot0._superItemList[slot8] then
				logError("技能超过支持显示数量 : " .. table.concat(slot1, "|"))

				return
			end

			gohelper.setActive(slot2.go, true)

			slot3 = slot1[slot8]

			slot2.icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[slot3].icon))

			slot2.info = {
				super = true,
				skillIdList = {
					slot3
				},
				skillIndex = CharacterEnum.skillIndex.SkillEx
			}
		end
	end

	for slot5 = #slot1 + 1, #slot0._superItemList do
		gohelper.setActive(slot0._superItemList[slot5].go, false)
	end
end

function slot0._refreshMO(slot0, slot1)
	slot0:_refreshHp(slot1)
	slot0:_refreshBuff(slot1)

	if slot1:isMonster() then
		if FightHelper.isBossId(slot0:_getBossId(), slot1:getCO().id) then
			slot0:_refreshEnemyPassiveSkill(slot2)
		else
			gohelper.setActive(slot0._goenemypassiveSkill, false)
		end
	end
end

function slot0._refreshEnemyPassiveSkill(slot0, slot1)
	slot0._bossSkillInfos = {}
	slot6 = FightConfig.instance:getPassiveSkillsAfterUIFilter(slot1.id)

	for slot6 = 1, #FightConfig.instance:_filterSpeicalSkillIds(slot6, true) do
		if lua_skill_specialbuff.configDict[slot2[slot6]] then
			if not slot0._enemypassiveiconGOs[slot6] then
				slot9 = slot0:getUserDataTb_()
				slot9.go = gohelper.cloneInPlace(slot0._enemypassiveSkillPrefab, "item" .. slot6)
				slot9._gotag = gohelper.findChild(slot9.go, "tag")
				slot9._txttag = gohelper.findChildText(slot9.go, "tag/#txt_tag")

				table.insert(slot0._enemypassiveiconGOs, slot9)
				table.insert(slot0._passiveiconImgs, gohelper.findChildImage(slot9.go, "icon"))
				gohelper.setActive(slot9.go, true)
			else
				gohelper.setActive(slot9.go, true)
			end

			if slot0._bossSkillInfos[slot6] == nil then
				slot0._bossSkillInfos[slot6] = {
					skillId = slot7,
					icon = slot8.icon
				}
			end

			if not string.nilorempty(slot8.lv) then
				gohelper.setActive(slot9._gotag, true)

				slot9._txttag.text = slot8.lv
			else
				gohelper.setActive(slot9._gotag, false)
			end

			if string.nilorempty(slot8.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. slot8.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(slot0._passiveiconImgs[slot6], slot8.icon)
		end
	end

	if #slot2 < #slot0._enemypassiveiconGOs then
		for slot6 = #slot2 + 1, #slot0._enemypassiveiconGOs do
			gohelper.setActive(slot0._enemypassiveiconGOs[slot6].go, false)
		end
	end

	if #slot0._bossSkillInfos > 0 then
		gohelper.setActive(slot0._goenemypassiveSkill, true)
	else
		gohelper.setActive(slot0._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(slot0._btnenemypassiveSkill.gameObject)
	slot0._btnenemypassiveSkill:AddClickListener(slot0._onBuffPassiveSkillClick, slot0)
end

function slot0._onBuffPassiveSkillClick(slot0)
	if slot0._isbuffviewopen then
		return
	end

	slot0:closeAllTips()
	slot0:_hideDetail()

	slot1 = nil

	if slot0._bossSkillInfos then
		for slot5, slot6 in pairs(slot0._bossSkillInfos) do
			slot1 = slot6.skillId

			if not slot0._enemybuffpassiveGOs[slot5] then
				slot7 = slot0:getUserDataTb_()
				slot7.go = gohelper.cloneInPlace(slot0._gobuffpassiveitem, "item" .. slot5)

				table.insert(slot0._enemybuffpassiveGOs, slot7)
				table.insert(slot0._passiveSkillImgs, gohelper.findChildImage(slot7.go, "title/simage_icon"))
				gohelper.setActive(slot7.go, true)
			else
				gohelper.setActive(slot7.go, true)
			end

			gohelper.setActive(gohelper.findChild(slot7.go, "txt_desc/image_line"), true)
			slot0:_setPassiveSkillTip(slot7.go, slot6)
			UISpriteSetMgr.instance:setFightPassiveSprite(slot0._passiveSkillImgs[slot5], slot6.icon)
		end

		if #slot0._bossSkillInfos < #slot0._enemybuffpassiveGOs then
			for slot5 = #slot0._bossSkillInfos + 1, #slot0._enemybuffpassiveGOs do
				gohelper.setActive(slot0._enemybuffpassiveGOs[slot5], false)
			end
		end

		gohelper.setActive(gohelper.findChild(slot0._enemybuffpassiveGOs[#slot0._bossSkillInfos].go, "txt_desc/image_line"), false)
		gohelper.setActive(slot0._gobuffpassiveview, true)

		slot0._isbuffviewopen = true
	end
end

function slot0._setPassiveSkillTip(slot0, slot1, slot2)
	slot4 = gohelper.findChildText(slot1, "txt_desc")

	SkillHelper.addHyperLinkClick(slot4, slot0.onClickHyperLink, slot0)

	slot5 = lua_skill.configDict[slot2.skillId]
	gohelper.findChildText(slot1, "title/txt_name").text = slot5.name
	slot4.text = SkillHelper.getEntityDescBySkillCo(slot0._curSelectId, slot5, "#CC492F", "#485E92")
end

function slot0.onClickPassiveHyperLink(slot0, slot1, slot2)
	slot0.commonBuffTipAnchorPos = slot0.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, slot0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function slot0._refreshHp(slot0, slot1)
	slot2 = math.max(slot1.currentHp, 0)
	slot3 = slot1.attrMO and math.max(slot1.attrMO.hp, 0)
	slot0._txthp.text = string.format("%d/%d", slot2, slot3)

	slot0._sliderhp:SetValue(slot3 > 0 and slot2 / slot3 or 0)
end

function slot0._refreshBuff(slot0, slot1)
	slot2 = FightBuffHelper.filterBuffType(slot1:getBuffList(), FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot2)
	table.sort(slot2, function (slot0, slot1)
		if slot0.time ~= slot1.time then
			return slot0.time < slot1.time
		end

		return slot0.id < slot1.id
	end)

	slot4 = 0
	slot5 = 0

	for slot9 = 1, slot2 and #slot2 or 0 do
		if lua_skill_buff.configDict[slot2[slot9].buffId] and slot11.isNoShow == 0 then
			if not slot0._buffTables[slot4 + 1] then
				slot0._buffTables[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gobuffitem, "item" .. slot4), FightBuffItem)
			end

			slot12:updateBuffMO(slot10)
			slot12:setClickCallback(slot0._onClickBuff, slot0)
			gohelper.setActive(slot0._buffTables[slot4].go, slot4 <= 6)
		end
	end

	for slot9 = slot4 + 1, #slot0._buffTables do
		gohelper.setActive(slot0._buffTables[slot9].go, false)
	end

	gohelper.setActive(slot0._scrollbuff.gameObject, slot4 > 0)
	gohelper.setActive(slot0._btnBuffMore, slot4 > 6)
end

function slot0._onClickBuff(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = slot1 or slot0._entityMO.id,
		viewname = slot0.viewName
	})

	if slot0._hadPopUp then
		slot0:_hideDetail()

		slot0._hadPopUp = false
	end
end

function slot0._showPassiveDetail(slot0)
	slot0:closeAllTips()

	if slot0._passiveSkillIds and #slot0._passiveSkillIds > 0 then
		gohelper.setActive(slot0._godetailView, true)
		slot0:_refreshPassiveDetail()

		slot0._hadPopUp = true
	end
end

function slot0.refreshScrollEnemy(slot0)
	slot0:_releaseHeadItemList()

	slot0.enemyItemList = {}

	gohelper.setActive(slot0.goScrollEnemy, true)

	slot1 = nil

	for slot5, slot6 in ipairs(slot0._entityList) do
		slot1 = slot0.enemyItemList[slot5] or slot0:createEnemyItem()

		gohelper.setActive(slot1.go, true)

		slot1.entityMo = slot6
		slot7 = slot6:getCO()

		gohelper.getSingleImage(slot1.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(slot6:getSpineSkinCO().headIcon))
		UISpriteSetMgr.instance:setEnemyInfoSprite(slot1.imageCareer, "sxy_" .. tostring(slot7.career))

		if slot7.heartVariantId and slot7.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(slot7.heartVariantId), slot1.imageIcon)
		end

		gohelper.setActive(slot1.goBossTag, slot0.bossIdDict[slot7.id])

		if slot6.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(slot1.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(slot1.imageIcon.transform, 0, 0, 0)
		end
	end

	for slot5 = #slot0._entityList + 1, #slot0.enemyItemList do
		gohelper.setActive(slot0.enemyItemList[slot5].go, false)
	end
end

function slot0.refreshScrollEnemySelectStatus(slot0)
	if slot0.enemyItemList then
		for slot4, slot5 in ipairs(slot0.enemyItemList) do
			slot6 = slot0._entityMO.uid == slot5.entityMo.uid

			gohelper.setActive(slot5.goSelectFrame, slot6)
			SLFramework.UGUI.GuiHelper.SetColor(slot5.imageIcon, slot0._entityMO.uid == slot5.entityMo.uid and "#ffffff" or "#8C8C8C")
			SLFramework.UGUI.GuiHelper.SetColor(slot5.imageCareer, slot0._entityMO.uid == slot5.entityMo.uid and "#ffffff" or "#828282")

			if slot6 then
				slot9 = -106 - 193 * (slot4 - 1) + recthelper.getAnchorY(slot0.goScrollEnemyContent.transform) + slot0._entityScrollHeight / 2
				slot10 = recthelper.getHeight(slot5.go.transform)
				slot12 = slot9 + slot10

				if slot9 - slot10 < -(slot0._entityScrollHeight / 2) then
					recthelper.setAnchorY(slot0.goScrollEnemyContent.transform, recthelper.getAnchorY(slot0.goScrollEnemyContent.transform) - (slot11 + slot13) - 54)
				end

				if slot13 < slot12 then
					recthelper.setAnchorY(slot0.goScrollEnemyContent.transform, recthelper.getAnchorY(slot0.goScrollEnemyContent.transform) - (slot12 - slot13) + 54)
				end
			end

			gohelper.setActive(slot5.subTag, FightDataHelper.entityMgr:isSub(slot5.entityMo.uid))
		end
	end
end

function slot0.createEnemyItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0.contentEnemyItem)
	slot1.imageIcon = gohelper.findChildImage(slot1.go, "item/icon")
	slot1.goBossTag = gohelper.findChild(slot1.go, "item/bosstag")
	slot1.imageCareer = gohelper.findChildImage(slot1.go, "item/career")
	slot1.goSelectFrame = gohelper.findChild(slot1.go, "item/go_selectframe")
	slot1.subTag = gohelper.findChild(slot1.go, "item/#go_SubTag")
	slot1.btnClick = gohelper.findChildButtonWithAudio(slot1.go, "item/btn_click")

	slot1.btnClick:AddClickListener(slot0.onClickEnemyItem, slot0, slot1)
	table.insert(slot0.enemyItemList, slot1)

	return slot1
end

function slot0.onClickEnemyItem(slot0, slot1)
	if slot1.entityMo.uid == slot0._entityMO.uid then
		return
	end

	slot0._curSelectId = slot1.entityMo.id

	slot0:closeAllTips()
	slot0:_refreshUI()
	slot0._ani:Play("switch", nil, )
end

function slot0.closeAllTips(slot0)
	slot0.viewContainer:hideSkillTipView()
	gohelper.setActive(slot0._godetailView, false)
	gohelper.setActive(slot0._gobuffpassiveview, false)

	slot0._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	slot0.openEquipInfoTipView = false
	slot0.openFightAttributeTipView = false
end

function slot0._showSkillDetail(slot0, slot1)
	slot0:closeAllTips()
	slot0.viewContainer:showSkillTipView(slot1, slot0.isCharacter, slot0._curSelectId)

	slot0._hadPopUp = true
end

function slot0._hideDetail(slot0)
	slot0.viewContainer:hideSkillTipView()
	gohelper.setActive(slot0._godetailView, false)
	gohelper.setActive(slot0._gobuffpassiveview, false)

	slot0._isbuffviewopen = false
end

function slot0._refreshPassiveDetail(slot0)
	slot6 = slot0._passiveSkillIds
	slot1 = slot0:_checkDestinyEffect(slot6)

	for slot6 = 1, #slot1 do
		if lua_skill.configDict[tonumber(slot1[slot6])] then
			if not slot0._detailPassiveTables[slot6] then
				slot10 = gohelper.cloneInPlace(slot0._godetailpassiveitem, "item" .. slot6)
				slot9 = slot0:getUserDataTb_()
				slot9.go = slot10
				slot9.name = gohelper.findChildText(slot10, "title/txt_name")
				slot9.icon = gohelper.findChildSingleImage(slot10, "title/simage_icon")
				slot9.desc = gohelper.findChildText(slot10, "txt_desc")

				SkillHelper.addHyperLinkClick(slot9.desc, slot0.onClickHyperLink, slot0)

				slot9.line = gohelper.findChild(slot10, "txt_desc/image_line")

				table.insert(slot0._detailPassiveTables, slot9)
			end

			slot9.name.text = slot8.name
			slot9.desc.text = SkillHelper.getEntityDescBySkillCo(slot0._curSelectId, slot8, "#CC492F", "#485E92")

			slot9.desc:GetPreferredValues()
			gohelper.setActive(slot9.go, true)
			gohelper.setActive(slot9.line, slot6 < slot2)
		else
			logError(string.format("被动技能配置没找到, id: %d", slot7))
		end
	end

	for slot6 = slot2 + 1, #slot0._detailPassiveTables do
		gohelper.setActive(slot0._detailPassiveTables[slot6].go, false)
	end
end

function slot0._checkDestinyEffect(slot0, slot1)
	if slot1 and slot0._entityMO and HeroModel.instance:getByHeroId(slot0._entityMO:getCO().id) and slot3.destinyStoneMo then
		slot1 = slot3.destinyStoneMo:_replaceSkill(slot1)
	end

	return slot1
end

function slot0.onClickHyperLink(slot0, slot1, slot2)
	slot0.commonBuffTipAnchorPos = slot0.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, slot0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function slot0._detectBossMultiHp(slot0, slot1)
	slot2 = BossRushModel.instance:getBossEntityMO()
	slot0._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and slot2 and slot2.id == slot1.id
	slot3 = slot1.attrMO.multiHpNum

	if slot0._isBossRush then
		slot3 = BossRushModel.instance:getMultiHpInfo().multiHpNum
	end

	gohelper.setActive(slot0._multiHpRoot, slot3 > 1)

	if slot3 > 1 then
		slot0:com_createObjList(slot0._onMultiHpItemShow, slot3, slot0._multiHpRoot, slot0._multiHpItem)
	end
end

function slot0._onMultiHpItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot0._entityMO.attrMO.multiHpNum
	slot5 = slot0._entityMO.attrMO:getCurMultiHpIndex()

	if slot0._isBossRush then
		slot6 = BossRushModel.instance:getMultiHpInfo()
		slot4 = slot6.multiHpNum
		slot5 = slot6.multiHpIdx
	end

	gohelper.setActive(gohelper.findChild(slot1, "hp"), slot3 <= slot4 - slot5)

	if slot3 == 1 and slot0._isBossRush then
		gohelper.setActive(slot6, true)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.EquipInfoTipsView then
		slot0.openEquipInfoTipView = false
	end

	if slot1 == ViewName.FightAttributeTipView then
		slot0.openFightAttributeTipView = false
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
	slot0:_releaseTween()

	if slot0._focusFlow then
		slot0._focusFlow:stop()

		slot0._focusFlow = nil
	end

	if slot0.subEntityList then
		for slot4, slot5 in ipairs(slot0.subEntityList) do
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(slot5:getTag(), slot5.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
end

function slot0.onDestroyView(slot0)
	slot4 = 1

	FightWorkFocusMonster.setVirtualCameDamping(1, slot4, 1)
	slot0._simagebg:UnLoadImage()

	for slot4 = 1, #slot0._skillGOs do
		slot5 = slot0._skillGOs[slot4]

		slot5.icon:UnLoadImage()
		slot5.btn:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._superItemList) do
		slot5.icon:UnLoadImage()
		slot5.btn:RemoveClickListener()
	end

	slot0._superItemList = nil

	slot0._simageequipicon:UnLoadImage()

	if slot0.equipClick then
		slot0.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:_releaseHeadItemList()
	slot0.resistanceComp:destroy()

	slot0.resistanceComp = nil

	slot0.stressComp:destroy()

	slot0.stressComp = nil

	slot0:__onDispose()
end

function slot0._releaseHeadItemList(slot0)
	if slot0.enemyItemList then
		for slot4, slot5 in ipairs(slot0.enemyItemList) do
			slot5.btnClick:RemoveClickListener()
			gohelper.destroy(slot5.go)
		end

		slot0.enemyItemList = nil
	end
end

function slot0._setVirtualCameDamping(slot0)
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function slot0._setEntityPosAndActive(slot0, slot1)
	slot3 = false

	if FightHelper.getEntity(slot1.id) and slot4:getMO() and FightConfig.instance:getSkinCO(slot5.skin) and slot6.canHide == 1 then
		slot3 = true
	end

	for slot9, slot10 in ipairs(FightHelper.getAllEntitys()) do
		if not FightHelper.isAssembledMonster(slot10) then
			slot10:setVisibleByPos(slot3 or slot2 == slot10.id)
		elseif slot1.side ~= slot10:getSide() then
			slot10:setVisibleByPos(slot3 or slot2 == slot10.id)
		else
			slot10:setVisibleByPos(true)
		end

		if slot10.buff then
			if slot2 ~= slot10.id then
				slot10.buff:hideBuffEffects()
			else
				slot10.buff:showBuffEffects()
			end
		end

		if slot10.nameUI then
			slot10.nameUI:setActive(slot2 == slot10.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	slot7 = nil

	if slot1.side == FightEnum.EntitySide.MySide then
		slot7 = lua_stance.configDict[FightHelper.getEntityStanceId(slot1, FightModel.instance:getCurWaveId())].pos1

		for slot15, slot16 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)) do
			if slot16.id == slot1.id then
				transformhelper.setLocalPos(slot16.go.transform, slot11[1], slot11[2], slot11[3])

				if slot16.buff then
					slot16.buff:hideBuffEffects()
					slot16.buff:showBuffEffects()
				end
			else
				slot16:setVisibleByPos(false)
			end
		end

		for slot15, slot16 in ipairs(slot0.subEntityList) do
			transformhelper.setLocalPos(slot16.go.transform, 20000, 20000, 20000)
		end
	end

	slot8 = FightHelper.getEntity(slot2)

	if FightDataHelper.entityMgr:isSub(slot2) then
		slot8 = nil

		for slot13, slot14 in ipairs(slot0.subEntityList) do
			if slot14.id == slot2 .. "focusSub" then
				if FightHelper.getEntity(slot2) then
					slot15:setVisibleByPos(false)
				end

				slot8 = slot14

				transformhelper.setLocalPos(slot14.go.transform, slot7[1], slot7[2], slot7[3])
			end
		end
	end

	if slot8 then
		slot11, slot12, slot13 = transformhelper.getPos(slot8:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle).transform)
		slot14 = nil

		if #((not slot9 or FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(slot2).skin)) and FightConfig.instance:getSkinCO(slot8:getMO().skin)).focusOffset == 3 then
			slot11 = slot11 + 2.7 + slot15[1]
			slot12 = slot12 - 2 + slot15[2]
			slot13 = slot13 + 5.4 + slot15[3]
		end

		slot0:_releaseTween()
		transformhelper.setPos(CameraMgr.instance:getVirtualCameraTrs(), slot11 + 0.2, slot12, slot13)
	end
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end
end

function slot0._playCameraTween(slot0)
	slot1 = CameraMgr.instance:getVirtualCameraTrs()
	slot2, slot3, slot4 = transformhelper.getPos(slot1)
	slot0._tweenId = ZProj.TweenHelper.DOMove(slot1, slot2 - 0.6, slot3, slot4, 0.5)
end

function slot0._focusEntity(slot0, slot1)
	if slot0._focusFlow then
		slot0._focusFlow:stop()

		slot0._focusFlow = nil
	end

	slot0._focusFlow = FlowSequence.New()

	slot0._focusFlow:addWork(FunctionWork.New(slot0._setVirtualCameDamping, slot0))
	slot0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	slot0._focusFlow:addWork(FightWorkFocusSubEntity.New(slot1))
	slot0._focusFlow:addWork(FunctionWork.New(slot0._setEntityPosAndActive, slot0, slot1))
	slot0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	slot0._focusFlow:addWork(FunctionWork.New(slot0._playCameraTween, slot0))
	slot0._focusFlow:addWork(WorkWaitSeconds.New(0.5))
	slot0._focusFlow:start({
		subEntityList = slot0.subEntityList
	})
end

function slot0._onBtnBuffMore(slot0)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = slot0._curSelectId,
		viewname = slot0.viewName
	})
end

return slot0
