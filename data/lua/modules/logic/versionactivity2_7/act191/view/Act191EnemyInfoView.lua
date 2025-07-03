module("modules.logic.versionactivity2_7.act191.view.Act191EnemyInfoView", package.seeall)

local var_0_0 = class("Act191EnemyInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "left_container/Title/Title/#image_Level")
	arg_1_0._scrollteam = gohelper.findChildScrollRect(arg_1_0.viewGO, "left_container/#scroll_team")
	arg_1_0._goHeroItem = gohelper.findChild(arg_1_0.viewGO, "left_container/#scroll_team/viewport/content/#go_HeroItem")
	arg_1_0._goMain = gohelper.findChild(arg_1_0.viewGO, "left_container/#scroll_team/viewport/content/#go_Main")
	arg_1_0._goSub = gohelper.findChild(arg_1_0.viewGO, "left_container/#scroll_team/viewport/content/#go_Sub")
	arg_1_0._goFetter = gohelper.findChild(arg_1_0.viewGO, "left_container/#scroll_team/viewport/content/#go_Fetter")
	arg_1_0._goRightContainer = gohelper.findChild(arg_1_0.viewGO, "#go_RightContainer")
	arg_1_0._imageRare = gohelper.findChildImage(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Rare")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/character/#simage_Icon")
	arg_1_0._imageCareer = gohelper.findChildImage(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Career")
	arg_1_0._imageDmgtype = gohelper.findChildImage(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/#image_Dmgtype")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/name/#txt_Name")
	arg_1_0._goFetterIcon = gohelper.findChild(arg_1_0.viewGO, "#go_RightContainer/go_SingleHero/tag/#go_FetterIcon")
	arg_1_0._goCEmpty1 = gohelper.findChild(arg_1_0.viewGO, "#go_RightContainer/Collection1/#go_CEmpty1")
	arg_1_0._goCollection1 = gohelper.findChild(arg_1_0.viewGO, "#go_RightContainer/Collection1/#go_Collection1")
	arg_1_0._imageCRare1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#image_CRare1")
	arg_1_0._simageCIcon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#simage_CIcon1")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = gohelper.findButtonWithAudio(arg_5_0._goCollection1)

	arg_5_0:addClickCb(var_5_0, arg_5_0.onClickCollection, arg_5_0)

	arg_5_0._fetterItemList = {}
	arg_5_0.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goRightContainer, Act191CharacterInfo)
	arg_5_0._fetterIconItemList = {}
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.nodeDetailMo = arg_7_0.viewParam
	arg_7_0.matchMo = arg_7_0.nodeDetailMo.matchInfo

	local var_7_0 = lua_activity191_match_rank.configDict[arg_7_0.matchMo.rank].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(arg_7_0._imageLevel, "act191_level_" .. string.lower(var_7_0))

	arg_7_0.heroItemDic = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.matchMo.heroMap) do
		if not arg_7_0.selectMain then
			arg_7_0.selectMain = iter_7_0
		end

		local var_7_1 = arg_7_0.matchMo:getRoleCo(iter_7_1.heroId)
		local var_7_2 = gohelper.clone(arg_7_0._goHeroItem, arg_7_0._goMain)
		local var_7_3 = arg_7_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_7_2)
		local var_7_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_3, Act191HeroHeadItem)

		var_7_4:setData(nil, var_7_1.id)
		var_7_4:setOverrideClick(arg_7_0.onClickHero, arg_7_0, iter_7_0)

		arg_7_0.heroItemDic[iter_7_0] = var_7_4
	end

	arg_7_0.subHeroItemDic = {}

	for iter_7_2, iter_7_3 in pairs(arg_7_0.matchMo.subHeroMap) do
		local var_7_5 = arg_7_0.matchMo:getRoleCo(iter_7_3)
		local var_7_6 = gohelper.clone(arg_7_0._goHeroItem, arg_7_0._goSub)
		local var_7_7 = arg_7_0:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, var_7_6)
		local var_7_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_7, Act191HeroHeadItem)

		var_7_8:setData(nil, var_7_5.id)
		var_7_8:setOverrideClick(arg_7_0.onClickSubHero, arg_7_0, iter_7_2)

		arg_7_0.subHeroItemDic[iter_7_2] = var_7_8
	end

	gohelper.setActive(arg_7_0._goHeroItem, false)
	arg_7_0:onClickHero(arg_7_0.selectMain, true)
	arg_7_0:refreshFetter()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.refreshCharacter(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.matchMo:getRoleCo(arg_10_1)

	UISpriteSetMgr.instance:setAct174Sprite(arg_10_0._imageRare, "act174_rolebg_" .. var_10_0.quality)
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imageCareer, "lssx_" .. var_10_0.career)

	local var_10_1 = Activity191Helper.getHeadIconSmall(var_10_0)

	arg_10_0._simageIcon:LoadImage(var_10_1)

	arg_10_0._txtName.text = var_10_0.name

	arg_10_0.characterItem:setData(var_10_0)

	local var_10_2 = string.split(var_10_0.tag, "#")

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = arg_10_0._fetterIconItemList[iter_10_0]

		if not var_10_3 then
			local var_10_4 = gohelper.cloneInPlace(arg_10_0._goFetterIcon)

			var_10_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_4, Act191FetterIconItem)
			arg_10_0._fetterIconItemList[iter_10_0] = var_10_3
		end

		var_10_3:setData(iter_10_1)
		var_10_3:setEnemyView()
		gohelper.setActive(arg_10_0._fetterIconItemList[iter_10_0].go, true)
	end

	for iter_10_2 = #var_10_2 + 1, #arg_10_0._fetterIconItemList do
		gohelper.setActive(arg_10_0._fetterIconItemList[iter_10_2].go, false)
	end

	gohelper.setActive(arg_10_0._goFetterIcon, false)
end

function var_0_0.refreshFetter(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._fetterItemList) do
		gohelper.setActive(iter_11_1.go, false)
	end

	local var_11_0 = arg_11_0.matchMo:getTeamFetterCntDic()
	local var_11_1 = Activity191Helper.getActiveFetterInfoList(var_11_0)

	for iter_11_2, iter_11_3 in ipairs(var_11_1) do
		local var_11_2 = arg_11_0._fetterItemList[iter_11_2]

		if not var_11_2 then
			local var_11_3 = arg_11_0:getResInst(Activity191Enum.PrefabPath.FetterItem, arg_11_0._goFetter)

			var_11_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_3, Act191FetterItem)

			var_11_2:setEnemyView()

			arg_11_0._fetterItemList[iter_11_2] = var_11_2
		end

		var_11_2:setData(iter_11_3.config, iter_11_3.count)
		gohelper.setActive(var_11_2.go, true)
	end
end

function var_0_0.onClickHero(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_2 and arg_12_0.selectMain == arg_12_1 then
		return
	else
		arg_12_0.selectMain = arg_12_1
		arg_12_0.selectSub = 0
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.heroItemDic) do
		iter_12_1:setActivation(iter_12_0 == arg_12_1)
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.subHeroItemDic) do
		iter_12_3:setActivation(false)
	end

	local var_12_0 = arg_12_0.matchMo.heroMap[arg_12_1]

	arg_12_0:refreshCharacter(var_12_0.heroId)

	if var_12_0.itemUid1 ~= 0 then
		local var_12_1 = arg_12_0.matchMo:getItemCo(var_12_0.itemUid1)

		arg_12_0._simageCIcon1:LoadImage(ResUrl.getRougeSingleBgCollection(var_12_1.icon))
		UISpriteSetMgr.instance:setAct174Sprite(arg_12_0._imageCRare1, "act174_propitembg_" .. var_12_1.rare)
	end

	gohelper.setActive(arg_12_0._goCEmpty1, var_12_0.itemUid1 == 0)
	gohelper.setActive(arg_12_0._goCollection1, var_12_0.itemUid1 ~= 0)
end

function var_0_0.onClickSubHero(arg_13_0, arg_13_1)
	if arg_13_0.selectSub == arg_13_1 then
		return
	else
		arg_13_0.selectSub = arg_13_1
		arg_13_0.selectMain = 0

		for iter_13_0, iter_13_1 in pairs(arg_13_0.heroItemDic) do
			iter_13_1:setActivation(false)
		end

		for iter_13_2, iter_13_3 in pairs(arg_13_0.subHeroItemDic) do
			iter_13_3:setActivation(iter_13_2 == arg_13_1)
		end
	end

	local var_13_0 = arg_13_0.matchMo.subHeroMap[arg_13_1]

	arg_13_0:refreshCharacter(var_13_0)
	gohelper.setActive(arg_13_0._goCEmpty1, true)
	gohelper.setActive(arg_13_0._goCollection1, false)
end

function var_0_0.onClickCollection(arg_14_0)
	if arg_14_0.selectMain then
		local var_14_0 = arg_14_0.matchMo.heroMap[arg_14_0.selectMain].itemUid1

		if var_14_0 ~= 0 then
			local var_14_1 = arg_14_0.matchMo:getItemCo(var_14_0)

			Activity191Controller.instance:openCollectionTipView({
				itemId = var_14_1.id
			})
		end
	end
end

return var_0_0
