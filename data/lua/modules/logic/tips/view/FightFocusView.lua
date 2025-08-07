module("modules.logic.tips.view.FightFocusView", package.seeall)

local var_0_0 = class("FightFocusView", FightBaseView)

function var_0_0._onAttributeClick_overseas(arg_1_0)
	if arg_1_0.openFightAttributeTipView then
		return
	end

	arg_1_0:closeAllTips()

	if arg_1_0._entityMO:isCharacter() then
		local var_1_0 = arg_1_0._entityMO:getCO()
		local var_1_1 = arg_1_0:_getHeroBaseAttr(var_1_0)

		ViewMgr.instance:openView(ViewName.FightAttributeTipView, {
			entityMO = arg_1_0._entityMO,
			mo = arg_1_0._entityMO.attrMO,
			data = var_1_1,
			isCharacter = arg_1_0.isCharacter
		})

		arg_1_0.openFightAttributeTipView = true
	else
		local var_1_2 = arg_1_0._entityMO:getCO()
		local var_1_3 = arg_1_0:_getMontBaseAttr(var_1_2)

		ViewMgr.instance:openView(ViewName.FightAttributeTipView, {
			entityMO = arg_1_0._entityMO,
			mo = arg_1_0._entityMO.attrMO,
			data = var_1_3,
			isCharacter = arg_1_0.isCharacter
		})

		arg_1_0.openFightAttributeTipView = true
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnclose = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "fightinfocontainer/#btn_close")
	arg_2_0._btnDetailClose = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_detailView/#btn_detailClose")
	arg_2_0._goinfoView = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView")
	arg_2_0._goinfoViewContent = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content")
	arg_2_0._imagecareer = gohelper.findChildImage(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#image_career")
	arg_2_0.levelRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg")
	arg_2_0._txtlevel = gohelper.findChildText(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#txt_name")
	arg_2_0._gostress = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_fightstressitem")
	arg_2_0._imagedmgtype = gohelper.findChildImage(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level/#image_dmgtype")
	arg_2_0._goplayerpassive = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive")
	arg_2_0._scrollenemypassive = gohelper.findChildScrollRect(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive")
	arg_2_0._goenemyemptyskill = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/emptyskill")
	arg_2_0._goenemypassive = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive")
	arg_2_0._goenemypassiveitem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	arg_2_0._goenemypassiveSkill = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill")
	arg_2_0._enemypassiveSkillPrefab = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/item")
	arg_2_0._btnenemypassiveSkill = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/btn_passiveclick")
	arg_2_0._goresistance = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#go_resistance")
	arg_2_0._txthp = gohelper.findChildText(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#txt_hp")
	arg_2_0._sliderhp = gohelper.findChildSlider(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#slider_hp")
	arg_2_0._goattributeroot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_attribute_root")
	arg_2_0._btnattribute = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_attribute_root/#btn_attribute")
	arg_2_0._scrollbuff = gohelper.findChildScrollRect(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff")
	arg_2_0._gobuffitem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff/Viewport/Content/buffitem")
	arg_2_0._godetailView = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_detailView")
	arg_2_0._goplayer = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player")
	arg_2_0._goenemy = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy")
	arg_2_0._scrollplotenemypassive = gohelper.findChildScrollRect(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive")
	arg_2_0._goplotenemypassive = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive")
	arg_2_0._goplotenemypassiveitem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	arg_2_0._godetailpassiveitem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem")
	arg_2_0._btnplayerpassive = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/#btn_playerpassive")
	arg_2_0._scrollcontent = gohelper.findChildScrollRect(arg_2_0.viewGO, "fightinfocontainer/#go_detailView/bg/#scroll_content")
	arg_2_0._gobuffpassiveview = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_buffpassiveview")
	arg_2_0._gobuffpassiveitem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	arg_2_0._gotargetframe = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_targetframe")
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_Bg")
	arg_2_0._containerGO = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer")
	arg_2_0._noskill = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/noskill")
	arg_2_0._skill = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/skill")
	arg_2_0._goplayerequipinfo = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo")
	arg_2_0._goequip = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip")
	arg_2_0._txtequiplv = gohelper.findChildText(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#txt_equiplv")
	arg_2_0._equipIconImage = gohelper.findChildImage(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	arg_2_0._simageequipicon = gohelper.findChildSingleImage(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	arg_2_0._goequipEmpty = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equipEmpty")
	arg_2_0._btnclosebuffpassive = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_buffpassiveview/#btn_detailClose")

	gohelper.setActive(arg_2_0._enemypassiveSkillPrefab, false)

	arg_2_0._enemypassiveiconGOs = arg_2_0:getUserDataTb_()
	arg_2_0._enemybuffpassiveGOs = arg_2_0:getUserDataTb_()
	arg_2_0._passiveSkillImgs = arg_2_0:getUserDataTb_()
	arg_2_0._passiveiconImgs = arg_2_0:getUserDataTb_()
	arg_2_0._bossSkillInfos = {}
	arg_2_0._isbuffviewopen = false
	arg_2_0._canClickAttribute = false
	arg_2_0._multiHpRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG")
	arg_2_0._multiHpItem = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG/image_HpItem")
	arg_2_0._btnSwitchEnemy = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy")
	arg_2_0._btnSwitchMember = gohelper.findChildButton(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_member")
	arg_2_0._switchEnemyNormal = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/normal")
	arg_2_0._switchEnemySelect = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/select")
	arg_2_0._switchMemberNormal = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_member/normal")
	arg_2_0._switchMemberSelect = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_switch/#btn_member/select")
	arg_2_0._btnBuffObj = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#btn_more")
	arg_2_0._btnBuffMore = gohelper.getClickWithDefaultAudio(arg_2_0._btnBuffObj)
	arg_2_0._goAssistBoss = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_assistBoss")
	arg_2_0._ani = SLFramework.AnimatorPlayer.Get(arg_2_0.viewGO)
	arg_2_0.go_fetter = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/go_fetter")
	arg_2_0.go_quality = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/go_quality")
	arg_2_0.go_collection = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_collection")
	arg_2_0.odysseySuitRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_odysseySuit")
	arg_2_0.aiJiAoSliderRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_azio")
	arg_2_0.alertRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_alert")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnclose:AddClickListener(arg_3_0._btncloseOnClick, arg_3_0)
	arg_3_0._btnDetailClose:AddClickListener(arg_3_0._hideDetail, arg_3_0)
	arg_3_0._btnplayerpassive:AddClickListener(arg_3_0._btnplayerpassiveOnClick, arg_3_0)
	arg_3_0._btnclosebuffpassive:AddClickListener(arg_3_0._onCloseBuffPassive, arg_3_0)
	arg_3_0._btnattribute:AddClickListener(arg_3_0._onAttributeClick, arg_3_0)
	arg_3_0._btnSwitchEnemy:AddClickListener(arg_3_0._onSwitchEnemy, arg_3_0)
	arg_3_0._btnSwitchMember:AddClickListener(arg_3_0._onSwitchMember, arg_3_0)
	arg_3_0._btnBuffMore:AddClickListener(arg_3_0._onBtnBuffMore, arg_3_0)
	arg_3_0:com_registFightEvent(FightEvent.onReceiveEntityInfoReply, arg_3_0._onReceiveEntityInfoReply)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclose:RemoveClickListener()
	arg_4_0._btnDetailClose:RemoveClickListener()
	arg_4_0._btnplayerpassive:RemoveClickListener()
	arg_4_0._btnenemypassiveSkill:RemoveClickListener()
	arg_4_0._btnclosebuffpassive:RemoveClickListener()
	arg_4_0._btnattribute:RemoveClickListener()
	arg_4_0._btnSwitchEnemy:RemoveClickListener()
	arg_4_0._btnSwitchMember:RemoveClickListener()
	arg_4_0._btnBuffMore:RemoveClickListener()
	arg_4_0:_releasePassiveSkillGOs()
end

function var_0_0._releasePassiveSkillGOs(arg_5_0)
	if #arg_5_0._passiveSkillGOs then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._passiveSkillGOs) do
			iter_5_1.btn:RemoveClickListener()
			gohelper.destroy(iter_5_1.go)
		end
	end

	arg_5_0._passiveSkillGOs = {}
end

function var_0_0._onSwitchEnemy(arg_6_0)
	arg_6_0:_onClickSwitchBtn(FightEnum.EntitySide.EnemySide)
end

function var_0_0._onSwitchMember(arg_7_0)
	arg_7_0:_onClickSwitchBtn(FightEnum.EntitySide.MySide)
end

function var_0_0._onClickSwitchBtn(arg_8_0, arg_8_1)
	arg_8_0:closeAllTips()

	arg_8_0._curSelectSide = arg_8_1

	arg_8_0:_refreshEntityList()

	arg_8_0._curSelectId = arg_8_0._entityList[1].id

	arg_8_0:_refreshUI()
	arg_8_0._ani:Play("switch", nil, nil)
end

function var_0_0._btncloseOnClick(arg_9_0)
	if arg_9_0.openEquipInfoTipView then
		ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

		arg_9_0.openEquipInfoTipView = false

		return
	end

	if arg_9_0.openFightAttributeTipView then
		ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

		arg_9_0.openFightAttributeTipView = false

		return
	end

	if arg_9_0._hadPopUp then
		arg_9_0:_hideDetail()

		arg_9_0._hadPopUp = false
	else
		arg_9_0:closeThis()
	end
end

function var_0_0._onCloseBuffPassive(arg_10_0)
	gohelper.setActive(arg_10_0._gobuffpassiveview, false)

	arg_10_0._isbuffviewopen = false
end

function var_0_0._btnplayerpassiveOnClick(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_11_0:_showPassiveDetail()
end

function var_0_0._btnenemypassiveOnClick(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_12_0:_showPassiveDetail()
end

function var_0_0.initScrollEnemyNode(arg_13_0)
	arg_13_0.enemyItemList = {}
	arg_13_0.goScrollEnemy = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#scroll_enemy")
	arg_13_0._entityScrollHeight = recthelper.getHeight(arg_13_0.goScrollEnemy.transform)
	arg_13_0.goScrollEnemyContent = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent")
	arg_13_0.contentSizeFitter = arg_13_0.goScrollEnemyContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	arg_13_0.contentEnemyItem = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent/enemyitem")

	gohelper.setActive(arg_13_0.contentEnemyItem, false)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._equipIconImage.enabled = false

	gohelper.setActive(arg_14_0._godetailView, false)
	arg_14_0:initScrollEnemyNode()
	arg_14_0._simagebg:LoadImage(ResUrl.getFightImage("fightfocus/full/bg_bossjieshao_mengban.png"))
	gohelper.setActive(arg_14_0._goenemypassiveitem, false)
	gohelper.setActive(arg_14_0._goexitem, false)
	gohelper.setActive(arg_14_0._gobuffitem, false)
	gohelper.setActive(arg_14_0._godetailpassiveitem, false)

	arg_14_0._passiveSkillGOs = {}
	arg_14_0._exItemTables = {}
	arg_14_0._buffTables = {}
	arg_14_0._detailPassiveTables = {}
	arg_14_0._playerpassiveGOList = arg_14_0:getUserDataTb_()

	for iter_14_0 = 1, 3 do
		local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel" .. iter_14_0)

		table.insert(arg_14_0._playerpassiveGOList, var_14_0)
	end

	local var_14_1 = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel4")

	arg_14_0._playerpassiveGOList[0] = var_14_1
	arg_14_0._txttalent = gohelper.findChildTextMesh(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/talent/tmp_talent")
	arg_14_0._txttalent.overflowMode = TMPro.TextOverflowModes.Ellipsis
	arg_14_0._gosuperitem = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_superitem")
	arg_14_0._goskillitem = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_skillitem")

	gohelper.setActive(arg_14_0._gosuperitem, false)
	gohelper.setActive(arg_14_0._goskillitem, false)

	arg_14_0._superItemList = {}

	local var_14_2

	for iter_14_1 = 1, 3 do
		local var_14_3 = arg_14_0:createSuperItem()

		table.insert(arg_14_0._superItemList, var_14_3)
	end

	arg_14_0._skillGOs = {}

	local var_14_4

	for iter_14_2 = 1, 3 do
		local var_14_5 = arg_14_0:createSkillItem()

		table.insert(arg_14_0._skillGOs, var_14_5)
	end

	arg_14_0._godetailcontent = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content")
	arg_14_0._gobg = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_detailView/bg")
	arg_14_0._onCloseNeedResetCamera = true
	arg_14_0._hadPopUp = false
	arg_14_0.openEquipInfoTipView = false
	arg_14_0.openFightAttributeTipView = false

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_14_0._onCloseView, arg_14_0)

	local var_14_6 = DungeonModel.instance.curSendChapterId

	if var_14_6 then
		local var_14_7 = DungeonConfig.instance:getChapterCO(var_14_6)

		arg_14_0.isSimple = var_14_7 and var_14_7.type == DungeonEnum.ChapterType.Simple
	end

	arg_14_0.resistanceComp = FightEntityResistanceComp.New(arg_14_0._goresistance, arg_14_0.viewContainer)

	arg_14_0.resistanceComp:onInitView()
end

function var_0_0.createSuperItem(arg_15_0)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = gohelper.cloneInPlace(arg_15_0._gosuperitem)
	var_15_0.icon = gohelper.findChildSingleImage(var_15_0.go, "lv/imgIcon")
	var_15_0.btn = gohelper.findChildButtonWithAudio(var_15_0.go, "btn_click")

	var_15_0.btn:AddClickListener(function(arg_16_0)
		arg_15_0:_showSkillDetail(arg_16_0.info)
	end, var_15_0)
	gohelper.setActive(var_15_0.go, false)

	return var_15_0
end

function var_0_0.createSkillItem(arg_17_0)
	local var_17_0 = arg_17_0:getUserDataTb_()

	var_17_0.go = gohelper.cloneInPlace(arg_17_0._goskillitem)
	var_17_0.icon = gohelper.findChildSingleImage(var_17_0.go, "lv/imgIcon")
	var_17_0.tag = gohelper.findChildSingleImage(var_17_0.go, "tag/pos/tag/tagIcon")
	var_17_0.btn = gohelper.findChildButtonWithAudio(var_17_0.go, "btn_click")

	var_17_0.btn:AddClickListener(function(arg_18_0)
		arg_17_0:_showSkillDetail(arg_18_0.info)
	end, var_17_0)
	gohelper.setActive(var_17_0.go, false)

	return var_17_0
end

function var_0_0._getEntityList(arg_19_0)
	local var_19_0 = FightDataHelper.entityMgr:getNormalList(arg_19_0._curSelectSide)
	local var_19_1 = FightDataHelper.entityMgr:getSpList(arg_19_0._curSelectSide)

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		table.insert(var_19_0, iter_19_1)
	end

	if FightModel.instance:isSeason2() and arg_19_0._curSelectSide == FightEnum.EntitySide.MySide then
		local var_19_2 = FightDataHelper.entityMgr:getSubList(arg_19_0._curSelectSide)

		for iter_19_2, iter_19_3 in ipairs(var_19_2) do
			table.insert(var_19_0, iter_19_3)
		end
	end

	for iter_19_4 = #var_19_0, 1, -1 do
		local var_19_3 = FightHelper.getEntity(var_19_0[iter_19_4].id)

		if var_19_3 and var_19_3.spine and var_19_3.spine.detectDisplayInScreen and not var_19_3.spine:detectDisplayInScreen() then
			table.remove(var_19_0, iter_19_4)
		end
	end

	arg_19_0:sortFightEntityList(var_19_0)

	local var_19_4 = FightDataHelper.entityMgr:getAssistBoss()

	if var_19_4 and arg_19_0._curSelectSide == FightEnum.EntitySide.MySide then
		table.insert(var_19_0, var_19_4)
	end

	return var_19_0
end

function var_0_0.sortFightEntityList(arg_20_0, arg_20_1)
	arg_20_0.bossIdDict = {}

	local var_20_0 = FightModel.instance:getFightParam()

	if not var_20_0.monsterGroupIds then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(var_20_0.monsterGroupIds) do
		local var_20_1 = lua_monster_group.configDict[iter_20_1].bossId

		if not string.nilorempty(var_20_1) then
			local var_20_2 = string.splitToNumber(var_20_1, "#")

			for iter_20_2, iter_20_3 in ipairs(var_20_2) do
				arg_20_0.bossIdDict[iter_20_3] = true
			end
		end
	end

	table.sort(arg_20_1, function(arg_21_0, arg_21_1)
		if arg_20_0.bossIdDict[arg_21_0.modelId] and not arg_20_0.bossIdDict[arg_21_1.modelId] then
			return true
		elseif not arg_20_0.bossIdDict[arg_21_0.modelId] and arg_20_0.bossIdDict[arg_21_1.modelId] then
			return false
		elseif arg_20_0.bossIdDict[arg_21_0.modelId] and arg_20_0.bossIdDict[arg_21_1.modelId] then
			return arg_21_0.modelId < arg_21_1.modelId
		else
			local var_21_0 = FightDataHelper.entityMgr:isSub(arg_21_0.id)
			local var_21_1 = FightDataHelper.entityMgr:isSub(arg_21_1.id)

			if var_21_0 and not var_21_1 then
				return false
			elseif not var_21_0 and var_21_1 then
				return true
			elseif not var_21_0 and not var_21_1 then
				return arg_21_0.modelId < arg_21_1.modelId
			else
				return arg_21_0.position > arg_21_1.position
			end
		end
	end)
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0.subEntityList = {}
	arg_22_0._attrEntityDic = {}
	arg_22_0._group = arg_22_0.viewParam and arg_22_0.viewParam.group or HeroGroupModel.instance:getCurGroupMO()

	if FightModel.instance:isSeason2() then
		arg_22_0._group = Season166HeroGroupModel.instance:getCurGroupMO()
	end

	arg_22_0._setEquipInfo = arg_22_0.viewParam and arg_22_0.viewParam.setEquipInfo
	arg_22_0._balanceHelper = arg_22_0.viewParam and arg_22_0.viewParam.balanceHelper or HeroGroupBalanceHelper

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, false)
	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	local var_22_0 = arg_22_0.viewParam and arg_22_0.viewParam.entityId and FightHelper.getEntity(arg_22_0.viewParam.entityId)

	if var_22_0 then
		arg_22_0._curSelectSide = var_22_0:getSide()
	else
		arg_22_0._curSelectSide = FightEnum.EntitySide.EnemySide
	end

	arg_22_0:_refreshEntityList()

	arg_22_0._curSelectId = var_22_0 and var_22_0.id or arg_22_0._entityList[1].id

	TaskDispatcher.runDelay(arg_22_0._refreshUI, arg_22_0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_roledetails)
	NavigateMgr.instance:addEscape(arg_22_0.viewContainer.viewName, arg_22_0._btncloseOnClick, arg_22_0)
end

function var_0_0._refreshEntityList(arg_23_0)
	arg_23_0._entityList = arg_23_0:_getEntityList()

	gohelper.setActive(arg_23_0._switchEnemyNormal, arg_23_0._curSelectSide == FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_23_0._switchEnemySelect, arg_23_0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_23_0._switchMemberNormal, arg_23_0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_23_0._switchMemberSelect, arg_23_0._curSelectSide == FightEnum.EntitySide.MySide)
	arg_23_0:refreshScrollEnemy()
end

function var_0_0._refreshUI(arg_24_0)
	local var_24_0 = FightDataHelper.entityMgr:getById(arg_24_0._curSelectId)

	if arg_24_0._entityMO ~= var_24_0 then
		arg_24_0:_focusEntity(var_24_0)
	end

	arg_24_0._entityMO = var_24_0

	local var_24_1 = var_24_0:isAssistBoss()

	if not var_24_1 then
		gohelper.setActive(arg_24_0._gotargetframe, true)
		gohelper.setActive(arg_24_0._goattributeroot, true)
		gohelper.setActive(arg_24_0._goinfoView, true)

		if var_24_0:isCharacter() then
			arg_24_0.isCharacter = true

			arg_24_0:_refreshCharacterInfo(var_24_0)
		else
			if var_24_0.side == FightEnum.EntitySide.MySide then
				arg_24_0.isCharacter = true
			else
				arg_24_0.isCharacter = false
			end

			arg_24_0:_refreshInfo(var_24_0:getCO())
		end

		gohelper.setActive(arg_24_0._goplayer, arg_24_0.isCharacter)
		gohelper.setActive(arg_24_0._goenemy, not arg_24_0.isCharacter)
		arg_24_0:_refreshMO(var_24_0)
		arg_24_0:_hideDetail()
		arg_24_0:_detectBossMultiHp(var_24_0)
	else
		gohelper.setActive(arg_24_0._gotargetframe, false)
		gohelper.setActive(arg_24_0._goattributeroot, false)
		gohelper.setActive(arg_24_0._goinfoView, false)
	end

	arg_24_0:setAssistBossStatus(var_24_1)
	arg_24_0:refreshScrollEnemySelectStatus()
	arg_24_0:refreshDouQuQuFetter()
	arg_24_0:refreshDouQuQuStar()
	arg_24_0:refreshDouQuQuCollection()
	arg_24_0:showOdysseyEquip()
	arg_24_0:showOdysseyEquipSuit()
	arg_24_0:showAiJiAoExPointSlider()
	arg_24_0:showAlert()
end

function var_0_0.setAssistBossStatus(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 then
		if not arg_25_0._assistBossView then
			arg_25_0._assistBossView = FightFocusTowerView.New(arg_25_0._goAssistBoss)
		end

		arg_25_0._assistBossView.bossId = arg_25_0._entityMO.modelId

		arg_25_0._assistBossView:show(arg_25_2)
	elseif arg_25_0._assistBossView then
		arg_25_0._assistBossView:hide(arg_25_2)
	end
end

function var_0_0._refreshInfo(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.isSimple and "levelEasy" or "level"

	gohelper.setActive(arg_26_0._btnattribute.gameObject, false)
	UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagecareer, "lssx_" .. tostring(arg_26_1.career))

	arg_26_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_26_1[var_26_0])

	local var_26_1 = FightConfig.instance:getNewMonsterConfig(arg_26_1)

	arg_26_0._txtname.text = var_26_1 and arg_26_1.highPriorityName or arg_26_1.name

	if isDebugBuild then
		logNormal(string.format("monster id=%d template=%d skillTemplate=%d", arg_26_1.id, arg_26_1.template, arg_26_1.skillTemplate))
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagedmgtype, "dmgtype" .. tostring(arg_26_1.dmgType))

	local var_26_2

	if arg_26_0.isCharacter then
		var_26_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_26_1.id)

		if next(var_26_2) then
			arg_26_0:_refreshPassiveSkill(var_26_2, arg_26_0._goplotenemypassiveitem)
		end

		gohelper.setActive(arg_26_0._scrollplotenemypassive.gameObject, true)
		gohelper.setActive(arg_26_0._goplayerpassive, false)
	else
		local var_26_3 = arg_26_0:_getBossId()

		if FightHelper.isBossId(var_26_3, arg_26_1.id) then
			var_26_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_26_1.id)
			var_26_2 = FightConfig.instance:_filterSpeicalSkillIds(var_26_2, false)
		else
			var_26_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_26_1.id)
		end

		arg_26_0:_refreshPassiveSkill(var_26_2, arg_26_0._goenemypassiveitem)
		gohelper.setActive(arg_26_0._goplayerpassive, false)
	end

	local var_26_4 = {}
	local var_26_5 = string.nilorempty(arg_26_1.activeSkill)
	local var_26_6 = #arg_26_1.uniqueSkill < 1
	local var_26_7 = var_26_5 and var_26_6

	if not var_26_5 then
		var_26_4 = string.split(arg_26_1.activeSkill, "|")
	end

	gohelper.setActive(arg_26_0._noskill, var_26_7)
	gohelper.setActive(arg_26_0._skill, not var_26_7)

	local var_26_8 = {}
	local var_26_9
	local var_26_10

	for iter_26_0, iter_26_1 in pairs(var_26_4) do
		local var_26_11 = string.splitToNumber(iter_26_1, "#")
		local var_26_12 = var_26_11[1]

		var_26_8[var_26_12] = {}

		for iter_26_2 = 2, #var_26_11 do
			table.insert(var_26_8[var_26_12], var_26_11[iter_26_2])
		end
	end

	arg_26_0:_refreshSuper(arg_26_1.uniqueSkill)
	arg_26_0:_refreshSkill(var_26_8)
	arg_26_0:_refreshAttrList(arg_26_0:_getMontBaseAttr(arg_26_1))
	arg_26_0:_refreshResistance()
	arg_26_0:refreshStress(arg_26_0._entityMO)
	gohelper.setActive(arg_26_0._goplayerequipinfo, false)
end

var_0_0.StressUiType2Cls = {
	[FightNameUIStressMgr.UiType.Normal] = FightFocusStressComp,
	[FightNameUIStressMgr.UiType.Act183] = FightFocusAct183StressComp
}

function var_0_0.refreshStress(arg_27_0, arg_27_1)
	if not arg_27_1 or not arg_27_1:hasStress() then
		arg_27_0:removeStressComp()

		return
	end

	local var_27_0 = FightStressHelper.getStressUiType(arg_27_1.id)

	if not arg_27_0.stressComp then
		arg_27_0:createStressComp(var_27_0)
		arg_27_0.stressComp:refreshStress(arg_27_1)

		return
	end

	if arg_27_0.stressComp:getUiType() == var_27_0 then
		arg_27_0.stressComp:refreshStress(arg_27_1)

		return
	end

	arg_27_0:removeStressComp()
	arg_27_0:createStressComp(var_27_0)
	arg_27_0.stressComp:refreshStress(arg_27_1)
end

function var_0_0.createStressComp(arg_28_0, arg_28_1)
	arg_28_0.stressComp = (var_0_0.StressUiType2Cls[arg_28_1] or FightFocusStressCompBase).New()

	arg_28_0.stressComp:init(arg_28_0._gostress)
end

function var_0_0._refreshResistance(arg_29_0)
	if arg_29_0.isCharacter then
		arg_29_0.resistanceComp:refresh(nil)

		return
	end

	local var_29_0 = arg_29_0._entityMO:getResistanceDict()

	arg_29_0.resistanceComp:refresh(var_29_0)
end

function var_0_0._getBossId(arg_30_0)
	local var_30_0 = FightModel.instance:getCurMonsterGroupId()
	local var_30_1 = var_30_0 and lua_monster_group.configDict[var_30_0]

	return var_30_1 and not string.nilorempty(var_30_1.bossId) and var_30_1.bossId or nil
end

local var_0_1 = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function var_0_0._onMonsterAttrItemShow(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = arg_31_1.transform
	local var_31_1 = var_31_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_31_2 = var_31_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_31_3 = HeroConfig.instance:getHeroAttributeCO(arg_31_2.id)

	if SLFramework.UGUI.GuiHelper.GetPreferredWidth(var_31_2, var_31_3.name) > recthelper.getWidth(var_31_2.transform) then
		var_31_2.overflowMode = TMPro.TextOverflowModes.Ellipsis
		arg_31_0._canClickAttribute = true
	end

	var_31_2.text = var_31_3.name

	UISpriteSetMgr.instance:setCommonSprite(var_31_1, "icon_att_" .. var_31_3.id)

	local var_31_4 = var_31_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_31_5 = var_31_0:Find("rate"):GetComponent(gohelper.Type_Image)

	if arg_31_0.isCharacter then
		gohelper.setActive(var_31_4.gameObject, true)
		gohelper.setActive(var_31_5.gameObject, false)

		var_31_4.text = arg_31_0._curAttrMO[var_0_1[arg_31_3]]
	else
		gohelper.setActive(var_31_4.gameObject, false)
		gohelper.setActive(var_31_5.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(var_31_5, "sx_" .. arg_31_2.value, true)
	end
end

function var_0_0._refreshCharacterInfo(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1:getTrialAttrCo()

	gohelper.setActive(arg_32_0._scrollplotenemypassive.gameObject, false)

	local var_32_1 = arg_32_1:getCO()

	arg_32_0:_refreshHeroEquipInfo(arg_32_1)
	UISpriteSetMgr.instance:setCommonSprite(arg_32_0._imagecareer, "lssx_" .. tostring(var_32_1.career))

	arg_32_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_32_1.level)
	arg_32_0._txtname.text = var_32_1.name

	if var_32_0 then
		arg_32_0._txtname.text = var_32_0.name
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_32_0._imagedmgtype, "dmgtype" .. tostring(var_32_1.dmgType))
	arg_32_0:_refreshCharacterPassiveSkill(arg_32_1)
	gohelper.setActive(arg_32_0._goenemypassive, false)
	gohelper.setActive(arg_32_0._noskill, false)
	gohelper.setActive(arg_32_0._skill, true)

	local var_32_2
	local var_32_3 = not PlayerModel.instance:isPlayerSelf(arg_32_1.userId)

	if tonumber(arg_32_1.uid) < 0 or var_32_3 then
		var_32_2 = arg_32_1.exSkillLevel
	end

	local var_32_4 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(var_32_1.id, nil, nil, var_32_2)

	if var_32_0 then
		var_32_4 = SkillConfig.instance:getHeroAllSkillIdDictByStr(var_32_0.activeSkill, var_32_0.uniqueSkill)
	end

	local var_32_5 = var_32_4[3][1]

	var_32_4[3] = nil

	if arg_32_1.exSkill and arg_32_1.exSkill > 0 then
		var_32_5 = arg_32_1.exSkill
	end

	if #arg_32_1.skillGroup1 > 0 then
		var_32_4[1] = LuaUtil.deepCopySimple(arg_32_1.skillGroup1)
	end

	if #arg_32_1.skillGroup2 > 0 then
		var_32_4[2] = LuaUtil.deepCopySimple(arg_32_1.skillGroup2)
	end

	arg_32_0:_refreshSuper({
		var_32_5
	})
	arg_32_0:_refreshSkill(var_32_4)
	arg_32_0:_refreshAttrList(arg_32_0:_getHeroBaseAttr(var_32_1))
	arg_32_0:refreshStress(arg_32_0._entityMO)
end

function var_0_0._refreshHeroEquipInfo(arg_33_0, arg_33_1)
	local var_33_0
	local var_33_1

	if tonumber(arg_33_1.uid) < 0 then
		if tonumber(arg_33_1.equipUid) > 0 then
			var_33_0 = EquipModel.instance:getEquip(arg_33_1.equipUid)
		elseif tonumber(arg_33_1.equipUid) < 0 then
			local var_33_2 = lua_equip_trial.configDict[-tonumber(arg_33_1.equipUid)]

			if var_33_2 then
				var_33_0 = EquipMO.New()

				var_33_0:initByTrialEquipCO(var_33_2)
			end
		elseif arg_33_1.trialEquip and arg_33_1.trialEquip.equipId > 0 then
			var_33_0 = EquipMO.New()

			local var_33_3 = {
				equipId = arg_33_1.trialEquip.equipId,
				equipLv = arg_33_1.trialEquip.equipLv,
				equipRefine = arg_33_1.trialEquip.refineLv
			}

			var_33_0:initByTrialCO(var_33_3)
		end
	else
		local var_33_4

		if not PlayerModel.instance:isPlayerSelf(arg_33_1.userId) then
			var_33_4 = arg_33_1.uid
		else
			local var_33_5 = arg_33_1:getCO()
			local var_33_6 = HeroModel.instance:getByHeroId(var_33_5.id)

			var_33_4 = var_33_6 and var_33_6.id
		end

		local var_33_7

		if arg_33_0._group then
			for iter_33_0, iter_33_1 in pairs(arg_33_0._group.heroList) do
				if var_33_4 and iter_33_1 == var_33_4 then
					var_33_7 = arg_33_0._group.equips[iter_33_0 - 1].equipUid[1]
					var_33_1 = iter_33_0
				end
			end
		end

		if tonumber(var_33_7) and tonumber(var_33_7) < 0 then
			local var_33_8 = lua_equip_trial.configDict[-tonumber(var_33_7)]

			if var_33_8 then
				var_33_0 = EquipMO.New()

				var_33_0:initByTrialEquipCO(var_33_8)
			end
		else
			var_33_0 = EquipModel.instance:getEquip(var_33_7)
		end
	end

	if var_33_0 and arg_33_0._balanceHelper.getIsBalanceMode() then
		local var_33_9, var_33_10, var_33_11 = arg_33_0._balanceHelper.getBalanceLv()

		if var_33_11 > var_33_0.level then
			local var_33_12 = EquipMO.New()

			var_33_12:initByConfig(nil, var_33_0.equipId, var_33_11, var_33_0.refineLv)

			var_33_0 = var_33_12
		end
	end

	if var_33_0 and var_33_1 and arg_33_0._setEquipInfo then
		local var_33_13 = arg_33_0._setEquipInfo[1]
		local var_33_14 = arg_33_0._setEquipInfo[2]

		var_33_0 = var_33_13(var_33_14, {
			posIndex = var_33_1,
			equipMO = var_33_0
		})
	end

	arg_33_0.equipMO = var_33_0

	if arg_33_0.equipMO then
		arg_33_0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_33_0.equipMO.config.icon), arg_33_0._equipIconLoaded, arg_33_0)

		arg_33_0._txtequiplv.text = string.format("Lv.%s", arg_33_0.equipMO.level)
		arg_33_0.equipClick = gohelper.getClick(arg_33_0._simageequipicon.gameObject)

		arg_33_0.equipClick:AddClickListener(arg_33_0.onEquipClick, arg_33_0)
	end

	gohelper.setActive(arg_33_0._goequip, arg_33_0.equipMO)
	gohelper.setActive(arg_33_0._goplayerequipinfo, arg_33_0.equipMO)
end

function var_0_0._equipIconLoaded(arg_34_0)
	arg_34_0._equipIconImage.enabled = true
end

function var_0_0.onEquipClick(arg_35_0)
	if arg_35_0.openEquipInfoTipView then
		return
	end

	arg_35_0:closeAllTips()
	gohelper.setActive(arg_35_0._godetailView, false)

	arg_35_0.openEquipInfoTipView = true

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = arg_35_0.equipMO,
		heroCo = arg_35_0._entityMO:getCO()
	})
end

function var_0_0._refreshAttrList(arg_36_0, arg_36_1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	arg_36_0._attrDataList = arg_36_1
	arg_36_0._curAttrMO = arg_36_0._attrEntityDic[arg_36_0._entityMO.id]

	if arg_36_0._curAttrMO then
		gohelper.CreateObjList(arg_36_0, arg_36_0._onMonsterAttrItemShow, arg_36_0._attrDataList, arg_36_0._goattributeroot)
		gohelper.setActive(arg_36_0._btnattribute.gameObject, true)
	else
		FightRpc.instance:sendEntityInfoRequest(arg_36_0._entityMO.id)
	end
end

function var_0_0._onReceiveEntityInfoReply(arg_37_0, arg_37_1)
	arg_37_0._attrEntityDic[arg_37_1.entityInfo.uid] = arg_37_1.entityInfo.attr
	arg_37_0._curAttrMO = arg_37_0._attrEntityDic[arg_37_0._entityMO.id]

	if arg_37_0._curAttrMO then
		gohelper.CreateObjList(arg_37_0, arg_37_0._onMonsterAttrItemShow, arg_37_0._attrDataList, arg_37_0._goattributeroot)
		gohelper.setActive(arg_37_0._btnattribute.gameObject, true)
	end
end

function var_0_0._getHeroBaseAttr(arg_38_0, arg_38_1)
	local var_38_0 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		table.insert(var_38_1, {
			id = HeroConfig.instance:getIDByAttrType(var_38_0[iter_38_0]),
			value = HeroConfig.instance:getHeroAttrRate(arg_38_1.id, iter_38_1)
		})
	end

	return var_38_1
end

function var_0_0._getMontBaseAttr(arg_39_0, arg_39_1)
	local var_39_0 = lua_monster_skill_template.configDict[arg_39_1.skillTemplate]
	local var_39_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_39_1.id)

	table.insert(var_39_1, 2, table.remove(var_39_1, 4))

	local var_39_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_39_3 = {}

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		table.insert(var_39_3, {
			id = HeroConfig.instance:getIDByAttrType(var_39_2[iter_39_0]),
			value = iter_39_1
		})
	end

	return var_39_3
end

function var_0_0._onAttributeClick(arg_40_0)
	arg_40_0:_onAttributeClick_overseas()
end

function var_0_0._refreshPassiveSkill(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:_releasePassiveSkillGOs()

	for iter_41_0 = 1, #arg_41_1 do
		local var_41_0 = arg_41_0._passiveSkillGOs[iter_41_0]

		if not var_41_0 then
			local var_41_1 = gohelper.cloneInPlace(arg_41_2, "item" .. iter_41_0)

			var_41_0 = arg_41_0:getUserDataTb_()
			var_41_0.go = var_41_1
			var_41_0.name = gohelper.findChildTextMesh(var_41_1, "tmp_talent")
			var_41_0.btn = gohelper.findChildButton(var_41_1, "#btn_enemypassive")

			table.insert(arg_41_0._passiveSkillGOs, var_41_0)
		end

		local var_41_2 = tonumber(arg_41_1[iter_41_0])
		local var_41_3 = lua_skill.configDict[var_41_2]

		var_41_0.btn:AddClickListener(arg_41_0._btnenemypassiveOnClick, arg_41_0)

		var_41_0.name.text = var_41_3.name

		gohelper.setActive(var_41_0.go, true)
	end

	for iter_41_1 = #arg_41_1 + 1, #arg_41_0._passiveSkillGOs do
		gohelper.setActive(arg_41_0._passiveSkillGOs[iter_41_1].go, false)
	end

	gohelper.setActive(arg_41_0._goenemypassive, #arg_41_1 > 0)

	arg_41_0._passiveSkillIds = arg_41_1

	local var_41_4 = arg_41_0._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	local var_41_5 = 80
	local var_41_6 = math.ceil(#arg_41_1 / 3)
	local var_41_7 = 200

	if var_41_6 <= 2 then
		var_41_7 = var_41_5 * var_41_6
	end

	var_41_4.minHeight = var_41_7
end

function var_0_0._refreshCharacterPassiveSkill(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1:getCO()
	local var_42_1, var_42_2 = SkillConfig.instance:getHeroExSkillLevelByLevel(var_42_0.id, arg_42_1.level)
	local var_42_3 = {}
	local var_42_4 = arg_42_0:getPassiveSkillList(arg_42_1)
	local var_42_5 = var_42_4 and var_42_4[0]

	if var_42_4 and #var_42_4 > 0 then
		gohelper.setActive(arg_42_0._goplayerpassive, true)

		local var_42_6 = var_42_4[1]

		arg_42_0._txttalent.text = lua_skill.configDict[var_42_6].name

		for iter_42_0, iter_42_1 in pairs(var_42_4) do
			local var_42_7 = iter_42_0 <= var_42_1

			gohelper.setActive(arg_42_0._playerpassiveGOList[iter_42_0], var_42_7)

			if var_42_7 then
				var_42_3[iter_42_0] = FightHelper.getPassiveSkill(arg_42_1.id, iter_42_1)
			end
		end

		for iter_42_2 = #var_42_4 + 1, #arg_42_0._playerpassiveGOList do
			gohelper.setActive(arg_42_0._playerpassiveGOList[iter_42_2], false)
		end
	end

	if var_42_5 then
		gohelper.setActive(arg_42_0._playerpassiveGOList[0], true)
	else
		gohelper.setActive(arg_42_0._playerpassiveGOList[0], false)
	end

	gohelper.setActive(arg_42_0._goplayerpassive, #var_42_3 > 0 or var_42_5)

	arg_42_0._passiveSkillIds = var_42_3
end

function var_0_0.getPassiveSkillList(arg_43_0, arg_43_1)
	local var_43_0 = {}
	local var_43_1
	local var_43_2 = arg_43_1:getTrialAttrCo()

	if var_43_2 then
		var_43_1 = arg_43_1.modelId

		local var_43_3 = string.splitToNumber(var_43_2.passiveSkill, "|")

		for iter_43_0, iter_43_1 in ipairs(var_43_3) do
			table.insert(var_43_0, iter_43_1)
		end
	else
		var_43_1 = arg_43_1:getCO().id

		local var_43_4 = arg_43_1.exSkillLevel
		local var_43_5 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(var_43_1, var_43_4)

		if var_43_5[0] then
			var_43_0[0] = var_43_5[0].skillPassive
		end

		for iter_43_2, iter_43_3 in ipairs(var_43_5) do
			table.insert(var_43_0, iter_43_3.skillPassive)
		end
	end

	local var_43_6 = FightModel.instance:getFightParam()
	local var_43_7 = var_43_6 and var_43_6:getCurEpisodeConfig()

	if var_43_7 and var_43_7.type == DungeonEnum.EpisodeType.BossRush then
		local var_43_8 = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_43_7.id)

		if var_43_8 and var_43_8.enhanceRole == 1 then
			var_43_0 = arg_43_0:exchangeHeroPassiveSkill(var_43_0, var_43_1)
		end
	end

	return var_43_0
end

function var_0_0.exchangeHeroPassiveSkill(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_1 then
		return arg_44_1
	end

	if not arg_44_2 then
		return arg_44_1
	end

	for iter_44_0, iter_44_1 in ipairs(lua_activity128_enhance.configList) do
		if iter_44_1.characterId == arg_44_2 then
			local var_44_0 = FightStrUtil.splitString2(iter_44_1.exchangeSkills, true)

			if var_44_0 then
				for iter_44_2, iter_44_3 in ipairs(arg_44_1) do
					for iter_44_4, iter_44_5 in ipairs(var_44_0) do
						if iter_44_5[1] == iter_44_3 then
							arg_44_1[iter_44_2] = iter_44_5[2]
						end
					end
				end
			end

			return arg_44_1
		end
	end

	return arg_44_1
end

function var_0_0._refreshSkill(arg_45_0, arg_45_1)
	local var_45_0
	local var_45_1
	local var_45_2

	for iter_45_0 = 1, #arg_45_1 do
		if iter_45_0 > #arg_45_0._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		local var_45_3 = arg_45_0._skillGOs[iter_45_0]
		local var_45_4 = arg_45_1[iter_45_0][1]
		local var_45_5 = lua_skill.configDict[var_45_4]

		if not var_45_5 then
			logError("技能表找不到id:" .. var_45_4)

			return
		end

		var_45_3.icon:LoadImage(ResUrl.getSkillIcon(var_45_5.icon))
		var_45_3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_45_5.showTag))

		local var_45_6 = {}

		var_45_6.super = false
		var_45_6.skillIdList = arg_45_1[iter_45_0]
		var_45_6.skillIndex = iter_45_0
		var_45_3.info = var_45_6

		gohelper.setActive(var_45_3.go, true)
	end

	for iter_45_1 = #arg_45_1 + 1, #arg_45_0._skillGOs do
		gohelper.setActive(arg_45_0._skillGOs[iter_45_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_46_0, arg_46_1)
	if arg_46_1 and #arg_46_1 > 0 then
		local var_46_0
		local var_46_1
		local var_46_2

		for iter_46_0 = 1, #arg_46_1 do
			local var_46_3 = arg_46_0._superItemList[iter_46_0]

			if not var_46_3 then
				logError("技能超过支持显示数量 : " .. table.concat(arg_46_1, "|"))

				return
			end

			gohelper.setActive(var_46_3.go, true)

			local var_46_4 = arg_46_1[iter_46_0]
			local var_46_5 = lua_skill.configDict[var_46_4]

			var_46_3.icon:LoadImage(ResUrl.getSkillIcon(var_46_5.icon))

			local var_46_6 = {}

			var_46_6.super = true
			var_46_6.skillIdList = {
				var_46_4
			}
			var_46_6.skillIndex = CharacterEnum.skillIndex.SkillEx
			var_46_3.info = var_46_6
		end
	end

	for iter_46_1 = #arg_46_1 + 1, #arg_46_0._superItemList do
		gohelper.setActive(arg_46_0._superItemList[iter_46_1].go, false)
	end
end

function var_0_0._refreshMO(arg_47_0, arg_47_1)
	arg_47_0:_refreshHp(arg_47_1)
	arg_47_0:_refreshBuff(arg_47_1)

	if arg_47_1:isMonster() then
		local var_47_0 = arg_47_1:getCO()

		if FightHelper.isBossId(arg_47_0:_getBossId(), var_47_0.id) then
			arg_47_0:_refreshEnemyPassiveSkill(var_47_0)
		else
			gohelper.setActive(arg_47_0._goenemypassiveSkill, false)
		end
	end
end

function var_0_0._refreshEnemyPassiveSkill(arg_48_0, arg_48_1)
	arg_48_0._bossSkillInfos = {}

	local var_48_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_48_1.id)
	local var_48_1 = FightConfig.instance:_filterSpeicalSkillIds(var_48_0, true)

	for iter_48_0 = 1, #var_48_1 do
		local var_48_2 = var_48_1[iter_48_0]
		local var_48_3 = lua_skill_specialbuff.configDict[var_48_2]

		if var_48_3 then
			local var_48_4 = arg_48_0._enemypassiveiconGOs[iter_48_0]

			if not var_48_4 then
				var_48_4 = arg_48_0:getUserDataTb_()
				var_48_4.go = gohelper.cloneInPlace(arg_48_0._enemypassiveSkillPrefab, "item" .. iter_48_0)
				var_48_4._gotag = gohelper.findChild(var_48_4.go, "tag")
				var_48_4._txttag = gohelper.findChildText(var_48_4.go, "tag/#txt_tag")

				table.insert(arg_48_0._enemypassiveiconGOs, var_48_4)

				local var_48_5 = gohelper.findChildImage(var_48_4.go, "icon")

				table.insert(arg_48_0._passiveiconImgs, var_48_5)
				gohelper.setActive(var_48_4.go, true)
			else
				gohelper.setActive(var_48_4.go, true)
			end

			if arg_48_0._bossSkillInfos[iter_48_0] == nil then
				arg_48_0._bossSkillInfos[iter_48_0] = {
					skillId = var_48_2,
					icon = var_48_3.icon
				}
			end

			if not string.nilorempty(var_48_3.lv) then
				gohelper.setActive(var_48_4._gotag, true)

				var_48_4._txttag.text = var_48_3.lv
			else
				gohelper.setActive(var_48_4._gotag, false)
			end

			if string.nilorempty(var_48_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_48_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_48_0._passiveiconImgs[iter_48_0], var_48_3.icon)
		end
	end

	if #var_48_1 < #arg_48_0._enemypassiveiconGOs then
		for iter_48_1 = #var_48_1 + 1, #arg_48_0._enemypassiveiconGOs do
			gohelper.setActive(arg_48_0._enemypassiveiconGOs[iter_48_1].go, false)
		end
	end

	if #arg_48_0._bossSkillInfos > 0 then
		gohelper.setActive(arg_48_0._goenemypassiveSkill, true)
	else
		gohelper.setActive(arg_48_0._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(arg_48_0._btnenemypassiveSkill.gameObject)
	arg_48_0._btnenemypassiveSkill:AddClickListener(arg_48_0._onBuffPassiveSkillClick, arg_48_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_49_0)
	if arg_49_0._isbuffviewopen then
		return
	end

	arg_49_0:closeAllTips()
	arg_49_0:_hideDetail()

	local var_49_0

	if arg_49_0._bossSkillInfos then
		for iter_49_0, iter_49_1 in pairs(arg_49_0._bossSkillInfos) do
			local var_49_1 = iter_49_1.skillId
			local var_49_2 = arg_49_0._enemybuffpassiveGOs[iter_49_0]

			if not var_49_2 then
				var_49_2 = arg_49_0:getUserDataTb_()
				var_49_2.go = gohelper.cloneInPlace(arg_49_0._gobuffpassiveitem, "item" .. iter_49_0)

				table.insert(arg_49_0._enemybuffpassiveGOs, var_49_2)

				local var_49_3 = gohelper.findChildImage(var_49_2.go, "title/simage_icon")

				table.insert(arg_49_0._passiveSkillImgs, var_49_3)
				gohelper.setActive(var_49_2.go, true)
			else
				gohelper.setActive(var_49_2.go, true)
			end

			local var_49_4 = gohelper.findChild(var_49_2.go, "txt_desc/image_line")

			gohelper.setActive(var_49_4, true)
			arg_49_0:_setPassiveSkillTip(var_49_2.go, iter_49_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_49_0._passiveSkillImgs[iter_49_0], iter_49_1.icon)
		end

		if #arg_49_0._bossSkillInfos < #arg_49_0._enemybuffpassiveGOs then
			for iter_49_2 = #arg_49_0._bossSkillInfos + 1, #arg_49_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_49_0._enemybuffpassiveGOs[iter_49_2], false)
			end
		end

		local var_49_5 = gohelper.findChild(arg_49_0._enemybuffpassiveGOs[#arg_49_0._bossSkillInfos].go, "txt_desc/image_line")

		gohelper.setActive(var_49_5, false)
		gohelper.setActive(arg_49_0._gobuffpassiveview, true)

		arg_49_0._isbuffviewopen = true
	end
end

function var_0_0._setPassiveSkillTip(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = gohelper.findChildText(arg_50_1, "title/txt_name")
	local var_50_1 = gohelper.findChildText(arg_50_1, "txt_desc")

	SkillHelper.addHyperLinkClick(var_50_1, arg_50_0.onClickHyperLink, arg_50_0)

	local var_50_2 = lua_skill.configDict[arg_50_2.skillId]

	var_50_0.text = var_50_2.name
	var_50_1.text = SkillHelper.getEntityDescBySkillCo(arg_50_0._curSelectId, var_50_2, "#CC492F", "#485E92")
end

function var_0_0.onClickPassiveHyperLink(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.commonBuffTipAnchorPos = arg_51_0.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_51_1, arg_51_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._refreshHp(arg_52_0, arg_52_1)
	local var_52_0 = math.max(arg_52_1.currentHp, 0)
	local var_52_1 = arg_52_1.attrMO and math.max(arg_52_1.attrMO.hp, 0)
	local var_52_2 = var_52_1 > 0 and var_52_0 / var_52_1 or 0

	arg_52_0._txthp.text = string.format("%d/%d", var_52_0, var_52_1)

	arg_52_0._sliderhp:SetValue(var_52_2)
end

function var_0_0._refreshBuff(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1:getBuffList()
	local var_53_1 = FightBuffHelper.filterBuffType(var_53_0, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_53_1)
	table.sort(var_53_1, function(arg_54_0, arg_54_1)
		if arg_54_0.time ~= arg_54_1.time then
			return arg_54_0.time < arg_54_1.time
		end

		return arg_54_0.id < arg_54_1.id
	end)

	local var_53_2 = var_53_1 and #var_53_1 or 0
	local var_53_3 = 0
	local var_53_4 = 0

	for iter_53_0 = 1, var_53_2 do
		local var_53_5 = var_53_1[iter_53_0]
		local var_53_6 = lua_skill_buff.configDict[var_53_5.buffId]

		if var_53_6 and var_53_6.isNoShow == 0 then
			var_53_3 = var_53_3 + 1

			local var_53_7 = arg_53_0._buffTables[var_53_3]

			if not var_53_7 then
				local var_53_8 = gohelper.cloneInPlace(arg_53_0._gobuffitem, "item" .. var_53_3)

				var_53_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_53_8, FightBuffItem)
				arg_53_0._buffTables[var_53_3] = var_53_7
			end

			var_53_7:updateBuffMO(var_53_5)
			var_53_7:setClickCallback(arg_53_0._onClickBuff, arg_53_0)
			gohelper.setActive(arg_53_0._buffTables[var_53_3].go, var_53_3 <= 6)
		end
	end

	for iter_53_1 = var_53_3 + 1, #arg_53_0._buffTables do
		gohelper.setActive(arg_53_0._buffTables[iter_53_1].go, false)
	end

	gohelper.setActive(arg_53_0._scrollbuff.gameObject, var_53_3 > 0)
	gohelper.setActive(arg_53_0._btnBuffMore, var_53_3 > 6)
end

function var_0_0._onClickBuff(arg_55_0, arg_55_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)

	arg_55_1 = arg_55_1 or arg_55_0._entityMO.id

	arg_55_0:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_55_1,
		viewname = arg_55_0.viewName
	})

	if arg_55_0._hadPopUp then
		arg_55_0:_hideDetail()

		arg_55_0._hadPopUp = false
	end
end

function var_0_0._showPassiveDetail(arg_56_0)
	arg_56_0:closeAllTips()

	if not arg_56_0._passiveSkillIds then
		return
	end

	local var_56_0 = arg_56_0._passiveSkillIds[0]

	if #arg_56_0._passiveSkillIds > 0 or var_56_0 then
		gohelper.setActive(arg_56_0._godetailView, true)
		arg_56_0:_refreshPassiveDetail()

		arg_56_0._hadPopUp = true
	end
end

function var_0_0.refreshScrollEnemy(arg_57_0)
	arg_57_0:_releaseHeadItemList()

	arg_57_0.enemyItemList = {}

	gohelper.setActive(arg_57_0.goScrollEnemy, true)

	local var_57_0

	for iter_57_0, iter_57_1 in ipairs(arg_57_0._entityList) do
		local var_57_1 = arg_57_0.enemyItemList[iter_57_0] or arg_57_0:createEnemyItem()

		gohelper.setActive(var_57_1.go, true)

		var_57_1.entityMo = iter_57_1

		local var_57_2 = iter_57_1:getCO()
		local var_57_3 = iter_57_1:getSpineSkinCO()

		if var_57_2 then
			UISpriteSetMgr.instance:setEnemyInfoSprite(var_57_1.imageCareer, "sxy_" .. tostring(var_57_2.career))
		end

		gohelper.getSingleImage(var_57_1.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_57_3.headIcon))

		if var_57_2 and var_57_2.heartVariantId and var_57_2.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_57_2.heartVariantId), var_57_1.imageIcon)
		end

		gohelper.setActive(var_57_1.goBossTag, arg_57_0.bossIdDict[var_57_2.id])

		if iter_57_1.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(var_57_1.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(var_57_1.imageIcon.transform, 0, 0, 0)
		end
	end

	for iter_57_2 = #arg_57_0._entityList + 1, #arg_57_0.enemyItemList do
		gohelper.setActive(arg_57_0.enemyItemList[iter_57_2].go, false)
	end
end

function var_0_0.refreshScrollEnemySelectStatus(arg_58_0)
	if arg_58_0.enemyItemList then
		for iter_58_0, iter_58_1 in ipairs(arg_58_0.enemyItemList) do
			local var_58_0 = arg_58_0._entityMO.uid == iter_58_1.entityMo.uid

			gohelper.setActive(iter_58_1.goSelectFrame, var_58_0)

			local var_58_1 = arg_58_0._entityMO.uid == iter_58_1.entityMo.uid and "#ffffff" or "#8C8C8C"
			local var_58_2 = arg_58_0._entityMO.uid == iter_58_1.entityMo.uid and "#ffffff" or "#828282"

			SLFramework.UGUI.GuiHelper.SetColor(iter_58_1.imageIcon, var_58_1)
			SLFramework.UGUI.GuiHelper.SetColor(iter_58_1.imageCareer, var_58_2)

			if var_58_0 then
				local var_58_3 = -106 - 193 * (iter_58_0 - 1) + recthelper.getAnchorY(arg_58_0.goScrollEnemyContent.transform) + arg_58_0._entityScrollHeight / 2
				local var_58_4 = recthelper.getHeight(iter_58_1.go.transform)
				local var_58_5 = var_58_3 - var_58_4
				local var_58_6 = var_58_3 + var_58_4
				local var_58_7 = arg_58_0._entityScrollHeight / 2

				if var_58_5 < -var_58_7 then
					local var_58_8 = var_58_5 + var_58_7

					recthelper.setAnchorY(arg_58_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_58_0.goScrollEnemyContent.transform) - var_58_8 - 54)
				end

				if var_58_7 < var_58_6 then
					local var_58_9 = var_58_6 - var_58_7

					recthelper.setAnchorY(arg_58_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_58_0.goScrollEnemyContent.transform) - var_58_9 + 54)
				end
			end

			gohelper.setActive(iter_58_1.subTag, FightDataHelper.entityMgr:isSub(iter_58_1.entityMo.uid))
		end
	end
end

function var_0_0.createEnemyItem(arg_59_0)
	local var_59_0 = arg_59_0:getUserDataTb_()

	var_59_0.go = gohelper.cloneInPlace(arg_59_0.contentEnemyItem)
	var_59_0.imageIcon = gohelper.findChildImage(var_59_0.go, "item/icon")
	var_59_0.goBossTag = gohelper.findChild(var_59_0.go, "item/bosstag")
	var_59_0.imageCareer = gohelper.findChildImage(var_59_0.go, "item/career")
	var_59_0.goSelectFrame = gohelper.findChild(var_59_0.go, "item/go_selectframe")
	var_59_0.subTag = gohelper.findChild(var_59_0.go, "item/#go_SubTag")
	var_59_0.btnClick = gohelper.findChildButtonWithAudio(var_59_0.go, "item/btn_click")

	var_59_0.btnClick:AddClickListener(arg_59_0.onClickEnemyItem, arg_59_0, var_59_0)
	table.insert(arg_59_0.enemyItemList, var_59_0)

	return var_59_0
end

function var_0_0.onClickEnemyItem(arg_60_0, arg_60_1)
	if arg_60_1.entityMo.uid == arg_60_0._entityMO.uid then
		return
	end

	arg_60_0._curSelectId = arg_60_1.entityMo.id

	arg_60_0:closeAllTips()
	arg_60_0:_refreshUI()
	arg_60_0._ani:Play("switch", nil, nil)
end

function var_0_0.closeAllTips(arg_61_0)
	arg_61_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_61_0._godetailView, false)
	gohelper.setActive(arg_61_0._gobuffpassiveview, false)

	arg_61_0._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	arg_61_0.openEquipInfoTipView = false
	arg_61_0.openFightAttributeTipView = false
end

function var_0_0._showSkillDetail(arg_62_0, arg_62_1)
	arg_62_0:closeAllTips()
	arg_62_0.viewContainer:showSkillTipView(arg_62_1, arg_62_0.isCharacter, arg_62_0._curSelectId)

	arg_62_0._hadPopUp = true
end

function var_0_0._hideDetail(arg_63_0)
	arg_63_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_63_0._godetailView, false)
	gohelper.setActive(arg_63_0._gobuffpassiveview, false)

	arg_63_0._isbuffviewopen = false
end

function var_0_0._refreshPassiveDetail(arg_64_0)
	local var_64_0 = {}

	if arg_64_0._passiveSkillIds[0] then
		table.insert(var_64_0, arg_64_0._passiveSkillIds[0])
	end

	for iter_64_0 = 1, #arg_64_0._passiveSkillIds do
		table.insert(var_64_0, arg_64_0._passiveSkillIds[iter_64_0])
	end

	local var_64_1 = #var_64_0
	local var_64_2 = arg_64_0:_checkReplaceSkill(var_64_0)

	for iter_64_1 = 1, var_64_1 do
		local var_64_3 = tonumber(var_64_2[iter_64_1])
		local var_64_4 = lua_skill.configDict[var_64_3]

		if var_64_4 then
			local var_64_5 = arg_64_0._detailPassiveTables[iter_64_1]

			if not var_64_5 then
				local var_64_6 = gohelper.cloneInPlace(arg_64_0._godetailpassiveitem, "item" .. iter_64_1)

				var_64_5 = arg_64_0:getUserDataTb_()
				var_64_5.go = var_64_6
				var_64_5.name = gohelper.findChildText(var_64_6, "title/txt_name")
				var_64_5.icon = gohelper.findChildSingleImage(var_64_6, "title/simage_icon")
				var_64_5.desc = gohelper.findChildText(var_64_6, "txt_desc")

				SkillHelper.addHyperLinkClick(var_64_5.desc, arg_64_0.onClickHyperLink, arg_64_0)

				var_64_5.line = gohelper.findChild(var_64_6, "txt_desc/image_line")

				table.insert(arg_64_0._detailPassiveTables, var_64_5)
			end

			var_64_5.name.text = var_64_4.name

			local var_64_7 = SkillHelper.getEntityDescBySkillCo(arg_64_0._curSelectId, var_64_4, "#CC492F", "#485E92")

			var_64_5.desc.text = var_64_7

			var_64_5.desc:GetPreferredValues()
			gohelper.setActive(var_64_5.go, true)
			gohelper.setActive(var_64_5.line, iter_64_1 < var_64_1)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_64_3))
		end
	end

	for iter_64_2 = var_64_1 + 1, #arg_64_0._detailPassiveTables do
		gohelper.setActive(arg_64_0._detailPassiveTables[iter_64_2].go, false)
	end
end

function var_0_0._checkReplaceSkill(arg_65_0, arg_65_1)
	if arg_65_1 and arg_65_0._entityMO then
		arg_65_1 = arg_65_0._entityMO:checkReplaceSkill(arg_65_1)
	end

	return arg_65_1
end

function var_0_0.onClickHyperLink(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0.commonBuffTipAnchorPos = arg_66_0.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_66_1, arg_66_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._detectBossMultiHp(arg_67_0, arg_67_1)
	local var_67_0 = BossRushModel.instance:getBossEntityMO()

	arg_67_0._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and var_67_0 and var_67_0.id == arg_67_1.id

	local var_67_1 = arg_67_1.attrMO.multiHpNum

	if arg_67_0._isBossRush then
		var_67_1 = BossRushModel.instance:getMultiHpInfo().multiHpNum
	end

	gohelper.setActive(arg_67_0._multiHpRoot, var_67_1 > 1)

	if var_67_1 > 1 then
		arg_67_0:com_createObjList(arg_67_0._onMultiHpItemShow, var_67_1, arg_67_0._multiHpRoot, arg_67_0._multiHpItem)
	end
end

function var_0_0._onMultiHpItemShow(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = arg_68_0._entityMO.attrMO.multiHpNum
	local var_68_1 = arg_68_0._entityMO.attrMO:getCurMultiHpIndex()

	if arg_68_0._isBossRush then
		local var_68_2 = BossRushModel.instance:getMultiHpInfo()

		var_68_0 = var_68_2.multiHpNum
		var_68_1 = var_68_2.multiHpIdx
	end

	local var_68_3 = gohelper.findChild(arg_68_1, "hp")

	gohelper.setActive(var_68_3, arg_68_3 <= var_68_0 - var_68_1)

	if arg_68_3 == 1 and arg_68_0._isBossRush then
		gohelper.setActive(var_68_3, true)
	end
end

function var_0_0._onCloseView(arg_69_0, arg_69_1)
	if arg_69_1 == ViewName.EquipInfoTipsView then
		arg_69_0.openEquipInfoTipView = false
	end

	if arg_69_1 == ViewName.FightAttributeTipView then
		arg_69_0.openFightAttributeTipView = false
	end
end

function var_0_0.onClose(arg_70_0)
	gohelper.setActive(arg_70_0.odysseySuitRoot, false)
	TaskDispatcher.cancelTask(arg_70_0._refreshUI, arg_70_0)
	arg_70_0:_releaseTween()

	if arg_70_0._focusFlow then
		arg_70_0._focusFlow:stop()

		arg_70_0._focusFlow = nil
	end

	if arg_70_0.subEntityList then
		for iter_70_0, iter_70_1 in ipairs(arg_70_0.subEntityList) do
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(iter_70_1:getTag(), iter_70_1.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
	arg_70_0:setAssistBossStatus(false, true)
end

function var_0_0.onDestroyView(arg_71_0)
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	arg_71_0._simagebg:UnLoadImage()

	for iter_71_0 = 1, #arg_71_0._skillGOs do
		local var_71_0 = arg_71_0._skillGOs[iter_71_0]

		var_71_0.icon:UnLoadImage()
		var_71_0.btn:RemoveClickListener()
	end

	for iter_71_1, iter_71_2 in ipairs(arg_71_0._superItemList) do
		iter_71_2.icon:UnLoadImage()
		iter_71_2.btn:RemoveClickListener()
	end

	arg_71_0._superItemList = nil

	arg_71_0._simageequipicon:UnLoadImage()

	if arg_71_0.equipClick then
		arg_71_0.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_71_0._onCloseView, arg_71_0)
	arg_71_0:_releaseHeadItemList()
	arg_71_0.resistanceComp:destroy()

	arg_71_0.resistanceComp = nil

	arg_71_0:removeStressComp()

	if arg_71_0._assistBossView then
		arg_71_0._assistBossView:destory()

		arg_71_0._assistBossView = nil
	end
end

function var_0_0.removeStressComp(arg_72_0)
	if arg_72_0.stressComp then
		arg_72_0.stressComp:destroy()

		arg_72_0.stressComp = nil
	end
end

function var_0_0._releaseHeadItemList(arg_73_0)
	if arg_73_0.enemyItemList then
		for iter_73_0, iter_73_1 in ipairs(arg_73_0.enemyItemList) do
			iter_73_1.btnClick:RemoveClickListener()
			gohelper.destroy(iter_73_1.go)
		end

		arg_73_0.enemyItemList = nil
	end
end

function var_0_0._setVirtualCameDamping(arg_74_0)
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function var_0_0._setEntityPosAndActive(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_1.id
	local var_75_1 = false
	local var_75_2 = FightHelper.getEntity(var_75_0)

	if var_75_2 then
		local var_75_3 = var_75_2:getMO()

		if var_75_3 then
			local var_75_4 = FightConfig.instance:getSkinCO(var_75_3.skin)

			if var_75_4 and var_75_4.canHide == 1 then
				var_75_1 = true
			end
		end
	end

	local var_75_5 = FightHelper.getAllEntitys()

	for iter_75_0, iter_75_1 in ipairs(var_75_5) do
		if not FightHelper.isAssembledMonster(iter_75_1) then
			iter_75_1:setVisibleByPos(var_75_1 or var_75_0 == iter_75_1.id)
		elseif arg_75_1.side ~= iter_75_1:getSide() then
			iter_75_1:setVisibleByPos(var_75_1 or var_75_0 == iter_75_1.id)
		else
			iter_75_1:setVisibleByPos(true)
		end

		if iter_75_1.buff then
			if var_75_0 ~= iter_75_1.id then
				iter_75_1.buff:hideBuffEffects()
			else
				iter_75_1.buff:showBuffEffects()
			end
		end

		if iter_75_1.nameUI then
			iter_75_1.nameUI:setActive(var_75_0 == iter_75_1.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	local var_75_6

	if arg_75_1.side == FightEnum.EntitySide.MySide then
		local var_75_7 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
		local var_75_8 = FightHelper.getEntityStanceId(arg_75_1, FightModel.instance:getCurWaveId())
		local var_75_9 = lua_stance.configDict[var_75_8].pos1

		var_75_6 = var_75_9

		for iter_75_2, iter_75_3 in ipairs(var_75_7) do
			if iter_75_3.id == arg_75_1.id then
				transformhelper.setLocalPos(iter_75_3.go.transform, var_75_9[1], var_75_9[2], var_75_9[3])

				if iter_75_3.buff then
					iter_75_3.buff:hideBuffEffects()
					iter_75_3.buff:showBuffEffects()
				end
			else
				iter_75_3:setVisibleByPos(false)
			end
		end

		for iter_75_4, iter_75_5 in ipairs(arg_75_0.subEntityList) do
			transformhelper.setLocalPos(iter_75_5.go.transform, 20000, 20000, 20000)
		end
	end

	local var_75_10 = FightHelper.getEntity(var_75_0)
	local var_75_11 = FightDataHelper.entityMgr:isSub(var_75_0)

	if var_75_11 then
		var_75_10 = nil

		for iter_75_6, iter_75_7 in ipairs(arg_75_0.subEntityList) do
			if iter_75_7.id == var_75_0 .. "focusSub" then
				local var_75_12 = FightHelper.getEntity(var_75_0)

				if var_75_12 then
					var_75_12:setVisibleByPos(false)
				end

				var_75_10 = iter_75_7

				transformhelper.setLocalPos(iter_75_7.go.transform, var_75_6[1], var_75_6[2], var_75_6[3])
			end
		end
	end

	if var_75_10 then
		local var_75_13 = var_75_10:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
		local var_75_14, var_75_15, var_75_16 = transformhelper.getPos(var_75_13.transform)
		local var_75_17 = var_75_14 + 2.7
		local var_75_18 = var_75_15 - 2
		local var_75_19 = var_75_16 + 5.4
		local var_75_20

		if var_75_11 then
			var_75_20 = FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(var_75_0).skin)
		else
			var_75_20 = FightConfig.instance:getSkinCO(var_75_10:getMO().skin)
		end

		local var_75_21 = var_75_20.focusOffset

		if #var_75_21 == 3 then
			var_75_17 = var_75_17 + var_75_21[1]
			var_75_18 = var_75_18 + var_75_21[2]
			var_75_19 = var_75_19 + var_75_21[3]
		end

		arg_75_0:_releaseTween()

		local var_75_22 = CameraMgr.instance:getVirtualCameraTrs()

		transformhelper.setPos(var_75_22, var_75_17 + 0.2, var_75_18, var_75_19)
	end
end

function var_0_0._releaseTween(arg_76_0)
	if arg_76_0._tweenId then
		ZProj.TweenHelper.KillById(arg_76_0._tweenId)
	end
end

function var_0_0._playCameraTween(arg_77_0)
	local var_77_0 = CameraMgr.instance:getVirtualCameraTrs()
	local var_77_1, var_77_2, var_77_3 = transformhelper.getPos(var_77_0)

	arg_77_0._tweenId = ZProj.TweenHelper.DOMove(var_77_0, var_77_1 - 0.6, var_77_2, var_77_3, 0.5)
end

function var_0_0._focusEntity(arg_78_0, arg_78_1)
	if arg_78_0._focusFlow then
		arg_78_0._focusFlow:stop()

		arg_78_0._focusFlow = nil
	end

	arg_78_0._focusFlow = FlowSequence.New()

	arg_78_0._focusFlow:addWork(FunctionWork.New(arg_78_0._setVirtualCameDamping, arg_78_0))
	arg_78_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_78_0._focusFlow:addWork(FightWorkFocusSubEntity.New(arg_78_1))
	arg_78_0._focusFlow:addWork(FunctionWork.New(arg_78_0._setEntityPosAndActive, arg_78_0, arg_78_1))
	arg_78_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_78_0._focusFlow:addWork(FunctionWork.New(arg_78_0._playCameraTween, arg_78_0))
	arg_78_0._focusFlow:addWork(WorkWaitSeconds.New(0.5))

	local var_78_0 = {
		subEntityList = arg_78_0.subEntityList
	}

	arg_78_0._focusFlow:start(var_78_0)
end

function var_0_0._onBtnBuffMore(arg_79_0)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_79_0._curSelectId,
		viewname = arg_79_0.viewName
	})
end

function var_0_0.refreshDouQuQuFetter(arg_80_0)
	local var_80_0 = FightDataHelper.fieldMgr.customData

	if not var_80_0 then
		return
	end

	if var_80_0[FightCustomData.CustomDataType.Act191] then
		if arg_80_0.douQuQuFetterView then
			arg_80_0.douQuQuFetterView:refreshEntityMO(arg_80_0._entityMO)
		else
			arg_80_0.douQuQuFetterView = arg_80_0:com_openSubView(FightDouQuQuFetterView, "ui/viewres/fight/fight_act191fetterview.prefab", arg_80_0.go_fetter, arg_80_0._entityMO)
		end
	end
end

function var_0_0.refreshDouQuQuStar(arg_81_0)
	local var_81_0 = FightDataHelper.fieldMgr.customData

	if not var_81_0 then
		return
	end

	if var_81_0[FightCustomData.CustomDataType.Act191] then
		gohelper.setActive(arg_81_0.levelRoot, false)
	end
end

function var_0_0.refreshDouQuQuCollection(arg_82_0)
	local var_82_0 = FightDataHelper.fieldMgr.customData

	if not var_82_0 then
		return
	end

	if var_82_0[FightCustomData.CustomDataType.Act191] then
		gohelper.setActive(arg_82_0.go_collection, true)

		if arg_82_0.douQuQuCollectionView then
			arg_82_0.douQuQuCollectionView:refreshEntityMO(arg_82_0._entityMO)
		else
			arg_82_0.douQuQuCollectionView = arg_82_0:com_openSubView(FightDouQuQuCollectionView, "ui/viewres/fight/fight_act191collectionview.prefab", arg_82_0.go_collection, arg_82_0._entityMO)
		end
	end
end

function var_0_0.showOdysseyEquip(arg_83_0)
	local var_83_0 = FightDataHelper.fieldMgr.customData

	if not var_83_0 then
		return
	end

	var_83_0 = var_83_0[FightCustomData.CustomDataType.Odyssey] or var_83_0[FightCustomData.CustomDataType.Act128Sp]

	if var_83_0 then
		gohelper.setActive(arg_83_0.go_collection, true)

		if arg_83_0.odysseyEquipView then
			arg_83_0.odysseyEquipView:refreshEntityMO(arg_83_0._entityMO)
		else
			arg_83_0.odysseyEquipView = arg_83_0:com_openSubView(FightFocusOdysseyEquipView, "ui/viewres/fight/fight_odysseycollectionview.prefab", arg_83_0.go_collection, arg_83_0._entityMO)
		end
	end
end

function var_0_0.showOdysseyEquipSuit(arg_84_0)
	local var_84_0 = FightDataHelper.fieldMgr.customData

	if not var_84_0 then
		return
	end

	var_84_0 = var_84_0[FightCustomData.CustomDataType.Odyssey] or var_84_0[FightCustomData.CustomDataType.Act128Sp]

	if var_84_0 then
		gohelper.setActive(arg_84_0.go_collection, true)

		if arg_84_0.odysseyEquipSuitView then
			arg_84_0.odysseyEquipSuitView:refreshEntityMO(arg_84_0._entityMO)
		else
			arg_84_0.odysseyEquipSuitView = arg_84_0:com_openSubView(FightFocusOdysseyEquipSuitView, "ui/viewres/fight/fight_odysseysuitview.prefab", arg_84_0.odysseySuitRoot, arg_84_0._entityMO)
		end
	end
end

function var_0_0.showAiJiAoExPointSlider(arg_85_0)
	if arg_85_0._entityMO.exPointType == FightEnum.ExPointType.Synchronization then
		gohelper.setActive(arg_85_0.aiJiAoSliderRoot, true)

		if arg_85_0.aiJiAoExPointSliderView then
			arg_85_0.aiJiAoExPointSliderView:refreshEntityMO(arg_85_0._entityMO)
		else
			arg_85_0.aiJiAoExPointSliderView = arg_85_0:com_openSubView(FightFocusAiJiAoExPointSliderView, "ui/viewres/fight/fightaijiaoenergysliderview.prefab", arg_85_0.aiJiAoSliderRoot, arg_85_0._entityMO)
		end
	else
		gohelper.setActive(arg_85_0.aiJiAoSliderRoot, false)
	end
end

function var_0_0.showAlert(arg_86_0)
	gohelper.setActive(arg_86_0.alertRoot, false)

	local var_86_0 = arg_86_0._entityMO._powerInfos

	if var_86_0 then
		for iter_86_0, iter_86_1 in pairs(var_86_0) do
			if iter_86_0 == FightEnum.PowerType.Alert then
				gohelper.setActive(arg_86_0.alertRoot, true)

				if arg_86_0.alertView then
					arg_86_0.alertView:refreshData(arg_86_0._entityMO.id, iter_86_1)
				else
					local var_86_1 = "ui/viewres/fight/fightalertview.prefab"

					arg_86_0.alertView = arg_86_0:com_openSubView(FightNamePowerInfoView6, var_86_1, arg_86_0.alertRoot, arg_86_0._entityMO.id, iter_86_1, true)
				end
			end
		end
	end
end

return var_0_0
