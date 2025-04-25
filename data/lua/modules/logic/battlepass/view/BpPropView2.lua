module("modules.logic.battlepass.view.BpPropView2", package.seeall)

slot0 = class("BpPropView2", BaseView)

function slot0.onInitView(slot0)
	slot0._bgClick = gohelper.getClick(slot0.viewGO)
	slot0._scrollitem = gohelper.findChild(slot0.viewGO, "#scroll")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll/itemcontent")
	slot0._goeff = gohelper.findChild(slot0.viewGO, "#go_eff")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btnOK")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btnBuy")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "title/level/#txt_lv")
	slot0._scrollContent2 = gohelper.findChild(slot0.viewGO, "#scroll2/Viewport/#go_rewards")
	slot0._item = gohelper.findChild(slot0.viewGO, "#scroll2/Viewport/#go_rewards/#go_Items")
end

function slot0.addEvents(slot0)
	slot0._bgClick:AddClickListener(slot0._onClickBG, slot0)
	slot0._btnclose:AddClickListener(slot0._onClickOK, slot0)
	slot0._btnBuy:AddClickListener(slot0.openChargeView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
	slot0._bgClick:RemoveClickListener()
end

function slot0._onClickBG(slot0)
	if not slot0._openDt or UnityEngine.Time.time < slot0._openDt + 1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "关闭"
	})
	slot0:closeThis()
end

function slot0._onClickOK(slot0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "确定"
	})
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._openDt = UnityEngine.Time.time
	CommonPropListItem.hasOpen = false

	slot0:_setPropItems()
	NavigateMgr.instance:addEscape(ViewName.BpPropView2, slot0._onClickBG, slot0)

	if CommonPropListModel.instance:isHadHighRareProp() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards_High_1)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)
	end

	slot1 = BpModel.instance:getBpLv()
	slot0._txtlv.text = slot1

	gohelper.setActive(slot0._item, false)

	slot3 = {}

	for slot7 = 1, slot1 do
		slot0:_calcBonus({}, slot3, BpConfig.instance:getBonusCO(BpModel.instance.id, slot7).payBonus)
	end

	slot0:_sortList(slot3)
	gohelper.CreateObjList(slot0, slot0._createItem, slot3, slot0._scrollContent2, slot0._item)
end

function slot0._sortList(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		if uv0:getIsSkin(slot0) ~= uv0:getIsSkin(slot1) then
			return uv0:getIsSkin(slot0)
		elseif uv0:getIsSummon(slot0) ~= uv0:getIsSummon(slot1) then
			return uv0:getIsSummon(slot0)
		elseif uv0:getIsEquip(slot0) ~= uv0:getIsEquip(slot1) then
			return uv0:getIsEquip(slot0)
		elseif CommonPropListModel.instance:_getQuality(slot0) ~= CommonPropListModel.instance:_getQuality(slot1) then
			return CommonPropListModel.instance:_getQuality(slot1) < CommonPropListModel.instance:_getQuality(slot0)
		elseif slot0.materilType ~= slot1.materilType then
			return slot1.materilType < slot0.materilType
		elseif slot0.materilType == MaterialEnum.MaterialType.Item and slot1.materilType == MaterialEnum.MaterialType.Item and CommonPropListModel.instance:_getSubType(slot0) ~= CommonPropListModel.instance:_getSubType(slot1) then
			return CommonPropListModel.instance:_getSubType(slot0) < CommonPropListModel.instance:_getSubType(slot1)
		elseif slot0.materilId ~= slot1.materilId then
			return slot1.materilId < slot0.materilId
		end
	end)
end

function slot0.getIsSkin(slot0, slot1)
	return slot1.materilType == MaterialEnum.MaterialType.HeroSkin
end

function slot0.getIsEquip(slot0, slot1)
	return slot1.materilType == MaterialEnum.MaterialType.Equip and slot1.materilId == 1000
end

function slot0.getIsSummon(slot0, slot1)
	return slot1.materilType == MaterialEnum.MaterialType.Item and slot1.materilId == 140001
end

function slot0._calcBonus(slot0, slot1, slot2, slot3)
	slot7 = "|"

	for slot7, slot8 in pairs(string.split(slot3, slot7)) do
		slot9 = string.splitToNumber(slot8, "#")
		slot11 = slot9[3]

		if not slot1[slot9[2]] then
			slot1[slot10] = {
				materilType = slot9[1],
				materilId = slot9[2],
				quantity = slot9[3],
				[4] = slot9[4],
				[5] = slot9[5]
			}

			table.insert(slot2, slot1[slot10])
		else
			slot1[slot10].quantity = slot1[slot10].quantity + slot11
		end
	end
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChild(slot1, "#go_Limit")
	slot6 = gohelper.findChild(slot1, "#go_new")
	slot9 = slot2.quantity

	IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "#go_item")):setMOValue(slot2.materilType, slot2.materilId, slot9, nil, true)

	slot11 = slot9 and slot9 ~= 0

	if slot0:getIsSkin(slot2) then
		slot11 = false
	end

	slot10:isShowEquipAndItemCount(slot11)

	if slot11 then
		slot10:setCountText(GameUtil.numberDisplay(slot9))
	end

	slot10:setCountFontSize(43)
	gohelper.setActive(slot4, slot2[4] == 1)
	gohelper.setActive(slot6, slot2[5] == 1)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._setPropItems(slot0)
	CommonPropListModel.instance:setPropList(slot0.viewParam)

	for slot5, slot6 in ipairs(CommonPropListModel.instance:getList()) do
		slot7 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._gocontent, "cell" .. slot5)

		transformhelper.setLocalScale(slot7.transform, 0.7, 0.7, 0.7)

		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, CommonPropListItem)
		slot8._index = slot5
		slot8._view = slot0

		slot8:onUpdateMO(slot6)

		function slot8.callback()
			uv0:setCountFontSize(43)
		end
	end
end

function slot0.openChargeView(slot0)
	StatController.instance:track(StatEnum.EventName.ClickBPRewardWindowButton, {
		[StatEnum.EventProperties.ButtonName] = "解锁吼吼典藏光碟"
	})
	ViewMgr.instance:openView(ViewName.BpChargeView)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false
end

function slot0.onDestroyView(slot0)
end

return slot0
