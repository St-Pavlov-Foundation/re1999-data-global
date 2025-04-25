module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationDetailView", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationDetailView", BaseView)
slot0.DISPLAY_TYPE = {
	Reward = 2,
	Effect = 1
}

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "effect/#simage_mask")
	slot0._goroleitemcontent = gohelper.findChild(slot0.viewGO, "effect/#go_roleitemcontent")
	slot0._goroleitem = gohelper.findChild(slot0.viewGO, "effect/#go_roleitemcontent/#go_roleitem")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "effect/#go_roleitemcontent/#go_roleitem/#go_select")
	slot0._scrolleffect = gohelper.findChildScrollRect(slot0.viewGO, "effect/#scroll_effect")
	slot0._godestinycontent = gohelper.findChild(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent")
	slot0._goeffectitem = gohelper.findChild(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem")
	slot0._imagestone = gohelper.findChildImage(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#image_stone")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/title/#txt_title")
	slot0._godecitem = gohelper.findChild(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "effect/#scroll_effect/Viewport/#go_destinycontent/#go_effectitem/#go_decitem/#txt_dec")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "reward/#scroll_reward")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "effect")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "reward")
	slot0._destinyEffectItemList = {}
	slot0._rewardItemList = {}
	slot0._roleItemList = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._showType = slot0.viewParam.showType
	slot0._needShowHeroIds = slot0.viewParam.heroId or nil
	slot0._actId = slot0.viewParam.actId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = slot0._showType == slot0.DISPLAY_TYPE.Reward

	if slot0._showType == slot0.DISPLAY_TYPE.Effect then
		slot0:_refreshDestinyInfo()
	elseif slot2 then
		slot0:_refreshReward()
	end

	gohelper.setActive(slot0._goeffect, slot1)
	gohelper.setActive(slot0._goreward, slot2)
end

function slot0._refreshReward(slot0)
	if Activity125Model.instance:getById(slot0._actId) == nil then
		return
	end

	if slot1:getEpisodeList() == nil or #slot2 <= 0 then
		return
	end

	if not string.nilorempty(slot1.config[slot2[1].id].bonus) then
		slot8 = #slot0._rewardItemList

		for slot12 = 1, #string.split(slot5, "|") do
			slot13 = nil

			if slot12 <= slot8 then
				slot13 = slot0._rewardItemList[slot12]
			else
				table.insert(slot0._rewardItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gorewarditem, slot0._gocontent), VersionActivity2_3NewCultivationRewardItem))
			end

			slot15 = string.splitToNumber(slot6[slot12], "#")

			slot13:setEnable(true)
			slot13:onUpdateMO(slot15[1], slot15[2], slot15[3])
		end

		if slot7 < slot8 then
			for slot12 = slot7 + 1, slot8 do
				slot0._rewardItemList[slot12]:setEnable(true)
			end
		end
	end
end

function slot0._refreshDestinyInfo(slot0)
	slot0:_refreshRoleInfo()
end

function slot0.onSelectRoleItem(slot0, slot1)
	if slot0._roleId and slot0._roleId == slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0._roleItemList) do
		slot6:refreshSelect(slot1)
	end

	slot0._roleId = slot1

	slot0:_refreshEffectInfo(slot1)
end

function slot0._refreshRoleInfo(slot0)
	slot1 = CharacterDestinyConfig.instance:getAllDestinyConfigList()

	if slot0._needShowHeroIds ~= nil then
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			for slot11, slot12 in ipairs(slot0._needShowHeroIds) do
				if slot7.heroId == slot12 then
					table.insert(slot2, slot7)
				end
			end
		end

		slot1 = slot2
	end

	if #slot1 <= 0 then
		return
	end

	for slot7 = 1, slot2 do
		slot8 = nil

		if #slot0._roleItemList < slot7 then
			slot9 = gohelper.clone(slot0._goroleitem, slot0._goroleitemcontent)

			gohelper.setActive(slot9, true)

			slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, VersionActivity2_3NewCultivationRoleItem)

			slot8:init(slot9)
			table.insert(slot0._roleItemList, slot8)
		else
			slot8 = slot0._roleItemList[slot7]
		end

		slot8:setData(slot1[slot7])
		slot8:setClickCallBack(slot0.onSelectRoleItem, slot0)
	end

	slot0:onSelectRoleItem(slot1[1].heroId)
end

function slot0._refreshEffectInfo(slot0, slot1)
	if CharacterDestinyConfig.instance:getHeroDestiny(slot1) == nil then
		return
	end

	if string.splitToNumber(slot2.facetsId, "#") == nil then
		return
	end

	slot4 = #slot3
	slot5 = #slot0._destinyEffectItemList

	for slot9, slot10 in ipairs(slot3) do
		slot11 = nil

		if slot5 < slot9 then
			slot12 = gohelper.clone(slot0._goeffectitem, slot0._godestinycontent)
			slot11 = MonoHelper.addNoUpdateLuaComOnceToGo(slot12, VersionActivity2_3NewCultivationDestinyItem)

			table.insert(slot0._destinyEffectItemList, slot11)
			slot11:init(slot12)
		else
			slot11 = slot0._destinyEffectItemList[slot9]
		end

		slot11:SetActive(true)
		slot11:setData(slot1, slot10)
	end

	if slot4 < slot5 then
		for slot9 = slot4 + 1, slot5 do
			slot0._destinyEffectItemList[slot9]:SetActive(false)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
