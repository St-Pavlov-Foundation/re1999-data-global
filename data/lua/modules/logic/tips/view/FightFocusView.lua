module("modules.logic.tips.view.FightFocusView", package.seeall)

local var_0_0 = class("FightFocusView", BaseViewExtended)

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
	arg_3_0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_3_0._onReceiveEntityInfoReply, arg_3_0)
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

	arg_14_0._txttalent = gohelper.findChildTextMesh(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/talent/tmp_talent")
	arg_14_0._txttalent.overflowMode = TMPro.TextOverflowModes.Ellipsis
	arg_14_0._gosuperitem = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_superitem")
	arg_14_0._goskillitem = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_skillitem")

	gohelper.setActive(arg_14_0._gosuperitem, false)
	gohelper.setActive(arg_14_0._goskillitem, false)

	arg_14_0._superItemList = {}

	local var_14_1

	for iter_14_1 = 1, 3 do
		local var_14_2 = arg_14_0:createSuperItem()

		table.insert(arg_14_0._superItemList, var_14_2)
	end

	arg_14_0._skillGOs = {}

	local var_14_3

	for iter_14_2 = 1, 3 do
		local var_14_4 = arg_14_0:createSkillItem()

		table.insert(arg_14_0._skillGOs, var_14_4)
	end

	arg_14_0._godetailcontent = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content")
	arg_14_0._gobg = gohelper.findChild(arg_14_0.viewGO, "fightinfocontainer/#go_detailView/bg")
	arg_14_0._onCloseNeedResetCamera = true
	arg_14_0._hadPopUp = false
	arg_14_0.openEquipInfoTipView = false
	arg_14_0.openFightAttributeTipView = false

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_14_0._onCloseView, arg_14_0)

	local var_14_5 = DungeonModel.instance.curSendChapterId

	if var_14_5 then
		local var_14_6 = DungeonConfig.instance:getChapterCO(var_14_5)

		arg_14_0.isSimple = var_14_6 and var_14_6.type == DungeonEnum.ChapterType.Simple
	end

	arg_14_0.resistanceComp = FightEntityResistanceComp.New(arg_14_0._goresistance, arg_14_0.viewContainer)

	arg_14_0.resistanceComp:onInitView()

	arg_14_0.stressComp = FightFocusStressComp.New()

	arg_14_0.stressComp:init(arg_14_0._gostress)
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
	arg_26_0.stressComp:refreshStress(arg_26_0._entityMO)
	gohelper.setActive(arg_26_0._goplayerequipinfo, false)
end

function var_0_0._refreshResistance(arg_27_0)
	if arg_27_0.isCharacter then
		arg_27_0.resistanceComp:refresh(nil)

		return
	end

	local var_27_0 = arg_27_0._entityMO:getResistanceDict()

	arg_27_0.resistanceComp:refresh(var_27_0)
end

function var_0_0._getBossId(arg_28_0)
	local var_28_0 = FightModel.instance:getCurMonsterGroupId()
	local var_28_1 = var_28_0 and lua_monster_group.configDict[var_28_0]

	return var_28_1 and not string.nilorempty(var_28_1.bossId) and var_28_1.bossId or nil
end

local var_0_1 = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function var_0_0._onMonsterAttrItemShow(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1.transform
	local var_29_1 = var_29_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_29_2 = var_29_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_29_3 = HeroConfig.instance:getHeroAttributeCO(arg_29_2.id)

	if SLFramework.UGUI.GuiHelper.GetPreferredWidth(var_29_2, var_29_3.name) > recthelper.getWidth(var_29_2.transform) then
		var_29_2.overflowMode = TMPro.TextOverflowModes.Ellipsis
		arg_29_0._canClickAttribute = true
	end

	var_29_2.text = var_29_3.name

	UISpriteSetMgr.instance:setCommonSprite(var_29_1, "icon_att_" .. var_29_3.id)

	local var_29_4 = var_29_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_29_5 = var_29_0:Find("rate"):GetComponent(gohelper.Type_Image)

	if arg_29_0.isCharacter then
		gohelper.setActive(var_29_4.gameObject, true)
		gohelper.setActive(var_29_5.gameObject, false)

		var_29_4.text = arg_29_0._curAttrMO[var_0_1[arg_29_3]]
	else
		gohelper.setActive(var_29_4.gameObject, false)
		gohelper.setActive(var_29_5.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(var_29_5, "sx_" .. arg_29_2.value, true)
	end
end

function var_0_0._refreshCharacterInfo(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1:getTrialAttrCo()

	gohelper.setActive(arg_30_0._scrollplotenemypassive.gameObject, false)

	local var_30_1 = arg_30_1:getCO()

	arg_30_0:_refreshHeroEquipInfo(arg_30_1)
	UISpriteSetMgr.instance:setCommonSprite(arg_30_0._imagecareer, "lssx_" .. tostring(var_30_1.career))

	arg_30_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_30_1.level)
	arg_30_0._txtname.text = var_30_1.name

	if var_30_0 then
		arg_30_0._txtname.text = var_30_0.name
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_30_0._imagedmgtype, "dmgtype" .. tostring(var_30_1.dmgType))
	arg_30_0:_refreshCharacterPassiveSkill(arg_30_1)
	gohelper.setActive(arg_30_0._goenemypassive, false)
	gohelper.setActive(arg_30_0._noskill, false)
	gohelper.setActive(arg_30_0._skill, true)

	local var_30_2
	local var_30_3 = not PlayerModel.instance:isPlayerSelf(arg_30_1.userId)

	if tonumber(arg_30_1.uid) < 0 or var_30_3 then
		var_30_2 = arg_30_1.exSkillLevel
	end

	local var_30_4 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(var_30_1.id, nil, nil, var_30_2)

	if var_30_0 then
		var_30_4 = SkillConfig.instance:getHeroAllSkillIdDictByStr(var_30_0.activeSkill, var_30_0.uniqueSkill)
	end

	local var_30_5 = var_30_4[3][1]

	var_30_4[3] = nil

	if arg_30_1.exSkill and arg_30_1.exSkill > 0 then
		var_30_5 = arg_30_1.exSkill
	end

	if #arg_30_1.skillGroup1 > 0 then
		var_30_4[1] = LuaUtil.deepCopySimple(arg_30_1.skillGroup1)
	end

	if #arg_30_1.skillGroup2 > 0 then
		var_30_4[2] = LuaUtil.deepCopySimple(arg_30_1.skillGroup2)
	end

	arg_30_0:_refreshSuper({
		var_30_5
	})
	arg_30_0:_refreshSkill(var_30_4)
	arg_30_0:_refreshAttrList(arg_30_0:_getHeroBaseAttr(var_30_1))
	arg_30_0.stressComp:refreshStress(arg_30_0._entityMO)
end

function var_0_0._refreshHeroEquipInfo(arg_31_0, arg_31_1)
	local var_31_0
	local var_31_1

	if tonumber(arg_31_1.uid) < 0 then
		if tonumber(arg_31_1.equipUid) > 0 then
			var_31_0 = EquipModel.instance:getEquip(arg_31_1.equipUid)
		elseif tonumber(arg_31_1.equipUid) < 0 then
			local var_31_2 = lua_equip_trial.configDict[-tonumber(arg_31_1.equipUid)]

			if var_31_2 then
				var_31_0 = EquipMO.New()

				var_31_0:initByTrialEquipCO(var_31_2)
			end
		elseif arg_31_1.trialEquip and arg_31_1.trialEquip.equipId > 0 then
			var_31_0 = EquipMO.New()

			local var_31_3 = {
				equipId = arg_31_1.trialEquip.equipId,
				equipLv = arg_31_1.trialEquip.equipLv,
				equipRefine = arg_31_1.trialEquip.refineLv
			}

			var_31_0:initByTrialCO(var_31_3)
		end
	else
		local var_31_4

		if not PlayerModel.instance:isPlayerSelf(arg_31_1.userId) then
			var_31_4 = arg_31_1.uid
		else
			local var_31_5 = arg_31_1:getCO()
			local var_31_6 = HeroModel.instance:getByHeroId(var_31_5.id)

			var_31_4 = var_31_6 and var_31_6.id
		end

		local var_31_7

		if arg_31_0._group then
			for iter_31_0, iter_31_1 in pairs(arg_31_0._group.heroList) do
				if var_31_4 and iter_31_1 == var_31_4 then
					var_31_7 = arg_31_0._group.equips[iter_31_0 - 1].equipUid[1]
					var_31_1 = iter_31_0
				end
			end
		end

		if tonumber(var_31_7) and tonumber(var_31_7) < 0 then
			local var_31_8 = lua_equip_trial.configDict[-tonumber(var_31_7)]

			if var_31_8 then
				var_31_0 = EquipMO.New()

				var_31_0:initByTrialEquipCO(var_31_8)
			end
		else
			var_31_0 = EquipModel.instance:getEquip(var_31_7)
		end
	end

	if var_31_0 and arg_31_0._balanceHelper.getIsBalanceMode() then
		local var_31_9, var_31_10, var_31_11 = arg_31_0._balanceHelper.getBalanceLv()

		if var_31_11 > var_31_0.level then
			local var_31_12 = EquipMO.New()

			var_31_12:initByConfig(nil, var_31_0.equipId, var_31_11, var_31_0.refineLv)

			var_31_0 = var_31_12
		end
	end

	if var_31_0 and var_31_1 and arg_31_0._setEquipInfo then
		local var_31_13 = arg_31_0._setEquipInfo[1]
		local var_31_14 = arg_31_0._setEquipInfo[2]

		var_31_0 = var_31_13(var_31_14, {
			posIndex = var_31_1,
			equipMO = var_31_0
		})
	end

	arg_31_0.equipMO = var_31_0

	if arg_31_0.equipMO then
		arg_31_0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_31_0.equipMO.config.icon), arg_31_0._equipIconLoaded, arg_31_0)

		arg_31_0._txtequiplv.text = string.format("Lv.%s", arg_31_0.equipMO.level)
		arg_31_0.equipClick = gohelper.getClick(arg_31_0._simageequipicon.gameObject)

		arg_31_0.equipClick:AddClickListener(arg_31_0.onEquipClick, arg_31_0)
	end

	gohelper.setActive(arg_31_0._goequip, arg_31_0.equipMO)
	gohelper.setActive(arg_31_0._goplayerequipinfo, arg_31_0.equipMO)
end

function var_0_0._equipIconLoaded(arg_32_0)
	arg_32_0._equipIconImage.enabled = true
end

function var_0_0.onEquipClick(arg_33_0)
	if arg_33_0.openEquipInfoTipView then
		return
	end

	arg_33_0:closeAllTips()
	gohelper.setActive(arg_33_0._godetailView, false)

	arg_33_0.openEquipInfoTipView = true

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = arg_33_0.equipMO,
		heroCo = arg_33_0._entityMO:getCO()
	})
end

function var_0_0._refreshAttrList(arg_34_0, arg_34_1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	arg_34_0._attrDataList = arg_34_1
	arg_34_0._curAttrMO = arg_34_0._attrEntityDic[arg_34_0._entityMO.id]

	if arg_34_0._curAttrMO then
		gohelper.CreateObjList(arg_34_0, arg_34_0._onMonsterAttrItemShow, arg_34_0._attrDataList, arg_34_0._goattributeroot)
		gohelper.setActive(arg_34_0._btnattribute.gameObject, true)
	else
		FightRpc.instance:sendEntityInfoRequest(arg_34_0._entityMO.id)
	end
end

function var_0_0._onReceiveEntityInfoReply(arg_35_0, arg_35_1)
	arg_35_0._attrEntityDic[arg_35_1.entityInfo.uid] = arg_35_1.entityInfo.attr
	arg_35_0._curAttrMO = arg_35_0._attrEntityDic[arg_35_0._entityMO.id]

	if arg_35_0._curAttrMO then
		gohelper.CreateObjList(arg_35_0, arg_35_0._onMonsterAttrItemShow, arg_35_0._attrDataList, arg_35_0._goattributeroot)
		gohelper.setActive(arg_35_0._btnattribute.gameObject, true)
	end
end

function var_0_0._getHeroBaseAttr(arg_36_0, arg_36_1)
	local var_36_0 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_36_1 = {}

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		table.insert(var_36_1, {
			id = HeroConfig.instance:getIDByAttrType(var_36_0[iter_36_0]),
			value = HeroConfig.instance:getHeroAttrRate(arg_36_1.id, iter_36_1)
		})
	end

	return var_36_1
end

function var_0_0._getMontBaseAttr(arg_37_0, arg_37_1)
	local var_37_0 = lua_monster_skill_template.configDict[arg_37_1.skillTemplate]
	local var_37_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_37_1.id)

	table.insert(var_37_1, 2, table.remove(var_37_1, 4))

	local var_37_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_37_3 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_1) do
		table.insert(var_37_3, {
			id = HeroConfig.instance:getIDByAttrType(var_37_2[iter_37_0]),
			value = iter_37_1
		})
	end

	return var_37_3
end

function var_0_0._onAttributeClick(arg_38_0)
	arg_38_0:_onAttributeClick_overseas()
end

function var_0_0._refreshPassiveSkill(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:_releasePassiveSkillGOs()

	for iter_39_0 = 1, #arg_39_1 do
		local var_39_0 = arg_39_0._passiveSkillGOs[iter_39_0]

		if not var_39_0 then
			local var_39_1 = gohelper.cloneInPlace(arg_39_2, "item" .. iter_39_0)

			var_39_0 = arg_39_0:getUserDataTb_()
			var_39_0.go = var_39_1
			var_39_0.name = gohelper.findChildTextMesh(var_39_1, "tmp_talent")
			var_39_0.btn = gohelper.findChildButton(var_39_1, "#btn_enemypassive")

			table.insert(arg_39_0._passiveSkillGOs, var_39_0)
		end

		local var_39_2 = tonumber(arg_39_1[iter_39_0])
		local var_39_3 = lua_skill.configDict[var_39_2]

		var_39_0.btn:AddClickListener(arg_39_0._btnenemypassiveOnClick, arg_39_0)

		var_39_0.name.text = var_39_3.name

		gohelper.setActive(var_39_0.go, true)
	end

	for iter_39_1 = #arg_39_1 + 1, #arg_39_0._passiveSkillGOs do
		gohelper.setActive(arg_39_0._passiveSkillGOs[iter_39_1].go, false)
	end

	gohelper.setActive(arg_39_0._goenemypassive, #arg_39_1 > 0)

	arg_39_0._passiveSkillIds = arg_39_1

	local var_39_4 = arg_39_0._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	local var_39_5 = 80
	local var_39_6 = math.ceil(#arg_39_1 / 3)
	local var_39_7 = 200

	if var_39_6 <= 2 then
		var_39_7 = var_39_5 * var_39_6
	end

	var_39_4.minHeight = var_39_7
end

function var_0_0._refreshCharacterPassiveSkill(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1:getCO()
	local var_40_1, var_40_2 = SkillConfig.instance:getHeroExSkillLevelByLevel(var_40_0.id, arg_40_1.level)
	local var_40_3 = {}
	local var_40_4 = arg_40_0:getPassiveSkillList(arg_40_1)

	if var_40_4 and #var_40_4 > 0 then
		gohelper.setActive(arg_40_0._goplayerpassive, true)

		local var_40_5 = var_40_4[1]

		arg_40_0._txttalent.text = lua_skill.configDict[var_40_5].name

		for iter_40_0 = 1, #var_40_4 do
			local var_40_6 = iter_40_0 <= var_40_1

			gohelper.setActive(arg_40_0._playerpassiveGOList[iter_40_0], var_40_6)

			if var_40_6 then
				table.insert(var_40_3, FightHelper.getPassiveSkill(arg_40_1.id, var_40_4[iter_40_0]))
			end
		end

		for iter_40_1 = #var_40_4 + 1, #arg_40_0._playerpassiveGOList do
			gohelper.setActive(arg_40_0._playerpassiveGOList[iter_40_1], false)
		end
	end

	gohelper.setActive(arg_40_0._goplayerpassive, #var_40_3 > 0)

	arg_40_0._passiveSkillIds = var_40_3
end

function var_0_0.getPassiveSkillList(arg_41_0, arg_41_1)
	local var_41_0 = {}
	local var_41_1
	local var_41_2 = arg_41_1:getTrialAttrCo()

	if var_41_2 then
		var_41_1 = arg_41_1.modelId

		local var_41_3 = string.splitToNumber(var_41_2.passiveSkill, "|")

		for iter_41_0, iter_41_1 in ipairs(var_41_3) do
			table.insert(var_41_0, iter_41_1)
		end
	else
		var_41_1 = arg_41_1:getCO().id

		local var_41_4 = arg_41_1.exSkillLevel
		local var_41_5 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(var_41_1, var_41_4)

		for iter_41_2, iter_41_3 in ipairs(var_41_5) do
			table.insert(var_41_0, iter_41_3.skillPassive)
		end
	end

	local var_41_6 = FightModel.instance:getFightParam()
	local var_41_7 = var_41_6 and var_41_6:getCurEpisodeConfig()

	if var_41_7 and var_41_7.type == DungeonEnum.EpisodeType.BossRush then
		local var_41_8 = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_41_7.id)

		if var_41_8 and var_41_8.enhanceRole == 1 then
			var_41_0 = arg_41_0:exchangeHeroPassiveSkill(var_41_0, var_41_1)
		end
	end

	return var_41_0
end

function var_0_0.exchangeHeroPassiveSkill(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_1 then
		return arg_42_1
	end

	if not arg_42_2 then
		return arg_42_1
	end

	for iter_42_0, iter_42_1 in ipairs(lua_activity128_enhance.configList) do
		if iter_42_1.characterId == arg_42_2 then
			local var_42_0 = FightStrUtil.splitString2(iter_42_1.exchangeSkills, true)

			if var_42_0 then
				for iter_42_2, iter_42_3 in ipairs(arg_42_1) do
					for iter_42_4, iter_42_5 in ipairs(var_42_0) do
						if iter_42_5[1] == iter_42_3 then
							arg_42_1[iter_42_2] = iter_42_5[2]
						end
					end
				end
			end

			return arg_42_1
		end
	end

	return arg_42_1
end

function var_0_0._refreshSkill(arg_43_0, arg_43_1)
	local var_43_0
	local var_43_1
	local var_43_2

	for iter_43_0 = 1, #arg_43_1 do
		if iter_43_0 > #arg_43_0._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		local var_43_3 = arg_43_0._skillGOs[iter_43_0]
		local var_43_4 = arg_43_1[iter_43_0][1]
		local var_43_5 = lua_skill.configDict[var_43_4]

		if not var_43_5 then
			logError("技能表找不到id:" .. var_43_4)

			return
		end

		var_43_3.icon:LoadImage(ResUrl.getSkillIcon(var_43_5.icon))
		var_43_3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_43_5.showTag))

		local var_43_6 = {}

		var_43_6.super = false
		var_43_6.skillIdList = arg_43_1[iter_43_0]
		var_43_6.skillIndex = iter_43_0
		var_43_3.info = var_43_6

		gohelper.setActive(var_43_3.go, true)
	end

	for iter_43_1 = #arg_43_1 + 1, #arg_43_0._skillGOs do
		gohelper.setActive(arg_43_0._skillGOs[iter_43_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_44_0, arg_44_1)
	if arg_44_1 and #arg_44_1 > 0 then
		local var_44_0
		local var_44_1
		local var_44_2

		for iter_44_0 = 1, #arg_44_1 do
			local var_44_3 = arg_44_0._superItemList[iter_44_0]

			if not var_44_3 then
				logError("技能超过支持显示数量 : " .. table.concat(arg_44_1, "|"))

				return
			end

			gohelper.setActive(var_44_3.go, true)

			local var_44_4 = arg_44_1[iter_44_0]
			local var_44_5 = lua_skill.configDict[var_44_4]

			var_44_3.icon:LoadImage(ResUrl.getSkillIcon(var_44_5.icon))

			local var_44_6 = {}

			var_44_6.super = true
			var_44_6.skillIdList = {
				var_44_4
			}
			var_44_6.skillIndex = CharacterEnum.skillIndex.SkillEx
			var_44_3.info = var_44_6
		end
	end

	for iter_44_1 = #arg_44_1 + 1, #arg_44_0._superItemList do
		gohelper.setActive(arg_44_0._superItemList[iter_44_1].go, false)
	end
end

function var_0_0._refreshMO(arg_45_0, arg_45_1)
	arg_45_0:_refreshHp(arg_45_1)
	arg_45_0:_refreshBuff(arg_45_1)

	if arg_45_1:isMonster() then
		local var_45_0 = arg_45_1:getCO()

		if FightHelper.isBossId(arg_45_0:_getBossId(), var_45_0.id) then
			arg_45_0:_refreshEnemyPassiveSkill(var_45_0)
		else
			gohelper.setActive(arg_45_0._goenemypassiveSkill, false)
		end
	end
end

function var_0_0._refreshEnemyPassiveSkill(arg_46_0, arg_46_1)
	arg_46_0._bossSkillInfos = {}

	local var_46_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_46_1.id)
	local var_46_1 = FightConfig.instance:_filterSpeicalSkillIds(var_46_0, true)

	for iter_46_0 = 1, #var_46_1 do
		local var_46_2 = var_46_1[iter_46_0]
		local var_46_3 = lua_skill_specialbuff.configDict[var_46_2]

		if var_46_3 then
			local var_46_4 = arg_46_0._enemypassiveiconGOs[iter_46_0]

			if not var_46_4 then
				var_46_4 = arg_46_0:getUserDataTb_()
				var_46_4.go = gohelper.cloneInPlace(arg_46_0._enemypassiveSkillPrefab, "item" .. iter_46_0)
				var_46_4._gotag = gohelper.findChild(var_46_4.go, "tag")
				var_46_4._txttag = gohelper.findChildText(var_46_4.go, "tag/#txt_tag")

				table.insert(arg_46_0._enemypassiveiconGOs, var_46_4)

				local var_46_5 = gohelper.findChildImage(var_46_4.go, "icon")

				table.insert(arg_46_0._passiveiconImgs, var_46_5)
				gohelper.setActive(var_46_4.go, true)
			else
				gohelper.setActive(var_46_4.go, true)
			end

			if arg_46_0._bossSkillInfos[iter_46_0] == nil then
				arg_46_0._bossSkillInfos[iter_46_0] = {
					skillId = var_46_2,
					icon = var_46_3.icon
				}
			end

			if not string.nilorempty(var_46_3.lv) then
				gohelper.setActive(var_46_4._gotag, true)

				var_46_4._txttag.text = var_46_3.lv
			else
				gohelper.setActive(var_46_4._gotag, false)
			end

			if string.nilorempty(var_46_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_46_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_46_0._passiveiconImgs[iter_46_0], var_46_3.icon)
		end
	end

	if #var_46_1 < #arg_46_0._enemypassiveiconGOs then
		for iter_46_1 = #var_46_1 + 1, #arg_46_0._enemypassiveiconGOs do
			gohelper.setActive(arg_46_0._enemypassiveiconGOs[iter_46_1].go, false)
		end
	end

	if #arg_46_0._bossSkillInfos > 0 then
		gohelper.setActive(arg_46_0._goenemypassiveSkill, true)
	else
		gohelper.setActive(arg_46_0._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(arg_46_0._btnenemypassiveSkill.gameObject)
	arg_46_0._btnenemypassiveSkill:AddClickListener(arg_46_0._onBuffPassiveSkillClick, arg_46_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_47_0)
	if arg_47_0._isbuffviewopen then
		return
	end

	arg_47_0:closeAllTips()
	arg_47_0:_hideDetail()

	local var_47_0

	if arg_47_0._bossSkillInfos then
		for iter_47_0, iter_47_1 in pairs(arg_47_0._bossSkillInfos) do
			local var_47_1 = iter_47_1.skillId
			local var_47_2 = arg_47_0._enemybuffpassiveGOs[iter_47_0]

			if not var_47_2 then
				var_47_2 = arg_47_0:getUserDataTb_()
				var_47_2.go = gohelper.cloneInPlace(arg_47_0._gobuffpassiveitem, "item" .. iter_47_0)

				table.insert(arg_47_0._enemybuffpassiveGOs, var_47_2)

				local var_47_3 = gohelper.findChildImage(var_47_2.go, "title/simage_icon")

				table.insert(arg_47_0._passiveSkillImgs, var_47_3)
				gohelper.setActive(var_47_2.go, true)
			else
				gohelper.setActive(var_47_2.go, true)
			end

			local var_47_4 = gohelper.findChild(var_47_2.go, "txt_desc/image_line")

			gohelper.setActive(var_47_4, true)
			arg_47_0:_setPassiveSkillTip(var_47_2.go, iter_47_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_47_0._passiveSkillImgs[iter_47_0], iter_47_1.icon)
		end

		if #arg_47_0._bossSkillInfos < #arg_47_0._enemybuffpassiveGOs then
			for iter_47_2 = #arg_47_0._bossSkillInfos + 1, #arg_47_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_47_0._enemybuffpassiveGOs[iter_47_2], false)
			end
		end

		local var_47_5 = gohelper.findChild(arg_47_0._enemybuffpassiveGOs[#arg_47_0._bossSkillInfos].go, "txt_desc/image_line")

		gohelper.setActive(var_47_5, false)
		gohelper.setActive(arg_47_0._gobuffpassiveview, true)

		arg_47_0._isbuffviewopen = true
	end
end

function var_0_0._setPassiveSkillTip(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = gohelper.findChildText(arg_48_1, "title/txt_name")
	local var_48_1 = gohelper.findChildText(arg_48_1, "txt_desc")

	SkillHelper.addHyperLinkClick(var_48_1, arg_48_0.onClickHyperLink, arg_48_0)

	local var_48_2 = lua_skill.configDict[arg_48_2.skillId]

	var_48_0.text = var_48_2.name
	var_48_1.text = SkillHelper.getEntityDescBySkillCo(arg_48_0._curSelectId, var_48_2, "#CC492F", "#485E92")
end

function var_0_0.onClickPassiveHyperLink(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0.commonBuffTipAnchorPos = arg_49_0.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_49_1, arg_49_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._refreshHp(arg_50_0, arg_50_1)
	local var_50_0 = math.max(arg_50_1.currentHp, 0)
	local var_50_1 = arg_50_1.attrMO and math.max(arg_50_1.attrMO.hp, 0)
	local var_50_2 = var_50_1 > 0 and var_50_0 / var_50_1 or 0

	arg_50_0._txthp.text = string.format("%d/%d", var_50_0, var_50_1)

	arg_50_0._sliderhp:SetValue(var_50_2)
end

function var_0_0._refreshBuff(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1:getBuffList()
	local var_51_1 = FightBuffHelper.filterBuffType(var_51_0, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_51_1)
	table.sort(var_51_1, function(arg_52_0, arg_52_1)
		if arg_52_0.time ~= arg_52_1.time then
			return arg_52_0.time < arg_52_1.time
		end

		return arg_52_0.id < arg_52_1.id
	end)

	local var_51_2 = var_51_1 and #var_51_1 or 0
	local var_51_3 = 0
	local var_51_4 = 0

	for iter_51_0 = 1, var_51_2 do
		local var_51_5 = var_51_1[iter_51_0]
		local var_51_6 = lua_skill_buff.configDict[var_51_5.buffId]

		if var_51_6 and var_51_6.isNoShow == 0 then
			var_51_3 = var_51_3 + 1

			local var_51_7 = arg_51_0._buffTables[var_51_3]

			if not var_51_7 then
				local var_51_8 = gohelper.cloneInPlace(arg_51_0._gobuffitem, "item" .. var_51_3)

				var_51_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_51_8, FightBuffItem)
				arg_51_0._buffTables[var_51_3] = var_51_7
			end

			var_51_7:updateBuffMO(var_51_5)
			var_51_7:setClickCallback(arg_51_0._onClickBuff, arg_51_0)
			gohelper.setActive(arg_51_0._buffTables[var_51_3].go, var_51_3 <= 6)
		end
	end

	for iter_51_1 = var_51_3 + 1, #arg_51_0._buffTables do
		gohelper.setActive(arg_51_0._buffTables[iter_51_1].go, false)
	end

	gohelper.setActive(arg_51_0._scrollbuff.gameObject, var_51_3 > 0)
	gohelper.setActive(arg_51_0._btnBuffMore, var_51_3 > 6)
end

function var_0_0._onClickBuff(arg_53_0, arg_53_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)

	arg_53_1 = arg_53_1 or arg_53_0._entityMO.id

	arg_53_0:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_53_1,
		viewname = arg_53_0.viewName
	})

	if arg_53_0._hadPopUp then
		arg_53_0:_hideDetail()

		arg_53_0._hadPopUp = false
	end
end

function var_0_0._showPassiveDetail(arg_54_0)
	arg_54_0:closeAllTips()

	if arg_54_0._passiveSkillIds and #arg_54_0._passiveSkillIds > 0 then
		gohelper.setActive(arg_54_0._godetailView, true)
		arg_54_0:_refreshPassiveDetail()

		arg_54_0._hadPopUp = true
	end
end

function var_0_0.refreshScrollEnemy(arg_55_0)
	arg_55_0:_releaseHeadItemList()

	arg_55_0.enemyItemList = {}

	gohelper.setActive(arg_55_0.goScrollEnemy, true)

	local var_55_0

	for iter_55_0, iter_55_1 in ipairs(arg_55_0._entityList) do
		local var_55_1 = arg_55_0.enemyItemList[iter_55_0] or arg_55_0:createEnemyItem()

		gohelper.setActive(var_55_1.go, true)

		var_55_1.entityMo = iter_55_1

		local var_55_2 = iter_55_1:getCO()
		local var_55_3 = iter_55_1:getSpineSkinCO()

		gohelper.getSingleImage(var_55_1.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_55_3.headIcon))
		UISpriteSetMgr.instance:setEnemyInfoSprite(var_55_1.imageCareer, "sxy_" .. tostring(var_55_2.career))

		if var_55_2.heartVariantId and var_55_2.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_55_2.heartVariantId), var_55_1.imageIcon)
		end

		gohelper.setActive(var_55_1.goBossTag, arg_55_0.bossIdDict[var_55_2.id])

		if iter_55_1.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(var_55_1.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(var_55_1.imageIcon.transform, 0, 0, 0)
		end
	end

	for iter_55_2 = #arg_55_0._entityList + 1, #arg_55_0.enemyItemList do
		gohelper.setActive(arg_55_0.enemyItemList[iter_55_2].go, false)
	end
end

function var_0_0.refreshScrollEnemySelectStatus(arg_56_0)
	if arg_56_0.enemyItemList then
		for iter_56_0, iter_56_1 in ipairs(arg_56_0.enemyItemList) do
			local var_56_0 = arg_56_0._entityMO.uid == iter_56_1.entityMo.uid

			gohelper.setActive(iter_56_1.goSelectFrame, var_56_0)

			local var_56_1 = arg_56_0._entityMO.uid == iter_56_1.entityMo.uid and "#ffffff" or "#8C8C8C"
			local var_56_2 = arg_56_0._entityMO.uid == iter_56_1.entityMo.uid and "#ffffff" or "#828282"

			SLFramework.UGUI.GuiHelper.SetColor(iter_56_1.imageIcon, var_56_1)
			SLFramework.UGUI.GuiHelper.SetColor(iter_56_1.imageCareer, var_56_2)

			if var_56_0 then
				local var_56_3 = -106 - 193 * (iter_56_0 - 1) + recthelper.getAnchorY(arg_56_0.goScrollEnemyContent.transform) + arg_56_0._entityScrollHeight / 2
				local var_56_4 = recthelper.getHeight(iter_56_1.go.transform)
				local var_56_5 = var_56_3 - var_56_4
				local var_56_6 = var_56_3 + var_56_4
				local var_56_7 = arg_56_0._entityScrollHeight / 2

				if var_56_5 < -var_56_7 then
					local var_56_8 = var_56_5 + var_56_7

					recthelper.setAnchorY(arg_56_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_56_0.goScrollEnemyContent.transform) - var_56_8 - 54)
				end

				if var_56_7 < var_56_6 then
					local var_56_9 = var_56_6 - var_56_7

					recthelper.setAnchorY(arg_56_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_56_0.goScrollEnemyContent.transform) - var_56_9 + 54)
				end
			end

			gohelper.setActive(iter_56_1.subTag, FightDataHelper.entityMgr:isSub(iter_56_1.entityMo.uid))
		end
	end
end

function var_0_0.createEnemyItem(arg_57_0)
	local var_57_0 = arg_57_0:getUserDataTb_()

	var_57_0.go = gohelper.cloneInPlace(arg_57_0.contentEnemyItem)
	var_57_0.imageIcon = gohelper.findChildImage(var_57_0.go, "item/icon")
	var_57_0.goBossTag = gohelper.findChild(var_57_0.go, "item/bosstag")
	var_57_0.imageCareer = gohelper.findChildImage(var_57_0.go, "item/career")
	var_57_0.goSelectFrame = gohelper.findChild(var_57_0.go, "item/go_selectframe")
	var_57_0.subTag = gohelper.findChild(var_57_0.go, "item/#go_SubTag")
	var_57_0.btnClick = gohelper.findChildButtonWithAudio(var_57_0.go, "item/btn_click")

	var_57_0.btnClick:AddClickListener(arg_57_0.onClickEnemyItem, arg_57_0, var_57_0)
	table.insert(arg_57_0.enemyItemList, var_57_0)

	return var_57_0
end

function var_0_0.onClickEnemyItem(arg_58_0, arg_58_1)
	if arg_58_1.entityMo.uid == arg_58_0._entityMO.uid then
		return
	end

	arg_58_0._curSelectId = arg_58_1.entityMo.id

	arg_58_0:closeAllTips()
	arg_58_0:_refreshUI()
	arg_58_0._ani:Play("switch", nil, nil)
end

function var_0_0.closeAllTips(arg_59_0)
	arg_59_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_59_0._godetailView, false)
	gohelper.setActive(arg_59_0._gobuffpassiveview, false)

	arg_59_0._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	arg_59_0.openEquipInfoTipView = false
	arg_59_0.openFightAttributeTipView = false
end

function var_0_0._showSkillDetail(arg_60_0, arg_60_1)
	arg_60_0:closeAllTips()
	arg_60_0.viewContainer:showSkillTipView(arg_60_1, arg_60_0.isCharacter, arg_60_0._curSelectId)

	arg_60_0._hadPopUp = true
end

function var_0_0._hideDetail(arg_61_0)
	arg_61_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_61_0._godetailView, false)
	gohelper.setActive(arg_61_0._gobuffpassiveview, false)

	arg_61_0._isbuffviewopen = false
end

function var_0_0._refreshPassiveDetail(arg_62_0)
	local var_62_0 = arg_62_0._passiveSkillIds
	local var_62_1 = #var_62_0
	local var_62_2 = arg_62_0:_checkDestinyEffect(var_62_0)

	for iter_62_0 = 1, var_62_1 do
		local var_62_3 = tonumber(var_62_2[iter_62_0])
		local var_62_4 = lua_skill.configDict[var_62_3]

		if var_62_4 then
			local var_62_5 = arg_62_0._detailPassiveTables[iter_62_0]

			if not var_62_5 then
				local var_62_6 = gohelper.cloneInPlace(arg_62_0._godetailpassiveitem, "item" .. iter_62_0)

				var_62_5 = arg_62_0:getUserDataTb_()
				var_62_5.go = var_62_6
				var_62_5.name = gohelper.findChildText(var_62_6, "title/txt_name")
				var_62_5.icon = gohelper.findChildSingleImage(var_62_6, "title/simage_icon")
				var_62_5.desc = gohelper.findChildText(var_62_6, "txt_desc")

				SkillHelper.addHyperLinkClick(var_62_5.desc, arg_62_0.onClickHyperLink, arg_62_0)

				var_62_5.line = gohelper.findChild(var_62_6, "txt_desc/image_line")

				table.insert(arg_62_0._detailPassiveTables, var_62_5)
			end

			var_62_5.name.text = var_62_4.name

			local var_62_7 = SkillHelper.getEntityDescBySkillCo(arg_62_0._curSelectId, var_62_4, "#CC492F", "#485E92")

			var_62_5.desc.text = var_62_7

			var_62_5.desc:GetPreferredValues()
			gohelper.setActive(var_62_5.go, true)
			gohelper.setActive(var_62_5.line, iter_62_0 < var_62_1)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_62_3))
		end
	end

	for iter_62_1 = var_62_1 + 1, #arg_62_0._detailPassiveTables do
		gohelper.setActive(arg_62_0._detailPassiveTables[iter_62_1].go, false)
	end
end

function var_0_0._checkDestinyEffect(arg_63_0, arg_63_1)
	if arg_63_1 and arg_63_0._entityMO then
		local var_63_0 = arg_63_0._entityMO:getCO()
		local var_63_1 = HeroModel.instance:getByHeroId(var_63_0.id)

		if var_63_1 and var_63_1.destinyStoneMo then
			arg_63_1 = var_63_1.destinyStoneMo:_replaceSkill(arg_63_1)
		end
	end

	return arg_63_1
end

function var_0_0.onClickHyperLink(arg_64_0, arg_64_1, arg_64_2)
	arg_64_0.commonBuffTipAnchorPos = arg_64_0.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_64_1, arg_64_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._detectBossMultiHp(arg_65_0, arg_65_1)
	local var_65_0 = BossRushModel.instance:getBossEntityMO()

	arg_65_0._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and var_65_0 and var_65_0.id == arg_65_1.id

	local var_65_1 = arg_65_1.attrMO.multiHpNum

	if arg_65_0._isBossRush then
		var_65_1 = BossRushModel.instance:getMultiHpInfo().multiHpNum
	end

	gohelper.setActive(arg_65_0._multiHpRoot, var_65_1 > 1)

	if var_65_1 > 1 then
		arg_65_0:com_createObjList(arg_65_0._onMultiHpItemShow, var_65_1, arg_65_0._multiHpRoot, arg_65_0._multiHpItem)
	end
end

function var_0_0._onMultiHpItemShow(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = arg_66_0._entityMO.attrMO.multiHpNum
	local var_66_1 = arg_66_0._entityMO.attrMO:getCurMultiHpIndex()

	if arg_66_0._isBossRush then
		local var_66_2 = BossRushModel.instance:getMultiHpInfo()

		var_66_0 = var_66_2.multiHpNum
		var_66_1 = var_66_2.multiHpIdx
	end

	local var_66_3 = gohelper.findChild(arg_66_1, "hp")

	gohelper.setActive(var_66_3, arg_66_3 <= var_66_0 - var_66_1)

	if arg_66_3 == 1 and arg_66_0._isBossRush then
		gohelper.setActive(var_66_3, true)
	end
end

function var_0_0._onCloseView(arg_67_0, arg_67_1)
	if arg_67_1 == ViewName.EquipInfoTipsView then
		arg_67_0.openEquipInfoTipView = false
	end

	if arg_67_1 == ViewName.FightAttributeTipView then
		arg_67_0.openFightAttributeTipView = false
	end
end

function var_0_0.onClose(arg_68_0)
	TaskDispatcher.cancelTask(arg_68_0._refreshUI, arg_68_0)
	arg_68_0:_releaseTween()

	if arg_68_0._focusFlow then
		arg_68_0._focusFlow:stop()

		arg_68_0._focusFlow = nil
	end

	if arg_68_0.subEntityList then
		for iter_68_0, iter_68_1 in ipairs(arg_68_0.subEntityList) do
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(iter_68_1:getTag(), iter_68_1.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
	arg_68_0:setAssistBossStatus(false, true)
end

function var_0_0.onDestroyView(arg_69_0)
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	arg_69_0._simagebg:UnLoadImage()

	for iter_69_0 = 1, #arg_69_0._skillGOs do
		local var_69_0 = arg_69_0._skillGOs[iter_69_0]

		var_69_0.icon:UnLoadImage()
		var_69_0.btn:RemoveClickListener()
	end

	for iter_69_1, iter_69_2 in ipairs(arg_69_0._superItemList) do
		iter_69_2.icon:UnLoadImage()
		iter_69_2.btn:RemoveClickListener()
	end

	arg_69_0._superItemList = nil

	arg_69_0._simageequipicon:UnLoadImage()

	if arg_69_0.equipClick then
		arg_69_0.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_69_0._onCloseView, arg_69_0)
	arg_69_0:_releaseHeadItemList()
	arg_69_0.resistanceComp:destroy()

	arg_69_0.resistanceComp = nil

	arg_69_0.stressComp:destroy()

	arg_69_0.stressComp = nil

	if arg_69_0._assistBossView then
		arg_69_0._assistBossView:destory()

		arg_69_0._assistBossView = nil
	end

	arg_69_0:__onDispose()
end

function var_0_0._releaseHeadItemList(arg_70_0)
	if arg_70_0.enemyItemList then
		for iter_70_0, iter_70_1 in ipairs(arg_70_0.enemyItemList) do
			iter_70_1.btnClick:RemoveClickListener()
			gohelper.destroy(iter_70_1.go)
		end

		arg_70_0.enemyItemList = nil
	end
end

function var_0_0._setVirtualCameDamping(arg_71_0)
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function var_0_0._setEntityPosAndActive(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_1.id
	local var_72_1 = false
	local var_72_2 = FightHelper.getEntity(var_72_0)

	if var_72_2 then
		local var_72_3 = var_72_2:getMO()

		if var_72_3 then
			local var_72_4 = FightConfig.instance:getSkinCO(var_72_3.skin)

			if var_72_4 and var_72_4.canHide == 1 then
				var_72_1 = true
			end
		end
	end

	local var_72_5 = FightHelper.getAllEntitys()

	for iter_72_0, iter_72_1 in ipairs(var_72_5) do
		if not FightHelper.isAssembledMonster(iter_72_1) then
			iter_72_1:setVisibleByPos(var_72_1 or var_72_0 == iter_72_1.id)
		elseif arg_72_1.side ~= iter_72_1:getSide() then
			iter_72_1:setVisibleByPos(var_72_1 or var_72_0 == iter_72_1.id)
		else
			iter_72_1:setVisibleByPos(true)
		end

		if iter_72_1.buff then
			if var_72_0 ~= iter_72_1.id then
				iter_72_1.buff:hideBuffEffects()
			else
				iter_72_1.buff:showBuffEffects()
			end
		end

		if iter_72_1.nameUI then
			iter_72_1.nameUI:setActive(var_72_0 == iter_72_1.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	local var_72_6

	if arg_72_1.side == FightEnum.EntitySide.MySide then
		local var_72_7 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
		local var_72_8 = FightHelper.getEntityStanceId(arg_72_1, FightModel.instance:getCurWaveId())
		local var_72_9 = lua_stance.configDict[var_72_8].pos1

		var_72_6 = var_72_9

		for iter_72_2, iter_72_3 in ipairs(var_72_7) do
			if iter_72_3.id == arg_72_1.id then
				transformhelper.setLocalPos(iter_72_3.go.transform, var_72_9[1], var_72_9[2], var_72_9[3])

				if iter_72_3.buff then
					iter_72_3.buff:hideBuffEffects()
					iter_72_3.buff:showBuffEffects()
				end
			else
				iter_72_3:setVisibleByPos(false)
			end
		end

		for iter_72_4, iter_72_5 in ipairs(arg_72_0.subEntityList) do
			transformhelper.setLocalPos(iter_72_5.go.transform, 20000, 20000, 20000)
		end
	end

	local var_72_10 = FightHelper.getEntity(var_72_0)
	local var_72_11 = FightDataHelper.entityMgr:isSub(var_72_0)

	if var_72_11 then
		var_72_10 = nil

		for iter_72_6, iter_72_7 in ipairs(arg_72_0.subEntityList) do
			if iter_72_7.id == var_72_0 .. "focusSub" then
				local var_72_12 = FightHelper.getEntity(var_72_0)

				if var_72_12 then
					var_72_12:setVisibleByPos(false)
				end

				var_72_10 = iter_72_7

				transformhelper.setLocalPos(iter_72_7.go.transform, var_72_6[1], var_72_6[2], var_72_6[3])
			end
		end
	end

	if var_72_10 then
		local var_72_13 = var_72_10:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
		local var_72_14, var_72_15, var_72_16 = transformhelper.getPos(var_72_13.transform)
		local var_72_17 = var_72_14 + 2.7
		local var_72_18 = var_72_15 - 2
		local var_72_19 = var_72_16 + 5.4
		local var_72_20

		if var_72_11 then
			var_72_20 = FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(var_72_0).skin)
		else
			var_72_20 = FightConfig.instance:getSkinCO(var_72_10:getMO().skin)
		end

		local var_72_21 = var_72_20.focusOffset

		if #var_72_21 == 3 then
			var_72_17 = var_72_17 + var_72_21[1]
			var_72_18 = var_72_18 + var_72_21[2]
			var_72_19 = var_72_19 + var_72_21[3]
		end

		arg_72_0:_releaseTween()

		local var_72_22 = CameraMgr.instance:getVirtualCameraTrs()

		transformhelper.setPos(var_72_22, var_72_17 + 0.2, var_72_18, var_72_19)
	end
end

function var_0_0._releaseTween(arg_73_0)
	if arg_73_0._tweenId then
		ZProj.TweenHelper.KillById(arg_73_0._tweenId)
	end
end

function var_0_0._playCameraTween(arg_74_0)
	local var_74_0 = CameraMgr.instance:getVirtualCameraTrs()
	local var_74_1, var_74_2, var_74_3 = transformhelper.getPos(var_74_0)

	arg_74_0._tweenId = ZProj.TweenHelper.DOMove(var_74_0, var_74_1 - 0.6, var_74_2, var_74_3, 0.5)
end

function var_0_0._focusEntity(arg_75_0, arg_75_1)
	if arg_75_0._focusFlow then
		arg_75_0._focusFlow:stop()

		arg_75_0._focusFlow = nil
	end

	arg_75_0._focusFlow = FlowSequence.New()

	arg_75_0._focusFlow:addWork(FunctionWork.New(arg_75_0._setVirtualCameDamping, arg_75_0))
	arg_75_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_75_0._focusFlow:addWork(FightWorkFocusSubEntity.New(arg_75_1))
	arg_75_0._focusFlow:addWork(FunctionWork.New(arg_75_0._setEntityPosAndActive, arg_75_0, arg_75_1))
	arg_75_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_75_0._focusFlow:addWork(FunctionWork.New(arg_75_0._playCameraTween, arg_75_0))
	arg_75_0._focusFlow:addWork(WorkWaitSeconds.New(0.5))

	local var_75_0 = {
		subEntityList = arg_75_0.subEntityList
	}

	arg_75_0._focusFlow:start(var_75_0)
end

function var_0_0._onBtnBuffMore(arg_76_0)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, {
		entityId = arg_76_0._curSelectId,
		viewname = arg_76_0.viewName
	})
end

return var_0_0
