module("modules.logic.rouge.view.RougeCollectionGiftView", package.seeall)

local var_0_0 = class("RougeCollectionGiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._gorougepageprogress = gohelper.findChild(arg_1_0.viewGO, "#go_rougepageprogress")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_start")
	arg_1_0._btnemptyBlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBlock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnemptyBlock:AddClickListener(arg_2_0._btnemptyBlockOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnemptyBlock:RemoveClickListener()
end

local var_0_1 = ZProj.TweenHelper

var_0_0.Type = {
	DropGroup = 2,
	Drop = 1,
	None = 0
}

function var_0_0._btnstartOnClick(arg_4_0)
	arg_4_0:_submitFunc()
end

function var_0_0._btnemptyBlockOnClick(arg_5_0)
	arg_5_0:setActiveBlock(false)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._btnemptyBlockGo = arg_6_0._btnemptyBlock.gameObject
	arg_6_0._scrollview = gohelper.findChildScrollRect(arg_6_0.viewGO, "scroll_view")
	arg_6_0._tipsText = gohelper.findChildText(arg_6_0.viewGO, "tips")
	arg_6_0._scrollViewGo = arg_6_0._scrollview.gameObject
	arg_6_0._scrollViewLimitScrollCmp = arg_6_0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_6_0._scrollViewTrans = arg_6_0._scrollViewGo.transform
	arg_6_0._btnstartGo = arg_6_0._btnstart.gameObject
	arg_6_0._collectionObjList = {}

	arg_6_0:_initPageProgress()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_refresh()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._isBlocked = nil
	arg_8_0._hasSelectedCount = 0
	arg_8_0._hasSelectedIndexDict = {}

	arg_8_0:_setActiveBtn(false)
	arg_8_0:onUpdateParam()

	arg_8_0._tipsText.text = string.format(luaLang("rougecollectiongiftview_txt_tips"), arg_8_0:_selectRewardNum())

	arg_8_0.viewContainer:registerCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, arg_8_0._onSelectIndexByUser, arg_8_0)
end

function var_0_0.onOpenFinish(arg_9_0)
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	gohelper.setActive(arg_9_0._gocollectionitem, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:_killTween()
	arg_10_0.viewContainer:unregisterCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, arg_10_0._onSelectIndexByUser, arg_10_0)
	GameUtil.onDestroyViewMemberList(arg_10_0, "_collectionObjList")
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0._refresh(arg_12_0)
	arg_12_0:_refreshList()
	arg_12_0:_refreshConfirmBtn()
end

function var_0_0._refreshConfirmBtn(arg_13_0)
	local var_13_0 = arg_13_0._hasSelectedCount == arg_13_0:_selectRewardNum()

	gohelper.setActive(arg_13_0._btnstartGo, var_13_0)
	arg_13_0:_tweenTipsText(not var_13_0)
end

local var_0_2 = 0.4

function var_0_0._tweenTipsText(arg_14_0, arg_14_1)
	arg_14_0:_killTween()

	local var_14_0 = arg_14_1 and 1 or 0
	local var_14_1 = arg_14_0._tipsText.alpha

	arg_14_0._tweenId = var_0_1.DoFade(arg_14_0._tipsText, var_14_1, var_14_0, var_0_2, nil, nil, nil, EaseType.OutQuad)
end

function var_0_0._killTween(arg_15_0)
	GameUtil.onDestroyViewMember_TweenId(arg_15_0, "_tweenId")
end

function var_0_0._refreshList(arg_16_0)
	local var_16_0 = arg_16_0:_getRewardList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1

		if iter_16_0 > #arg_16_0._collectionObjList then
			var_16_1 = arg_16_0:_create_RougeCollectionGiftViewItem(iter_16_0)

			table.insert(arg_16_0._collectionObjList, var_16_1)
		else
			var_16_1 = arg_16_0._collectionObjList[iter_16_0]
		end

		var_16_1:onUpdateMO(iter_16_1)
		var_16_1:setActive(true)
		var_16_1:setSelected(arg_16_0._hasSelectedIndexDict[iter_16_0] and true or false)
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_0._collectionObjList do
		arg_16_0._collectionObjList[iter_16_2]:setActive(false)
	end
end

function var_0_0._getRewardList(arg_17_0)
	if not arg_17_0._tmpRewardList then
		arg_17_0._tmpRewardList = arg_17_0:_rewardList()
	end

	return arg_17_0._tmpRewardList
end

function var_0_0._create_RougeCollectionGiftViewItem(arg_18_0, arg_18_1)
	local var_18_0 = gohelper.cloneInPlace(arg_18_0._gocollectionitem)
	local var_18_1 = RougeCollectionGiftViewItem.New({
		parent = arg_18_0,
		baseViewContainer = arg_18_0.viewContainer
	})

	var_18_1:setIndex(arg_18_1)
	var_18_1:init(var_18_0)

	return var_18_1
end

function var_0_0._setActiveBtn(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._btnstartGo, arg_19_1)
end

function var_0_0._initPageProgress(arg_20_0)
	local var_20_0 = RougePageProgress
	local var_20_1 = arg_20_0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, arg_20_0._gorougepageprogress, var_20_0.__cname)

	arg_20_0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_1, var_20_0)

	arg_20_0._pageProgress:setData()
end

function var_0_0._selectRewardNum(arg_21_0)
	if not arg_21_0.viewParam then
		return arg_21_0:_getRougeSelectRewardNum()
	end

	return arg_21_0.viewParam.selectRewardNum or arg_21_0:_getRougeSelectRewardNum()
end

function var_0_0._rewardList(arg_22_0)
	if not arg_22_0.viewParam then
		return arg_22_0:_getRougeLastRewardList()
	end

	return arg_22_0.viewParam.rewardList or arg_22_0:_getRougeLastRewardList()
end

function var_0_0._submitFunc(arg_23_0)
	if not arg_23_0.viewParam then
		arg_23_0:_defaultSubmitFunc()

		return
	end

	if arg_23_0.viewParam.submitFunc then
		arg_23_0.viewParam.submitFunc(arg_23_0)
	else
		arg_23_0:_defaultSubmitFunc()
	end
end

function var_0_0._getRougeSelectRewardNum(arg_24_0)
	return RougeModel.instance:getSelectRewardNum() or 0
end

function var_0_0._getRougeLastRewardList(arg_25_0)
	local var_25_0 = RougeModel.instance:getLastRewardList()
	local var_25_1 = {}

	if not var_25_0 or #var_25_0 == 0 then
		return var_25_1
	end

	local var_25_2 = RougeOutsideModel.instance:config()

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_3 = iter_25_1.id
		local var_25_4 = iter_25_1.param
		local var_25_5 = var_25_2:getLastRewardCO(var_25_3)
		local var_25_6 = var_25_5.type
		local var_25_7 = {
			title = "",
			id = var_25_3,
			descList = {},
			type = var_0_0.Type.unknown
		}

		if var_25_6 == "drop" then
			var_25_7.type = var_0_0.Type.Drop
			var_25_7.title = var_25_5.title

			table.insert(var_25_7.descList, var_25_5.desc)

			var_25_7.resUrl = ResUrl.getRougeSingleBgCollection(var_25_5.iconName)
		elseif var_25_6 == "dropGroup" then
			var_25_7.type = var_0_0.Type.DropGroup
			var_25_7.resUrl = nil
			var_25_7.title = var_25_5.title
			var_25_7.data = {}

			local var_25_8 = string.splitToNumber(var_25_4, "#")

			var_25_7.data.collectionId = var_25_8[1]

			for iter_25_2, iter_25_3 in ipairs(var_25_8) do
				local var_25_9 = RougeCollectionConfig.instance:getCollectionCfg(iter_25_3)

				if var_25_7.resUrl == nil and not string.nilorempty(var_25_9.iconPath) then
					var_25_7.resUrl = ResUrl.getRougeSingleBgCollection(var_25_9.iconPath)
				end

				local var_25_10, var_25_11 = RougeCollectionConfig.instance:getCollectionEffectsInfo(iter_25_3)

				for iter_25_4, iter_25_5 in ipairs(var_25_10) do
					table.insert(var_25_7.descList, HeroSkillModel.instance:skillDesToSpot(iter_25_5))
				end

				for iter_25_6, iter_25_7 in ipairs(var_25_11) do
					local var_25_12 = SkillConfig.instance:getSkillEffectDescCo(iter_25_7)
					local var_25_13 = RougeCollectionHelper.instance:getHeroSkillDesc(var_25_12.name, var_25_12.desc)

					table.insert(var_25_7.descList, HeroSkillModel.instance:skillDesToSpot(var_25_13))
				end
			end
		else
			local var_25_14 = string.format("[RougeInfoMO:getLastRewardList] unsupported error type=%s, id=%s", var_25_6, var_25_3)

			logError(var_25_14)
		end

		table.insert(var_25_1, var_25_7)
	end

	return var_25_1
end

function var_0_0._isSingleSelect(arg_26_0)
	return arg_26_0:_selectRewardNum() == 1
end

function var_0_0._onSelectIndexByUser(arg_27_0, arg_27_1)
	if arg_27_0:_isSingleSelect() then
		arg_27_0:_onSelectIndex_SingleSelect(arg_27_1)
	else
		arg_27_0:_onSelectIndex_MultiSelect(arg_27_1)
	end
end

function var_0_0._onSelectIndex_SingleSelect(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._collectionObjList[arg_28_1]

	if arg_28_0._hasSelectedIndexDict[arg_28_1] then
		return
	end

	local var_28_1, var_28_2 = next(arg_28_0._hasSelectedIndexDict)

	if var_28_1 then
		arg_28_0._hasSelectedIndexDict[var_28_1] = nil

		arg_28_0._collectionObjList[var_28_1]:setSelected(false)
	end

	var_28_0:setSelected(true)

	arg_28_0._hasSelectedIndexDict[arg_28_1] = true
	arg_28_0._hasSelectedCount = math.min(1, arg_28_0._hasSelectedCount + 1)

	arg_28_0:_refreshConfirmBtn()
end

function var_0_0._onSelectIndex_MultiSelect(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._collectionObjList[arg_29_1]

	if arg_29_0._hasSelectedIndexDict[arg_29_1] then
		arg_29_0._hasSelectedIndexDict[arg_29_1] = false
		arg_29_0._hasSelectedCount = arg_29_0._hasSelectedCount - 1

		var_29_0:setSelected(false)
		arg_29_0:_refreshConfirmBtn()

		return
	end

	if arg_29_0._hasSelectedCount >= arg_29_0:_selectRewardNum() then
		GameFacade.showToast(ToastEnum.RougeCollectionGiftView_ReachMaxSelectedCount)

		return
	end

	var_29_0:setSelected(true)

	arg_29_0._hasSelectedIndexDict[arg_29_1] = true
	arg_29_0._hasSelectedCount = arg_29_0._hasSelectedCount + 1

	arg_29_0:_refreshConfirmBtn()
end

local var_0_3 = "RougeCollectionGiftView:_defaultSubmitFunc"

function var_0_0._defaultSubmitFunc(arg_30_0)
	UIBlockHelper.instance:startBlock(var_0_3, 1, arg_30_0.viewName)

	local var_30_0 = RougeOutsideModel.instance:season()
	local var_30_1 = {}
	local var_30_2 = arg_30_0:_getRewardList()

	for iter_30_0, iter_30_1 in pairs(arg_30_0._hasSelectedIndexDict) do
		local var_30_3 = var_30_2[iter_30_0].id

		if iter_30_1 then
			table.insert(var_30_1, var_30_3)
		end
	end

	RougeRpc.instance:sendEnterRougeSelectRewardRequest(var_30_0, var_30_1, function(arg_31_0, arg_31_1)
		if arg_31_1 ~= 0 then
			logError("RougeCollectionGiftView:_defaultSubmitFunc resultCode=" .. tostring(arg_31_1))

			return
		end

		UIBlockHelper.instance:endBlock(var_0_3)
		RougeController.instance:openRougeFactionView()
	end)
end

function var_0_0.getScrollViewGo(arg_32_0)
	return arg_32_0._scrollViewGo
end

function var_0_0.getScrollRect(arg_33_0)
	return arg_33_0._scrollViewLimitScrollCmp
end

function var_0_0.setActiveBlock(arg_34_0, arg_34_1)
	if arg_34_0._isBlocked == arg_34_1 then
		return
	end

	arg_34_0._isBlocked = arg_34_1

	gohelper.setActive(arg_34_0._btnemptyBlockGo, arg_34_1)

	if not arg_34_1 then
		for iter_34_0, iter_34_1 in ipairs(arg_34_0._collectionObjList) do
			iter_34_1:onCloseBlock()
		end
	end
end

return var_0_0
