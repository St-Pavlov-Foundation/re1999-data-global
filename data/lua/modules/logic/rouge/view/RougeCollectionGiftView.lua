module("modules.logic.rouge.view.RougeCollectionGiftView", package.seeall)

slot0 = class("RougeCollectionGiftView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._gorougepageprogress = gohelper.findChild(slot0.viewGO, "#go_rougepageprogress")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_start")
	slot0._btnemptyBlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBlock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnemptyBlock:AddClickListener(slot0._btnemptyBlockOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btnemptyBlock:RemoveClickListener()
end

slot1 = ZProj.TweenHelper
slot0.Type = {
	DropGroup = 2,
	Drop = 1,
	None = 0
}

function slot0._btnstartOnClick(slot0)
	slot0:_submitFunc()
end

function slot0._btnemptyBlockOnClick(slot0)
	slot0:setActiveBlock(false)
end

function slot0._editableInitView(slot0)
	slot0._btnemptyBlockGo = slot0._btnemptyBlock.gameObject
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "scroll_view")
	slot0._tipsText = gohelper.findChildText(slot0.viewGO, "tips")
	slot0._scrollViewGo = slot0._scrollview.gameObject
	slot0._scrollViewLimitScrollCmp = slot0._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	slot0._scrollViewTrans = slot0._scrollViewGo.transform
	slot0._btnstartGo = slot0._btnstart.gameObject
	slot0._collectionObjList = {}

	slot0:_initPageProgress()
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0._isBlocked = nil
	slot0._hasSelectedCount = 0
	slot0._hasSelectedIndexDict = {}

	slot0:_setActiveBtn(false)
	slot0:onUpdateParam()

	slot0._tipsText.text = string.format(luaLang("rougecollectiongiftview_txt_tips"), slot0:_selectRewardNum())

	slot0.viewContainer:registerCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, slot0._onSelectIndexByUser, slot0)
end

function slot0.onOpenFinish(slot0)
	ViewMgr.instance:closeView(ViewName.RougeDifficultyView)
	gohelper.setActive(slot0._gocollectionitem, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function slot0.onClose(slot0)
	slot0:_killTween()
	slot0.viewContainer:unregisterCallback(RougeEvent.RougeCollectionGiftView_OnSelectIndex, slot0._onSelectIndexByUser, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_collectionObjList")
end

function slot0.onDestroyView(slot0)
end

function slot0._refresh(slot0)
	slot0:_refreshList()
	slot0:_refreshConfirmBtn()
end

function slot0._refreshConfirmBtn(slot0)
	slot1 = slot0._hasSelectedCount == slot0:_selectRewardNum()

	gohelper.setActive(slot0._btnstartGo, slot1)
	slot0:_tweenTipsText(not slot1)
end

slot2 = 0.4

function slot0._tweenTipsText(slot0, slot1)
	slot0:_killTween()

	slot0._tweenId = uv0.DoFade(slot0._tipsText, slot0._tipsText.alpha, slot1 and 1 or 0, uv1, nil, , , EaseType.OutQuad)
end

function slot0._killTween(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId")
end

function slot0._refreshList(slot0)
	for slot5, slot6 in ipairs(slot0:_getRewardList()) do
		slot7 = nil

		if slot5 > #slot0._collectionObjList then
			table.insert(slot0._collectionObjList, slot0:_create_RougeCollectionGiftViewItem(slot5))
		else
			slot7 = slot0._collectionObjList[slot5]
		end

		slot7:onUpdateMO(slot6)
		slot7:setActive(true)
		slot7:setSelected(slot0._hasSelectedIndexDict[slot5] and true or false)
	end

	for slot5 = #slot1 + 1, #slot0._collectionObjList do
		slot0._collectionObjList[slot5]:setActive(false)
	end
end

function slot0._getRewardList(slot0)
	if not slot0._tmpRewardList then
		slot0._tmpRewardList = slot0:_rewardList()
	end

	return slot0._tmpRewardList
end

function slot0._create_RougeCollectionGiftViewItem(slot0, slot1)
	slot3 = RougeCollectionGiftViewItem.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot3:setIndex(slot1)
	slot3:init(gohelper.cloneInPlace(slot0._gocollectionitem))

	return slot3
end

function slot0._setActiveBtn(slot0, slot1)
	gohelper.setActive(slot0._btnstartGo, slot1)
end

function slot0._initPageProgress(slot0)
	slot1 = RougePageProgress
	slot0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, slot0._gorougepageprogress, slot1.__cname), slot1)

	slot0._pageProgress:setData()
end

function slot0._selectRewardNum(slot0)
	if not slot0.viewParam then
		return slot0:_getRougeSelectRewardNum()
	end

	return slot0.viewParam.selectRewardNum or slot0:_getRougeSelectRewardNum()
end

function slot0._rewardList(slot0)
	if not slot0.viewParam then
		return slot0:_getRougeLastRewardList()
	end

	return slot0.viewParam.rewardList or slot0:_getRougeLastRewardList()
end

function slot0._submitFunc(slot0)
	if not slot0.viewParam then
		slot0:_defaultSubmitFunc()

		return
	end

	if slot0.viewParam.submitFunc then
		slot0.viewParam.submitFunc(slot0)
	else
		slot0:_defaultSubmitFunc()
	end
end

function slot0._getRougeSelectRewardNum(slot0)
	return RougeModel.instance:getSelectRewardNum() or 0
end

function slot0._getRougeLastRewardList(slot0)
	if not RougeModel.instance:getLastRewardList() or #slot1 == 0 then
		return {}
	end

	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot8.id
		slot10 = slot8.param
		slot13 = {
			title = "",
			id = slot9,
			descList = {},
			type = uv0.Type.unknown,
			type = uv0.Type.Drop,
			title = slot11.title
		}

		if RougeOutsideModel.instance:config():getLastRewardCO(slot9).type == "drop" then
			table.insert(slot13.descList, slot11.desc)

			slot13.resUrl = ResUrl.getRougeSingleBgCollection(slot11.iconName)
		elseif slot12 == "dropGroup" then
			slot13.type = uv0.Type.DropGroup
			slot13.resUrl = nil
			slot13.title = slot11.title
			slot13.data = {}
			slot14 = string.splitToNumber(slot10, "#")
			slot13.data.collectionId = slot14[1]

			for slot18, slot19 in ipairs(slot14) do
				slot20 = RougeCollectionConfig.instance:getCollectionCfg(slot19)

				if slot13.resUrl == nil and not string.nilorempty(slot20.iconPath) then
					slot13.resUrl = ResUrl.getRougeSingleBgCollection(slot20.iconPath)
				end

				slot21, slot22 = RougeCollectionConfig.instance:getCollectionEffectsInfo(slot19)

				for slot26, slot27 in ipairs(slot21) do
					table.insert(slot13.descList, HeroSkillModel.instance:skillDesToSpot(slot27))
				end

				for slot26, slot27 in ipairs(slot22) do
					slot28 = SkillConfig.instance:getSkillEffectDescCo(slot27)

					table.insert(slot13.descList, HeroSkillModel.instance:skillDesToSpot(RougeCollectionHelper.instance:getHeroSkillDesc(slot28.name, slot28.desc)))
				end
			end
		else
			logError(string.format("[RougeInfoMO:getLastRewardList] unsupported error type=%s, id=%s", slot12, slot9))
		end

		table.insert(slot2, slot13)
	end

	return slot2
end

function slot0._isSingleSelect(slot0)
	return slot0:_selectRewardNum() == 1
end

function slot0._onSelectIndexByUser(slot0, slot1)
	if slot0:_isSingleSelect() then
		slot0:_onSelectIndex_SingleSelect(slot1)
	else
		slot0:_onSelectIndex_MultiSelect(slot1)
	end
end

function slot0._onSelectIndex_SingleSelect(slot0, slot1)
	slot2 = slot0._collectionObjList[slot1]

	if slot0._hasSelectedIndexDict[slot1] then
		return
	end

	slot3, slot4 = next(slot0._hasSelectedIndexDict)

	if slot3 then
		slot0._hasSelectedIndexDict[slot3] = nil

		slot0._collectionObjList[slot3]:setSelected(false)
	end

	slot2:setSelected(true)

	slot0._hasSelectedIndexDict[slot1] = true
	slot0._hasSelectedCount = math.min(1, slot0._hasSelectedCount + 1)

	slot0:_refreshConfirmBtn()
end

function slot0._onSelectIndex_MultiSelect(slot0, slot1)
	if slot0._hasSelectedIndexDict[slot1] then
		slot0._hasSelectedIndexDict[slot1] = false
		slot0._hasSelectedCount = slot0._hasSelectedCount - 1

		slot0._collectionObjList[slot1]:setSelected(false)
		slot0:_refreshConfirmBtn()

		return
	end

	if slot0:_selectRewardNum() <= slot0._hasSelectedCount then
		GameFacade.showToast(ToastEnum.RougeCollectionGiftView_ReachMaxSelectedCount)

		return
	end

	slot2:setSelected(true)

	slot0._hasSelectedIndexDict[slot1] = true
	slot0._hasSelectedCount = slot0._hasSelectedCount + 1

	slot0:_refreshConfirmBtn()
end

slot3 = "RougeCollectionGiftView:_defaultSubmitFunc"

function slot0._defaultSubmitFunc(slot0)
	UIBlockHelper.instance:startBlock(uv0, 1, slot0.viewName)

	slot1 = RougeOutsideModel.instance:season()
	slot2 = {}

	for slot7, slot8 in pairs(slot0._hasSelectedIndexDict) do
		if slot8 then
			table.insert(slot2, slot0:_getRewardList()[slot7].id)
		end
	end

	RougeRpc.instance:sendEnterRougeSelectRewardRequest(slot1, slot2, function (slot0, slot1)
		if slot1 ~= 0 then
			logError("RougeCollectionGiftView:_defaultSubmitFunc resultCode=" .. tostring(slot1))

			return
		end

		UIBlockHelper.instance:endBlock(uv0)
		RougeController.instance:openRougeFactionView()
	end)
end

function slot0.getScrollViewGo(slot0)
	return slot0._scrollViewGo
end

function slot0.getScrollRect(slot0)
	return slot0._scrollViewLimitScrollCmp
end

function slot0.setActiveBlock(slot0, slot1)
	if slot0._isBlocked == slot1 then
		return
	end

	slot0._isBlocked = slot1

	gohelper.setActive(slot0._btnemptyBlockGo, slot1)

	if not slot1 then
		for slot5, slot6 in ipairs(slot0._collectionObjList) do
			slot6:onCloseBlock()
		end
	end
end

return slot0
