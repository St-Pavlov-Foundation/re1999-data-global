module("modules.logic.rouge.view.RougeFactionIllustrationDetailItem", package.seeall)

local var_0_0 = class("RougeFactionIllustrationDetailItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcoin = gohelper.findChildText(arg_1_0.viewGO, "Select/detail/coin/#txt_coin")
	arg_1_0._txtbag = gohelper.findChildText(arg_1_0.viewGO, "Select/detail/bag/#txt_bag")
	arg_1_0._txtgroup = gohelper.findChildText(arg_1_0.viewGO, "Select/detail/group/#txt_group")
	arg_1_0._gobag = gohelper.findChild(arg_1_0.viewGO, "Select/detail/baglayout/#go_bag")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Select/detail/baglayout/#btn_check")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "Select/detail/beidong/#Scroll_Desc/Viewport/Content/#go_descitem")
	arg_1_0._goskillitem = gohelper.findChild(arg_1_0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_skills/#go_skillitem")
	arg_1_0._godetail2 = gohelper.findChild(arg_1_0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2")
	arg_1_0._imageskillicon = gohelper.findChildImage(arg_1_0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#image_skillicon")
	arg_1_0._txtdec2 = gohelper.findChildText(arg_1_0.viewGO, "Select/detail/zhouyu/#go_skillcontainer/#go_detail2/#txt_dec2")
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "Select/#go_Bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "Select/#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Select/#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "Select/#txt_name/#txt_en")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Select/#scroll_desc")
	arg_1_0._txtscrollDesc = gohelper.findChildText(arg_1_0.viewGO, "Select/#scroll_desc/viewport/content/#txt_scrollDesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
end

function var_0_0._refreshAllBtnStatus(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._skillItemList) do
		local var_4_0 = arg_4_1 == iter_4_0

		arg_4_0:_setBtnStatus(var_4_0, iter_4_1.gonormal, iter_4_1.goselect)
	end
end

function var_0_0._setBtnStatus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	gohelper.setActive(arg_5_2, not arg_5_1)
	gohelper.setActive(arg_5_3, arg_5_1)
end

function var_0_0._btncheckOnClick(arg_6_0)
	local var_6_0 = {
		collectionCfgIds = arg_6_0._collectionCfgIds
	}

	RougeController.instance:openRougeCollectionInitialView(var_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._skillItemList = arg_7_0:getUserDataTb_()

	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_7_0._onTouchScreenUp, arg_7_0)
	gohelper.setActive(arg_7_0._godetail2, false)

	arg_7_0._descItemList = {
		arg_7_0:_create_RougeFactionItemSelected_DescItem(1),
		(arg_7_0:_create_RougeFactionItemSelected_DescItem(2))
	}
end

function var_0_0._onTouchScreenUp(arg_8_0)
	if arg_8_0._showTips then
		arg_8_0._showTips = false

		return
	end

	gohelper.setActive(arg_8_0._godetail2, false)
	arg_8_0:_refreshAllBtnStatus()
end

function var_0_0._editableAddEvents(arg_9_0)
	return
end

function var_0_0._editableRemoveEvents(arg_10_0)
	return
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1
	arg_11_0._txtname.text = arg_11_1.name
	arg_11_0._txtcoin.text = arg_11_1.coin
	arg_11_0._txtbag.text = tostring(arg_11_1.power) .. "/" .. tostring(arg_11_1.powerLimit)
	arg_11_0._txtgroup.text = arg_11_1.capacity
	arg_11_0._txtscrollDesc.text = arg_11_1.desc

	arg_11_0:_initSkill()
	arg_11_0:_initOrRefreshDescItemList(arg_11_1)
	arg_11_0:_initOrRefreshCollectonSlot(arg_11_1)
	UISpriteSetMgr.instance:setRouge2Sprite(arg_11_0._imageicon, string.format("%s_light", arg_11_0._mo.icon))

	if RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, arg_11_0._mo.id) ~= nil then
		local var_11_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_11_0, RougeEnum.FavoriteType.Faction, arg_11_0._mo.id)
	end
end

function var_0_0._initOrRefreshCollectonSlot(arg_12_0, arg_12_1)
	if not arg_12_0._collectionSlotComp then
		arg_12_0._collectionSlotComp = RougeCollectionSlotComp.Get(arg_12_0._gobag, RougeCollectionHelper.StyleShowCollectionSlotParam)
	end

	local var_12_0 = arg_12_1.layoutId
	local var_12_1 = RougeCollectionConfig.instance:getCollectionInitialBagSize(var_12_0)
	local var_12_2 = arg_12_0:_createInitialCollections(var_12_0)

	arg_12_0._collectionSlotComp:onUpdateMO(var_12_1.col, var_12_1.row, var_12_2)
end

function var_0_0._createInitialCollections(arg_13_0, arg_13_1)
	local var_13_0 = RougeCollectionConfig.instance:getStyleInitialCollections(arg_13_1)

	if not var_13_0 then
		return
	end

	local var_13_1 = {}

	arg_13_0._collectionCfgIds = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_2 = RougeCollectionSlotMO.New()
		local var_13_3 = {
			item = {
				id = iter_13_0,
				itemId = iter_13_1.cfgId
			},
			rotation = iter_13_1.rotation,
			pos = iter_13_1.pos
		}

		var_13_2:init(var_13_3)
		table.insert(var_13_1, var_13_2)
		table.insert(arg_13_0._collectionCfgIds, iter_13_1.cfgId)
	end

	return var_13_1
end

function var_0_0._initSkill(arg_14_0)
	local var_14_0 = arg_14_0:_getAllSkills()
	local var_14_1 = RougeOutsideModel.instance:config()
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_3 = arg_14_0:_getOrCreateSkillItem(iter_14_0)
		local var_14_4 = var_14_1:getSkillCo(iter_14_1.type, iter_14_1.skillId)
		local var_14_5 = var_14_4 and var_14_4.icon

		if not string.nilorempty(var_14_5) then
			UISpriteSetMgr.instance:setRouge2Sprite(var_14_3.imagenormalicon, var_14_5, true)
			UISpriteSetMgr.instance:setRouge2Sprite(var_14_3.imagselecticon, var_14_5 .. "_light", true)
		else
			logError(string.format("未配置肉鸽流派技能图标, 技能类型 = %s, 技能id = %s", iter_14_1.type, iter_14_1.skillId))
		end

		arg_14_0["_skillDesc" .. iter_14_0] = var_14_4.desc
		arg_14_0["_skillIcon" .. iter_14_0] = var_14_4.icon

		gohelper.setActive(var_14_3.viewGO, true)

		var_14_2[var_14_3] = true
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._skillItemList) do
		if not var_14_2[iter_14_3] then
			gohelper.setActive(iter_14_3.viewGO, false)
		end
	end
end

function var_0_0._getOrCreateSkillItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._skillItemList and arg_15_0._skillItemList[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.viewGO = gohelper.cloneInPlace(arg_15_0._goskillitem, "item_" .. arg_15_1)
		var_15_0.gonormal = gohelper.findChild(var_15_0.viewGO, "go_normal")
		var_15_0.imagenormalicon = gohelper.findChildImage(var_15_0.viewGO, "go_normal/image_icon")
		var_15_0.goselect = gohelper.findChild(var_15_0.viewGO, "go_select")
		var_15_0.imagselecticon = gohelper.findChildImage(var_15_0.viewGO, "go_select/image_icon")
		var_15_0.btnclick = gohelper.findChildButtonWithAudio(var_15_0.viewGO, "btn_click")

		var_15_0.btnclick:AddClickListener(arg_15_0._btnskillOnClick, arg_15_0, arg_15_1)
		table.insert(arg_15_0._skillItemList, var_15_0)
	end

	return var_15_0
end

function var_0_0._btnskillOnClick(arg_16_0, arg_16_1)
	arg_16_0._showTips = true
	arg_16_0._txtdec2.text = arg_16_0["_skillDesc" .. arg_16_1]

	UISpriteSetMgr.instance:setRouge2Sprite(arg_16_0._imageskillicon, arg_16_0["_skillIcon" .. arg_16_1], true)
	gohelper.setActive(arg_16_0._godetail2, false)
	gohelper.setActive(arg_16_0._godetail2, true)
	arg_16_0:_refreshAllBtnStatus(arg_16_1)
end

function var_0_0._removeAllSkillClickListener(arg_17_0)
	if arg_17_0._skillItemList then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._skillItemList) do
			if iter_17_1.btnclick then
				iter_17_1.btnclick:RemoveClickListener()
			end
		end
	end
end

function var_0_0._getAllSkills(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = string.splitToNumber(arg_18_0._mo.activeSkills, "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		table.insert(var_18_0, {
			type = RougeEnum.SkillType.Style,
			skillId = iter_18_1
		})
	end

	local var_18_2 = string.splitToNumber(arg_18_0._mo.mapSkills, "#")

	for iter_18_2, iter_18_3 in ipairs(var_18_2) do
		table.insert(var_18_0, {
			type = RougeEnum.SkillType.Map,
			skillId = iter_18_3
		})
	end

	local var_18_3 = RougeDLCConfig101.instance:getStyleUnlockSkills(arg_18_0._mo.id)

	for iter_18_4, iter_18_5 in ipairs(var_18_3 or {}) do
		table.insert(var_18_0, {
			type = iter_18_5.type,
			skillId = iter_18_5.skillId
		})
	end

	return var_18_0
end

function var_0_0._createItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = gohelper.cloneInPlace(arg_19_1, arg_19_2.__cname)
	local var_19_1 = arg_19_2.New(arg_19_0)

	var_19_1:init(var_19_0)

	return var_19_1
end

function var_0_0._create_RougeFactionItemSelected_DescItem(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or #arg_20_0._descItemList

	local var_20_0 = arg_20_0:_createItem(arg_20_0._godescitem, RougeFactionItemSelected_DescItem)

	var_20_0:setIndex(arg_20_1)

	return var_20_0
end

function var_0_0._initOrRefreshDescItemList(arg_21_0, arg_21_1)
	local var_21_0 = RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(arg_21_1)

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_1 = arg_21_0._descItemList[iter_21_0]

		if not var_21_1 then
			var_21_1 = arg_21_0:_create_RougeFactionItemSelected_DescItem(iter_21_0)
			arg_21_0._descItemList[iter_21_0] = var_21_1
		end

		var_21_1:setData(iter_21_1)
	end

	for iter_21_2 = #var_21_0 + 1, #arg_21_0._descItemList do
		arg_21_0._descItemList[iter_21_2]:setData(nil)
	end
end

function var_0_0.onSelect(arg_22_0, arg_22_1)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_23_0._onTouchScreenUp, arg_23_0)
	GameUtil.onDestroyViewMemberList(arg_23_0, "_descItemList")

	if arg_23_0._collectionSlotComp then
		arg_23_0._collectionSlotComp:destroy()

		arg_23_0._collectionSlotComp = nil
	end

	arg_23_0:_removeAllSkillClickListener()
end

return var_0_0
