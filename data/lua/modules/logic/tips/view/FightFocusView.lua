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
	arg_2_0.reduceHpGo = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/reducehp")
	arg_2_0.reduceHpImage = arg_2_0.reduceHpGo:GetComponent(gohelper.Type_Image)
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
	arg_2_0.skillTipsRoot = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/skilltipview")

	gohelper.setAsLastSibling(arg_2_0.skillTipsRoot)

	arg_2_0.goSurvivalHealth = gohelper.findChild(arg_2_0.viewGO, "fightinfocontainer/#go_survivalHealth")
	arg_2_0.rectSurvivalHealth = arg_2_0.goSurvivalHealth:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_2_0.goSurvivalHealth, false)

	arg_2_0.txtHealth = gohelper.findChildText(arg_2_0.viewGO, "fightinfocontainer/#go_survivalHealth/#txt_survivalHealth")
	arg_2_0.imageHealth = gohelper.findChildImage(arg_2_0.viewGO, "fightinfocontainer/#go_survivalHealth/#image_icon")
	arg_2_0.healthClick = gohelper.findChildClickWithDefaultAudio(arg_2_0.viewGO, "fightinfocontainer/#go_survivalHealth/#btn_click")

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
	arg_3_0.healthClick:AddClickListener(arg_3_0.onClickHealth, arg_3_0)
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
	arg_4_0.healthClick:RemoveClickListener()
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

	for iter_19_5 = #var_19_0, 1, -1 do
		local var_19_4 = FightLocalDataMgr.instance.entityMgr:getById(var_19_0[iter_19_5].id)

		if var_19_4 and var_19_4:isStatusDead() then
			table.remove(var_19_0, iter_19_5)
		end
	end

	arg_19_0:sortFightEntityList(var_19_0)

	local var_19_5 = FightDataHelper.entityMgr:getAssistBoss()

	if var_19_5 and arg_19_0._curSelectSide == FightEnum.EntitySide.MySide then
		table.insert(var_19_0, var_19_5)
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

	if #arg_22_0._entityList == 0 then
		arg_22_0._curSelectSide = FightEnum.EntitySide.MySide

		gohelper.setActive(arg_22_0._btnSwitchEnemy.gameObject, false)
		arg_22_0:_refreshEntityList()
	end

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
	arg_26_0:refreshKillLine(arg_26_0._entityMO)
	gohelper.setActive(arg_26_0._goplayerequipinfo, false)
	arg_26_0:refreshHealth(arg_26_0._entityMO)
end

function var_0_0.refreshKillLine(arg_27_0, arg_27_1)
	if not arg_27_0.killLineComp then
		arg_27_0.killLineComp = FightFocusHpKillLineComp.New(FightHpKillLineComp.KillLineType.FocusHp)

		arg_27_0.killLineComp:init(arg_27_0._sliderhp.gameObject)
	end

	arg_27_0.killLineComp:refreshByEntityMo(arg_27_1)
end

var_0_0.StressUiType2Cls = {
	[FightNameUIStressMgr.UiType.Normal] = FightFocusStressComp,
	[FightNameUIStressMgr.UiType.Act183] = FightFocusAct183StressComp
}

function var_0_0.refreshStress(arg_28_0, arg_28_1)
	if not arg_28_1 or not arg_28_1:hasStress() then
		arg_28_0:removeStressComp()

		return
	end

	local var_28_0 = FightStressHelper.getStressUiType(arg_28_1.id)

	if not arg_28_0.stressComp then
		arg_28_0:createStressComp(var_28_0)
		arg_28_0.stressComp:refreshStress(arg_28_1)

		return
	end

	if arg_28_0.stressComp:getUiType() == var_28_0 then
		arg_28_0.stressComp:refreshStress(arg_28_1)

		return
	end

	arg_28_0:removeStressComp()
	arg_28_0:createStressComp(var_28_0)
	arg_28_0.stressComp:refreshStress(arg_28_1)
end

function var_0_0.createStressComp(arg_29_0, arg_29_1)
	arg_29_0.stressComp = (var_0_0.StressUiType2Cls[arg_29_1] or FightFocusStressCompBase).New()

	arg_29_0.stressComp:init(arg_29_0._gostress)
end

function var_0_0._refreshResistance(arg_30_0)
	if arg_30_0.isCharacter then
		arg_30_0.resistanceComp:refresh(nil)

		return
	end

	local var_30_0 = arg_30_0._entityMO:getResistanceDict()

	arg_30_0.resistanceComp:refresh(var_30_0)
end

function var_0_0._getBossId(arg_31_0)
	local var_31_0 = FightModel.instance:getCurMonsterGroupId()
	local var_31_1 = var_31_0 and lua_monster_group.configDict[var_31_0]

	return var_31_1 and not string.nilorempty(var_31_1.bossId) and var_31_1.bossId or nil
end

local var_0_1 = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function var_0_0._onMonsterAttrItemShow(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_1.transform
	local var_32_1 = var_32_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_32_2 = var_32_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_32_3 = HeroConfig.instance:getHeroAttributeCO(arg_32_2.id)

	if SLFramework.UGUI.GuiHelper.GetPreferredWidth(var_32_2, var_32_3.name) > recthelper.getWidth(var_32_2.transform) then
		var_32_2.overflowMode = TMPro.TextOverflowModes.Ellipsis
		arg_32_0._canClickAttribute = true
	end

	var_32_2.text = var_32_3.name

	UISpriteSetMgr.instance:setCommonSprite(var_32_1, "icon_att_" .. var_32_3.id)

	local var_32_4 = var_32_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_32_5 = var_32_0:Find("rate"):GetComponent(gohelper.Type_Image)

	if arg_32_0.isCharacter then
		gohelper.setActive(var_32_4.gameObject, true)
		gohelper.setActive(var_32_5.gameObject, false)

		var_32_4.text = arg_32_0._curAttrMO[var_0_1[arg_32_3]]
	else
		gohelper.setActive(var_32_4.gameObject, false)
		gohelper.setActive(var_32_5.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(var_32_5, "sx_" .. arg_32_2.value, true)
	end
end

function var_0_0._refreshCharacterInfo(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1:getTrialAttrCo()

	gohelper.setActive(arg_33_0._scrollplotenemypassive.gameObject, false)

	local var_33_1 = arg_33_1:getCO()

	arg_33_0:_refreshHeroEquipInfo(arg_33_1)
	UISpriteSetMgr.instance:setCommonSprite(arg_33_0._imagecareer, "lssx_" .. tostring(var_33_1.career))

	arg_33_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_33_1.level)
	arg_33_0._txtname.text = var_33_1.name

	if var_33_0 then
		arg_33_0._txtname.text = var_33_0.name
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_33_0._imagedmgtype, "dmgtype" .. tostring(var_33_1.dmgType))
	arg_33_0:_refreshCharacterPassiveSkill(arg_33_1)
	gohelper.setActive(arg_33_0._goenemypassive, false)
	gohelper.setActive(arg_33_0._noskill, false)
	gohelper.setActive(arg_33_0._skill, true)

	local var_33_2
	local var_33_3 = not PlayerModel.instance:isPlayerSelf(arg_33_1.userId)

	if tonumber(arg_33_1.uid) < 0 or var_33_3 then
		var_33_2 = arg_33_1.exSkillLevel
	end

	local var_33_4 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(var_33_1.id, nil, nil, var_33_2)

	if var_33_0 then
		var_33_4 = SkillConfig.instance:getHeroAllSkillIdDictByStr(var_33_0.activeSkill, var_33_0.uniqueSkill)
	end

	local var_33_5 = var_33_4[3][1]

	var_33_4[3] = nil

	if arg_33_1.exSkill and arg_33_1.exSkill > 0 then
		var_33_5 = arg_33_1.exSkill
	end

	if #arg_33_1.skillGroup1 > 0 then
		var_33_4[1] = LuaUtil.deepCopySimple(arg_33_1.skillGroup1)
	end

	if #arg_33_1.skillGroup2 > 0 then
		var_33_4[2] = LuaUtil.deepCopySimple(arg_33_1.skillGroup2)
	end

	arg_33_0:_refreshSuper({
		var_33_5
	})
	arg_33_0:_refreshSkill(var_33_4)
	arg_33_0:_refreshAttrList(arg_33_0:_getHeroBaseAttr(var_33_1))
	arg_33_0:refreshStress(arg_33_0._entityMO)
	arg_33_0:refreshKillLine(arg_33_0._entityMO)
	arg_33_0:refreshHealth(arg_33_0._entityMO)
end

function var_0_0._refreshHeroEquipInfo(arg_34_0, arg_34_1)
	local var_34_0
	local var_34_1

	if arg_34_1.equipRecord then
		var_34_0 = arg_34_1:getEquipMo()
	elseif tonumber(arg_34_1.uid) < 0 then
		if tonumber(arg_34_1.equipUid) > 0 then
			var_34_0 = EquipModel.instance:getEquip(arg_34_1.equipUid)
		elseif tonumber(arg_34_1.equipUid) < 0 then
			local var_34_2 = lua_equip_trial.configDict[-tonumber(arg_34_1.equipUid)]

			if var_34_2 then
				var_34_0 = EquipMO.New()

				var_34_0:initByTrialEquipCO(var_34_2)
			end
		elseif arg_34_1.trialEquip and arg_34_1.trialEquip.equipId > 0 then
			var_34_0 = EquipMO.New()

			local var_34_3 = {
				equipId = arg_34_1.trialEquip.equipId,
				equipLv = arg_34_1.trialEquip.equipLv,
				equipRefine = arg_34_1.trialEquip.refineLv
			}

			var_34_0:initByTrialCO(var_34_3)
		end
	else
		local var_34_4

		if not PlayerModel.instance:isPlayerSelf(arg_34_1.userId) then
			var_34_4 = arg_34_1.uid
		else
			local var_34_5 = arg_34_1:getCO()
			local var_34_6 = HeroModel.instance:getByHeroId(var_34_5.id)

			var_34_4 = var_34_6 and var_34_6.id
		end

		local var_34_7

		if arg_34_0._group then
			for iter_34_0, iter_34_1 in pairs(arg_34_0._group.heroList) do
				if var_34_4 and iter_34_1 == var_34_4 then
					var_34_7 = arg_34_0._group.equips[iter_34_0 - 1].equipUid[1]
					var_34_1 = iter_34_0
				end
			end
		end

		if tonumber(var_34_7) and tonumber(var_34_7) < 0 then
			local var_34_8 = lua_equip_trial.configDict[-tonumber(var_34_7)]

			if var_34_8 then
				var_34_0 = EquipMO.New()

				var_34_0:initByTrialEquipCO(var_34_8)
			end
		else
			var_34_0 = EquipModel.instance:getEquip(var_34_7)
		end
	end

	if var_34_0 and arg_34_0._balanceHelper.getIsBalanceMode() then
		local var_34_9, var_34_10, var_34_11 = arg_34_0._balanceHelper.getBalanceLv()

		if var_34_11 > var_34_0.level then
			local var_34_12 = EquipMO.New()

			var_34_12:initByConfig(nil, var_34_0.equipId, var_34_11, var_34_0.refineLv)

			var_34_0 = var_34_12
		end
	end

	if var_34_0 and var_34_1 and arg_34_0._setEquipInfo then
		local var_34_13 = arg_34_0._setEquipInfo[1]
		local var_34_14 = arg_34_0._setEquipInfo[2]

		var_34_0 = var_34_13(var_34_14, {
			posIndex = var_34_1,
			equipMO = var_34_0
		})
	end

	arg_34_0.equipMO = var_34_0

	if arg_34_0.equipMO then
		arg_34_0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_34_0.equipMO.config.icon), arg_34_0._equipIconLoaded, arg_34_0)

		arg_34_0._txtequiplv.text = string.format("Lv.%s", arg_34_0.equipMO.level)
		arg_34_0.equipClick = gohelper.getClick(arg_34_0._simageequipicon.gameObject)

		arg_34_0.equipClick:AddClickListener(arg_34_0.onEquipClick, arg_34_0)
	end

	gohelper.setActive(arg_34_0._goequip, arg_34_0.equipMO)
	gohelper.setActive(arg_34_0._goplayerequipinfo, arg_34_0.equipMO)
end

function var_0_0._equipIconLoaded(arg_35_0)
	arg_35_0._equipIconImage.enabled = true
end

function var_0_0.onEquipClick(arg_36_0)
	if arg_36_0.openEquipInfoTipView then
		return
	end

	arg_36_0:closeAllTips()
	gohelper.setActive(arg_36_0._godetailView, false)

	arg_36_0.openEquipInfoTipView = true

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = arg_36_0.equipMO,
		heroCo = arg_36_0._entityMO:getCO()
	})
end

function var_0_0._refreshAttrList(arg_37_0, arg_37_1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	arg_37_0._attrDataList = arg_37_1
	arg_37_0._curAttrMO = arg_37_0._attrEntityDic[arg_37_0._entityMO.id]

	if arg_37_0._curAttrMO then
		gohelper.CreateObjList(arg_37_0, arg_37_0._onMonsterAttrItemShow, arg_37_0._attrDataList, arg_37_0._goattributeroot)
		gohelper.setActive(arg_37_0._btnattribute.gameObject, true)
	else
		FightRpc.instance:sendEntityInfoRequest(arg_37_0._entityMO.id)
	end
end

function var_0_0._onReceiveEntityInfoReply(arg_38_0, arg_38_1)
	arg_38_0._attrEntityDic[arg_38_1.entityInfo.uid] = arg_38_1.entityInfo.attr
	arg_38_0._curAttrMO = arg_38_0._attrEntityDic[arg_38_0._entityMO.id]

	if arg_38_0._curAttrMO then
		gohelper.CreateObjList(arg_38_0, arg_38_0._onMonsterAttrItemShow, arg_38_0._attrDataList, arg_38_0._goattributeroot)
		gohelper.setActive(arg_38_0._btnattribute.gameObject, true)
	end
end

function var_0_0._getHeroBaseAttr(arg_39_0, arg_39_1)
	local var_39_0 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_39_1 = {}

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		table.insert(var_39_1, {
			id = HeroConfig.instance:getIDByAttrType(var_39_0[iter_39_0]),
			value = HeroConfig.instance:getHeroAttrRate(arg_39_1.id, iter_39_1)
		})
	end

	return var_39_1
end

function var_0_0._getMontBaseAttr(arg_40_0, arg_40_1)
	local var_40_0 = lua_monster_skill_template.configDict[arg_40_1.skillTemplate]
	local var_40_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_40_1.id)

	table.insert(var_40_1, 2, table.remove(var_40_1, 4))

	local var_40_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_40_3 = {}

	for iter_40_0, iter_40_1 in ipairs(var_40_1) do
		table.insert(var_40_3, {
			id = HeroConfig.instance:getIDByAttrType(var_40_2[iter_40_0]),
			value = iter_40_1
		})
	end

	return var_40_3
end

function var_0_0._onAttributeClick(arg_41_0)
	arg_41_0:_onAttributeClick_overseas()
end

function var_0_0._refreshPassiveSkill(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0:_releasePassiveSkillGOs()

	for iter_42_0 = 1, #arg_42_1 do
		local var_42_0 = arg_42_0._passiveSkillGOs[iter_42_0]

		if not var_42_0 then
			local var_42_1 = gohelper.cloneInPlace(arg_42_2, "item" .. iter_42_0)

			var_42_0 = arg_42_0:getUserDataTb_()
			var_42_0.go = var_42_1
			var_42_0.name = gohelper.findChildTextMesh(var_42_1, "tmp_talent")
			var_42_0.btn = gohelper.findChildButton(var_42_1, "#btn_enemypassive")

			table.insert(arg_42_0._passiveSkillGOs, var_42_0)
		end

		local var_42_2 = tonumber(arg_42_1[iter_42_0])
		local var_42_3 = lua_skill.configDict[var_42_2]

		var_42_0.btn:AddClickListener(arg_42_0._btnenemypassiveOnClick, arg_42_0)

		var_42_0.name.text = var_42_3.name

		gohelper.setActive(var_42_0.go, true)
	end

	for iter_42_1 = #arg_42_1 + 1, #arg_42_0._passiveSkillGOs do
		gohelper.setActive(arg_42_0._passiveSkillGOs[iter_42_1].go, false)
	end

	gohelper.setActive(arg_42_0._goenemypassive, #arg_42_1 > 0)

	arg_42_0._passiveSkillIds = arg_42_1

	local var_42_4 = arg_42_0._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	local var_42_5 = 80
	local var_42_6 = math.ceil(#arg_42_1 / 3)
	local var_42_7 = 200

	if var_42_6 <= 2 then
		var_42_7 = var_42_5 * var_42_6
	end

	var_42_4.minHeight = var_42_7
end

function var_0_0._refreshCharacterPassiveSkill(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1:getCO()
	local var_43_1, var_43_2 = SkillConfig.instance:getHeroExSkillLevelByLevel(var_43_0.id, arg_43_1.level)
	local var_43_3 = {}
	local var_43_4 = arg_43_0:getPassiveSkillList(arg_43_1)
	local var_43_5 = var_43_4 and var_43_4[0]

	HeroDestinyStoneMO.replaceSkillList(var_43_4, arg_43_1.destinyStone, arg_43_1.destinyRank)

	if var_43_4 and #var_43_4 > 0 then
		gohelper.setActive(arg_43_0._goplayerpassive, true)

		local var_43_6 = var_43_4[1]

		arg_43_0._txttalent.text = lua_skill.configDict[var_43_6].name

		for iter_43_0, iter_43_1 in pairs(var_43_4) do
			local var_43_7 = iter_43_0 <= var_43_1

			gohelper.setActive(arg_43_0._playerpassiveGOList[iter_43_0], var_43_7)

			if var_43_7 then
				var_43_3[iter_43_0] = FightHelper.getPassiveSkill(arg_43_1.id, iter_43_1)
			end
		end

		for iter_43_2 = #var_43_4 + 1, #arg_43_0._playerpassiveGOList do
			gohelper.setActive(arg_43_0._playerpassiveGOList[iter_43_2], false)
		end
	end

	if var_43_5 then
		gohelper.setActive(arg_43_0._playerpassiveGOList[0], true)
	else
		gohelper.setActive(arg_43_0._playerpassiveGOList[0], false)
	end

	gohelper.setActive(arg_43_0._goplayerpassive, #var_43_3 > 0 or var_43_5)

	arg_43_0._passiveSkillIds = var_43_3
end

function var_0_0.getPassiveSkillList(arg_44_0, arg_44_1)
	local var_44_0 = {}
	local var_44_1
	local var_44_2 = arg_44_1:getTrialAttrCo()

	if var_44_2 then
		var_44_1 = arg_44_1.modelId

		local var_44_3 = string.splitToNumber(var_44_2.passiveSkill, "|")

		for iter_44_0, iter_44_1 in ipairs(var_44_3) do
			table.insert(var_44_0, iter_44_1)
		end
	else
		var_44_1 = arg_44_1:getCO().id

		local var_44_4 = arg_44_1.exSkillLevel
		local var_44_5 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(var_44_1, var_44_4)

		if var_44_5[0] then
			var_44_0[0] = var_44_5[0].skillPassive
		end

		for iter_44_2, iter_44_3 in ipairs(var_44_5) do
			table.insert(var_44_0, iter_44_3.skillPassive)
		end
	end

	local var_44_6 = FightModel.instance:getFightParam()
	local var_44_7 = var_44_6 and var_44_6:getCurEpisodeConfig()

	if var_44_7 and var_44_7.type == DungeonEnum.EpisodeType.BossRush then
		local var_44_8 = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_44_7.id)

		if var_44_8 and var_44_8.enhanceRole == 1 then
			var_44_0 = arg_44_0:exchangeHeroPassiveSkill(var_44_0, var_44_1)
		end
	end

	return var_44_0
end

function var_0_0.exchangeHeroPassiveSkill(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_1 then
		return arg_45_1
	end

	if not arg_45_2 then
		return arg_45_1
	end

	for iter_45_0, iter_45_1 in ipairs(lua_activity128_enhance.configList) do
		if iter_45_1.characterId == arg_45_2 then
			local var_45_0 = FightStrUtil.splitString2(iter_45_1.exchangeSkills, true)

			if var_45_0 then
				for iter_45_2, iter_45_3 in ipairs(arg_45_1) do
					for iter_45_4, iter_45_5 in ipairs(var_45_0) do
						if iter_45_5[1] == iter_45_3 then
							arg_45_1[iter_45_2] = iter_45_5[2]
						end
					end
				end
			end

			return arg_45_1
		end
	end

	return arg_45_1
end

function var_0_0._refreshSkill(arg_46_0, arg_46_1)
	local var_46_0
	local var_46_1
	local var_46_2

	for iter_46_0 = 1, #arg_46_1 do
		if iter_46_0 > #arg_46_0._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		local var_46_3 = arg_46_0._skillGOs[iter_46_0]
		local var_46_4 = arg_46_1[iter_46_0][1]
		local var_46_5 = lua_skill.configDict[var_46_4]

		if not var_46_5 then
			logError("技能表找不到id:" .. var_46_4)

			return
		end

		var_46_3.icon:LoadImage(ResUrl.getSkillIcon(var_46_5.icon))
		var_46_3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_46_5.showTag))

		local var_46_6 = {}

		var_46_6.super = false
		var_46_6.skillIdList = arg_46_1[iter_46_0]
		var_46_6.skillIndex = iter_46_0
		var_46_3.info = var_46_6

		gohelper.setActive(var_46_3.go, true)
	end

	for iter_46_1 = #arg_46_1 + 1, #arg_46_0._skillGOs do
		gohelper.setActive(arg_46_0._skillGOs[iter_46_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_47_0, arg_47_1)
	if arg_47_1 and #arg_47_1 > 0 then
		local var_47_0
		local var_47_1
		local var_47_2

		for iter_47_0 = 1, #arg_47_1 do
			local var_47_3 = arg_47_0._superItemList[iter_47_0]

			if not var_47_3 then
				logError("技能超过支持显示数量 : " .. table.concat(arg_47_1, "|"))

				return
			end

			local var_47_4 = arg_47_1[iter_47_0]

			if var_47_4 ~= 0 then
				local var_47_5 = lua_skill.configDict[var_47_4]

				var_47_3.icon:LoadImage(ResUrl.getSkillIcon(var_47_5.icon))

				local var_47_6 = {}

				var_47_6.super = true
				var_47_6.skillIdList = {
					var_47_4
				}
				var_47_6.skillIndex = CharacterEnum.skillIndex.SkillEx
				var_47_3.info = var_47_6
			end

			gohelper.setActive(var_47_3.go, var_47_4 ~= 0)
		end
	end

	for iter_47_1 = #arg_47_1 + 1, #arg_47_0._superItemList do
		gohelper.setActive(arg_47_0._superItemList[iter_47_1].go, false)
	end
end

function var_0_0._refreshMO(arg_48_0, arg_48_1)
	arg_48_0:_refreshHp(arg_48_1)
	arg_48_0:_refreshBuff(arg_48_1)

	if arg_48_1:isMonster() then
		local var_48_0 = arg_48_1:getCO()

		if FightHelper.isBossId(arg_48_0:_getBossId(), var_48_0.id) then
			arg_48_0:_refreshEnemyPassiveSkill(var_48_0)
		else
			gohelper.setActive(arg_48_0._goenemypassiveSkill, false)
		end
	end
end

function var_0_0._refreshEnemyPassiveSkill(arg_49_0, arg_49_1)
	arg_49_0._bossSkillInfos = {}

	local var_49_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_49_1.id)
	local var_49_1 = FightConfig.instance:_filterSpeicalSkillIds(var_49_0, true)

	for iter_49_0 = 1, #var_49_1 do
		local var_49_2 = var_49_1[iter_49_0]
		local var_49_3 = lua_skill_specialbuff.configDict[var_49_2]

		if var_49_3 then
			local var_49_4 = arg_49_0._enemypassiveiconGOs[iter_49_0]

			if not var_49_4 then
				var_49_4 = arg_49_0:getUserDataTb_()
				var_49_4.go = gohelper.cloneInPlace(arg_49_0._enemypassiveSkillPrefab, "item" .. iter_49_0)
				var_49_4._gotag = gohelper.findChild(var_49_4.go, "tag")
				var_49_4._txttag = gohelper.findChildText(var_49_4.go, "tag/#txt_tag")

				table.insert(arg_49_0._enemypassiveiconGOs, var_49_4)

				local var_49_5 = gohelper.findChildImage(var_49_4.go, "icon")

				table.insert(arg_49_0._passiveiconImgs, var_49_5)
				gohelper.setActive(var_49_4.go, true)
			else
				gohelper.setActive(var_49_4.go, true)
			end

			if arg_49_0._bossSkillInfos[iter_49_0] == nil then
				arg_49_0._bossSkillInfos[iter_49_0] = {
					skillId = var_49_2,
					icon = var_49_3.icon
				}
			end

			if not string.nilorempty(var_49_3.lv) then
				gohelper.setActive(var_49_4._gotag, true)

				var_49_4._txttag.text = var_49_3.lv
			else
				gohelper.setActive(var_49_4._gotag, false)
			end

			if string.nilorempty(var_49_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_49_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_49_0._passiveiconImgs[iter_49_0], var_49_3.icon)
		end
	end

	if #var_49_1 < #arg_49_0._enemypassiveiconGOs then
		for iter_49_1 = #var_49_1 + 1, #arg_49_0._enemypassiveiconGOs do
			gohelper.setActive(arg_49_0._enemypassiveiconGOs[iter_49_1].go, false)
		end
	end

	if #arg_49_0._bossSkillInfos > 0 then
		gohelper.setActive(arg_49_0._goenemypassiveSkill, true)
	else
		gohelper.setActive(arg_49_0._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(arg_49_0._btnenemypassiveSkill.gameObject)
	arg_49_0._btnenemypassiveSkill:AddClickListener(arg_49_0._onBuffPassiveSkillClick, arg_49_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_50_0)
	if arg_50_0._isbuffviewopen then
		return
	end

	arg_50_0:closeAllTips()
	arg_50_0:_hideDetail()

	local var_50_0

	if arg_50_0._bossSkillInfos then
		for iter_50_0, iter_50_1 in pairs(arg_50_0._bossSkillInfos) do
			local var_50_1 = iter_50_1.skillId
			local var_50_2 = arg_50_0._enemybuffpassiveGOs[iter_50_0]

			if not var_50_2 then
				var_50_2 = arg_50_0:getUserDataTb_()
				var_50_2.go = gohelper.cloneInPlace(arg_50_0._gobuffpassiveitem, "item" .. iter_50_0)

				table.insert(arg_50_0._enemybuffpassiveGOs, var_50_2)

				local var_50_3 = gohelper.findChildImage(var_50_2.go, "title/simage_icon")

				table.insert(arg_50_0._passiveSkillImgs, var_50_3)
				gohelper.setActive(var_50_2.go, true)
			else
				gohelper.setActive(var_50_2.go, true)
			end

			local var_50_4 = gohelper.findChild(var_50_2.go, "txt_desc/image_line")

			gohelper.setActive(var_50_4, true)
			arg_50_0:_setPassiveSkillTip(var_50_2.go, iter_50_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_50_0._passiveSkillImgs[iter_50_0], iter_50_1.icon)
		end

		if #arg_50_0._bossSkillInfos < #arg_50_0._enemybuffpassiveGOs then
			for iter_50_2 = #arg_50_0._bossSkillInfos + 1, #arg_50_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_50_0._enemybuffpassiveGOs[iter_50_2], false)
			end
		end

		local var_50_5 = gohelper.findChild(arg_50_0._enemybuffpassiveGOs[#arg_50_0._bossSkillInfos].go, "txt_desc/image_line")

		gohelper.setActive(var_50_5, false)
		gohelper.setActive(arg_50_0._gobuffpassiveview, true)

		arg_50_0._isbuffviewopen = true
	end
end

function var_0_0._setPassiveSkillTip(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = gohelper.findChildText(arg_51_1, "title/txt_name")
	local var_51_1 = gohelper.findChildText(arg_51_1, "txt_desc")

	SkillHelper.addHyperLinkClick(var_51_1, arg_51_0.onClickHyperLink, arg_51_0)

	local var_51_2 = lua_skill.configDict[arg_51_2.skillId]

	var_51_0.text = var_51_2.name
	var_51_1.text = SkillHelper.getEntityDescBySkillCo(arg_51_0._curSelectId, var_51_2, "#CC492F", "#485E92")
end

function var_0_0.onClickPassiveHyperLink(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.commonBuffTipAnchorPos = arg_52_0.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	local var_52_0 = FightConfig.instance:getEntityName(arg_52_0._curSelectId)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_52_1, arg_52_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right, var_52_0)
end

function var_0_0._refreshHp(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_1:getLockMaxHpRate()
	local var_53_1 = math.max(arg_53_1.currentHp, 0)
	local var_53_2 = (arg_53_1.attrMO and math.max(arg_53_1.attrMO.hp, 0)) * var_53_0

	arg_53_0._txthp.text = string.format("%d/%d", var_53_1, var_53_2)

	local var_53_3 = var_53_1 / var_53_2 * var_53_0

	arg_53_0._sliderhp:SetValue(var_53_3)

	local var_53_4 = var_53_0 < 1

	gohelper.setActive(arg_53_0.reduceHpGo, var_53_4)

	if var_53_4 then
		arg_53_0.reduceHpImage.fillAmount = Mathf.Clamp01(1 - var_53_0)
	end
end

function var_0_0._refreshBuff(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_1:getBuffList()
	local var_54_1 = FightBuffHelper.filterBuffType(var_54_0, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_54_1)
	table.sort(var_54_1, function(arg_55_0, arg_55_1)
		if arg_55_0.time ~= arg_55_1.time then
			return arg_55_0.time < arg_55_1.time
		end

		return arg_55_0.id < arg_55_1.id
	end)

	local var_54_2 = var_54_1 and #var_54_1 or 0
	local var_54_3 = 0
	local var_54_4 = 0

	for iter_54_0 = 1, var_54_2 do
		local var_54_5 = var_54_1[iter_54_0]
		local var_54_6 = lua_skill_buff.configDict[var_54_5.buffId]

		if var_54_6 and var_54_6.isNoShow == 0 then
			var_54_3 = var_54_3 + 1

			local var_54_7 = arg_54_0._buffTables[var_54_3]

			if not var_54_7 then
				local var_54_8 = gohelper.cloneInPlace(arg_54_0._gobuffitem, "item" .. var_54_3)

				var_54_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_54_8, FightBuffItem)
				arg_54_0._buffTables[var_54_3] = var_54_7
			end

			var_54_7:updateBuffMO(var_54_5)
			var_54_7:setClickCallback(arg_54_0._onClickBuff, arg_54_0)
			gohelper.setActive(arg_54_0._buffTables[var_54_3].go, var_54_3 <= 6)
		end
	end

	for iter_54_1 = var_54_3 + 1, #arg_54_0._buffTables do
		gohelper.setActive(arg_54_0._buffTables[iter_54_1].go, false)
	end

	gohelper.setActive(arg_54_0._scrollbuff.gameObject, var_54_3 > 0)
	gohelper.setActive(arg_54_0._btnBuffMore, var_54_3 > 6)
end

function var_0_0._onClickBuff(arg_56_0, arg_56_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)

	arg_56_1 = arg_56_1 or arg_56_0._entityMO.id

	arg_56_0:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_56_1,
		viewname = arg_56_0.viewName
	})

	if arg_56_0._hadPopUp then
		arg_56_0:_hideDetail()

		arg_56_0._hadPopUp = false
	end
end

function var_0_0._showPassiveDetail(arg_57_0)
	arg_57_0:closeAllTips()

	if not arg_57_0._passiveSkillIds then
		return
	end

	local var_57_0 = arg_57_0._passiveSkillIds[0]

	if #arg_57_0._passiveSkillIds > 0 or var_57_0 then
		gohelper.setActive(arg_57_0._godetailView, true)
		arg_57_0:_refreshPassiveDetail()

		arg_57_0._hadPopUp = true
	end
end

function var_0_0.refreshScrollEnemy(arg_58_0)
	arg_58_0:_releaseHeadItemList()

	arg_58_0.enemyItemList = {}

	gohelper.setActive(arg_58_0.goScrollEnemy, true)

	local var_58_0

	for iter_58_0, iter_58_1 in ipairs(arg_58_0._entityList) do
		local var_58_1 = arg_58_0.enemyItemList[iter_58_0] or arg_58_0:createEnemyItem()

		gohelper.setActive(var_58_1.go, true)

		var_58_1.entityMo = iter_58_1

		local var_58_2 = iter_58_1:getCO()

		if var_58_2 then
			UISpriteSetMgr.instance:setEnemyInfoSprite(var_58_1.imageCareer, "sxy_" .. tostring(var_58_2.career))
		end

		local var_58_3 = arg_58_0:getHeadIcon(iter_58_1)

		gohelper.getSingleImage(var_58_1.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_58_3))

		if var_58_2 and var_58_2.heartVariantId and var_58_2.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_58_2.heartVariantId), var_58_1.imageIcon)
		end

		gohelper.setActive(var_58_1.goBossTag, arg_58_0.bossIdDict[var_58_2.id])

		if iter_58_1.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(var_58_1.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(var_58_1.imageIcon.transform, 0, 0, 0)
		end

		local var_58_4 = FightHelper.getSurvivalEntityHealth(iter_58_1.id)

		gohelper.setActive(var_58_1.healthGo, var_58_4 ~= nil)

		if var_58_4 then
			local var_58_5 = FightNameUIHealthComp.getHealthIcon(var_58_4)

			UISpriteSetMgr.instance:setFightSprite(var_58_1.healthTag, var_58_5, true)
		end
	end

	for iter_58_2 = #arg_58_0._entityList + 1, #arg_58_0.enemyItemList do
		gohelper.setActive(arg_58_0.enemyItemList[iter_58_2].go, false)
	end
end

function var_0_0.getHeadIcon(arg_59_0, arg_59_1)
	if not arg_59_1 then
		return
	end

	local var_59_0 = arg_59_1.modelId
	local var_59_1 = lua_fight_sp_500m_model.configDict[var_59_0]

	if var_59_1 then
		return var_59_1.headIconName
	end

	return arg_59_1:getSpineSkinCO().headIcon
end

function var_0_0.refreshScrollEnemySelectStatus(arg_60_0)
	if arg_60_0.enemyItemList then
		for iter_60_0, iter_60_1 in ipairs(arg_60_0.enemyItemList) do
			local var_60_0 = arg_60_0._entityMO.uid == iter_60_1.entityMo.uid

			gohelper.setActive(iter_60_1.goSelectFrame, var_60_0)

			local var_60_1 = arg_60_0._entityMO.uid == iter_60_1.entityMo.uid and "#ffffff" or "#8C8C8C"
			local var_60_2 = arg_60_0._entityMO.uid == iter_60_1.entityMo.uid and "#ffffff" or "#828282"

			SLFramework.UGUI.GuiHelper.SetColor(iter_60_1.imageIcon, var_60_1)
			SLFramework.UGUI.GuiHelper.SetColor(iter_60_1.imageCareer, var_60_2)

			if var_60_0 then
				local var_60_3 = -106 - 193 * (iter_60_0 - 1) + recthelper.getAnchorY(arg_60_0.goScrollEnemyContent.transform) + arg_60_0._entityScrollHeight / 2
				local var_60_4 = recthelper.getHeight(iter_60_1.go.transform)
				local var_60_5 = var_60_3 - var_60_4
				local var_60_6 = var_60_3 + var_60_4
				local var_60_7 = arg_60_0._entityScrollHeight / 2

				if var_60_5 < -var_60_7 then
					local var_60_8 = var_60_5 + var_60_7

					recthelper.setAnchorY(arg_60_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_60_0.goScrollEnemyContent.transform) - var_60_8 - 54)
				end

				if var_60_7 < var_60_6 then
					local var_60_9 = var_60_6 - var_60_7

					recthelper.setAnchorY(arg_60_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_60_0.goScrollEnemyContent.transform) - var_60_9 + 54)
				end
			end

			gohelper.setActive(iter_60_1.subTag, FightDataHelper.entityMgr:isSub(iter_60_1.entityMo.uid))
		end
	end
end

function var_0_0.createEnemyItem(arg_61_0)
	local var_61_0 = arg_61_0:getUserDataTb_()

	var_61_0.go = gohelper.cloneInPlace(arg_61_0.contentEnemyItem)
	var_61_0.imageIcon = gohelper.findChildImage(var_61_0.go, "item/icon")
	var_61_0.goBossTag = gohelper.findChild(var_61_0.go, "item/bosstag")
	var_61_0.imageCareer = gohelper.findChildImage(var_61_0.go, "item/career")
	var_61_0.healthTag = gohelper.findChildImage(var_61_0.go, "item/healthTag")
	var_61_0.healthGo = var_61_0.healthTag.gameObject
	var_61_0.goSelectFrame = gohelper.findChild(var_61_0.go, "item/go_selectframe")
	var_61_0.subTag = gohelper.findChild(var_61_0.go, "item/#go_SubTag")
	var_61_0.btnClick = gohelper.findChildButtonWithAudio(var_61_0.go, "item/btn_click")

	var_61_0.btnClick:AddClickListener(arg_61_0.onClickEnemyItem, arg_61_0, var_61_0)
	gohelper.setActive(var_61_0.healthGo, false)
	table.insert(arg_61_0.enemyItemList, var_61_0)

	return var_61_0
end

function var_0_0.onClickEnemyItem(arg_62_0, arg_62_1)
	if arg_62_1.entityMo.uid == arg_62_0._entityMO.uid then
		return
	end

	arg_62_0._curSelectId = arg_62_1.entityMo.id

	arg_62_0:closeAllTips()
	arg_62_0:_refreshUI()
	arg_62_0._ani:Play("switch", nil, nil)
end

function var_0_0.closeAllTips(arg_63_0)
	arg_63_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_63_0._godetailView, false)
	gohelper.setActive(arg_63_0._gobuffpassiveview, false)

	arg_63_0._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	arg_63_0.openEquipInfoTipView = false
	arg_63_0.openFightAttributeTipView = false
end

function var_0_0._showSkillDetail(arg_64_0, arg_64_1)
	arg_64_0:closeAllTips()
	arg_64_0.viewContainer:showSkillTipView(arg_64_1, arg_64_0.isCharacter, arg_64_0._curSelectId)

	arg_64_0._hadPopUp = true
end

function var_0_0._hideDetail(arg_65_0)
	arg_65_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_65_0._godetailView, false)
	gohelper.setActive(arg_65_0._gobuffpassiveview, false)

	arg_65_0._isbuffviewopen = false
end

function var_0_0._refreshPassiveDetail(arg_66_0)
	local var_66_0 = {}

	if arg_66_0._passiveSkillIds[0] then
		table.insert(var_66_0, arg_66_0._passiveSkillIds[0])
	end

	for iter_66_0 = 1, #arg_66_0._passiveSkillIds do
		table.insert(var_66_0, arg_66_0._passiveSkillIds[iter_66_0])
	end

	local var_66_1 = #var_66_0
	local var_66_2 = arg_66_0:_checkReplaceSkill(var_66_0)

	for iter_66_1 = 1, var_66_1 do
		local var_66_3 = tonumber(var_66_2[iter_66_1])
		local var_66_4 = lua_skill.configDict[var_66_3]

		if var_66_4 then
			local var_66_5 = arg_66_0._detailPassiveTables[iter_66_1]

			if not var_66_5 then
				local var_66_6 = gohelper.cloneInPlace(arg_66_0._godetailpassiveitem, "item" .. iter_66_1)

				var_66_5 = arg_66_0:getUserDataTb_()
				var_66_5.go = var_66_6
				var_66_5.name = gohelper.findChildText(var_66_6, "title/txt_name")
				var_66_5.icon = gohelper.findChildSingleImage(var_66_6, "title/simage_icon")
				var_66_5.desc = gohelper.findChildText(var_66_6, "txt_desc")

				SkillHelper.addHyperLinkClick(var_66_5.desc, arg_66_0.onClickHyperLink, arg_66_0)

				var_66_5.line = gohelper.findChild(var_66_6, "txt_desc/image_line")

				table.insert(arg_66_0._detailPassiveTables, var_66_5)
			end

			var_66_5.name.text = var_66_4.name

			local var_66_7 = SkillHelper.getEntityDescBySkillCo(arg_66_0._curSelectId, var_66_4, "#CC492F", "#485E92")

			var_66_5.desc.text = var_66_7

			var_66_5.desc:GetPreferredValues()
			gohelper.setActive(var_66_5.go, true)
			gohelper.setActive(var_66_5.line, iter_66_1 < var_66_1)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_66_3))
		end
	end

	for iter_66_2 = var_66_1 + 1, #arg_66_0._detailPassiveTables do
		gohelper.setActive(arg_66_0._detailPassiveTables[iter_66_2].go, false)
	end
end

function var_0_0._checkReplaceSkill(arg_67_0, arg_67_1)
	if arg_67_1 and arg_67_0._entityMO then
		arg_67_1 = arg_67_0._entityMO:checkReplaceSkill(arg_67_1)
	end

	return arg_67_1
end

function var_0_0.onClickHyperLink(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0.commonBuffTipAnchorPos = arg_68_0.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	local var_68_0 = FightConfig.instance:getEntityName(arg_68_0._curSelectId)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_68_1, arg_68_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right, var_68_0)
end

function var_0_0._detectBossMultiHp(arg_69_0, arg_69_1)
	local var_69_0 = BossRushModel.instance:getBossEntityMO()

	arg_69_0._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and var_69_0 and var_69_0.id == arg_69_1.id

	local var_69_1 = arg_69_1.attrMO.multiHpNum

	if arg_69_0._isBossRush then
		var_69_1 = BossRushModel.instance:getMultiHpInfo().multiHpNum
	end

	gohelper.setActive(arg_69_0._multiHpRoot, var_69_1 > 1)

	if var_69_1 > 1 then
		arg_69_0:com_createObjList(arg_69_0._onMultiHpItemShow, var_69_1, arg_69_0._multiHpRoot, arg_69_0._multiHpItem)
	end
end

function var_0_0._onMultiHpItemShow(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = arg_70_0._entityMO.attrMO.multiHpNum
	local var_70_1 = arg_70_0._entityMO.attrMO:getCurMultiHpIndex()

	if arg_70_0._isBossRush then
		local var_70_2 = BossRushModel.instance:getMultiHpInfo()

		var_70_0 = var_70_2.multiHpNum
		var_70_1 = var_70_2.multiHpIdx
	end

	local var_70_3 = gohelper.findChild(arg_70_1, "hp")

	gohelper.setActive(var_70_3, arg_70_3 <= var_70_0 - var_70_1)

	if arg_70_3 == 1 and arg_70_0._isBossRush then
		gohelper.setActive(var_70_3, true)
	end
end

function var_0_0._onCloseView(arg_71_0, arg_71_1)
	if arg_71_1 == ViewName.EquipInfoTipsView then
		arg_71_0.openEquipInfoTipView = false
	end

	if arg_71_1 == ViewName.FightAttributeTipView then
		arg_71_0.openFightAttributeTipView = false
	end
end

function var_0_0.onClose(arg_72_0)
	gohelper.setActive(arg_72_0.odysseySuitRoot, false)
	TaskDispatcher.cancelTask(arg_72_0._refreshUI, arg_72_0)
	arg_72_0:_releaseTween()

	if arg_72_0._focusFlow then
		arg_72_0._focusFlow:stop()

		arg_72_0._focusFlow = nil
	end

	if arg_72_0.subEntityList then
		for iter_72_0, iter_72_1 in ipairs(arg_72_0.subEntityList) do
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(iter_72_1:getTag(), iter_72_1.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
	arg_72_0:setAssistBossStatus(false, true)
end

function var_0_0.onDestroyView(arg_73_0)
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	arg_73_0._simagebg:UnLoadImage()

	for iter_73_0 = 1, #arg_73_0._skillGOs do
		local var_73_0 = arg_73_0._skillGOs[iter_73_0]

		var_73_0.icon:UnLoadImage()
		var_73_0.btn:RemoveClickListener()
	end

	for iter_73_1, iter_73_2 in ipairs(arg_73_0._superItemList) do
		iter_73_2.icon:UnLoadImage()
		iter_73_2.btn:RemoveClickListener()
	end

	arg_73_0._superItemList = nil

	arg_73_0._simageequipicon:UnLoadImage()

	if arg_73_0.equipClick then
		arg_73_0.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_73_0._onCloseView, arg_73_0)
	arg_73_0:_releaseHeadItemList()
	arg_73_0.resistanceComp:destroy()

	arg_73_0.resistanceComp = nil

	arg_73_0:removeStressComp()

	if arg_73_0.killLineComp then
		arg_73_0.killLineComp:destroy()

		arg_73_0.killLineComp = nil
	end

	if arg_73_0._assistBossView then
		arg_73_0._assistBossView:destory()

		arg_73_0._assistBossView = nil
	end
end

function var_0_0.removeStressComp(arg_74_0)
	if arg_74_0.stressComp then
		arg_74_0.stressComp:destroy()

		arg_74_0.stressComp = nil
	end
end

function var_0_0._releaseHeadItemList(arg_75_0)
	if arg_75_0.enemyItemList then
		for iter_75_0, iter_75_1 in ipairs(arg_75_0.enemyItemList) do
			iter_75_1.btnClick:RemoveClickListener()
			gohelper.destroy(iter_75_1.go)
		end

		arg_75_0.enemyItemList = nil
	end
end

function var_0_0._setVirtualCameDamping(arg_76_0)
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function var_0_0._setEntityPosAndActive(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_1.id
	local var_77_1 = false
	local var_77_2 = FightHelper.getEntity(var_77_0)

	if var_77_2 then
		local var_77_3 = var_77_2:getMO()

		if var_77_3 then
			local var_77_4 = FightConfig.instance:getSkinCO(var_77_3.skin)

			if var_77_4 and var_77_4.canHide == 1 then
				var_77_1 = true
			end
		end
	end

	local var_77_5 = FightHelper.getAllEntitys()

	for iter_77_0, iter_77_1 in ipairs(var_77_5) do
		if not FightHelper.isAssembledMonster(iter_77_1) then
			iter_77_1:setVisibleByPos(var_77_1 or var_77_0 == iter_77_1.id)
		elseif arg_77_1.side ~= iter_77_1:getSide() then
			iter_77_1:setVisibleByPos(var_77_1 or var_77_0 == iter_77_1.id)
		else
			iter_77_1:setVisibleByPos(true)
		end

		if iter_77_1.buff then
			if var_77_0 ~= iter_77_1.id then
				iter_77_1.buff:hideBuffEffects()
			else
				iter_77_1.buff:showBuffEffects()
			end
		end

		if iter_77_1.nameUI then
			iter_77_1.nameUI:setActive(var_77_0 == iter_77_1.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	local var_77_6

	if arg_77_1.side == FightEnum.EntitySide.MySide then
		local var_77_7 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
		local var_77_8 = FightHelper.getEntityStanceId(arg_77_1, FightModel.instance:getCurWaveId())
		local var_77_9 = lua_stance.configDict[var_77_8].pos1

		var_77_6 = var_77_9

		for iter_77_2, iter_77_3 in ipairs(var_77_7) do
			if iter_77_3.id == arg_77_1.id then
				transformhelper.setLocalPos(iter_77_3.go.transform, var_77_9[1], var_77_9[2], var_77_9[3])

				if iter_77_3.buff then
					iter_77_3.buff:hideBuffEffects()
					iter_77_3.buff:showBuffEffects()
				end
			else
				iter_77_3:setVisibleByPos(false)
			end
		end

		for iter_77_4, iter_77_5 in ipairs(arg_77_0.subEntityList) do
			transformhelper.setLocalPos(iter_77_5.go.transform, 20000, 20000, 20000)
		end
	end

	local var_77_10 = FightHelper.getEntity(var_77_0)
	local var_77_11 = FightDataHelper.entityMgr:isSub(var_77_0)

	if var_77_11 then
		var_77_10 = nil

		for iter_77_6, iter_77_7 in ipairs(arg_77_0.subEntityList) do
			if iter_77_7.id == var_77_0 .. "focusSub" then
				local var_77_12 = FightHelper.getEntity(var_77_0)

				if var_77_12 then
					var_77_12:setVisibleByPos(false)
				end

				var_77_10 = iter_77_7

				transformhelper.setLocalPos(iter_77_7.go.transform, var_77_6[1], var_77_6[2], var_77_6[3])
			end
		end
	end

	if var_77_10 then
		local var_77_13 = var_77_10:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
		local var_77_14, var_77_15, var_77_16 = transformhelper.getPos(var_77_13.transform)
		local var_77_17 = var_77_14 + 2.7
		local var_77_18 = var_77_15 - 2
		local var_77_19 = var_77_16 + 5.4
		local var_77_20

		if var_77_11 then
			var_77_20 = FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(var_77_0).skin)
		else
			var_77_20 = FightConfig.instance:getSkinCO(var_77_10:getMO().skin)
		end

		local var_77_21 = var_77_20.focusOffset

		if #var_77_21 == 3 then
			var_77_17 = var_77_17 + var_77_21[1]
			var_77_18 = var_77_18 + var_77_21[2]
			var_77_19 = var_77_19 + var_77_21[3]
		end

		arg_77_0:_releaseTween()

		local var_77_22 = CameraMgr.instance:getVirtualCameraTrs()

		transformhelper.setPos(var_77_22, var_77_17 + 0.2, var_77_18, var_77_19)
	end
end

function var_0_0._releaseTween(arg_78_0)
	if arg_78_0._tweenId then
		ZProj.TweenHelper.KillById(arg_78_0._tweenId)
	end
end

function var_0_0._playCameraTween(arg_79_0)
	local var_79_0 = CameraMgr.instance:getVirtualCameraTrs()
	local var_79_1, var_79_2, var_79_3 = transformhelper.getPos(var_79_0)

	arg_79_0._tweenId = ZProj.TweenHelper.DOMove(var_79_0, var_79_1 - 0.6, var_79_2, var_79_3, 0.5)
end

function var_0_0._focusEntity(arg_80_0, arg_80_1)
	if arg_80_0._focusFlow then
		arg_80_0._focusFlow:stop()

		arg_80_0._focusFlow = nil
	end

	arg_80_0._focusFlow = FlowSequence.New()

	arg_80_0._focusFlow:addWork(FunctionWork.New(arg_80_0._setVirtualCameDamping, arg_80_0))
	arg_80_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_80_0._focusFlow:addWork(FightWorkFocusSubEntity.New(arg_80_1))
	arg_80_0._focusFlow:addWork(FunctionWork.New(arg_80_0._setEntityPosAndActive, arg_80_0, arg_80_1))
	arg_80_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_80_0._focusFlow:addWork(FunctionWork.New(arg_80_0._playCameraTween, arg_80_0))
	arg_80_0._focusFlow:addWork(WorkWaitSeconds.New(0.5))

	local var_80_0 = {
		subEntityList = arg_80_0.subEntityList
	}

	arg_80_0._focusFlow:start(var_80_0)
end

function var_0_0._onBtnBuffMore(arg_81_0)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_81_0._curSelectId,
		viewname = arg_81_0.viewName
	})
end

function var_0_0.refreshDouQuQuFetter(arg_82_0)
	local var_82_0 = FightDataHelper.fieldMgr.customData

	if not var_82_0 then
		return
	end

	if var_82_0[FightCustomData.CustomDataType.Act191] then
		if arg_82_0.douQuQuFetterView then
			arg_82_0.douQuQuFetterView:refreshEntityMO(arg_82_0._entityMO)
		else
			arg_82_0.douQuQuFetterView = arg_82_0:com_openSubView(FightDouQuQuFetterView, "ui/viewres/fight/fight_act191fetterview.prefab", arg_82_0.go_fetter, arg_82_0._entityMO)
		end
	end
end

function var_0_0.refreshDouQuQuStar(arg_83_0)
	local var_83_0 = FightDataHelper.fieldMgr.customData

	if not var_83_0 then
		return
	end

	if var_83_0[FightCustomData.CustomDataType.Act191] then
		gohelper.setActive(arg_83_0.levelRoot, false)
	end
end

function var_0_0.refreshDouQuQuCollection(arg_84_0)
	local var_84_0 = FightDataHelper.fieldMgr.customData

	if not var_84_0 then
		return
	end

	if var_84_0[FightCustomData.CustomDataType.Act191] then
		gohelper.setActive(arg_84_0.go_collection, true)

		if arg_84_0.douQuQuCollectionView then
			arg_84_0.douQuQuCollectionView:refreshEntityMO(arg_84_0._entityMO)
		else
			arg_84_0.douQuQuCollectionView = arg_84_0:com_openSubView(FightDouQuQuCollectionView, "ui/viewres/fight/fight_act191collectionview.prefab", arg_84_0.go_collection, arg_84_0._entityMO)
		end
	end
end

function var_0_0.showOdysseyEquip(arg_85_0)
	local var_85_0 = FightDataHelper.fieldMgr.customData

	if not var_85_0 then
		return
	end

	var_85_0 = var_85_0[FightCustomData.CustomDataType.Odyssey] or var_85_0[FightCustomData.CustomDataType.Act128Sp]

	if var_85_0 then
		gohelper.setActive(arg_85_0.go_collection, true)

		if arg_85_0.odysseyEquipView then
			arg_85_0.odysseyEquipView:refreshEntityMO(arg_85_0._entityMO)
		else
			arg_85_0.odysseyEquipView = arg_85_0:com_openSubView(FightFocusOdysseyEquipView, "ui/viewres/fight/fight_odysseycollectionview.prefab", arg_85_0.go_collection, arg_85_0._entityMO)
		end
	end
end

function var_0_0.showOdysseyEquipSuit(arg_86_0)
	local var_86_0 = FightDataHelper.fieldMgr.customData

	if not var_86_0 then
		return
	end

	var_86_0 = var_86_0[FightCustomData.CustomDataType.Odyssey] or var_86_0[FightCustomData.CustomDataType.Act128Sp]

	if var_86_0 then
		gohelper.setActive(arg_86_0.go_collection, true)

		if arg_86_0.odysseyEquipSuitView then
			arg_86_0.odysseyEquipSuitView:refreshEntityMO(arg_86_0._entityMO)
		else
			arg_86_0.odysseyEquipSuitView = arg_86_0:com_openSubView(FightFocusOdysseyEquipSuitView, "ui/viewres/fight/fight_odysseysuitview.prefab", arg_86_0.odysseySuitRoot, arg_86_0._entityMO)
		end
	end
end

function var_0_0.showAiJiAoExPointSlider(arg_87_0)
	if arg_87_0._entityMO.exPointType == FightEnum.ExPointType.Synchronization then
		gohelper.setActive(arg_87_0.aiJiAoSliderRoot, true)

		if arg_87_0.aiJiAoExPointSliderView then
			arg_87_0.aiJiAoExPointSliderView:refreshEntityMO(arg_87_0._entityMO)
		else
			arg_87_0.aiJiAoExPointSliderView = arg_87_0:com_openSubView(FightFocusAiJiAoExPointSliderView, "ui/viewres/fight/fightaijiaoenergysliderview.prefab", arg_87_0.aiJiAoSliderRoot, arg_87_0._entityMO)
		end
	else
		gohelper.setActive(arg_87_0.aiJiAoSliderRoot, false)
	end
end

function var_0_0.showAlert(arg_88_0)
	gohelper.setActive(arg_88_0.alertRoot, false)

	local var_88_0 = arg_88_0._entityMO._powerInfos

	if var_88_0 then
		for iter_88_0, iter_88_1 in pairs(var_88_0) do
			if iter_88_0 == FightEnum.PowerType.Alert then
				gohelper.setActive(arg_88_0.alertRoot, true)

				if arg_88_0.alertView then
					arg_88_0.alertView:refreshData(arg_88_0._entityMO.id, iter_88_1)
				else
					local var_88_1 = "ui/viewres/fight/fightalertview.prefab"

					arg_88_0.alertView = arg_88_0:com_openSubView(FightNamePowerInfoView6, var_88_1, arg_88_0.alertRoot, arg_88_0._entityMO.id, iter_88_1, true)
				end
			end
		end
	end
end

var_0_0.HealthInterval = -50

function var_0_0.onClickHealth(arg_89_0)
	local var_89_0 = arg_89_0._entityMO and FightHelper.getSurvivalEntityHealth(arg_89_0._entityMO.id)

	if not var_89_0 then
		return
	end

	local var_89_1 = FightNameUIHealthComp.getCurHealthStatus(var_89_0)
	local var_89_2 = FightNameUIHealthComp.getHealthTitle(var_89_1)
	local var_89_3 = FightNameUIHealthComp.getHealthDesc(var_89_1)
	local var_89_4 = recthelper.getWidth(arg_89_0.rectSurvivalHealth)
	local var_89_5 = recthelper.getHeight(arg_89_0.rectSurvivalHealth)
	local var_89_6 = recthelper.uiPosToScreenPos(arg_89_0.rectSurvivalHealth)

	var_89_6.x = var_89_6.x + var_89_4 / 2 + var_0_0.HealthInterval
	var_89_6.y = var_89_6.y + var_89_5 / 2

	FightCommonTipController.instance:openCommonView(var_89_2, var_89_3, var_89_6)
end

function var_0_0.refreshHealth(arg_90_0, arg_90_1)
	local var_90_0 = arg_90_1 and FightHelper.getSurvivalEntityHealth(arg_90_1.id)

	if not var_90_0 then
		gohelper.setActive(arg_90_0.goSurvivalHealth, false)

		return
	end

	gohelper.setActive(arg_90_0.goSurvivalHealth, true)

	arg_90_0.txtHealth.text = string.format("%d/%d", var_90_0, FightHelper.getSurvivalMaxHealth() or 120)

	local var_90_1 = FightNameUIHealthComp.getHealthIcon(var_90_0)

	UISpriteSetMgr.instance:setFightSprite(arg_90_0.imageHealth, var_90_1, true)
end

return var_0_0
