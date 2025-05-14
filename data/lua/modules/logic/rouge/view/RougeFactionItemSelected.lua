module("modules.logic.rouge.view.RougeFactionItemSelected", package.seeall)

local var_0_0 = class("RougeFactionItemSelected", RougeFactionItem_Base)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtcoin = gohelper.findChildText(arg_1_0.viewGO, "detail/coin/#txt_coin")
	arg_1_0._txtbag = gohelper.findChildText(arg_1_0.viewGO, "detail/bag/#txt_bag")
	arg_1_0._txtgroup = gohelper.findChildText(arg_1_0.viewGO, "detail/group/#txt_group")
	arg_1_0._gobag = gohelper.findChild(arg_1_0.viewGO, "detail/baglayout/#go_bag")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "detail/baglayout/#btn_check")
	arg_1_0._scrolldesc2 = gohelper.findChildScrollRect(arg_1_0.viewGO, "detail/beidong/#scroll_desc2")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "detail/beidong/#scroll_desc2/Viewport/Content/#go_descitem")
	arg_1_0._gobtnitem = gohelper.findChild(arg_1_0.viewGO, "detail/zhouyu/content/#go_btnitem")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "detail/zhouyu/#go_detail")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "detail/zhouyu/#go_detail/#txt_dec")
	arg_1_0._detailimageicon = gohelper.findChildImage(arg_1_0.viewGO, "detail/zhouyu/#go_detail/icon")
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "#go_Bg")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_en")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._txtscrollDesc = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#txt_scrollDesc")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtdec.text = ""
	arg_4_0._detailTrans = arg_4_0._godetail.transform

	RougeFactionItem_Base._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._godescitem, false)
	gohelper.setActive(arg_4_0._gobtnitem, false)

	local var_4_0 = arg_4_0._scrolldesc.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)
	local var_4_1 = arg_4_0._scrolldesc2.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)

	arg_4_0:_onSetScrollParentGameObject(var_4_0)
	arg_4_0:_onSetScrollParentGameObject(var_4_1)

	arg_4_0._descItemList = {
		arg_4_0:_create_RougeFactionItemSelected_DescItem(1),
		(arg_4_0:_create_RougeFactionItemSelected_DescItem(2))
	}
	arg_4_0._btnItemList = {
		arg_4_0:_create_RougeFactionItemSelected_BtnItem(1),
		(arg_4_0:_create_RougeFactionItemSelected_BtnItem(2))
	}

	gohelper.setActive(arg_4_0._godetail, true)
	arg_4_0:_deselectAllBtnItems()
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.UpdateUnlockSkill, arg_4_0._onUpdateUnlockSkill, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	RougeFactionItem_Base.onDestroyView(arg_5_0)
	GameUtil.onDestroyViewMemberList(arg_5_0, "_descItemList")
	GameUtil.onDestroyViewMemberList(arg_5_0, "_btnItemList")
	arg_5_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_5_0._onTouchScreen, arg_5_0)

	if arg_5_0._collectionSlotComp then
		arg_5_0._collectionSlotComp:destroy()

		arg_5_0._collectionSlotComp = nil
	end
end

function var_0_0.setData(arg_6_0, arg_6_1)
	RougeFactionItem_Base.setData(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_0:staticData().startViewAllInfo
	local var_6_1 = arg_6_1.styleCO
	local var_6_2 = var_6_0[RougeEnum.StartViewEnum.coin] or 0
	local var_6_3 = var_6_0[RougeEnum.StartViewEnum.power] or 0
	local var_6_4 = var_6_0[RougeEnum.StartViewEnum.powerLimit] or 0
	local var_6_5 = var_6_0[RougeEnum.StartViewEnum.capacity] or 0

	arg_6_0._txtcoin.text = var_6_1.coin + var_6_2
	arg_6_0._txtbag.text = tostring(var_6_1.power + var_6_3) .. "/" .. tostring(var_6_1.powerLimit + var_6_4)
	arg_6_0._txtgroup.text = var_6_1.capacity + var_6_5

	arg_6_0:_initOrRefreshDescItemList(arg_6_1)
	arg_6_0:_initOrRefreshBtnItemList(arg_6_1)
	arg_6_0:_initOrRefreshCollectonSlot(arg_6_1)
end

function var_0_0._create_RougeFactionItemSelected_DescItem(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or #arg_7_0._descItemList

	local var_7_0 = arg_7_0:_createItem(arg_7_0._godescitem, RougeFactionItemSelected_DescItem)

	var_7_0:setIndex(arg_7_1)

	return var_7_0
end

function var_0_0._initOrRefreshDescItemList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.styleCO
	local var_8_1 = RougeConfig1.instance:calcStyleCOPassiveSkillDescsList(var_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = arg_8_0._descItemList[iter_8_0]

		if not var_8_2 then
			var_8_2 = arg_8_0:_create_RougeFactionItemSelected_DescItem(iter_8_0)
			arg_8_0._descItemList[iter_8_0] = var_8_2
		end

		var_8_2:setData(iter_8_1)
	end

	for iter_8_2 = #var_8_1 + 1, #arg_8_0._descItemList do
		arg_8_0._descItemList[iter_8_2]:setData(nil)
	end
end

function var_0_0._create_RougeFactionItemSelected_BtnItem(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or #arg_9_0._btnItemList

	local var_9_0 = arg_9_0:_createItem(arg_9_0._gobtnitem, RougeFactionItemSelected_BtnItem)

	var_9_0:setIndex(arg_9_1)

	return var_9_0
end

function var_0_0._initOrRefreshBtnItemList(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.styleCO

	arg_10_0._skillIds = {}

	arg_10_0:_initOrRefreshActiveSkillItemList(var_10_0)
	arg_10_0:_initOrRefreshMapSkillItemList(var_10_0)
	arg_10_0:_initOrRefreshUnlockSkillItemList(var_10_0)

	for iter_10_0 = (arg_10_0._skillIds and #arg_10_0._skillIds or 0) + 1, #arg_10_0._btnItemList do
		arg_10_0._btnItemList[iter_10_0]:setData(nil)
	end
end

function var_0_0._initOrRefreshActiveSkillItemList(arg_11_0, arg_11_1)
	local var_11_0 = string.splitToNumber(arg_11_1.activeSkills, "#")

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0:_getCanUseItemIndex()
		local var_11_2 = arg_11_0._btnItemList[var_11_1]

		if not var_11_2 then
			var_11_2 = arg_11_0:_create_RougeFactionItemSelected_BtnItem(var_11_1)
			arg_11_0._btnItemList[var_11_1] = var_11_2
		end

		var_11_2:setData(RougeEnum.SkillType.Style, iter_11_1, true)
		table.insert(arg_11_0._skillIds, iter_11_1)
	end
end

function var_0_0._initOrRefreshMapSkillItemList(arg_12_0, arg_12_1)
	local var_12_0 = string.splitToNumber(arg_12_1.mapSkills, "#")

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0:_getCanUseItemIndex()
		local var_12_2 = arg_12_0._btnItemList[var_12_1]

		if not var_12_2 then
			var_12_2 = arg_12_0:_create_RougeFactionItemSelected_BtnItem(var_12_1)
			arg_12_0._btnItemList[var_12_1] = var_12_2
		end

		var_12_2:setData(RougeEnum.SkillType.Map, iter_12_1, true)
		table.insert(arg_12_0._skillIds, iter_12_1)
	end
end

function var_0_0._initOrRefreshUnlockSkillItemList(arg_13_0, arg_13_1)
	local var_13_0 = RougeOutsideModel.instance:getRougeGameRecord()
	local var_13_1 = RougeDLCConfig101.instance:getStyleUnlockSkills(arg_13_1.id)

	for iter_13_0, iter_13_1 in ipairs(var_13_1 or {}) do
		if RougeDLCHelper.isCurrentUsingContent(iter_13_1.version) then
			local var_13_2 = arg_13_0:_getCanUseItemIndex()
			local var_13_3 = arg_13_0._btnItemList[var_13_2]

			if not var_13_3 then
				var_13_3 = arg_13_0:_create_RougeFactionItemSelected_BtnItem(var_13_2)
				arg_13_0._btnItemList[var_13_2] = var_13_3
			end

			local var_13_4 = iter_13_1.type
			local var_13_5 = var_13_0:isSkillUnlock(iter_13_1.type, iter_13_1.skillId)

			var_13_3:setData(var_13_4, iter_13_1.skillId, var_13_5)
			table.insert(arg_13_0._skillIds, iter_13_1.skillId)
		end
	end
end

function var_0_0._getCanUseItemIndex(arg_14_0)
	return arg_14_0._skillIds and #arg_14_0._skillIds + 1 or 0
end

function var_0_0._initOrRefreshCollectonSlot(arg_15_0, arg_15_1)
	if not arg_15_0._collectionSlotComp then
		arg_15_0._collectionSlotComp = RougeCollectionSlotComp.Get(arg_15_0._gobag, RougeCollectionHelper.StyleCollectionSlotParam)

		local var_15_0 = arg_15_1.styleCO.layoutId
		local var_15_1 = RougeCollectionConfig.instance:getCollectionInitialBagSize(var_15_0)
		local var_15_2 = arg_15_0:_createInitialCollections(var_15_0)

		arg_15_0._collectionSlotComp:onUpdateMO(var_15_1.col, var_15_1.row, var_15_2)
	end
end

function var_0_0._createInitialCollections(arg_16_0, arg_16_1)
	local var_16_0 = RougeCollectionConfig.instance:getStyleInitialCollections(arg_16_1)

	if not var_16_0 then
		return
	end

	local var_16_1 = {}

	arg_16_0._collectionCfgIds = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = RougeCollectionSlotMO.New()
		local var_16_3 = {
			item = {
				id = iter_16_0,
				itemId = iter_16_1.cfgId
			},
			rotation = iter_16_1.rotation,
			pos = iter_16_1.pos
		}

		var_16_2:init(var_16_3)
		table.insert(var_16_1, var_16_2)
		table.insert(arg_16_0._collectionCfgIds, iter_16_1.cfgId)
	end

	return var_16_1
end

function var_0_0._createItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = gohelper.cloneInPlace(arg_17_1, arg_17_2.__cname)
	local var_17_1 = arg_17_2.New(arg_17_0)

	var_17_1:init(var_17_0)

	return var_17_1
end

function var_0_0._btnItemOnSelectIndex(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._btnItemList[arg_18_1]:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	arg_18_0._btnItemLastSelectIndex = arg_18_1

	if not arg_18_2 then
		local var_18_0 = arg_18_0._skillIds[arg_18_1]

		RougeDLCController101.instance:openRougeFactionLockedTips({
			skillId = var_18_0
		})

		return
	end

	arg_18_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_18_0._onTouchScreen, arg_18_0)
	arg_18_0:_setActiveDetail(true)
end

function var_0_0._onTouchScreen(arg_19_0)
	arg_19_0:_deselectAllBtnItems()
end

function var_0_0._setActiveDetail(arg_20_0, arg_20_1)
	GameUtil.setActive01(arg_20_0._detailTrans, arg_20_1)

	if arg_20_1 then
		arg_20_0:_resetDetailPos()
	end
end

function var_0_0._deselectAllBtnItems(arg_21_0)
	arg_21_0:_setActiveDetail(false)

	if arg_21_0._btnItemLastSelectIndex then
		local var_21_0 = arg_21_0._btnItemList[arg_21_0._btnItemLastSelectIndex]

		if var_21_0 then
			var_21_0:setSelected(false)
		end

		arg_21_0._btnItemLastSelectIndex = nil

		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._btnItemList) do
		iter_21_1:setSelected(false)
	end
end

function var_0_0._btncheckOnClick(arg_22_0)
	local var_22_0 = {
		collectionCfgIds = arg_22_0._collectionCfgIds
	}

	RougeController.instance:openRougeCollectionInitialView(var_22_0)
end

local var_0_1 = 303

function var_0_0._resetDetailPos(arg_23_0)
	local var_23_0 = arg_23_0._btnItemList[#arg_23_0._btnItemList]

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0:transform()

	if not var_23_1 then
		return
	end

	local var_23_2 = recthelper.rectToRelativeAnchorPos(var_23_1.position, arg_23_0._detailTrans.parent)

	arg_23_0._detailTrans.localPosition = Vector3.New(var_23_2.x + var_0_1, var_23_2.y - 57, 0)
end

function var_0_0._onUpdateUnlockSkill(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = tabletool.indexOf(arg_24_0._skillIds, arg_24_2)

	if not var_24_0 then
		return
	end

	local var_24_1 = arg_24_0._btnItemList[var_24_0]

	if var_24_1 then
		var_24_1:onUnlocked()
	end
end

return var_0_0
